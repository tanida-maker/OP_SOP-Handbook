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
