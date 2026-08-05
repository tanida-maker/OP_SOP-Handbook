import Link from "next/link";
import SiteHeader from "@/components/SiteHeader";
import LeftRail from "@/components/LeftRail";
import { createClient, getSessionUser } from "@/lib/supabase/server";
import { APP_VERSION } from "@/lib/version";

export default async function MainLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { fullName, isAdmin } = await getSessionUser();

  const supabase = await createClient();
  const { count } = await supabase
    .from("announcements")
    .select("*", { count: "exact", head: true })
    .eq("published", true);

  return (
    <>
      {/* Desktop icon rail */}
      <LeftRail isAdmin={isAdmin} announceCount={count ?? 0} />

      {/* Mobile top bar (rail is hidden on mobile) */}
      <div className="md:hidden">
        <SiteHeader fullName={fullName ?? "พนักงาน"} isAdmin={isAdmin} />
      </div>

      <div className="flex min-h-screen flex-col md:pl-60">
        <main className="mx-auto w-full max-w-6xl flex-1 px-4 py-6 md:px-8 md:py-10">
          {children}
        </main>
        <footer className="border-t border-border bg-surface">
          <div className="mx-auto flex max-w-6xl flex-col items-center justify-between gap-2 px-4 py-6 text-sm text-muted md:flex-row md:px-8">
            <p>
              © {new Date().getFullYear()} AIRPORTELs — Operations Knowledge
              Center · v{APP_VERSION}
            </p>
            <div className="flex items-center gap-4">
              <Link href="/onboarding" className="hover:text-text">
                พนักงานใหม่
              </Link>
              <Link href="/announcements" className="hover:text-text">
                ประกาศ
              </Link>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
}
