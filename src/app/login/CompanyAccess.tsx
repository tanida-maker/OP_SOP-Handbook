"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase/client";
import T from "@/components/T";

// Company e-mail access to Q4 (no Scheduling account): activate, then sign in with
// Google (same address) or the e-mail login link.
export default function CompanyAccess() {
  const [email, setEmail] = useState("");
  const [busy, setBusy] = useState(false);
  const [msg, setMsg] = useState<{ ok: boolean; th: string; en: string } | null>(null);

  async function go(sendLink: boolean) {
    setBusy(true);
    setMsg(null);
    try {
      const res = await fetch("/api/q4/register", {
        method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify({ email }),
      });
      const j = await res.json().catch(() => ({}));
      if (!res.ok) {
        setMsg(j.error === "not_company"
          ? { ok: false, th: `ใช้ได้เฉพาะอีเมลบริษัท (${(j.domains ?? []).map((d: string) => "@" + d).join(", ")})`, en: "Company e-mail only" }
          : { ok: false, th: "เปิดใช้งานไม่สำเร็จ ลองใหม่อีกครั้ง", en: "Could not activate, try again" });
        return;
      }
      if (!sendLink) {
        setMsg({ ok: true, th: "เปิดใช้งานแล้ว กด “เข้าสู่ระบบด้วย Google” ด้านบนด้วยอีเมลนี้ได้เลย", en: "Activated. Use “Sign in with Google” above with this address" });
        return;
      }
      const supabase = createClient();
      const { error } = await supabase.auth.signInWithOtp({
        email: email.trim(),
        options: { shouldCreateUser: false, emailRedirectTo: `${window.location.origin}/auth/callback?next=${encodeURIComponent("/q4")}` },
      });
      setMsg(error
        ? { ok: false, th: "ส่งลิงก์ไม่สำเร็จ (อาจส่งถี่เกินไป) ให้ใช้ “เข้าสู่ระบบด้วย Google” แทน", en: "Could not send the link; use Google sign-in instead" }
        : { ok: true, th: "ส่งลิงก์เข้าสู่ระบบไปที่อีเมลแล้ว เปิดอีเมลแล้วกดลิงก์", en: "Login link sent, check your inbox" });
    } catch {
      setMsg({ ok: false, th: "เชื่อมต่อไม่สำเร็จ", en: "Connection failed" });
    } finally {
      setBusy(false);
    }
  }

  const valid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());
  return (
    <div className="mt-4 rounded-2xl border border-border bg-surface p-5 text-sm shadow-sm">
      <p className="mb-1 font-bold text-text">
        <T th="ใช้อีเมลบริษัท (ไม่มีบัญชีระบบตารางงาน)" en="Company e-mail (no Scheduling account)" />
      </p>
      <p className="mb-3 text-xs text-muted">
        <T th="ดูสรุปผล รายการ Presentation และทำงานในทีม Support ได้ ส่วนการแจ้งเรื่องผ่านฟอร์มใช้ได้เฉพาะพนักงานสาขาที่ Login ด้วยบัญชีระบบตารางงาน"
           en="View summary, issues, presentation and work in Support teams. Submitting issues is for branch staff with Scheduling accounts" />
      </p>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="name@airportels.asia"
        className="mb-2 w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm" />
      <div className="grid grid-cols-2 gap-2">
        <button disabled={busy || !valid} onClick={() => go(false)}
          className="rounded-lg border border-border px-3 py-2 text-sm font-semibold hover:bg-surface-2 disabled:opacity-50">
          <T th="เปิดใช้งาน แล้วใช้ Google" en="Activate, then Google" />
        </button>
        <button disabled={busy || !valid} onClick={() => go(true)}
          className="rounded-lg bg-[#14232E] px-3 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
          <T th="ส่งลิงก์เข้าสู่ระบบ" en="Send login link" />
        </button>
      </div>
      {msg && <p className={`mt-2 text-xs ${msg.ok ? "text-ok" : "text-danger"}`}><T th={msg.th} en={msg.en} /></p>}
    </div>
  );
}
