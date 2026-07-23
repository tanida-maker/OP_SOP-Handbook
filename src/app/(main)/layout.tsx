import Link from "next/link";
import SiteHeader from "@/components/SiteHeader";
import { getSessionUser } from "@/lib/supabase/server";

export default async function MainLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { fullName, isAdmin } = await getSessionUser();

  return (
    <>
      <SiteHeader fullName={fullName ?? "พนักงาน"} isAdmin={isAdmin} />
      <main className="mx-auto w-full max-w-6xl flex-1 px-4 py-6 md:py-8">
        {children}
      </main>
      <footer className="border-t border-border bg-surface">
        <div className="mx-auto flex max-w-6xl flex-col items-center justify-between gap-2 px-4 py-6 text-sm text-muted md:flex-row">
          <p>© {new Date().getFullYear()} AIRPORTELs — SOP Hub</p>
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
    </>
  );
}
