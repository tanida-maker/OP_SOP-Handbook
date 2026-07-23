import Link from "next/link";
import { FileText, FilePlus2, Megaphone, Tags } from "lucide-react";
import { createClient } from "@/lib/supabase/server";

export const dynamic = "force-dynamic";
export const metadata = { title: "ระบบจัดการ" };

async function count(table: string, filter?: (q: any) => any) {
  const supabase = await createClient();
  let q = supabase.from(table).select("*", { count: "exact", head: true });
  if (filter) q = filter(q);
  const { count: c } = await q;
  return c ?? 0;
}

export default async function AdminHome() {
  const [total, published, drafts, cats, anns] = await Promise.all([
    count("documents"),
    count("documents", (q) => q.eq("status", "published")),
    count("documents", (q) => q.eq("status", "draft")),
    count("categories"),
    count("announcements"),
  ]);

  const stats = [
    { label: "คู่มือทั้งหมด", value: total, href: "/admin/documents" },
    { label: "เผยแพร่แล้ว", value: published, href: "/admin/documents" },
    { label: "ฉบับร่าง", value: drafts, href: "/admin/documents" },
    { label: "หมวดหมู่", value: cats, href: "/admin/categories" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-extrabold text-text">ภาพรวม</h1>
        <Link
          href="/admin/documents/new"
          className="flex items-center gap-2 rounded-lg bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700"
        >
          <FilePlus2 size={17} /> สร้างคู่มือใหม่
        </Link>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {stats.map((s) => (
          <Link
            key={s.label}
            href={s.href}
            className="rounded-2xl border border-border bg-surface p-5 hover:border-brand-300"
          >
            <p className="text-sm text-muted">{s.label}</p>
            <p className="mt-1 text-3xl font-extrabold text-text">{s.value}</p>
          </Link>
        ))}
      </div>

      <div className="grid gap-4 sm:grid-cols-3">
        <Link
          href="/admin/documents"
          className="flex items-center gap-3 rounded-2xl border border-border bg-surface p-5 hover:border-brand-300"
        >
          <FileText className="text-brand-600" />
          <span className="font-semibold text-text">จัดการคู่มือ</span>
        </Link>
        <Link
          href="/admin/categories"
          className="flex items-center gap-3 rounded-2xl border border-border bg-surface p-5 hover:border-brand-300"
        >
          <Tags className="text-brand-600" />
          <span className="font-semibold text-text">จัดการหมวดหมู่</span>
        </Link>
        <Link
          href="/admin/announcements"
          className="flex items-center gap-3 rounded-2xl border border-border bg-surface p-5 hover:border-brand-300"
        >
          <Megaphone className="text-brand-600" />
          <span className="font-semibold text-text">
            ประกาศ ({anns})
          </span>
        </Link>
      </div>
    </div>
  );
}
