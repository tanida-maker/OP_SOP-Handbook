import Link from "next/link";
import { notFound } from "next/navigation";
import { Archive, ChevronRight, Clock } from "lucide-react";
import { createClient, getSessionUser } from "@/lib/supabase/server";
import T from "@/components/T";
import type { DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "คลังเอกสารเก็บถาวร (Archive)" };

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString("th-TH", {
    year: "numeric",
    month: "short",
    day: "numeric",
  });
}

export default async function ArchivePage() {
  const { isAdmin } = await getSessionUser();
  if (!isAdmin) notFound();

  const supabase = await createClient();
  const { data } = await supabase
    .from("documents")
    .select("*, category:categories(id,name,slug,icon,color)")
    .eq("status", "archived")
    .order("updated_at", { ascending: false });

  const docs = (data ?? []) as DocumentWithCategory[];

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <header className="flex items-start gap-4">
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-brand-600 text-white">
          <Archive size={26} />
        </span>
        <div>
          <h1 className="text-2xl font-extrabold text-text">
            <T th="คลังเอกสารเก็บถาวร" en="Archive" />
          </h1>
          <p className="mt-1 text-muted">
            <T
              th="เอกสารฉบับเก่าที่ถูกแทนที่ด้วยฉบับใหม่แล้ว — เก็บไว้เพื่อการอ้างอิงของแอดมิน (พนักงานทั่วไปไม่เห็น)"
              en="Superseded document versions, kept for admin reference (hidden from staff)"
            />
          </p>
        </div>
      </header>

      {docs.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-10 text-center text-muted">
          <T th="ยังไม่มีเอกสารในคลังเก็บถาวร" en="No archived documents yet" />
        </p>
      ) : (
        <ul className="space-y-3">
          {docs.map((d) => (
            <li key={d.id}>
              <Link
                href={`/sop/${d.slug}`}
                className="flex items-center gap-3 rounded-xl border border-border bg-surface p-4 transition hover:-translate-y-0.5 hover:border-brand-300 hover:shadow-sm"
              >
                <span className="grid h-10 w-10 shrink-0 place-items-center rounded-lg bg-amber-100 text-amber-700">
                  <Archive size={18} />
                </span>
                <div className="min-w-0 flex-1">
                  <p className="clamp-1 font-semibold text-text">{d.title}</p>
                  <p className="mt-0.5 flex items-center gap-1.5 text-xs text-muted">
                    <Clock size={12} /> {formatDate(d.updated_at)}
                    {d.category?.name ? ` · ${d.category.name}` : ""}
                  </p>
                </div>
                <ChevronRight size={16} className="shrink-0 text-muted" />
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
