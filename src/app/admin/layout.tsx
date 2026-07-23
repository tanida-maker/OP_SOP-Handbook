import Link from "next/link";
import { redirect } from "next/navigation";
import { ArrowLeft, FileText, LayoutDashboard, Megaphone, Tags } from "lucide-react";
import { getSessionUser } from "@/lib/supabase/server";

const NAV = [
  { href: "/admin", label: "ภาพรวม", icon: LayoutDashboard },
  { href: "/admin/documents", label: "คู่มือ (SOP/WI)", icon: FileText },
  { href: "/admin/categories", label: "หมวดหมู่", icon: Tags },
  { href: "/admin/announcements", label: "ประกาศ", icon: Megaphone },
];

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, isAdmin } = await getSessionUser();
  if (!user) redirect("/login?next=/admin");
  if (!isAdmin) redirect("/");

  return (
    <div className="min-h-screen bg-bg">
      <div className="mx-auto flex max-w-7xl flex-col gap-6 px-4 py-6 md:flex-row">
        {/* Sidebar */}
        <aside className="md:w-60 md:shrink-0">
          <div className="mb-4 flex items-center gap-2">
            <span className="grid h-9 w-9 place-items-center rounded-xl bg-brand-600 text-white font-extrabold">
              A
            </span>
            <div className="leading-tight">
              <p className="text-sm font-extrabold text-text">ระบบจัดการ</p>
              <p className="text-[11px] text-muted">SOP Hub Admin</p>
            </div>
          </div>

          <nav className="flex gap-1 overflow-x-auto rounded-xl border border-border bg-surface p-2 md:flex-col md:overflow-visible">
            {NAV.map((n) => (
              <Link
                key={n.href}
                href={n.href}
                className="flex shrink-0 items-center gap-2.5 rounded-lg px-3 py-2.5 text-sm font-medium text-muted hover:bg-surface-2 hover:text-text md:shrink"
              >
                <n.icon size={18} />
                {n.label}
              </Link>
            ))}
          </nav>

          <Link
            href="/"
            className="mt-3 flex items-center gap-2 rounded-lg px-3 py-2.5 text-sm text-muted hover:text-text"
          >
            <ArrowLeft size={16} /> กลับหน้าพนักงาน
          </Link>
        </aside>

        {/* Content */}
        <div className="min-w-0 flex-1">{children}</div>
      </div>
    </div>
  );
}
