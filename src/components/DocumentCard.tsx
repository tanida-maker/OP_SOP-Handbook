import Link from "next/link";
import { ArrowRight, Clock } from "lucide-react";
import Icon from "./Icon";
import T from "./T";
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
      {/* Colorful category cover (pastel, by category) */}
      <div
        className="relative h-36 overflow-hidden rounded-[14px]"
        style={{ background: p.grad }}
      >
        {/* layered soft shapes for depth */}
        <span
          className="absolute -right-8 -top-10 h-28 w-28 rounded-full"
          style={{ background: "rgba(255,255,255,0.32)" }}
        />
        <span
          className="absolute -bottom-12 -left-6 h-28 w-28 rounded-full"
          style={{ background: "rgba(255,255,255,0.18)" }}
        />
        <span
          className="absolute bottom-5 right-9 h-14 w-14 rotate-12 rounded-2xl"
          style={{ background: "rgba(255,255,255,0.16)" }}
        />

        {/* big category icon in a soft tile */}
        <div className="absolute inset-0 flex items-center justify-center">
          <span
            className="grid h-[72px] w-[72px] place-items-center rounded-2xl shadow-sm transition group-hover:scale-110 group-hover:-rotate-3"
            style={{ background: "rgba(255,255,255,0.6)", color: p.ink }}
          >
            <Icon name={doc.category?.icon} size={38} />
          </span>
        </div>

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
            className="absolute right-3 top-3 rounded-full bg-white/75 px-2 py-0.5 text-[10px] font-bold"
            style={{ color: p.ink }}
          >
            Onboarding
          </span>
        )}
      </div>

      {/* Body */}
      <div className="flex flex-1 flex-col px-3 pb-2 pt-3">
        <span className="text-[11px] font-semibold uppercase tracking-wide text-muted">
          {doc.status === "draft" ? (
            <T th="ฉบับร่าง" en="Draft" />
          ) : (
            <T th="คู่มือ · SOP" en="Manual · SOP" />
          )}
        </span>
        <h3 className="clamp-2 mt-1 font-bold leading-snug text-text group-hover:text-brand-700">
          {doc.title}
        </h3>
        {doc.summary && (
          <p className="clamp-2 mt-1.5 text-[13px] text-muted">{doc.summary}</p>
        )}

        <div className="mt-3 flex items-center justify-between border-t border-border pt-2.5 text-xs text-muted">
          <span className="flex items-center gap-1.5">
            <Clock size={13} /> {shortDate(doc.updated_at)}
          </span>
          <span className="flex items-center gap-1 font-semibold text-brand-600">
            <T th="อ่าน" en="Read" />{" "}
            <ArrowRight size={13} className="transition group-hover:translate-x-0.5" />
          </span>
        </div>
      </div>
    </Link>
  );
}
