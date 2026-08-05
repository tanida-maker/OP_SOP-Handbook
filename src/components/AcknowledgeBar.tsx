"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { CheckCircle2, Loader2 } from "lucide-react";
import { acknowledgeDoc } from "@/app/(main)/onboarding/actions";

export default function AcknowledgeBar({
  docId,
  role,
  alreadyAcked,
}: {
  docId: string;
  role: string;
  alreadyAcked: boolean;
}) {
  const router = useRouter();
  const [busy, setBusy] = useState(false);
  const [done, setDone] = useState(alreadyAcked);

  async function ack() {
    setBusy(true);
    const res = await acknowledgeDoc(docId);
    setBusy(false);
    if (res.ok) {
      setDone(true);
      router.push(`/onboarding?role=${role}`);
      router.refresh();
    }
  }

  return (
    <div className="sticky bottom-4 z-30 mt-8 rounded-2xl border border-brand-200 bg-brand-50 p-4 shadow-lg">
      <div className="flex flex-col items-center gap-3 sm:flex-row sm:justify-between">
        <p className="text-sm font-medium text-brand-900">
          {done
            ? "✅ คุณได้อ่านและรับทราบคู่มือนี้แล้ว"
            : "อ่านคู่มือนี้จบแล้ว? กดรับทราบเพื่อปลดล็อกหัวข้อถัดไป"}
        </p>
        <button
          onClick={ack}
          disabled={busy || done}
          className="flex w-full shrink-0 items-center justify-center gap-2 rounded-lg bg-brand-600 px-5 py-2.5 text-sm font-semibold text-white transition hover:bg-brand-700 disabled:opacity-60 sm:w-auto"
        >
          {busy ? (
            <Loader2 size={17} className="animate-spin" />
          ) : (
            <CheckCircle2 size={17} />
          )}
          {done ? "กลับสู่เส้นทาง" : "อ่านและรับทราบ"}
        </button>
      </div>
    </div>
  );
}
