import { createHmac } from "crypto";
import { NextResponse } from "next/server";
import { getSessionUser } from "@/lib/supabase/server";
import { Q4_STATUS_TH, type Q4Entry, type Q4Review } from "@/lib/q4";

// Lark notifications for the Q4 module, sent to TWO separate groups:
//  A) Assignment group (internal teams)  LARK_WEBHOOK_URL        [+ LARK_WEBHOOK_SECRET]
//     - when teams are assigned / delegated, or the status changes
//     - full detail: assigned teams, newly assigned teams, central action, each team's comment
//  B) Branch staff group (who reported)  LARK_BRANCH_WEBHOOK_URL [+ LARK_BRANCH_WEBHOOK_SECRET]
//     - only when the status changes
//     - customer-facing summary: status, who is handling it, central action (no internal team comments)
//  C) Optional DM to the reporter         LARK_APP_ID + LARK_APP_SECRET
// All keys are server-only Vercel env vars.
export const dynamic = "force-dynamic";

const LARK = process.env.LARK_DOMAIN || "https://open.larksuite.com";
const clean = (x: string | null | undefined) => (x ?? "").replace(/\s+/g, " ").trim();

type Card = Record<string, unknown>;

async function sendWebhook(url: string | undefined, secret: string | undefined, card: Card): Promise<string> {
  if (!url) return "skipped (no webhook)";
  const body: Record<string, unknown> = { msg_type: "interactive", card };
  if (secret) {
    const ts = Math.floor(Date.now() / 1000).toString();
    body.timestamp = ts;
    body.sign = createHmac("sha256", `${ts}\n${secret}`).update("").digest("base64");
  }
  try {
    const res = await fetch(url, { method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify(body) });
    const j = await res.json().catch(() => ({}));
    return res.ok && (j.code === 0 || j.StatusCode === 0) ? "sent" : `error: ${j.msg || res.status}`;
  } catch {
    return "error: unreachable";
  }
}

function makeCard(title: string, template: string, lines: string[], link: string): Card {
  return {
    config: { wide_screen_mode: true },
    header: { template, title: { tag: "plain_text", content: title } },
    elements: [
      { tag: "div", text: { tag: "lark_md", content: lines.filter(Boolean).join("\n") } },
      ...(link ? [{ tag: "action", actions: [{ tag: "button", type: "primary", text: { tag: "plain_text", content: "เปิดดูในระบบ" }, url: link }] }] : []),
    ],
  };
}

export async function POST(req: Request) {
  const { user, supabase } = await getSessionUser();
  if (!user) return NextResponse.json({ error: "not_signed_in" }, { status: 401 });

  const { entry_id, prev_status, prev_teams } = (await req.json().catch(() => ({}))) as {
    entry_id?: string; prev_status?: string; prev_teams?: string[];
  };
  if (!entry_id) return NextResponse.json({ error: "missing_entry" }, { status: 400 });

  // Permission + reporter e-mail (null unless caller is admin or an assigned team member)
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
  const added = teams.filter((x) => !(prev_teams ?? []).includes(x));
  const statusChanged = !!prev_status && prev_status !== status;
  const site = process.env.NEXT_PUBLIC_SITE_URL || "";
  const link = site ? `${site}/q4?tab=list` : "";
  const by = `${rev?.updated_as || "ส่วนกลาง (Admin)"}${(info.updater_name || user.email) ? ` (${info.updater_name || user.email})` : ""}`;
  const statusLine = `**สถานะ:** ${statusChanged ? `${prev_status} → ` : ""}**${status}** (${Q4_STATUS_TH[status] ?? ""})`;
  const color = status === "Completed" ? "green" : status === "Waiting for Support" ? "orange" : "blue";

  const result: { group?: string; branch?: string; dm?: string } = {};

  // A) Assignment group: new assignments or status change
  if (added.length || statusChanged) {
    const card = makeCard(
      added.length ? `Q4 · มอบหมายงาน [${entry.branch}] → ${added.join(", ")}` : `Q4 · อัปเดตงาน [${entry.branch}]`,
      added.length ? "red" : color,
      [
        added.length ? `**มอบหมายใหม่:** ${added.join(", ")}` : "",
        `**ทีมรับผิดชอบทั้งหมด:** ${teams.join(", ") || "-"}`,
        `**สาขา:** ${entry.branch} · ${entry.service_area}`,
        `**หมวด:** ${entry.category} · Priority ${entry.priority}`,
        statusLine,
        `**เรื่องที่แจ้ง:** ${clean(entry.support).slice(0, 300)}`,
        rev?.action ? `**Central action:** ${clean(rev.action)}` : "",
        ...notes.map((x) => `**${x.team}:** ${clean(x.note)}`),
        `ผู้แจ้ง: ${info.reporter_name || "-"} · อัปเดตโดย: ${by}`,
      ],
      link,
    );
    result.group = await sendWebhook(process.env.LARK_WEBHOOK_URL, process.env.LARK_WEBHOOK_SECRET, card);
  } else result.group = "skipped (no change)";

  // B) Branch staff group: status changes only, summary without internal team comments
  const branchCard = makeCard(
    `Q4 · ความคืบหน้าเรื่องที่สาขาแจ้ง [${entry.branch}]`,
    color,
    [
      `**สาขา:** ${entry.branch} · ผู้แจ้ง ${info.reporter_name || "-"}`,
      `**เรื่องที่แจ้ง:** ${clean(entry.support).slice(0, 300)}`,
      statusLine,
      teams.length ? `**ทีมที่ดูแล:** ${teams.join(", ")}` : "",
      rev?.action ? `**ส่วนกลางดำเนินการ:** ${clean(rev.action)}` : "",
    ],
    link,
  );
  result.branch = statusChanged
    ? await sendWebhook(process.env.LARK_BRANCH_WEBHOOK_URL, process.env.LARK_BRANCH_WEBHOOK_SECRET, branchCard)
    : "skipped (status unchanged)";

  // C) Optional DM to the reporter (status changes only)
  const appId = process.env.LARK_APP_ID, appSecret = process.env.LARK_APP_SECRET;
  if (statusChanged && appId && appSecret && info.reporter_email) {
    try {
      const tk = await fetch(`${LARK}/open-apis/auth/v3/tenant_access_token/internal`, {
        method: "POST", headers: { "content-type": "application/json" },
        body: JSON.stringify({ app_id: appId, app_secret: appSecret }),
      }).then((x) => x.json());
      if (!tk.tenant_access_token) throw new Error(tk.msg || "token");
      const res = await fetch(`${LARK}/open-apis/im/v1/messages?receive_id_type=email`, {
        method: "POST",
        headers: { "content-type": "application/json", authorization: `Bearer ${tk.tenant_access_token}` },
        body: JSON.stringify({ receive_id: info.reporter_email, msg_type: "interactive", content: JSON.stringify(branchCard) }),
      });
      const j = await res.json().catch(() => ({}));
      result.dm = j.code === 0 ? "sent" : `error: ${j.msg || res.status}`;
    } catch (err) {
      result.dm = `error: ${(err as Error).message}`;
    }
  } else result.dm = "skipped";

  return NextResponse.json({ ok: true, ...result });
}
