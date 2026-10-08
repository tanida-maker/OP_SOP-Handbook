import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

// Self-service access for anyone with a company e-mail (no Scheduling account needed).
//  - Only addresses on the company domains are accepted (Q4_COMPANY_DOMAINS, comma-separated;
//    default "airportels.asia,airportels.co").
//  - Creates a Q4-only login account (app_metadata.q4_external + q4_company): all Q4 tabs except
//    the issue form; blocked from SOP Hub and Scheduling data. No e-mail is sent by this route.
//  - Owning the mailbox is still required to sign in (Google or e-mail login link), so registering
//    someone else's address gives nobody access.
// Public sign-up in Supabase stays closed. Needs SUPABASE_SERVICE_ROLE_KEY.
export const dynamic = "force-dynamic";

const DOMAINS = (process.env.Q4_COMPANY_DOMAINS || "airportels.asia,airportels.co")
  .split(",").map((d) => d.trim().toLowerCase()).filter(Boolean);

export async function POST(req: Request) {
  const { email: raw } = (await req.json().catch(() => ({}))) as { email?: string };
  const email = (raw ?? "").trim().toLowerCase();
  const domain = email.split("@")[1] ?? "";
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return NextResponse.json({ error: "bad_email" }, { status: 400 });
  if (!DOMAINS.includes(domain)) return NextResponse.json({ error: "not_company", domains: DOMAINS }, { status: 403 });

  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) return NextResponse.json({ error: "missing_service_key" }, { status: 500 });
  const admin = createClient(process.env.NEXT_PUBLIC_SUPABASE_URL!, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  const found = await admin.schema("sop").rpc("q4_find_user", { p_email: email });
  if (found.error) return NextResponse.json({ error: found.error.message }, { status: 500 });
  if (found.data) return NextResponse.json({ ok: true, existing: true });

  const c = await admin.auth.admin.createUser({
    email, email_confirm: true, app_metadata: { q4_external: true, q4_company: true },
  });
  if (c.error) return NextResponse.json({ error: c.error.message }, { status: 500 });
  return NextResponse.json({ ok: true, created: true });
}
