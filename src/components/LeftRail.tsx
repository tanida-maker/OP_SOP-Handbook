"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import {
  GraduationCap,
  Home,
  LayoutGrid,
  LogOut,
  Megaphone,
  Search,
  Settings,
  type LucideIcon,
} from "lucide-react";
import ThemeToggle from "./ThemeToggle";
import { createClient } from "@/lib/supabase/client";

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
    {
      href: "/announcements",
      label: "ประกาศ",
      icon: Megaphone,
      badge: announceCount,
    },
    { href: "/search", label: "ค้นหา", icon: Search },
  ];
  if (isAdmin) items.push({ href: "/admin", label: "ระบบจัดการ", icon: Settings });

  const isActive = (href: string) =>
    href === "/" ? pathname === "/" : pathname.startsWith(href);

  async function logout() {
    await createClient().auth.signOut();
    router.push("/login");
    router.refresh();
  }

  return (
    <aside className="fixed inset-y-0 left-0 z-40 hidden w-[76px] flex-col items-center border-r border-border bg-surface py-5 md:flex">
      <Link
        href="/"
        className="grid h-11 w-11 place-items-center rounded-2xl bg-brand-600 text-lg font-extrabold text-white shadow-sm"
        title="AIRPORTELs SOP Hub"
      >
        A
      </Link>

      <nav className="mt-8 flex flex-1 flex-col items-center gap-2">
        {items.map((it) => {
          const active = isActive(it.href);
          return (
            <Link
              key={it.href}
              href={it.href}
              title={it.label}
              className={`relative grid h-11 w-11 place-items-center rounded-2xl transition ${
                active
                  ? "bg-brand-50 text-brand-700"
                  : "text-muted hover:bg-surface-2 hover:text-text"
              }`}
            >
              <it.icon size={21} />
              {active && (
                <span className="absolute -left-5 h-6 w-1.5 rounded-full bg-brand-600" />
              )}
              {!!it.badge && it.badge > 0 && (
                <span className="absolute -right-0.5 -top-0.5 grid h-4 min-w-4 place-items-center rounded-full bg-accent px-1 text-[10px] font-bold text-white">
                  {it.badge}
                </span>
              )}
            </Link>
          );
        })}
      </nav>

      <div className="mt-4 flex flex-col items-center gap-2">
        <Link
          href="/#categories"
          title="หมวดหมู่"
          className="grid h-11 w-11 place-items-center rounded-2xl text-muted transition hover:bg-surface-2 hover:text-text"
        >
          <LayoutGrid size={21} />
        </Link>
        <ThemeToggle />
        <button
          onClick={logout}
          title="ออกจากระบบ"
          className="grid h-11 w-11 place-items-center rounded-2xl text-muted transition hover:bg-red-50 hover:text-danger"
        >
          <LogOut size={21} />
        </button>
      </div>
    </aside>
  );
}
