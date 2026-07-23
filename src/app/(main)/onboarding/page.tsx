import { GraduationCap } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import OnboardingList from "./OnboardingList";
import type { Document } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "พนักงานใหม่ (Onboarding)" };

export default async function OnboardingPage() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("documents")
    .select("id, slug, title, summary")
    .eq("status", "published")
    .eq("is_onboarding", true)
    .order("onboarding_order", { ascending: true, nullsFirst: false })
    .order("title");

  const steps = (data ?? []) as Pick<
    Document,
    "id" | "slug" | "title" | "summary"
  >[];

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <header className="flex items-start gap-4">
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-brand-600 text-white">
          <GraduationCap size={28} />
        </span>
        <div>
          <h1 className="text-2xl font-extrabold text-text">
            เส้นทางพนักงานใหม่
          </h1>
          <p className="mt-1 text-muted">
            ทำตามขั้นตอนด้านล่างให้ครบ เพื่อเริ่มต้นการทำงานอย่างมั่นใจ
          </p>
        </div>
      </header>

      {steps.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-8 text-center text-muted">
          ยังไม่มีคู่มือสำหรับ Onboarding — แอดมินสามารถกำหนดได้จากหน้าจัดการคู่มือ
        </p>
      ) : (
        <OnboardingList steps={steps} />
      )}
    </div>
  );
}
