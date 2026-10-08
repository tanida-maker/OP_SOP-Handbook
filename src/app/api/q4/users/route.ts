import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";
import { getSessionUser } from "@/lib/supabase/server";

// Q4 User Management: Q4 admins add people by e-mail (Gmail or company) with a role
//   review | assign | edit
// People without an account get a Q4-only login account (no Scheduling, no SOP Hub).
// Needs SUPABASE_SERVICE_ROLE_KEY (server-only).
export const dynamic = "force-dynamic";

const ROLES = ["review", "assign", "edit"];

export async function POST(req: Request) {
  const { user, supabase } = await getSessionUser();
  if (!user) return NextResponse.json({ error: "not_signed_in" }, { status: 401 });
  const ok = await supabase.schema("sop").rpc("q4_admin");
  if (ok.error || ok.data !== true) return NextResponse.json({ error: "not_allowed" }, { status: 403 });

  const { email: raw, name, role } = (await req.json().catch(() => ({}))) as { email?: string; name?: string; role?: string };
  const email = (raw ?? "").trim().toLowerCase();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return NextResponse.json({ error: "bad_email" }, { status: 400 });
  if (!role || !ROLES.includes(role)) return NextResponse.json({ error: "bad_role" }, { status: 400 });

  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) return NextResponse.json({ error: "missing_service_key" }, { status: 500 });
  const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, key, { auth: { persistSession: false, autoRefreshToken: false } });

  let userId: string | null = null;
  let created = false;
  const found = await admin.schema("sop").rpc("q4_find_user", { p_email: email });
  if (found.error) return NextResponse.json({ error: found.error.message }, { status: 500 });
  if (found.data) userId = found.data as string;
  else {
    const domains = (process.env.Q4_COMPANY_DOMAINS || "airportels.asia,airportels.co").split(",").map((d) => d.trim().toLowerCase());
    const company = domains.includes(email.split("@")[1] ?? "");
    const c = await admin.auth.admin.createUser({
      email, email_confirm: true, app_metadata: { q4_external: true, q4_company: company, q4_role_user: true },
    });
    if (c.error || !c.data.user) return NextResponse.json({ error: c.error?.message ?? "create_failed" }, { status: 500 });
    userId = c.data.user.id;
    created = true;
  }

  const up = await admin.schema("sop").from("q4_roles").upsert(
    { user_id: userId, email, name: (name ?? "").trim() || null, role, added_by: user.id },
    { onConflict: "user_id" },
  );
  if (up.error) return NextResponse.json({ error: up.error.message }, { status: 500 });
  return NextResponse.json({ ok: true, created });
}
