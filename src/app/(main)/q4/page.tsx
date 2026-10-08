import { getSessionUser } from "@/lib/supabase/server";
import Q4App from "./Q4App";

export const dynamic = "force-dynamic";

// Optional deep link for team hand-off, e.g. /q4?tab=list&team=HR
export default async function Q4Page({
  searchParams,
}: {
  searchParams: Promise<{ tab?: string; team?: string }>;
}) {
  const { user, isAdmin, fullName, supabase } = await getSessionUser();
  const r = user ? await supabase.schema("sop").rpc("q4_my_role") : null;
  const role = (r && !r.error && typeof r.data === "string" ? r.data : null) as "review" | "assign" | "edit" | null;
  const sp = await searchParams;
  const tab = sp.tab === "list" || sp.tab === "summary" || sp.tab === "present" || sp.tab === "team" || sp.tab === "users" || sp.tab === "meet" ? sp.tab : "form";
  return (
    <Q4App
      userId={user?.id ?? null}
      isAdmin={isAdmin}
      fullName={fullName ?? ""}
      initialTab={tab}
      initialTeam={sp.team ?? ""}
      external={user?.app_metadata?.q4_external === true}
      company={user?.app_metadata?.q4_company === true}
      role={role}
    />
  );
}
