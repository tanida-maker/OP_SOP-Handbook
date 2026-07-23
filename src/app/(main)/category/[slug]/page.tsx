import Link from "next/link";
import { notFound } from "next/navigation";
import { ChevronRight } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import Icon from "@/components/Icon";
import DocumentCard from "@/components/DocumentCard";
import type { Category, DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();
  const { data } = await supabase
    .from("categories")
    .select("name")
    .eq("slug", slug)
    .single();
  return { title: data?.name ?? "หมวดหมู่" };
}

export default async function CategoryPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();

  const { data: category } = await supabase
    .from("categories")
    .select("*")
    .eq("slug", slug)
    .single();

  if (!category) notFound();
  const cat = category as Category;

  const { data: docs } = await supabase
    .from("documents")
    .select("*, category:categories(id,name,slug,icon,color)")
    .eq("category_id", cat.id)
    .eq("status", "published")
    .order("updated_at", { ascending: false });

  const documents = (docs ?? []) as DocumentWithCategory[];

  return (
    <div className="space-y-6">
      <nav className="flex items-center gap-1.5 text-sm text-muted">
        <Link href="/" className="hover:text-text">
          หน้าแรก
        </Link>
        <ChevronRight size={14} />
        <span className="text-text">{cat.name}</span>
      </nav>

      <header className="flex items-start gap-4">
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-brand-50 text-brand-600">
          <Icon name={cat.icon} size={28} />
        </span>
        <div>
          <h1 className="text-2xl font-extrabold text-text">{cat.name}</h1>
          {cat.description && (
            <p className="mt-1 text-muted">{cat.description}</p>
          )}
        </div>
      </header>

      {documents.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-8 text-center text-muted">
          ยังไม่มีคู่มือในหมวดนี้
        </p>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {documents.map((d) => (
            <DocumentCard key={d.id} doc={d} />
          ))}
        </div>
      )}
    </div>
  );
}
