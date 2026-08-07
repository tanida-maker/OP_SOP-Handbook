import Link from "next/link";
import { FilePlus2, Pencil } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import type { DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "จัดการคู่มือ" };

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString("th-TH", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
}

export default async function AdminDocuments() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("documents")
    .select("*, category:categories(id,name,slug,icon,color)")
    .neq("status", "archived") // archived versions live under /archive
    .order("updated_at", { ascending: false });

  const docs = (data ?? []) as DocumentWithCategory[];

  return (
    <div className="space-y-5">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-extrabold text-text">คู่มือ (SOP / WI)</h1>
        <Link
          href="/admin/documents/new"
          className="flex items-center gap-2 rounded-lg bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700"
        >
          <FilePlus2 size={17} /> สร้างคู่มือใหม่
        </Link>
      </div>

      {docs.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-10 text-center text-muted">
          ยังไม่มีคู่มือ — เริ่มสร้างคู่มือแรกได้เลย
        </p>
      ) : (
        <div className="overflow-hidden rounded-2xl border border-border bg-surface">
          <table className="w-full text-sm">
            <thead className="border-b border-border bg-surface-2/60 text-left text-muted">
              <tr>
                <th className="px-4 py-3 font-semibold">ชื่อ</th>
                <th className="hidden px-4 py-3 font-semibold sm:table-cell">
                  หมวดหมู่
                </th>
                <th className="px-4 py-3 font-semibold">สถานะ</th>
                <th className="hidden px-4 py-3 font-semibold md:table-cell">
                  อัปเดต
                </th>
                <th className="px-4 py-3"></th>
              </tr>
            </thead>
            <tbody>
              {docs.map((d) => (
                <tr key={d.id} className="border-b border-border last:border-0">
                  <td className="px-4 py-3">
                    <span className="font-medium text-text">{d.title}</span>
                    {d.is_onboarding && (
                      <span className="ml-2 rounded bg-brand-50 px-1.5 py-0.5 text-[10px] font-semibold text-brand-700">
                        Onboarding
                      </span>
                    )}
                  </td>
                  <td className="hidden px-4 py-3 text-muted sm:table-cell">
                    {d.category?.name ?? "—"}
                  </td>
                  <td className="px-4 py-3">
                    <span
                      className={`inline-block whitespace-nowrap rounded-full px-2.5 py-1 text-[11px] font-semibold ${
                        d.status === "published"
                          ? "bg-green-100 text-green-700"
                          : d.status === "archived"
                          ? "bg-slate-200 text-slate-600"
                          : "bg-amber-100 text-amber-700"
                      }`}
                    >
                      {d.status === "published"
                        ? "เผยแพร่แล้ว"
                        : d.status === "archived"
                        ? "เก็บถาวร"
                        : "ฉบับร่าง"}
                    </span>
                  </td>
                  <td className="hidden px-4 py-3 text-muted md:table-cell">
                    {formatDate(d.updated_at)}
                  </td>
                  <td className="px-4 py-3 text-right">
                    <Link
                      href={`/admin/documents/${d.id}`}
                      className="inline-flex items-center gap-1.5 rounded-lg border border-border px-3 py-1.5 text-xs font-medium text-text hover:border-brand-300"
                    >
                      <Pencil size={14} /> แก้ไข
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
