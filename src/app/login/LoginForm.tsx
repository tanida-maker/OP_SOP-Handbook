"use client";

import { useRouter, useSearchParams } from "next/navigation";
import { useState } from "react";
import { Loader2, LogIn, Mail } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/LanguageProvider";

function GoogleIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 48 48" aria-hidden="true">
      <path
        fill="#EA4335"
        d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"
      />
      <path
        fill="#4285F4"
        d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"
      />
      <path
        fill="#FBBC05"
        d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"
      />
      <path
        fill="#34A853"
        d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"
      />
    </svg>
  );
}

export default function LoginForm() {
  const router = useRouter();
  const params = useSearchParams();
  const t = useT();
  const next = params.get("next") || "/";

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [googleLoading, setGoogleLoading] = useState(false);
  const [msg, setMsg] = useState<{ type: "error" | "ok"; text: string } | null>(
    null
  );

  const callbackUrl = () =>
    `${window.location.origin}/auth/callback?next=${encodeURIComponent(next)}`;

  async function signInGoogle() {
    setGoogleLoading(true);
    setMsg(null);
    const supabase = createClient();
    const { error } = await supabase.auth.signInWithOAuth({
      provider: "google",
      options: {
        redirectTo: callbackUrl(),
        queryParams: { prompt: "select_account" },
      },
    });
    if (error) {
      setGoogleLoading(false);
      setMsg({
        type: "error",
        text: t("เข้าสู่ระบบด้วย Google ไม่สำเร็จ", "Google sign-in failed"),
      });
    }
    // On success the browser is redirected to Google, so no further action here.
  }

  async function signInPassword(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    setMsg(null);
    const supabase = createClient();
    const { error } = await supabase.auth.signInWithPassword({
      email: email.trim(),
      password,
    });
    setLoading(false);
    if (error) {
      setMsg({
        type: "error",
        text: t("อีเมลหรือรหัสผ่านไม่ถูกต้อง", "Incorrect email or password"),
      });
      return;
    }
    router.push(next);
    router.refresh();
  }

  async function sendMagicLink() {
    if (!email.trim()) {
      setMsg({
        type: "error",
        text: t("กรุณากรอกอีเมลก่อน", "Please enter your email first"),
      });
      return;
    }
    setLoading(true);
    setMsg(null);
    const supabase = createClient();
    const { error } = await supabase.auth.signInWithOtp({
      email: email.trim(),
      options: { emailRedirectTo: callbackUrl() },
    });
    setLoading(false);
    setMsg(
      error
        ? {
            type: "error",
            text: t("ส่งลิงก์ไม่สำเร็จ กรุณาลองใหม่", "Could not send the link. Please try again"),
          }
        : {
            type: "ok",
            text: t("ส่งลิงก์เข้าสู่ระบบไปที่อีเมลแล้ว", "A sign-in link has been sent to your email"),
          }
    );
  }

  const busy = loading || googleLoading;

  return (
    <div className="space-y-4">
      {/* Google sign-in (same account pool as the Scheduling app) */}
      <button
        type="button"
        onClick={signInGoogle}
        disabled={busy}
        className="flex w-full items-center justify-center gap-3 rounded-lg border border-border bg-surface py-2.5 text-sm font-semibold text-text transition hover:bg-surface-2 disabled:opacity-60"
      >
        {googleLoading ? (
          <Loader2 size={18} className="animate-spin" />
        ) : (
          <GoogleIcon />
        )}
        {t("เข้าสู่ระบบด้วย Google", "Sign in with Google")}
      </button>

      <div className="flex items-center gap-3">
        <span className="h-px flex-1 bg-border" />
        <span className="text-xs text-muted">{t("หรือ", "or")}</span>
        <span className="h-px flex-1 bg-border" />
      </div>

      <form onSubmit={signInPassword} className="space-y-4">
        <div>
          <label className="mb-1 block text-sm font-medium text-text">
            {t("อีเมล", "Email")}
          </label>
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="you@airportels.asia"
            className="w-full rounded-lg border border-border bg-surface px-3 py-2.5 text-sm text-text outline-none focus:border-brand-400"
          />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium text-text">
            {t("รหัสผ่าน", "Password")}
          </label>
          <input
            type="password"
            required
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="••••••••"
            className="w-full rounded-lg border border-border bg-surface px-3 py-2.5 text-sm text-text outline-none focus:border-brand-400"
          />
        </div>

        {msg && (
          <p
            className={`rounded-lg px-3 py-2 text-sm ${
              msg.type === "error"
                ? "bg-red-50 text-red-700"
                : "bg-green-50 text-green-700"
            }`}
          >
            {msg.text}
          </p>
        )}

        <button
          type="submit"
          disabled={busy}
          className="flex w-full items-center justify-center gap-2 rounded-lg bg-brand-600 py-2.5 text-sm font-semibold text-white transition hover:bg-brand-700 disabled:opacity-60"
        >
          {loading ? (
            <Loader2 size={18} className="animate-spin" />
          ) : (
            <LogIn size={18} />
          )}
          {t("เข้าสู่ระบบ", "Sign in")}
        </button>

        <button
          type="button"
          onClick={sendMagicLink}
          disabled={busy}
          className="flex w-full items-center justify-center gap-2 rounded-lg border border-border py-2.5 text-sm font-medium text-text transition hover:bg-surface-2 disabled:opacity-60"
        >
          <Mail size={18} /> {t("ส่งลิงก์เข้าสู่ระบบทางอีเมล", "Email me a sign-in link")}
        </button>
      </form>
    </div>
  );
}
