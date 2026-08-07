"use server";

import { revalidatePath } from "next/cache";
import { getSessionUser } from "@/lib/supabase/server";

type Result = { ok: boolean; error?: string; id?: string; slug?: string };

async function requireAdmin() {
  const { user, isAdmin, supabase } = await getSessionUser();
  if (!user || !isAdmin) {
    throw new Error("ไม่มีสิทธิ์ (admin เท่านั้น)");
  }
  return { supabase, userId: user.id };
}

function slugify(input: string) {
  const base = input
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9ก-๙\s-]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-")
    .slice(0, 80);
  return base || `doc-${crypto.randomUUID().slice(0, 8)}`;
}

// ---------------- Documents ----------------
export interface DocumentInput {
  id?: string;
  title: string;
  slug?: string;
  summary?: string | null;
  category_id?: string | null;
  content_html: string;
  cover_image?: string | null;
  tags?: string[];
  status: "draft" | "published" | "archived";
  is_onboarding: boolean;
  onboarding_order?: number | null;
}

export async function saveDocument(input: DocumentInput): Promise<Result> {
  try {
    const { supabase, userId } = await requireAdmin();
    if (!input.title?.trim()) return { ok: false, error: "กรุณาใส่ชื่อคู่มือ" };

    const slug = (input.slug?.trim() && slugify(input.slug)) || slugify(input.title);

    const payload = {
      title: input.title.trim(),
      slug,
      summary: input.summary?.trim() || null,
      category_id: input.category_id || null,
      content_html: input.content_html ?? "",
      cover_image: input.cover_image || null,
      tags: input.tags ?? [],
      status: input.status,
      is_onboarding: input.is_onboarding,
      onboarding_order: input.is_onboarding
        ? input.onboarding_order ?? 100
        : null,
      updated_by: userId,
    };

    if (input.id) {
      const { error } = await supabase
        .from("documents")
        .update(payload)
        .eq("id", input.id);
      if (error) return { ok: false, error: error.message };
    } else {
      const { data, error } = await supabase
        .from("documents")
        .insert(payload)
        .select("id")
        .single();
      if (error) return { ok: false, error: error.message };
      input.id = data.id;
    }

    revalidatePath("/");
    revalidatePath("/onboarding");
    revalidatePath(`/sop/${slug}`);
    revalidatePath("/admin/documents");
    return { ok: true, id: input.id, slug };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}

export async function deleteDocument(id: string): Promise<Result> {
  try {
    const { supabase } = await requireAdmin();
    const { error } = await supabase.from("documents").delete().eq("id", id);
    if (error) return { ok: false, error: error.message };
    revalidatePath("/");
    revalidatePath("/admin/documents");
    return { ok: true };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}

// ---------------- Categories ----------------
export interface CategoryInput {
  id?: string;
  name: string;
  slug?: string;
  description?: string | null;
  icon?: string | null;
  sort_order?: number;
}

export async function saveCategory(input: CategoryInput): Promise<Result> {
  try {
    const { supabase } = await requireAdmin();
    if (!input.name?.trim()) return { ok: false, error: "กรุณาใส่ชื่อหมวดหมู่" };
    const slug = (input.slug?.trim() && slugify(input.slug)) || slugify(input.name);
    const payload = {
      name: input.name.trim(),
      slug,
      description: input.description?.trim() || null,
      icon: input.icon || "FileText",
      sort_order: input.sort_order ?? 100,
    };
    if (input.id) {
      const { error } = await supabase
        .from("categories")
        .update(payload)
        .eq("id", input.id);
      if (error) return { ok: false, error: error.message };
    } else {
      const { error } = await supabase.from("categories").insert(payload);
      if (error) return { ok: false, error: error.message };
    }
    revalidatePath("/");
    revalidatePath("/admin/categories");
    return { ok: true, slug };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}

export async function deleteCategory(id: string): Promise<Result> {
  try {
    const { supabase } = await requireAdmin();
    const { error } = await supabase.from("categories").delete().eq("id", id);
    if (error) return { ok: false, error: error.message };
    revalidatePath("/");
    revalidatePath("/admin/categories");
    return { ok: true };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}

// ---------------- Announcements ----------------
export interface AnnouncementInput {
  id?: string;
  title: string;
  body_html?: string;
  level: "info" | "warning" | "critical";
  pinned: boolean;
  published: boolean;
}

export async function saveAnnouncement(
  input: AnnouncementInput
): Promise<Result> {
  try {
    const { supabase, userId } = await requireAdmin();
    if (!input.title?.trim()) return { ok: false, error: "กรุณาใส่หัวข้อ" };
    const payload = {
      title: input.title.trim(),
      body_html: input.body_html ?? "",
      level: input.level,
      pinned: input.pinned,
      published: input.published,
      created_by: userId,
    };
    if (input.id) {
      const { error } = await supabase
        .from("announcements")
        .update(payload)
        .eq("id", input.id);
      if (error) return { ok: false, error: error.message };
    } else {
      const { error } = await supabase.from("announcements").insert(payload);
      if (error) return { ok: false, error: error.message };
    }
    revalidatePath("/");
    revalidatePath("/announcements");
    revalidatePath("/admin/announcements");
    return { ok: true };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}

export async function deleteAnnouncement(id: string): Promise<Result> {
  try {
    const { supabase } = await requireAdmin();
    const { error } = await supabase
      .from("announcements")
      .delete()
      .eq("id", id);
    if (error) return { ok: false, error: error.message };
    revalidatePath("/");
    revalidatePath("/announcements");
    revalidatePath("/admin/announcements");
    return { ok: true };
  } catch (e) {
    return { ok: false, error: e instanceof Error ? e.message : "error" };
  }
}
