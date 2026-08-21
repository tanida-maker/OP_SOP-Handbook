"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { Loader2, Pencil, Pin, Plus, Trash2, X } from "lucide-react";
import { deleteAnnouncement, saveAnnouncement } from "../actions";
import type { Announcement } from "@/lib/types";
import Editor from "@/components/editor/Editor";

type Draft = Partial<Announcement>;

const LEVELS = [
  { v: "info", label: "ข้อมูลทั่วไป" },
  { v: "warning", label: "ควรทราบ" },
  { v: "critical", label: "สำคัญมาก" },
] as const;

export default function AnnouncementManager({
  items,
}: {
  items: Announcement[];
}) {
  const router = useRouter();
  const [editing, setEditing] = useState<Draft | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  function openNew() {
    setEditing({
      title: "",
      body_html: "",
      level: "info",
      pinned: false,
      published: true,
    });
  }
  function openEdit(a: Announcement) {
    setEditing({ ...a });
  }

  async function save() {
    if (!editing) return;
    setBusy(true);
    setError(null);
    const res = await saveAnnouncement({
      id: editing.id,
      title: editing.title ?? "",
      body_html: editing.body_html ?? "",
      level: (editing.level as Announcement["level"]) ?? "info",
      pinned: !!editing.pinned,
      published: editing.published ?? true,
    });
    setBusy(false);
    if (!res.ok) {
      setError(res.error ?? "บันทึกไม่สำเร็จ");
      return;
    }
    setEditing(null);
    router.refresh();
  }

  async function remove(id: string) {
    if (!confirm("ลบประกาศนี้?")) return;
    setBusy(true);
    await deleteAnnouncement(id);
    setBusy(false);
    router.refresh();
  }

  const field =
    "w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm text-text outline-none focus:border-brand-400";

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-extrabold text-text">ประกาศ</h1>
        <button
          onClick={openNew}
          className="flex items-center gap-2 rounded-lg bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700"
        >
          <Plus size={17} /> เพิ่มประกาศ
        </button>
      </div>

      <div className="grid gap-3">
        {items.length === 0 && (
          <p className="rounded-xl border border-dashed border-border bg-surface p-8 text-center text-muted">
            ยังไม่มีประกาศ
          </p>
        )}
        {items.map((a) => (
          <div
            key={a.id}
            className="flex items-start gap-3 rounded-xl border border-border bg-surface p-4"
          >
            <div className="min-w-0 flex-1">
              <div className="flex flex-wrap items-center gap-2">
                {a.pinned && <Pin size={14} className="text-brand-600" />}
                <span className="font-semibold text-text">{a.title}</span>
                <span className="rounded-full bg-surface-2 px-2 py-0.5 text-[10px] font-semibold text-muted">
                  {LEVELS.find((l) => l.v === a.level)?.label}
                </span>
                {!a.published && (
                  <span className="rounded-full bg-amber-100 px-2 py-0.5 text-[10px] font-semibold text-amber-700">
                    ซ่อนอยู่
                  </span>
                )}
              </div>
            </div>
            <button
              onClick={() => openEdit(a)}
              className="grid h-9 w-9 place-items-center rounded-lg border border-border text-muted hover:text-text"
            >
              <Pencil size={16} />
            </button>
            <button
              onClick={() => remove(a.id)}
              disabled={busy}
              className="grid h-9 w-9 place-items-center rounded-lg border border-border text-danger hover:bg-red-50"
            >
              <Trash2 size={16} />
            </button>
          </div>
        ))}
      </div>

      {editing && (
        <div className="fixed inset-0 z-50 grid place-items-center p-4">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setEditing(null)}
          />
          <div className="relative w-full max-w-lg rounded-2xl border border-border bg-surface p-5 shadow-lg">
            <div className="mb-4 flex items-center justify-between">
              <h2 className="text-lg font-bold text-text">
                {editing.id ? "แก้ไขประกาศ" : "เพิ่มประกาศ"}
              </h2>
              <button
                onClick={() => setEditing(null)}
                className="grid h-8 w-8 place-items-center rounded-full border border-border"
              >
                <X size={16} />
              </button>
            </div>

            <div className="space-y-3">
              <input
                className={field}
                placeholder="หัวข้อประกาศ"
                value={editing.title ?? ""}
                onChange={(e) =>
                  setEditing({ ...editing, title: e.target.value })
                }
              />
              <div>
                <label className="mb-1 block text-xs font-medium text-muted">
                  เนื้อหาประกาศ — จัดขนาดฟอนต์ / ตัวหนา / เอียง / ขีดเส้นใต้ / หัวข้อ / รายการ / ลิงก์ / รูปภาพ ได้
                </label>
                <Editor
                  value={editing.body_html ?? ""}
                  onChange={(html) =>
                    setEditing({ ...editing, body_html: html })
                  }
                />
              </div>
              <div className="flex flex-wrap items-center gap-3">
                <select
                  className={field + " max-w-[12rem]"}
                  value={editing.level ?? "info"}
                  onChange={(e) =>
                    setEditing({
                      ...editing,
                      level: e.target.value as Announcement["level"],
                    })
                  }
                >
                  {LEVELS.map((l) => (
                    <option key={l.v} value={l.v}>
                      {l.label}
                    </option>
                  ))}
                </select>
                <label className="flex items-center gap-2 text-sm text-text">
                  <input
                    type="checkbox"
                    className="h-4 w-4 accent-brand-600"
                    checked={!!editing.pinned}
                    onChange={(e) =>
                      setEditing({ ...editing, pinned: e.target.checked })
                    }
                  />
                  ปักหมุด
                </label>
                <label className="flex items-center gap-2 text-sm text-text">
                  <input
                    type="checkbox"
                    className="h-4 w-4 accent-brand-600"
                    checked={editing.published ?? true}
                    onChange={(e) =>
                      setEditing({ ...editing, published: e.target.checked })
                    }
                  />
                  เผยแพร่
                </label>
              </div>

              {error && (
                <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
                  {error}
                </p>
              )}

              <button
                onClick={save}
                disabled={busy}
                className="flex w-full items-center justify-center gap-2 rounded-lg bg-brand-600 py-2.5 text-sm font-semibold text-white hover:bg-brand-700 disabled:opacity-60"
              >
                {busy && <Loader2 size={16} className="animate-spin" />}
                บันทึก
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
