import Link from "next/link";
import Icon from "./Icon";
import type { Category } from "@/lib/types";

export default function CategoryCard({
  category,
  count,
}: {
  category: Category;
  count?: number;
}) {
  return (
    <Link
      href={`/category/${category.slug}`}
      className="group flex items-start gap-4 rounded-[var(--radius-card)] border border-border bg-surface p-4 shadow-sm transition hover:-translate-y-0.5 hover:border-brand-300 hover:shadow-md"
    >
      <span className="grid h-12 w-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-brand-600 group-hover:bg-brand-100">
        <Icon name={category.icon} />
      </span>
      <div className="min-w-0">
        <h3 className="font-bold text-text">{category.name}</h3>
        {category.description && (
          <p className="clamp-2 mt-1 text-sm text-muted">
            {category.description}
          </p>
        )}
        {typeof count === "number" && (
          <p className="mt-2 text-xs font-medium text-brand-600">
            {count} คู่มือ
          </p>
        )}
      </div>
    </Link>
  );
}
