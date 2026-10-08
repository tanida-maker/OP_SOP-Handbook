import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { getSessionUser } from "@/lib/supabase/server";
import { Q4_TEAMS } from "@/lib/q4";

// Add a person to a Support team by e-mail, even if they have no Scheduling account.
//  - Caller must be an SOP admin or already a member of that team.
//  - If the e-mail has no account yet, a login account is created (no e-mail is sent,
//    public sign-up stays closed). The person then signs in with Google (same Gmail /
//    Google Workspace address) or with "send login link by e-mail".
// Needs SUPABASE_SERVICE_ROLE_KEY in Vercel (server-only Secret).
export const dynamic = "force-dynamic";

export async function POST(req: Request) {
  const { user, isAdmin, supabase } = await getSessionUser();
  if (!user) return NextResponse.json({ error: "not_signed_in" }, { status: 401 });

  const { email: raw, team } = (await req.json().catch(() => ({}))) as { email?: string; team?: string };
  const email = (raw ?? "").trim().toLowerCase();
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return NextResponse.json({ error: "bad_email" }, { status: 400 });
  if (!team || !Q4_TEAMS.includes(team)) return NextResponse.json({ error: "bad_team" }, { status: 400 });

  if (!isAdmin) {
    const [qa, m] = await Promise.all([
      supabase.schema("sop").rpc("q4_admin"),
      supabase.schema("sop").rpc("q4_is_team_member", { p_team: team }),
    ]);
    if (qa.data !== true && m.data !== true) return NextResponse.json({ error: "not_allowed" }, { status: 403 });
  }

  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) return NextResponse.json({ error: "missing_service_key" }, { status: 500 });
  const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  // find or create the login account
  let userId: string | null = null;
  let created = false;
  const found = await admin.schema("sop").rpc("q4_find_user", { p_email: email });
  if (found.error) return NextResponse.json({ error: found.error.message }, { status: 500 });
  if (found.data) userId = found.data as string;
  else {
    // app_metadata (not user-editable) marks the account as an external Support member: Q4 only
    const domains = (process.env.Q4_COMPANY_DOMAINS || "airportels.asia,airportels.co").split(",").map((d) => d.trim().toLowerCase());
    const company = domains.includes(email.split("@")[1] ?? "");
    const c = await admin.auth.admin.createUser({ email, email_confirm: true, app_metadata: { q4_external: true, q4_company: company, invited_to: team } });
    if (c.error || !c.data.user) return NextResponse.json({ error: c.error?.message ?? "create_failed" }, { status: 500 });
    userId = c.data.user.id;
    created = true;
  }

  const ins = await admin.schema("sop").from("q4_team_members")
    .upsert({ user_id: userId, team, added_by: user.id }, { onConflict: "user_id,team", ignoreDuplicates: true });
  if (ins.error) return NextResponse.json({ error: ins.error.message }, { status: 500 });

  return NextResponse.json({ ok: true, created });
}
