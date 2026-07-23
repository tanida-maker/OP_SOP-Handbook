"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import { Loader2, Pencil, Plus, Trash2, X } from "lucide-react";
import Icon from "@/components/Icon";
import { deleteCategory, saveCategory } from "../actions";
import type { Category } from "@/lib/types";

const ICONS = [
  "GraduationCap",
  "Briefcase",
  "CreditCard",
  "Truck",
  "PackageCheck",
  "Siren",
  "Wrench",
  "BadgeCheck",
  "FileText",
];

const empty = { name: "", slug: "", description: "", icon: "FileText", sort_order: 100 };

export default function CategoryManager({
  categories,
}: {
  categories: Category[];
}) {
  const router = useRouter();
  const [editing, setEditing] = useState<Partial<Category> | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function save() {
    if (!editing) return;
    setBusy(true);
    setError(null);
    const res = await saveCategory({
      id: editing.id,
      name: editing.name ?? "",
      slug: editing.slug ?? undefined,
      description: editing.description ?? null,
      icon: editing.icon ?? "FileText",
      sort_order: editing.sort_order ?? 100,
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
    if (!confirm("ลบหมวดหมู่นี้? คู่มือในหมวดจะไม่ถูกลบ แต่จะไม่มีหมวดหมู่"))
      return;
    setBusy(true);
    await deleteCategory(id);
    setBusy(false);
    router.refresh();
  }

  const field =
    "w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm text-text outline-none focus:border-brand-400";

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-extrabold text-text">หมวดหมู่</h1>
        <button
          onClick={() => setEditing({ ...empty })}
          className="flex items-center gap-2 rounded-lg bg-brand-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-brand-700"
        >
          <Plus size={17} /> เพิ่มหมวดหมู่
        </button>
      </div>

      <div className="grid gap-3">
        {categories.map((c) => (
          <div
            key={c.id}
            className="flex items-center gap-3 rounded-xl border border-border bg-surface p-3"
          >
            <span className="grid h-10 w-10 place-items-center rounded-lg bg-brand-50 text-brand-600">
              <Icon name={c.icon} size={20} />
            </span>
            <div className="min-w-0 flex-1">
              <p className="font-semibold text-text">{c.name}</p>
              <p className="clamp-1 text-xs text-muted">
                /{c.slug} {c.description ? `· ${c.description}` : ""}
              </p>
            </div>
            <button
              onClick={() => setEditing(c)}
              className="grid h-9 w-9 place-items-center rounded-lg border border-border text-muted hover:text-text"
            >
              <Pencil size={16} />
            </button>
            <button
              onClick={() => remove(c.id)}
              disabled={busy}
              className="grid h-9 w-9 place-items-center rounded-lg border border-border text-danger hover:bg-red-50"
            >
              <Trash2 size={16} />
            </button>
          </div>
        ))}
      </div>

      {/* Modal */}
      {editing && (
        <div className="fixed inset-0 z-50 grid place-items-center p-4">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setEditing(null)}
          />
          <div className="relative w-full max-w-md rounded-2xl border border-border bg-surface p-5 shadow-lg">
            <div className="mb-4 flex items-center justify-between">
              <h2 className="text-lg font-bold text-text">
                {editing.id ? "แก้ไขหมวดหมู่" : "เพิ่มหมวดหมู่"}
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
                placeholder="ชื่อหมวดหมู่"
                value={editing.name ?? ""}
                onChange={(e) =>
                  setEditing({ ...editing, name: e.target.value })
                }
              />
              <input
                className={field}
                placeholder="คำอธิบาย (ไม่บังคับ)"
                value={editing.description ?? ""}
                onChange={(e) =>
                  setEditing({ ...editing, description: e.target.value })
                }
              />
              <div>
                <p className="mb-1.5 text-sm font-medium text-text">ไอคอน</p>
                <div className="flex flex-wrap gap-2">
                  {ICONS.map((ic) => (
                    <button
                      key={ic}
                      onClick={() => setEditing({ ...editing, icon: ic })}
                      className={`grid h-10 w-10 place-items-center rounded-lg border ${
                        editing.icon === ic
                          ? "border-brand-400 bg-brand-50 text-brand-700"
                          : "border-border text-muted"
                      }`}
                    >
                      <Icon name={ic} size={18} />
                    </button>
                  ))}
                </div>
              </div>
              <div className="flex items-center gap-2">
                <label className="text-sm text-muted">ลำดับ</label>
                <input
                  type="number"
                  className={field}
                  value={editing.sort_order ?? 100}
                  onChange={(e) =>
                    setEditing({
                      ...editing,
                      sort_order: Number(e.target.value),
                    })
                  }
                />
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
