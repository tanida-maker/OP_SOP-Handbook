"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import { Check, ChevronRight, Lock } from "lucide-react";
import type { Document } from "@/lib/types";

type Step = Pick<
  Document,
  "id" | "slug" | "title" | "summary" | "onboarding_order" | "onboarding_roles"
>;

const ROLES = [
  { key: "gs", label: "Guest Service / Porter", emoji: "🧳" },
  { key: "cs", label: "Customer Service", emoji: "🎧" },
] as const;

export default function OnboardingTracks({
  docs,
  ackedIds,
  initialRole = "gs",
}: {
  docs: Step[];
  ackedIds: string[];
  initialRole?: string;
}) {
  const [role, setRole] = useState<string>(
    ROLES.some((r) => r.key === initialRole) ? initialRole : "gs"
  );
  const acked = useMemo(() => new Set(ackedIds), [ackedIds]);

  const track = useMemo(
    () =>
      docs
        .filter((d) => (d.onboarding_roles ?? []).includes(role))
        .sort((a, b) => (a.onboarding_order ?? 999) - (b.onboarding_order ?? 999)),
    [docs, role]
  );

  const doneCount = track.filter((d) => acked.has(d.id)).length;
  const pct = track.length ? Math.round((doneCount / track.length) * 100) : 0;
  // first step that is not yet acknowledged = the only unlocked "next" step
  const firstOpenIdx = track.findIndex((d) => !acked.has(d.id));

  return (
    <div className="space-y-5">
      {/* Role tabs */}
      <div className="flex flex-wrap gap-2">
        {ROLES.map((r) => {
          const on = role === r.key;
          return (
            <button
              key={r.key}
              onClick={() => setRole(r.key)}
              className={`rounded-full border px-4 py-2 text-sm font-semibold transition ${
                on
                  ? "border-brand-600 bg-brand-600 text-white shadow-sm"
                  : "border-border bg-surface text-muted hover:border-brand-300 hover:text-text"
              }`}
            >
              {r.emoji} {r.label}
            </button>
          );
        })}
      </div>

      {/* Progress */}
      <div className="rounded-xl border border-border bg-surface p-4">
        <div className="mb-2 flex items-center justify-between text-sm">
          <span className="font-medium text-text">ความคืบหน้า</span>
          <span className="text-muted">
            {doneCount}/{track.length} ({pct}%)
          </span>
        </div>
        <div className="h-2.5 w-full overflow-hidden rounded-full bg-surface-2">
          <div
            className="h-full rounded-full bg-brand-600 transition-all"
            style={{ width: `${pct}%` }}
          />
        </div>
        {pct === 100 && track.length > 0 && (
          <p className="mt-2 text-sm font-semibold text-ok">
            ✅ เรียนรู้ครบทุกหัวข้อแล้ว ยินดีด้วย!
          </p>
        )}
      </div>

      {/* Steps (locked until the previous one is acknowledged) */}
      {track.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-8 text-center text-muted">
          ยังไม่มีคู่มือสำหรับสายงานนี้
        </p>
      ) : (
        <ol className="space-y-3">
          {track.map((d, i) => {
            const isDone = acked.has(d.id);
            const isOpen = i === firstOpenIdx; // the current unlocked step
            const isLocked = !isDone && !isOpen;
            return (
              <li
                key={d.id}
                className={`flex items-center gap-3 rounded-xl border p-4 transition ${
                  isLocked
                    ? "border-border bg-surface-2/40 opacity-60"
                    : "border-border bg-surface"
                }`}
              >
                <span
                  className={`grid h-8 w-8 shrink-0 place-items-center rounded-full border text-sm font-bold ${
                    isDone
                      ? "border-brand-600 bg-brand-600 text-white"
                      : isOpen
                      ? "border-brand-400 text-brand-700"
                      : "border-border text-muted"
                  }`}
                >
                  {isDone ? <Check size={16} /> : isLocked ? <Lock size={14} /> : i + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <span className="text-xs font-semibold text-brand-600">
                    ขั้นที่ {i + 1}
                  </span>
                  <p className={`font-semibold ${isDone ? "text-muted" : "text-text"}`}>
                    {d.title}
                  </p>
                  {d.summary && (
                    <p className="clamp-1 text-sm text-muted">{d.summary}</p>
                  )}
                </div>
                {isLocked ? (
                  <span className="flex shrink-0 items-center gap-1 rounded-lg bg-surface-2 px-3 py-2 text-xs font-medium text-muted">
                    <Lock size={13} /> ล็อก
                  </span>
                ) : (
                  <Link
                    href={`/sop/${d.slug}?ob=${role}`}
                    className={`flex shrink-0 items-center gap-1 rounded-lg px-3 py-2 text-sm font-semibold ${
                      isDone
                        ? "bg-surface-2 text-muted hover:text-text"
                        : "bg-brand-600 text-white hover:bg-brand-700"
                    }`}
                  >
                    {isDone ? "ทบทวน" : "เปิดอ่าน"}
                    <ChevronRight size={15} />
                  </Link>
                )}
              </li>
            );
          })}
        </ol>
      )}

      <p className="text-center text-xs text-muted">
        ต้องกด “อ่านและรับทราบ” ในแต่ละหัวข้อ จึงจะปลดล็อกหัวข้อถัดไป
      </p>
    </div>
  );
}
