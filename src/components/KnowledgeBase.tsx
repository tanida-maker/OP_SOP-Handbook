"use client";

import { useMemo, useState } from "react";
import { FileSearch } from "lucide-react";
import DocumentCard from "./DocumentCard";
import { useT } from "./LanguageProvider";
import type { Category, DocumentWithCategory } from "@/lib/types";

export default function KnowledgeBase({
  docs,
  categories,
}: {
  docs: DocumentWithCategory[];
  categories: Category[];
}) {
  const t = useT();
  const [active, setActive] = useState<string>("all");

  // Only show categories that actually have published docs.
  const usable = useMemo(() => {
    const withDocs = new Set(docs.map((d) => d.category?.slug).filter(Boolean));
    return categories.filter((c) => withDocs.has(c.slug));
  }, [docs, categories]);

  const shown = useMemo(
    () => (active === "all" ? docs : docs.filter((d) => d.category?.slug === active)),
    [docs, active]
  );

  const pill = (key: string, label: string) => {
    const on = active === key;
    return (
      <button
        key={key}
        onClick={() => setActive(key)}
        className={`shrink-0 rounded-full border px-4 py-2 text-sm font-semibold transition ${
          on
            ? "border-brand-600 bg-brand-600 text-white shadow-sm"
            : "border-border bg-surface text-muted hover:border-brand-300 hover:text-text"
        }`}
      >
        {label}
      </button>
    );
  };

  return (
    <section id="knowledge" className="scroll-mt-6 space-y-5">
      <div>
        <h2 className="text-2xl font-extrabold tracking-tight text-text">
          {t("คลังคู่มือการทำงาน", "Knowledge Base")}
        </h2>
        <p className="mt-1 text-sm text-muted">
          {t(
            `เลือกหมวดเพื่อกรอง หรือดูทั้งหมด — ${docs.length} คู่มือ`,
            `Filter by category or view all — ${docs.length} manuals`
          )}
        </p>
      </div>

      {/* Filter pills */}
      <div className="-mx-1 flex gap-2 overflow-x-auto px-1 pb-1">
        {pill("all", t("ทั้งหมด", "All"))}
        {usable.map((c) => pill(c.slug, c.name))}
      </div>

      {/* Cards grid */}
      {shown.length === 0 ? (
        <div className="flex flex-col items-center gap-3 rounded-2xl border border-dashed border-border bg-surface p-12 text-center">
          <FileSearch size={38} className="text-muted" />
          <p className="text-muted">{t("ยังไม่มีคู่มือในหมวดนี้", "No manuals in this category yet")}</p>
        </div>
      ) : (
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {shown.map((d) => (
            <DocumentCard key={d.id} doc={d} />
          ))}
        </div>
      )}
    </section>
  );
}
