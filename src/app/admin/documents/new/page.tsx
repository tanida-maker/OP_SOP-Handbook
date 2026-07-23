import { createClient } from "@/lib/supabase/server";
import DocumentForm from "../DocumentForm";
import type { Category } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "สร้างคู่มือใหม่" };

export default async function NewDocumentPage() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order");

  return (
    <div className="space-y-5">
      <h1 className="text-2xl font-extrabold text-text">สร้างคู่มือใหม่</h1>
      <DocumentForm categories={(data ?? []) as Category[]} />
    </div>
  );
}
