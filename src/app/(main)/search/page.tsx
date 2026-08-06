import { SearchX } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import DocumentCard from "@/components/DocumentCard";
import SearchBox from "@/components/SearchBox";
import T from "@/components/T";
import type { DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "ค้นหา" };

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const { q } = await searchParams;
  const term = (q ?? "").trim();

  let docs: DocumentWithCategory[] = [];
  if (term) {
    const supabase = await createClient();
    const escaped = term.replace(/[%,]/g, " ");
    const { data } = await supabase
      .from("documents")
      .select("*, category:categories(id,name,slug,icon,color)")
      .eq("status", "published")
      .or(
        `title.ilike.%${escaped}%,summary.ilike.%${escaped}%,content_html.ilike.%${escaped}%`
      )
      .order("updated_at", { ascending: false })
      .limit(40);
    docs = (data ?? []) as DocumentWithCategory[];
  }

  return (
    <div className="space-y-6">
      <div className="mx-auto max-w-xl">
        <SearchBox autoFocus defaultValue={term} />
      </div>

      {term && (
        <p className="text-sm text-muted">
          <T
            th={`ผลการค้นหา "${term}" — พบ ${docs.length} รายการ`}
            en={`Results for "${term}" — ${docs.length} found`}
          />
        </p>
      )}

      {term && docs.length === 0 ? (
        <div className="flex flex-col items-center gap-3 rounded-xl border border-dashed border-border bg-surface p-12 text-center">
          <SearchX size={40} className="text-muted" />
          <p className="text-muted">
            <T th="ไม่พบคู่มือที่ตรงกับคำค้นหา" en="No manuals match your search" />
          </p>
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {docs.map((d) => (
            <DocumentCard key={d.id} doc={d} />
          ))}
        </div>
      )}
    </div>
  );
}
