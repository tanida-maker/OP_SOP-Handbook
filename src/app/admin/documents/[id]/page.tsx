import Link from "next/link";
import { notFound } from "next/navigation";
import { ExternalLink } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import DocumentForm from "../DocumentForm";
import type { Category, Document } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "แก้ไขคู่มือ" };

export default async function EditDocumentPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createClient();

  const [{ data: doc }, { data: cats }] = await Promise.all([
    supabase.from("documents").select("*").eq("id", id).single(),
    supabase.from("categories").select("*").order("sort_order"),
  ]);

  if (!doc) notFound();
  const d = doc as Document;

  return (
    <div className="space-y-5">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-extrabold text-text">แก้ไขคู่มือ</h1>
        {d.status === "published" && (
          <Link
            href={`/sop/${d.slug}`}
            target="_blank"
            className="flex items-center gap-1.5 text-sm font-medium text-brand-600 hover:underline"
          >
            <ExternalLink size={15} /> ดูหน้าจริง
          </Link>
        )}
      </div>
      <DocumentForm categories={(cats ?? []) as Category[]} doc={d} />
    </div>
  );
}
