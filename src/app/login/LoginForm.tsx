"use client";

import { useRouter, useSearchParams } from "next/navigation";
import { useState } from "react";
import { Loader2, LogIn, Mail } from "lucide-react";
import { createClient } from "@/lib/supabase/client";

export default function LoginForm() {
  const router = useRouter();
  const params = useSearchParams();
  const next = params.get("next") || "/";

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState<{ type: "error" | "ok"; text: string } | null>(
    null
  );

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
      setMsg({ type: "error", text: "อีเมลหรือรหัสผ่านไม่ถูกต้อง" });
      return;
    }
    router.push(next);
    router.refresh();
  }

  async function sendMagicLink() {
    if (!email.trim()) {
      setMsg({ type: "error", text: "กรุณากรอกอีเมลก่อน" });
      return;
    }
    setLoading(true);
    setMsg(null);
    const supabase = createClient();
    const { error } = await supabase.auth.signInWithOtp({
      email: email.trim(),
      options: {
        emailRedirectTo: `${window.location.origin}/auth/callback?next=${encodeURIComponent(
          next
        )}`,
      },
    });
    setLoading(false);
    setMsg(
      error
        ? { type: "error", text: "ส่งลิงก์ไม่สำเร็จ กรุณาลองใหม่" }
        : { type: "ok", text: "ส่งลิงก์เข้าสู่ระบบไปที่อีเมลแล้ว" }
    );
  }

  return (
    <form onSubmit={signInPassword} className="space-y-4">
      <div>
        <label className="mb-1 block text-sm font-medium text-text">
          อีเมล
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
          รหัสผ่าน
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
        disabled={loading}
        className="flex w-full items-center justify-center gap-2 rounded-lg bg-brand-600 py-2.5 text-sm font-semibold text-white transition hover:bg-brand-700 disabled:opacity-60"
      >
        {loading ? <Loader2 size={18} className="animate-spin" /> : <LogIn size={18} />}
        เข้าสู่ระบบ
      </button>

      <button
        type="button"
        onClick={sendMagicLink}
        disabled={loading}
        className="flex w-full items-center justify-center gap-2 rounded-lg border border-border py-2.5 text-sm font-medium text-text transition hover:bg-surface-2 disabled:opacity-60"
      >
        <Mail size={18} /> ส่งลิงก์เข้าสู่ระบบทางอีเมล
      </button>
    </form>
  );
}
