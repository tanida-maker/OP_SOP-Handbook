"use client";

import { useRouter } from "next/navigation";
import { Search } from "lucide-react";
import { useState } from "react";
import { useT } from "./LanguageProvider";

export default function SearchBox({
  autoFocus = false,
  defaultValue = "",
  placeholder,
}: {
  autoFocus?: boolean;
  defaultValue?: string;
  placeholder?: string;
}) {
  const router = useRouter();
  const t = useT();
  const [q, setQ] = useState(defaultValue);
  const ph =
    placeholder ?? t("ค้นหา SOP, คู่มือ, ขั้นตอน...", "Search SOPs, manuals, steps...");

  function submit(e: React.FormEvent) {
    e.preventDefault();
    const term = q.trim();
    if (term) router.push(`/search?q=${encodeURIComponent(term)}`);
  }

  return (
    <form onSubmit={submit} className="relative w-full">
      <Search
        size={18}
        className="pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-muted"
      />
      <input
        // eslint-disable-next-line jsx-a11y/no-autofocus
        autoFocus={autoFocus}
        value={q}
        onChange={(e) => setQ(e.target.value)}
        placeholder={ph}
        className="w-full rounded-full border border-border bg-surface py-2.5 pl-11 pr-4 text-sm text-text placeholder:text-muted shadow-sm outline-none focus:border-brand-400"
      />
    </form>
  );
}
