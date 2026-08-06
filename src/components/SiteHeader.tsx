"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";
import {
  CalendarDays,
  GraduationCap,
  Home,
  LayoutGrid,
  LogOut,
  Megaphone,
  Menu,
  Settings,
  User,
  X,
} from "lucide-react";
import ThemeToggle from "./ThemeToggle";
import LangToggle from "./LangToggle";
import SearchBox from "./SearchBox";
import Logo from "./Logo";
import { useT } from "./LanguageProvider";
import { createClient } from "@/lib/supabase/client";

export default function SiteHeader({
  fullName,
  isAdmin,
}: {
  fullName: string;
  isAdmin: boolean;
}) {
  const router = useRouter();
  const t = useT();
  const [open, setOpen] = useState(false);
  const [menu, setMenu] = useState(false);

  const NAV = [
    { href: "/", label: t("หน้าแรก", "Home"), icon: Home },
    { href: "/onboarding", label: t("พนักงานใหม่", "New Staff"), icon: GraduationCap },
    { href: "/announcements", label: t("ประกาศ", "Announcements"), icon: Megaphone },
  ];

  async function logout() {
    const supabase = createClient();
    await supabase.auth.signOut();
    router.push("/login");
    router.refresh();
  }

  return (
    <>
      <header className="sticky top-0 z-40 border-b border-border bg-surface/85 backdrop-blur">
      <div className="mx-auto flex h-16 max-w-6xl items-center gap-3 px-4">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-2 shrink-0">
          <Logo height={22} />
          <span className="hidden sm:block leading-tight">
            <span className="block text-sm font-extrabold tracking-tight text-text">
              AIRPORTELs
            </span>
            <span className="block text-[11px] font-medium text-muted">
              Operations Knowledge Center
            </span>
          </span>
        </Link>

        {/* Desktop nav */}
        <nav className="ml-2 hidden items-center gap-1 md:flex">
          {NAV.map((n) => (
            <Link
              key={n.href}
              href={n.href}
              className="rounded-full px-3 py-2 text-sm font-medium text-muted hover:bg-surface-2 hover:text-text transition"
            >
              {n.label}
            </Link>
          ))}
        </nav>

        {/* Search (desktop) */}
        <div className="ml-auto hidden max-w-xs flex-1 md:block">
          <SearchBox />
        </div>

        <div className="ml-auto flex items-center gap-2 md:ml-2">
          <LangToggle />
          <ThemeToggle />

          {/* User menu (desktop) */}
          <div className="relative hidden md:block">
            <button
              onClick={() => setMenu((v) => !v)}
              onBlur={() => setTimeout(() => setMenu(false), 150)}
              className="flex items-center gap-2 rounded-full border border-border bg-surface py-1 pl-1 pr-3 hover:border-brand-300 transition"
            >
              <span className="grid h-7 w-7 place-items-center rounded-full bg-brand-100 text-brand-700">
                <User size={16} />
              </span>
              <span className="max-w-[9rem] truncate text-sm font-medium text-text">
                {fullName}
              </span>
            </button>
            {menu && (
              <div className="absolute right-0 mt-2 w-52 overflow-hidden rounded-xl border border-border bg-surface shadow-lg">
                {isAdmin && (
                  <Link
                    href="/admin"
                    className="flex items-center gap-2 px-4 py-3 text-sm text-text hover:bg-surface-2"
                  >
                    <Settings size={16} /> {t("ระบบจัดการ (Admin)", "Admin")}
                  </Link>
                )}
                <button
                  onClick={logout}
                  className="flex w-full items-center gap-2 px-4 py-3 text-sm text-danger hover:bg-surface-2"
                >
                  <LogOut size={16} /> {t("ออกจากระบบ", "Log out")}
                </button>
              </div>
            )}
          </div>

          {/* Mobile hamburger */}
          <button
            onClick={() => setOpen(true)}
            className="grid h-9 w-9 place-items-center rounded-full border border-border bg-surface text-text md:hidden"
            aria-label={t("เมนู", "Menu")}
          >
            <Menu size={18} />
          </button>
        </div>
      </div>
      </header>

      {/* Mobile drawer (outside <header> so backdrop-blur doesn't trap position:fixed) */}
      {open && (
        <div className="fixed inset-0 z-50 md:hidden">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setOpen(false)}
          />
          <div className="absolute right-0 top-0 h-full w-80 max-w-[85%] bg-surface p-4 shadow-lg">
            <div className="mb-4 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="grid h-7 w-7 place-items-center rounded-full bg-brand-100 text-brand-700">
                  <User size={16} />
                </span>
                <span className="text-sm font-semibold text-text">
                  {fullName}
                </span>
              </div>
              <button
                onClick={() => setOpen(false)}
                className="grid h-9 w-9 place-items-center rounded-full border border-border"
                aria-label={t("ปิด", "Close")}
              >
                <X size={18} />
              </button>
            </div>

            <div className="mb-4" onClick={() => setOpen(false)}>
              <SearchBox />
            </div>

            <nav className="flex flex-col gap-1">
              {NAV.map((n) => (
                <Link
                  key={n.href}
                  href={n.href}
                  onClick={() => setOpen(false)}
                  className="flex items-center gap-3 rounded-lg px-3 py-3 text-sm font-medium text-text hover:bg-surface-2"
                >
                  <n.icon size={18} className="text-brand-600" />
                  {n.label}
                </Link>
              ))}
              <Link
                href="/#categories"
                onClick={() => setOpen(false)}
                className="flex items-center gap-3 rounded-lg px-3 py-3 text-sm font-medium text-text hover:bg-surface-2"
              >
                <LayoutGrid size={18} className="text-brand-600" />
                {t("หมวดหมู่ทั้งหมด", "All Categories")}
              </Link>
              <a
                href="https://airportels-scheduling.vercel.app"
                target="_blank"
                rel="noopener"
                onClick={() => setOpen(false)}
                className="flex items-center gap-3 rounded-lg px-3 py-3 text-sm font-medium text-text hover:bg-surface-2"
              >
                <CalendarDays size={18} className="text-brand-600" />
                {t("ตารางงาน (Scheduling)", "Scheduling")} ↗
              </a>
              {isAdmin && (
                <Link
                  href="/admin"
                  onClick={() => setOpen(false)}
                  className="flex items-center gap-3 rounded-lg px-3 py-3 text-sm font-medium text-text hover:bg-surface-2"
                >
                  <Settings size={18} className="text-brand-600" />
                  {t("ระบบจัดการ (Admin)", "Admin")}
                </Link>
              )}
            </nav>

            <button
              onClick={logout}
              className="mt-4 flex w-full items-center justify-center gap-2 rounded-lg border border-border py-3 text-sm font-medium text-danger hover:bg-surface-2"
            >
              <LogOut size={16} /> {t("ออกจากระบบ", "Log out")}
            </button>
          </div>
        </div>
      )}
    </>
  );
}
