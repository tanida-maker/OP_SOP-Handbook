"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import {
  CalendarDays,
  GraduationCap,
  Home,
  LayoutGrid,
  LogOut,
  Megaphone,
  Moon,
  Search,
  Settings,
  type LucideIcon,
} from "lucide-react";
import ThemeToggle from "./ThemeToggle";
import Logo from "./Logo";
import { createClient } from "@/lib/supabase/client";

const SCHEDULING_URL = "https://airportels-scheduling.vercel.app";

type Item = { href: string; label: string; icon: LucideIcon; badge?: number };

export default function LeftRail({
  isAdmin,
  announceCount = 0,
}: {
  isAdmin: boolean;
  announceCount?: number;
}) {
  const pathname = usePathname();
  const router = useRouter();

  const items: Item[] = [
    { href: "/", label: "หน้าแรก", icon: Home },
    { href: "/onboarding", label: "พนักงานใหม่", icon: GraduationCap },
    { href: "/announcements", label: "ประกาศ", icon: Megaphone, badge: announceCount },
    { href: "/search", label: "ค้นหา", icon: Search },
  ];
  if (isAdmin)
    items.push({ href: "/admin", label: "ระบบจัดการ", icon: Settings });

  const isActive = (href: string) =>
    href === "/" ? pathname === "/" : pathname.startsWith(href);

  async function logout() {
    await createClient().auth.signOut();
    router.push("/login");
    router.refresh();
  }

  const row =
    "flex items-center gap-3 rounded-xl px-3 py-2.5 text-sm font-medium transition";

  return (
    <aside className="fixed inset-y-0 left-0 z-40 hidden w-60 flex-col border-r border-border bg-surface px-3 py-5 md:flex">
      <Link href="/" className="mb-6 flex items-center px-2" title="หน้าแรก">
        <Logo height={22} />
      </Link>

      <nav className="flex flex-1 flex-col gap-1 overflow-y-auto">
        {items.map((it) => {
          const active = isActive(it.href);
          return (
            <Link
              key={it.href}
              href={it.href}
              className={`${row} ${
                active
                  ? "bg-brand-50 text-brand-700"
                  : "text-muted hover:bg-surface-2 hover:text-text"
              }`}
            >
              <it.icon size={20} className="shrink-0" />
              <span className="flex-1">{it.label}</span>
              {!!it.badge && it.badge > 0 && (
                <span className="grid h-5 min-w-5 place-items-center rounded-full bg-accent px-1.5 text-[11px] font-bold text-white">
                  {it.badge}
                </span>
              )}
            </Link>
          );
        })}

        {/* External: Scheduling app (same login) */}
        <a
          href={SCHEDULING_URL}
          target="_blank"
          rel="noopener"
          className={`${row} text-muted hover:bg-surface-2 hover:text-text`}
        >
          <CalendarDays size={20} className="shrink-0" />
          <span className="flex-1">ตารางงาน</span>
          <span className="text-xs text-muted">↗</span>
        </a>
      </nav>

      <div className="mt-3 flex flex-col gap-1 border-t border-border pt-3">
        <Link
          href="/#categories"
          className={`${row} text-muted hover:bg-surface-2 hover:text-text`}
        >
          <LayoutGrid size={20} className="shrink-0" />
          <span className="flex-1">หมวดหมู่</span>
        </Link>

        <div className={`${row} text-muted`}>
          <Moon size={20} className="shrink-0" />
          <span className="flex-1">ธีมสว่าง/มืด</span>
          <ThemeToggle />
        </div>

        <button
          onClick={logout}
          className={`${row} text-danger hover:bg-red-50`}
        >
          <LogOut size={20} className="shrink-0" />
          <span className="flex-1 text-left">ออกจากระบบ</span>
        </button>
      </div>
    </aside>
  );
}
