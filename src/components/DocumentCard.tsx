import Link from "next/link";
import { FileText } from "lucide-react";
import type { DocumentWithCategory } from "@/lib/types";

export default function DocumentCard({ doc }: { doc: DocumentWithCategory }) {
  return (
    <Link
      href={`/sop/${doc.slug}`}
      className="group flex flex-col overflow-hidden rounded-[var(--radius-card)] border border-border bg-surface shadow-sm transition hover:-translate-y-0.5 hover:border-brand-300 hover:shadow-md"
    >
      <div className="relative aspect-[16/9] w-full overflow-hidden bg-surface-2">
        {doc.cover_image ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            src={doc.cover_image}
            alt=""
            className="h-full w-full object-cover transition group-hover:scale-105"
          />
        ) : (
          <div className="grid h-full w-full place-items-center text-brand-300">
            <FileText size={40} />
          </div>
        )}
        {doc.category && (
          <span className="absolute left-3 top-3 rounded-full bg-surface/90 px-2.5 py-1 text-[11px] font-semibold text-brand-700 backdrop-blur">
            {doc.category.name}
          </span>
        )}
      </div>
      <div className="flex flex-1 flex-col p-4">
        <h3 className="clamp-2 font-bold leading-snug text-text group-hover:text-brand-700">
          {doc.title}
        </h3>
        {doc.summary && (
          <p className="clamp-2 mt-1.5 text-sm text-muted">{doc.summary}</p>
        )}
        {doc.status === "draft" && (
          <span className="mt-3 w-fit rounded-full bg-amber-100 px-2 py-0.5 text-[11px] font-semibold text-amber-700">
            ฉบับร่าง
          </span>
        )}
      </div>
    </Link>
  );
}
