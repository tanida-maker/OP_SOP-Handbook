"use server";

import { revalidatePath } from "next/cache";
import { getSessionUser } from "@/lib/supabase/server";

// Record that the current user has read + acknowledged an onboarding document.
export async function acknowledgeDoc(docId: string): Promise<{ ok: boolean }> {
  const { user, supabase } = await getSessionUser();
  if (!user) return { ok: false };
  const { error } = await supabase
    .from("onboarding_acks")
    .upsert({ user_id: user.id, doc_id: docId }, { onConflict: "user_id,doc_id" });
  revalidatePath("/onboarding");
  return { ok: !error };
}

// Toggle a Day-1 checklist item for the current user.
export async function toggleChecklistItem(
  key: string,
  done: boolean
): Promise<{ ok: boolean }> {
  const { user, supabase } = await getSessionUser();
  if (!user) return { ok: false };
  if (done) {
    await supabase
      .from("checklist_progress")
      .upsert({ user_id: user.id, item_key: key }, { onConflict: "user_id,item_key" });
  } else {
    await supabase
      .from("checklist_progress")
      .delete()
      .eq("user_id", user.id)
      .eq("item_key", key);
  }
  revalidatePath("/onboarding");
  return { ok: true };
}
