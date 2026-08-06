"use client";

import { Languages } from "lucide-react";
import { useLang } from "./LanguageProvider";

export default function LangToggle() {
  const { lang, setLang } = useLang();
  return (
    <button
      onClick={() => setLang(lang === "en" ? "th" : "en")}
      className="grid h-8 w-14 place-items-center rounded-full border border-border bg-surface text-xs font-bold text-text transition hover:border-brand-300"
      title={lang === "en" ? "เปลี่ยนเป็นภาษาไทย" : "Switch to English"}
      aria-label="Toggle language"
    >
      <span className="flex items-center gap-1">
        <Languages size={13} />
        {lang === "en" ? "TH" : "EN"}
      </span>
    </button>
  );
}
