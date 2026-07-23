import { createClient } from "@/lib/supabase/server";
import CategoryManager from "./CategoryManager";
import type { Category } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "จัดการหมวดหมู่" };

export default async function AdminCategories() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order");

  return <CategoryManager categories={(data ?? []) as Category[]} />;
}
