import { createHmac } from "crypto";
import { NextResponse } from "next/server";
import { getSessionUser } from "@/lib/supabase/server";
import { Q4_STATUS_TH, type Q4Entry, type Q4Review } from "@/lib/q4";

// Sends a Lark notification when an issue's status changes:
//  1) to the Q4 Lark group via its Custom Bot webhook   (LARK_WEBHOOK_URL [+ LARK_WEBHOOK_SECRET])
//  2) as a direct message to the person who reported it (LARK_APP_ID + LARK_APP_SECRET, optional)
// All keys are server-only Vercel env vars; nothing is sent to the browser.
export const dynamic = "force-dynamic";

const LARK = process.env.LARK_DOMAIN || "https://open.larksuite.com";
const clean = (x: string | null | undefined) => (x ?? "").replace(/\s+/g, " ").trim();

export async function POST(req: Request) {
  const { user, supabase } = await getSessionUser();
  if (!user) return NextResponse.json({ error: "not_signed_in" }, { status: 401 });

  const { entry_id, prev_status } = (await req.json().catch(() => ({}))) as { entry_id?: string; prev_status?: string };
  if (!entry_id) return NextResponse.json({ error: "missing_entry" }, { status: 400 });

  // Permission + reporter e-mail (returns null unless caller is admin or assigned team member)
  const ctx = await supabase.schema("sop").rpc("q4_notify_context", { p_entry: entry_id });
  if (ctx.error || !ctx.data) return NextResponse.json({ error: "forbidden" }, { status: 403 });
  const info = ctx.data as { reporter_email: string | null; reporter_name: string | null; updater_name: string | null };

  const [e, r, n] = await Promise.all([
    supabase.schema("sop").from("q4_entries").select("*").eq("id", entry_id).single(),
    supabase.schema("sop").from("q4_reviews").select("*").eq("entry_id", entry_id).maybeSingle(),
    supabase.schema("sop").from("q4_team_notes").select("team, note").eq("entry_id", entry_id),
  ]);
  if (e.error || !e.data) return NextResponse.json({ error: "not_found" }, { status: 404 });
  const entry = e.data as Q4Entry;
  const rev = (r.data ?? null) as Q4Review | null;
  const status = rev?.status ?? "New";
  const teams = rev?.teams?.length ? rev.teams : rev?.team ? [rev.team] : [];
  const notes = (n.data ?? []) as { team: string; note: string }[];
  const site = process.env.NEXT_PUBLIC_SITE_URL || "";
  const link = `${site}/q4?tab=list`;

  const lines = [
    `**สาขา:** ${entry.branch} · ${entry.service_area}`,
    `**หมวด:** ${entry.category} · Priority ${entry.priority}`,
    `**สถานะ:** ${prev_status && prev_status !== status ? `${prev_status} → ` : ""}**${status}** (${Q4_STATUS_TH[status] ?? ""})`,
    teams.length ? `**ทีมรับผิดชอบ:** ${teams.join(", ")}` : "",
    `**เรื่องที่แจ้ง:** ${clean(entry.support).slice(0, 300)}`,
    rev?.action ? `**Central action:** ${clean(rev.action)}` : "",
    ...notes.map((x) => `**${x.team}:** ${clean(x.note)}`),
    `ผู้แจ้ง: ${info.reporter_name || "-"} · อัปเดตโดย: ${info.updater_name || "-"}`,
  ].filter(Boolean);

  const card = {
    config: { wide_screen_mode: true },
    header: {
      template: status === "Completed" ? "green" : status === "Waiting for Support" ? "orange" : "blue",
      title: { tag: "plain_text", content: `Q4 & ปีใหม่ · อัปเดตสถานะ [${entry.branch}]` },
    },
    elements: [
      { tag: "div", text: { tag: "lark_md", content: lines.join("\n") } },
      ...(site ? [{ tag: "action", actions: [{ tag: "button", type: "primary", text: { tag: "plain_text", content: "เปิดดูในระบบ" }, url: link }] }] : []),
    ],
  };

  const result: { group?: string; dm?: string } = {};

  // 1) Group webhook
  const hook = process.env.LARK_WEBHOOK_URL;
  if (hook) {
    const body: Record<string, unknown> = { msg_type: "interactive", card };
    const secret = process.env.LARK_WEBHOOK_SECRET;
    if (secret) {
      const ts = Math.floor(Date.now() / 1000).toString();
      body.timestamp = ts;
      body.sign = createHmac("sha256", `${ts}\n${secret}`).update("").digest("base64");
    }
    try {
      const res = await fetch(hook, { method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify(body) });
      const j = await res.json().catch(() => ({}));
      result.group = res.ok && (j.code === 0 || j.StatusCode === 0) ? "sent" : `error: ${j.msg || res.status}`;
    } catch {
      result.group = "error: unreachable";
    }
  } else result.group = "skipped (no LARK_WEBHOOK_URL)";

  // 2) Direct message to the reporter (by login e-mail)
  const appId = process.env.LARK_APP_ID, appSecret = process.env.LARK_APP_SECRET;
  if (appId && appSecret && info.reporter_email) {
    try {
      const tk = await fetch(`${LARK}/open-apis/auth/v3/tenant_access_token/internal`, {
        method: "POST", headers: { "content-type": "application/json" },
        body: JSON.stringify({ app_id: appId, app_secret: appSecret }),
      }).then((x) => x.json());
      if (!tk.tenant_access_token) throw new Error(tk.msg || "token");
      const res = await fetch(`${LARK}/open-apis/im/v1/messages?receive_id_type=email`, {
        method: "POST",
        headers: { "content-type": "application/json", authorization: `Bearer ${tk.tenant_access_token}` },
        body: JSON.stringify({ receive_id: info.reporter_email, msg_type: "interactive", content: JSON.stringify(card) }),
      });
      const j = await res.json().catch(() => ({}));
      result.dm = j.code === 0 ? "sent" : `error: ${j.msg || res.status}`;
    } catch (err) {
      result.dm = `error: ${(err as Error).message}`;
    }
  } else result.dm = appId ? "skipped (no reporter e-mail)" : "skipped (no LARK_APP_ID)";

  return NextResponse.json({ ok: true, ...result });
}
