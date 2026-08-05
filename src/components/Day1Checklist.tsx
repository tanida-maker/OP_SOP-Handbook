"use client";

import { useState, useTransition } from "react";
import { CheckSquare, ListChecks, Square } from "lucide-react";
import { toggleChecklistItem } from "@/app/(main)/onboarding/actions";

const ITEMS: { key: string; label: string; hint?: string }[] = [
  {
    key: "access",
    label: "รับ Access ทุกระบบครบ",
    hint: "Empeo · Lark · ระบบ POS · Google Sheet สาขา · Scheduling app + SOP Hub",
  },
  { key: "lark-groups", label: "เข้า Lark group ที่เกี่ยวข้องครบทุกกลุ่ม" },
  { key: "read-docs", label: "อ่านคู่มือส่งมอบงานในระบบนี้ให้ครบ" },
  {
    key: "one-on-one",
    label: "นัด 1-on-1 กับ Supervisor (ผู้สอนงาน) ภายในวันแรก",
  },
  { key: "contacts", label: "ทำความรู้จัก contact person หลักในทีมและสาขา" },
  {
    key: "plan",
    label: "ตรวจสอบ Onboarding Checklist และวางแผนการเรียนรู้ร่วมกับ Supervisor",
  },
];

export default function Day1Checklist({
  checkedKeys,
}: {
  checkedKeys: string[];
}) {
  const [done, setDone] = useState<Set<string>>(new Set(checkedKeys));
  const [, startTransition] = useTransition();

  function toggle(key: string) {
    const next = new Set(done);
    const willDo = !next.has(key);
    willDo ? next.add(key) : next.delete(key);
    setDone(next);
    startTransition(async () => {
      await toggleChecklistItem(key, willDo);
    });
  }

  const pct = Math.round((done.size / ITEMS.length) * 100);

  return (
    <section className="overflow-hidden rounded-2xl border border-border bg-surface">
      <div
        className="flex items-center gap-3 px-5 py-4 text-white"
        style={{ background: "linear-gradient(135deg,#1a66e0,#184593)" }}
      >
        <ListChecks size={22} />
        <div className="flex-1">
          <h2 className="font-extrabold">เช็คลิสต์วันแรก (Day 1)</h2>
          <p className="text-xs text-brand-100">
            สิ่งที่ต้องทำให้ครบในวันแรกของการเริ่มงาน
          </p>
        </div>
        <span className="rounded-full bg-white/20 px-3 py-1 text-sm font-bold">
          {done.size}/{ITEMS.length}
        </span>
      </div>

      <div className="h-1.5 w-full bg-surface-2">
        <div
          className="h-full bg-brand-500 transition-all"
          style={{ width: `${pct}%` }}
        />
      </div>

      <ul className="divide-y divide-border">
        {ITEMS.map((it) => {
          const on = done.has(it.key);
          return (
            <li key={it.key}>
              <button
                onClick={() => toggle(it.key)}
                className="flex w-full items-start gap-3 px-5 py-3.5 text-left transition hover:bg-surface-2"
              >
                <span className={on ? "text-brand-600" : "text-muted"}>
                  {on ? <CheckSquare size={22} /> : <Square size={22} />}
                </span>
                <span className="flex-1">
                  <span
                    className={`block font-medium ${
                      on ? "text-muted line-through" : "text-text"
                    }`}
                  >
                    {it.label}
                  </span>
                  {it.hint && (
                    <span className="mt-0.5 block text-xs text-muted">
                      {it.hint}
                    </span>
                  )}
                </span>
              </button>
            </li>
          );
        })}
      </ul>
    </section>
  );
}
