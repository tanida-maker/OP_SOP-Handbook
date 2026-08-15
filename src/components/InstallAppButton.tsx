"use client";

import { useEffect, useState } from "react";
import { Share, Plus, X, Smartphone } from "lucide-react";
import { useT } from "./LanguageProvider";

// Chrome's "beforeinstallprompt" event (not in the standard DOM lib types).
type BeforeInstallPromptEvent = Event & {
  prompt: () => Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
};

let swRegistered = false;

function usePwaInstall() {
  const [deferred, setDeferred] = useState<BeforeInstallPromptEvent | null>(null);
  const [installed, setInstalled] = useState(false);
  const [isIOS, setIsIOS] = useState(false);

  useEffect(() => {
    if (!swRegistered && "serviceWorker" in navigator) {
      swRegistered = true;
      navigator.serviceWorker.register("/sw.js").catch(() => {});
    }

    const standalone =
      window.matchMedia("(display-mode: standalone)").matches ||
      (window.navigator as unknown as { standalone?: boolean }).standalone === true;
    setInstalled(standalone);

    const ua = window.navigator.userAgent || "";
    const iOS = /iphone|ipad|ipod/i.test(ua) ||
      // iPadOS 13+ reports as Mac; detect by touch
      (/macintosh/i.test(ua) && "ontouchend" in document);
    setIsIOS(iOS && !standalone);

    const onBIP = (e: Event) => {
      e.preventDefault();
      setDeferred(e as BeforeInstallPromptEvent);
    };
    const onInstalled = () => {
      setInstalled(true);
      setDeferred(null);
    };
    window.addEventListener("beforeinstallprompt", onBIP);
    window.addEventListener("appinstalled", onInstalled);
    return () => {
      window.removeEventListener("beforeinstallprompt", onBIP);
      window.removeEventListener("appinstalled", onInstalled);
    };
  }, []);

  const promptInstall = async () => {
    if (!deferred) return;
    await deferred.prompt();
    await deferred.userChoice;
    setDeferred(null);
  };

  return { installed, isIOS, canPrompt: !!deferred, promptInstall };
}

export default function InstallAppButton({
  variant = "icon",
  onAction,
}: {
  variant?: "icon" | "menu";
  onAction?: () => void;
}) {
  const t = useT();
  const { installed, isIOS, canPrompt, promptInstall } = usePwaInstall();
  const [showHelp, setShowHelp] = useState(false);

  // Only show when the app isn't installed and there's a real path to install.
  const visible = !installed && (canPrompt || isIOS);
  if (!visible) return null;

  async function handleClick() {
    if (canPrompt) {
      await promptInstall();
    } else if (isIOS) {
      setShowHelp(true);
    }
    onAction?.();
  }

  return (
    <>
      {variant === "icon" ? (
        <button
          onClick={handleClick}
          className="grid h-9 w-9 place-items-center rounded-full bg-amber-500 text-white shadow-sm ring-1 ring-amber-600/50 transition hover:bg-amber-600"
          aria-label={t("ติดตั้งแอป", "Install app")}
          title={t("ติดตั้งแอปลงหน้าจอโฮม", "Install app to home screen")}
        >
          <Smartphone size={18} strokeWidth={2.4} />
        </button>
      ) : (
        <button
          onClick={handleClick}
          className="flex w-full items-center gap-3 rounded-lg border border-amber-300 bg-gradient-to-r from-amber-100 to-brand-50 px-3 py-3 text-sm font-bold text-brand-800"
        >
          <span className="grid h-7 w-7 shrink-0 place-items-center rounded-lg bg-amber-400 text-white">
            <Smartphone size={16} />
          </span>
          <span className="leading-tight">
            {t("ติดตั้งแอป", "Install App")}
            <span className="block text-[11px] font-semibold text-brand-600">
              {t("เพิ่มลงหน้าจอโฮม", "Add to Home Screen")}
            </span>
          </span>
        </button>
      )}

      {/* iOS instructions (no native install prompt on Safari) */}
      {showHelp && (
        <div
          className="fixed inset-0 z-[60] flex items-end sm:items-center sm:justify-center"
          role="dialog"
          aria-modal="true"
        >
          <div
            className="absolute inset-0 bg-black/50"
            onClick={() => setShowHelp(false)}
          />
          <div className="relative w-full sm:max-w-sm rounded-t-2xl sm:rounded-2xl border border-border bg-surface p-5 shadow-xl">
            <div className="mb-3 flex items-center justify-between">
              <div className="flex items-center gap-2 text-text">
                <Smartphone size={18} className="text-brand-600" />
                <span className="text-base font-bold">
                  {t("ติดตั้งแอปบน iPhone / iPad", "Install on iPhone / iPad")}
                </span>
              </div>
              <button
                onClick={() => setShowHelp(false)}
                className="grid h-8 w-8 place-items-center rounded-full border border-border text-muted"
                aria-label={t("ปิด", "Close")}
              >
                <X size={16} />
              </button>
            </div>
            <ol className="space-y-3 text-sm text-text">
              <li className="flex items-start gap-3">
                <span className="grid h-6 w-6 shrink-0 place-items-center rounded-full bg-brand-100 text-xs font-bold text-brand-700">
                  1
                </span>
                <span className="flex flex-wrap items-center gap-1">
                  {t("แตะปุ่ม", "Tap the")}
                  <span className="inline-flex items-center gap-1 rounded-md bg-surface-2 px-1.5 py-0.5 font-semibold">
                    <Share size={13} /> {t("แชร์", "Share")}
                  </span>
                  {t("ในแถบเมนูของ Safari", "button in Safari")}
                </span>
              </li>
              <li className="flex items-start gap-3">
                <span className="grid h-6 w-6 shrink-0 place-items-center rounded-full bg-brand-100 text-xs font-bold text-brand-700">
                  2
                </span>
                <span className="flex flex-wrap items-center gap-1">
                  {t("เลือก", "Choose")}
                  <span className="inline-flex items-center gap-1 rounded-md bg-surface-2 px-1.5 py-0.5 font-semibold">
                    <Plus size={13} /> {t("เพิ่มไปยังหน้าจอโฮม", "Add to Home Screen")}
                  </span>
                </span>
              </li>
              <li className="flex items-start gap-3">
                <span className="grid h-6 w-6 shrink-0 place-items-center rounded-full bg-brand-100 text-xs font-bold text-brand-700">
                  3
                </span>
                <span>
                  {t("แตะ ", "Tap ")}
                  <strong>{t("เพิ่ม (Add)", "Add")}</strong>
                  {t(" มุมขวาบน — เสร็จเรียบร้อย", " in the top-right — done!")}
                </span>
              </li>
            </ol>
          </div>
        </div>
      )}
    </>
  );
}
