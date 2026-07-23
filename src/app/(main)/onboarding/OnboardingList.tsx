"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { Check, ChevronRight, Circle } from "lucide-react";

type Step = { id: string; slug: string; title: string; summary: string | null };

const KEY = "sop-onboarding-progress";

export default function OnboardingList({ steps }: { steps: Step[] }) {
  const [done, setDone] = useState<Record<string, boolean>>({});

  useEffect(() => {
    try {
      setDone(JSON.parse(localStorage.getItem(KEY) || "{}"));
    } catch {}
  }, []);

  function toggle(id: string) {
    setDone((prev) => {
      const next = { ...prev, [id]: !prev[id] };
      try {
        localStorage.setItem(KEY, JSON.stringify(next));
      } catch {}
      return next;
    });
  }

  const completed = steps.filter((s) => done[s.id]).length;
  const pct = steps.length ? Math.round((completed / steps.length) * 100) : 0;

  return (
    <div className="space-y-4">
      <div className="rounded-xl border border-border bg-surface p-4">
        <div className="mb-2 flex items-center justify-between text-sm">
          <span className="font-medium text-text">ความคืบหน้า</span>
          <span className="text-muted">
            {completed}/{steps.length} ({pct}%)
          </span>
        </div>
        <div className="h-2.5 w-full overflow-hidden rounded-full bg-surface-2">
          <div
            className="h-full rounded-full bg-brand-600 transition-all"
            style={{ width: `${pct}%` }}
          />
        </div>
      </div>

      <ol className="space-y-3">
        {steps.map((s, i) => (
          <li
            key={s.id}
            className="flex items-center gap-3 rounded-xl border border-border bg-surface p-4"
          >
            <button
              onClick={() => toggle(s.id)}
              aria-label="ทำเครื่องหมายว่าเรียนแล้ว"
              className={`grid h-8 w-8 shrink-0 place-items-center rounded-full border transition ${
                done[s.id]
                  ? "border-brand-600 bg-brand-600 text-white"
                  : "border-border text-muted hover:border-brand-400"
              }`}
            >
              {done[s.id] ? <Check size={16} /> : <Circle size={14} />}
            </button>
            <div className="min-w-0 flex-1">
              <span className="text-xs font-semibold text-brand-600">
                ขั้นที่ {i + 1}
              </span>
              <p
                className={`font-semibold ${
                  done[s.id] ? "text-muted line-through" : "text-text"
                }`}
              >
                {s.title}
              </p>
              {s.summary && (
                <p className="clamp-1 text-sm text-muted">{s.summary}</p>
              )}
            </div>
            <Link
              href={`/sop/${s.slug}`}
              className="flex shrink-0 items-center gap-1 rounded-lg bg-brand-50 px-3 py-2 text-sm font-medium text-brand-700 hover:bg-brand-100"
            >
              เปิดอ่าน <ChevronRight size={15} />
            </Link>
          </li>
        ))}
      </ol>
    </div>
  );
}
