import { getSessionUser } from "@/lib/supabase/server";
import Q4App from "./Q4App";

export const dynamic = "force-dynamic";

export default async function Q4Page() {
  const { user, isAdmin, fullName } = await getSessionUser();
  return <Q4App userId={user?.id ?? null} isAdmin={isAdmin} fullName={fullName ?? ""} />;
}
