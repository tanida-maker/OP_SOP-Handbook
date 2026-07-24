import Link from "next/link";
import { ArrowRight, Clock } from "lucide-react";
import Icon from "./Icon";
import { categoryPastel } from "@/lib/categoryStyle";
import type { DocumentWithCategory } from "@/lib/types";

function shortDate(iso: string) {
  return new Date(iso).toLocaleDateString("th-TH", {
    day: "numeric",
    month: "short",
  });
}

export default function DocumentCard({ doc }: { doc: DocumentWithCategory }) {
  const p = categoryPastel(doc.category?.slug);

  return (
    <Link
      href={`/sop/${doc.slug}`}
      className="group flex flex-col rounded-[20px] border border-border bg-surface p-2 shadow-sm transition hover:-translate-y-1 hover:shadow-lg"
    >
      {/* Illustrated pastel header */}
      <div
        className="relative h-32 overflow-hidden rounded-[14px]"
        style={{ background: p.grad }}
      >
        {/* soft decorative blobs */}
        <span
          className="absolute -right-6 -top-8 h-24 w-24 rounded-full"
          style={{ background: "rgba(255,255,255,0.35)" }}
        />
        <span
          className="absolute -bottom-10 right-8 h-20 w-20 rounded-2xl"
          style={{ background: "rgba(255,255,255,0.22)", rotate: "18deg" }}
        />
        {/* watermark category icon */}
        <div
          className="absolute bottom-2 right-3 transition group-hover:scale-110"
          style={{ color: p.ink, opacity: 0.9 }}
        >
          {doc.cover_image ? null : <Icon name={doc.category?.icon} size={46} />}
        </div>
        {doc.cover_image && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            src={doc.cover_image}
            alt=""
            className="absolute inset-0 h-full w-full object-cover"
          />
        )}
        {/* category chip */}
        {doc.category && (
          <span
            className="absolute left-3 top-3 rounded-full px-2.5 py-1 text-[11px] font-bold backdrop-blur"
            style={{ background: p.chip, color: p.ink }}
          >
            {doc.category.name}
          </span>
        )}
        {doc.is_onboarding && (
          <span
            className="absolute right-3 top-3 rounded-full bg-white/70 px-2 py-0.5 text-[10px] font-bold"
            style={{ color: p.ink }}
          >
            Onboarding
          </span>
        )}
      </div>

      {/* Body */}
      <div className="flex flex-1 flex-col px-3 pb-2 pt-3">
        <span className="text-[11px] font-semibold uppercase tracking-wide text-muted">
          {doc.status === "draft" ? "ฉบับร่าง" : "คู่มือ · SOP"}
        </span>
        <h3 className="clamp-2 mt-1 font-bold leading-snug text-text group-hover:text-brand-700">
          {doc.title}
        </h3>
        {doc.summary && (
          <p className="clamp-2 mt-1.5 text-[13px] text-muted">{doc.summary}</p>
        )}

        {/* Footer stats row */}
        <div className="mt-3 flex items-center justify-between border-t border-border pt-2.5 text-xs text-muted">
          <span className="flex items-center gap-1.5">
            <Clock size={13} /> {shortDate(doc.updated_at)}
          </span>
          <span className="flex items-center gap-1 font-semibold text-brand-600">
            อ่าน <ArrowRight size={13} className="transition group-hover:translate-x-0.5" />
          </span>
        </div>
      </div>
    </Link>
  );
}
