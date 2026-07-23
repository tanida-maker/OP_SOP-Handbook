"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";
import Link from "next/link";
import { ImagePlus, Loader2, Save, Trash2, X } from "lucide-react";
import Editor from "@/components/editor/Editor";
import { createClient } from "@/lib/supabase/client";
import { deleteDocument, saveDocument } from "../actions";
import type { Category, Document } from "@/lib/types";

export default function DocumentForm({
  categories,
  doc,
}: {
  categories: Category[];
  doc?: Document;
}) {
  const router = useRouter();

  const [title, setTitle] = useState(doc?.title ?? "");
  const [slug, setSlug] = useState(doc?.slug ?? "");
  const [summary, setSummary] = useState(doc?.summary ?? "");
  const [categoryId, setCategoryId] = useState(doc?.category_id ?? "");
  const [content, setContent] = useState(doc?.content_html ?? "");
  const [cover, setCover] = useState(doc?.cover_image ?? "");
  const [tags, setTags] = useState((doc?.tags ?? []).join(", "));
  const [status, setStatus] = useState<Document["status"]>(
    doc?.status ?? "draft"
  );
  const [isOnboarding, setIsOnboarding] = useState(doc?.is_onboarding ?? false);
  const [onboardingOrder, setOnboardingOrder] = useState(
    doc?.onboarding_order ?? 100
  );

  const [saving, setSaving] = useState(false);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [error, setError] = useState<string | null>(null);

  async function uploadCover(file: File) {
    setUploadingCover(true);
    try {
      const supabase = createClient();
      const ext = file.name.split(".").pop() || "jpg";
      const path = `covers/${crypto.randomUUID()}.${ext}`;
      const { error } = await supabase.storage
        .from("sop-media")
        .upload(path, file);
      if (error) throw error;
      const {
        data: { publicUrl },
      } = supabase.storage.from("sop-media").getPublicUrl(path);
      setCover(publicUrl);
    } catch (e) {
      alert("อัปโหลดภาพปกไม่สำเร็จ: " + (e instanceof Error ? e.message : ""));
    } finally {
      setUploadingCover(false);
    }
  }

  async function submit(publish?: boolean) {
    setSaving(true);
    setError(null);
    const res = await saveDocument({
      id: doc?.id,
      title,
      slug: slug || undefined,
      summary,
      category_id: categoryId || null,
      content_html: content,
      cover_image: cover || null,
      tags: tags
        .split(",")
        .map((t) => t.trim())
        .filter(Boolean),
      status: publish ? "published" : status,
      is_onboarding: isOnboarding,
      onboarding_order: onboardingOrder,
    });
    setSaving(false);
    if (!res.ok) {
      setError(res.error ?? "บันทึกไม่สำเร็จ");
      return;
    }
    router.push("/admin/documents");
    router.refresh();
  }

  async function remove() {
    if (!doc?.id) return;
    if (!confirm("ยืนยันลบคู่มือนี้? การลบไม่สามารถกู้คืนได้")) return;
    setSaving(true);
    const res = await deleteDocument(doc.id);
    setSaving(false);
    if (!res.ok) {
      setError(res.error ?? "ลบไม่สำเร็จ");
      return;
    }
    router.push("/admin/documents");
    router.refresh();
  }

  const field =
    "w-full rounded-lg border border-border bg-surface px-3 py-2.5 text-sm text-text outline-none focus:border-brand-400";
  const label = "mb-1.5 block text-sm font-medium text-text";

  return (
    <div className="grid gap-6 lg:grid-cols-[1fr_320px]">
      {/* Main column */}
      <div className="space-y-5">
        <div>
          <label className={label}>ชื่อคู่มือ *</label>
          <input
            className={field}
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="เช่น การเปิด-ปิดเคาน์เตอร์สำหรับสาขาสนามบิน"
          />
        </div>

        <div>
          <label className={label}>คำอธิบายสั้น (สรุป)</label>
          <textarea
            className={field}
            rows={2}
            value={summary ?? ""}
            onChange={(e) => setSummary(e.target.value)}
            placeholder="สรุปสั้นๆ ว่าคู่มือนี้เกี่ยวกับอะไร"
          />
        </div>

        <div>
          <label className={label}>เนื้อหา</label>
          <Editor value={content} onChange={setContent} />
          <p className="mt-1.5 text-xs text-muted">
            ใช้แถบเครื่องมือเพื่อจัดรูปแบบ แทรกรูปภาพ วิดีโอ (อัปโหลด) หรือฝัง
            YouTube
          </p>
        </div>

        {error && (
          <p className="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-700">
            {error}
          </p>
        )}
      </div>

      {/* Sidebar */}
      <aside className="space-y-5">
        <div className="rounded-2xl border border-border bg-surface p-4">
          <div className="flex flex-col gap-2">
            <button
              onClick={() => submit(true)}
              disabled={saving}
              className="flex items-center justify-center gap-2 rounded-lg bg-brand-600 py-2.5 text-sm font-semibold text-white hover:bg-brand-700 disabled:opacity-60"
            >
              {saving ? (
                <Loader2 size={17} className="animate-spin" />
              ) : (
                <Save size={17} />
              )}
              บันทึกและเผยแพร่
            </button>
            <button
              onClick={() => submit(false)}
              disabled={saving}
              className="rounded-lg border border-border py-2.5 text-sm font-medium text-text hover:bg-surface-2 disabled:opacity-60"
            >
              บันทึกฉบับร่าง
            </button>
            <Link
              href="/admin/documents"
              className="rounded-lg py-2 text-center text-sm text-muted hover:text-text"
            >
              ยกเลิก
            </Link>
          </div>
        </div>

        <div className="space-y-4 rounded-2xl border border-border bg-surface p-4">
          <div>
            <label className={label}>หมวดหมู่</label>
            <select
              className={field}
              value={categoryId ?? ""}
              onChange={(e) => setCategoryId(e.target.value)}
            >
              <option value="">— ไม่ระบุ —</option>
              {categories.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className={label}>สถานะปัจจุบัน</label>
            <span
              className={`inline-block rounded-full px-3 py-1 text-xs font-semibold ${
                status === "published"
                  ? "bg-green-100 text-green-700"
                  : "bg-amber-100 text-amber-700"
              }`}
            >
              {status === "published" ? "เผยแพร่แล้ว" : "ฉบับร่าง"}
            </span>
          </div>

          <div>
            <label className={label}>ป้ายกำกับ (คั่นด้วย ,)</label>
            <input
              className={field}
              value={tags}
              onChange={(e) => setTags(e.target.value)}
              placeholder="POS, การชำระเงิน"
            />
          </div>

          <div>
            <label className={label}>URL (slug)</label>
            <input
              className={field}
              value={slug}
              onChange={(e) => setSlug(e.target.value)}
              placeholder="เว้นว่างเพื่อสร้างอัตโนมัติ"
            />
          </div>
        </div>

        {/* Cover */}
        <div className="rounded-2xl border border-border bg-surface p-4">
          <label className={label}>ภาพปก</label>
          {cover ? (
            <div className="relative">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src={cover}
                alt=""
                className="aspect-[16/9] w-full rounded-lg object-cover"
              />
              <button
                onClick={() => setCover("")}
                className="absolute right-2 top-2 grid h-8 w-8 place-items-center rounded-full bg-black/60 text-white"
              >
                <X size={16} />
              </button>
            </div>
          ) : (
            <label className="flex aspect-[16/9] w-full cursor-pointer flex-col items-center justify-center gap-2 rounded-lg border border-dashed border-border text-muted hover:border-brand-400">
              {uploadingCover ? (
                <Loader2 className="animate-spin" />
              ) : (
                <>
                  <ImagePlus size={22} />
                  <span className="text-sm">อัปโหลดภาพปก</span>
                </>
              )}
              <input
                type="file"
                accept="image/*"
                hidden
                onChange={(e) => {
                  const f = e.target.files?.[0];
                  if (f) uploadCover(f);
                }}
              />
            </label>
          )}
        </div>

        {/* Onboarding */}
        <div className="rounded-2xl border border-border bg-surface p-4">
          <label className="flex items-center gap-2.5">
            <input
              type="checkbox"
              checked={isOnboarding}
              onChange={(e) => setIsOnboarding(e.target.checked)}
              className="h-4 w-4 accent-brand-600"
            />
            <span className="text-sm font-medium text-text">
              รวมในเส้นทางพนักงานใหม่
            </span>
          </label>
          {isOnboarding && (
            <div className="mt-3">
              <label className={label}>ลำดับขั้น</label>
              <input
                type="number"
                className={field}
                value={onboardingOrder}
                onChange={(e) => setOnboardingOrder(Number(e.target.value))}
              />
            </div>
          )}
        </div>

        {doc?.id && (
          <button
            onClick={remove}
            disabled={saving}
            className="flex w-full items-center justify-center gap-2 rounded-lg border border-red-200 py-2.5 text-sm font-medium text-danger hover:bg-red-50 disabled:opacity-60"
          >
            <Trash2 size={16} /> ลบคู่มือนี้
          </button>
        )}
      </aside>
    </div>
  );
}
