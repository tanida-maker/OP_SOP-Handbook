import Link from "next/link";
import { notFound } from "next/navigation";
import { ChevronRight, Clock, Pencil, Tag } from "lucide-react";
import { createClient, getSessionUser } from "@/lib/supabase/server";
import ContentRenderer from "@/components/ContentRenderer";
import DocumentCard from "@/components/DocumentCard";
import type { DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();
  const { data } = await supabase
    .from("documents")
    .select("title, summary")
    .eq("slug", slug)
    .single();
  return { title: data?.title ?? "คู่มือ", description: data?.summary ?? undefined };
}

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString("th-TH", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

export default async function SopPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const supabase = await createClient();
  const { profile } = await getSessionUser();
  const isAdmin = profile?.role === "admin";

  const { data: doc } = await supabase
    .from("documents")
    .select("*, category:categories(id,name,slug,icon,color)")
    .eq("slug", slug)
    .single();

  if (!doc) notFound();
  const d = doc as DocumentWithCategory;

  // Related docs in the same category.
  const { data: related } = d.category_id
    ? await supabase
        .from("documents")
        .select("*, category:categories(id,name,slug,icon,color)")
        .eq("category_id", d.category_id)
        .eq("status", "published")
        .neq("id", d.id)
        .limit(3)
    : { data: [] };

  const relatedDocs = (related ?? []) as DocumentWithCategory[];

  return (
    <article className="mx-auto max-w-3xl space-y-6">
      <nav className="flex flex-wrap items-center gap-1.5 text-sm text-muted">
        <Link href="/" className="hover:text-text">
          หน้าแรก
        </Link>
        <ChevronRight size={14} />
        {d.category && (
          <>
            <Link
              href={`/category/${d.category.slug}`}
              className="hover:text-text"
            >
              {d.category.name}
            </Link>
            <ChevronRight size={14} />
          </>
        )}
        <span className="clamp-1 text-text">{d.title}</span>
      </nav>

      <header className="space-y-4">
        {d.status === "draft" && (
          <span className="inline-block rounded-full bg-amber-100 px-3 py-1 text-xs font-semibold text-amber-700">
            ฉบับร่าง (มองเห็นเฉพาะแอดมิน)
          </span>
        )}
        <div className="flex items-start justify-between gap-4">
          <h1 className="text-2xl font-extrabold leading-tight text-text md:text-3xl">
            {d.title}
          </h1>
          {isAdmin && (
            <Link
              href={`/admin/documents/${d.id}`}
              className="flex shrink-0 items-center gap-1.5 rounded-lg border border-border bg-surface px-3 py-2 text-sm font-medium text-text hover:border-brand-300"
            >
              <Pencil size={15} /> แก้ไข
            </Link>
          )}
        </div>
        {d.summary && <p className="text-lg text-muted">{d.summary}</p>}
        <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-muted">
          <span className="flex items-center gap-1.5">
            <Clock size={15} /> อัปเดต {formatDate(d.updated_at)}
          </span>
          <span>เวอร์ชัน {d.version}</span>
        </div>
        {d.cover_image && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            src={d.cover_image}
            alt=""
            className="w-full rounded-2xl border border-border object-cover"
          />
        )}
      </header>

      <div className="rounded-2xl border border-border bg-surface p-5 md:p-8">
        <ContentRenderer html={d.content_html} />
      </div>

      {d.tags && d.tags.length > 0 && (
        <div className="flex flex-wrap items-center gap-2">
          <Tag size={15} className="text-muted" />
          {d.tags.map((t) => (
            <span
              key={t}
              className="rounded-full bg-surface-2 px-3 py-1 text-xs text-muted"
            >
              {t}
            </span>
          ))}
        </div>
      )}

      {relatedDocs.length > 0 && (
        <section className="space-y-4 pt-4">
          <h2 className="text-lg font-bold text-text">คู่มือที่เกี่ยวข้อง</h2>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {relatedDocs.map((r) => (
              <DocumentCard key={r.id} doc={r} />
            ))}
          </div>
        </section>
      )}
    </article>
  );
}
