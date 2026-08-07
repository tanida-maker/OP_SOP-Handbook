// Shared domain types for the SOP Hub.

export type Role = "admin" | "staff";
export type DocStatus = "draft" | "published" | "archived";

export interface Profile {
  id: string;
  full_name: string | null;
  role: Role;
  branch: string | null;
  created_at: string;
}

export interface Category {
  id: string;
  slug: string;
  name: string;
  description: string | null;
  icon: string | null; // lucide icon name
  color: string | null; // hex, optional accent
  sort_order: number;
  created_at: string;
}

export interface Document {
  id: string;
  slug: string;
  title: string;
  summary: string | null;
  category_id: string | null;
  content_html: string; // rendered HTML from the editor
  cover_image: string | null;
  tags: string[] | null;
  status: DocStatus;
  is_onboarding: boolean;
  onboarding_order: number | null;
  onboarding_roles?: string[] | null;
  version: number;
  updated_at: string;
  created_at: string;
  updated_by: string | null;
}

export interface DocumentWithCategory extends Document {
  category: Pick<Category, "id" | "name" | "slug" | "icon" | "color"> | null;
}

export interface Announcement {
  id: string;
  title: string;
  body_html: string;
  level: "info" | "warning" | "critical";
  pinned: boolean;
  published: boolean;
  published_at: string | null;
  created_at: string;
  created_by: string | null;
}
