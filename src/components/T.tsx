"use client";

import { useT } from "./LanguageProvider";

// Inline bilingual text usable inside server components:  <T th="ไทย" en="English" />
export default function T({ th, en }: { th: string; en: string }) {
  const t = useT();
  return <>{t(th, en)}</>;
}
