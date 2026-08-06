"use client";

import { createContext, useContext, useEffect, useState } from "react";

export type Lang = "th" | "en";

const Ctx = createContext<{
  lang: Lang;
  setLang: (l: Lang) => void;
}>({ lang: "th", setLang: () => {} });

export function LanguageProvider({ children }: { children: React.ReactNode }) {
  const [lang, setLangState] = useState<Lang>("th");

  useEffect(() => {
    try {
      const s = localStorage.getItem("sop-lang");
      if (s === "en" || s === "th") setLangState(s);
    } catch {}
  }, []);

  const setLang = (l: Lang) => {
    setLangState(l);
    try {
      localStorage.setItem("sop-lang", l);
    } catch {}
    document.documentElement.setAttribute("lang", l);
  };

  return <Ctx.Provider value={{ lang, setLang }}>{children}</Ctx.Provider>;
}

export function useLang() {
  return useContext(Ctx);
}

// Translation helper: t("ไทย", "English") → picks by current language.
export function useT() {
  const { lang } = useContext(Ctx);
  return (th: string, en: string) => (lang === "en" ? en : th);
}
