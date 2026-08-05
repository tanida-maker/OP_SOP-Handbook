import { GraduationCap } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import OnboardingTracks from "@/components/OnboardingTracks";
import type { Document } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "พนักงานใหม่ (Onboarding)" };

export default async function OnboardingPage({
  searchParams,
}: {
  searchParams: Promise<{ role?: string }>;
}) {
  const { role } = await searchParams;
  const supabase = await createClient();

  const [{ data: docs }, { data: acks }] = await Promise.all([
    supabase
      .from("documents")
      .select("id, slug, title, summary, onboarding_order, onboarding_roles")
      .eq("status", "published")
      .eq("is_onboarding", true)
      .order("onboarding_order", { ascending: true, nullsFirst: false }),
    supabase.from("onboarding_acks").select("doc_id"),
  ]);

  const steps = (docs ?? []) as Pick<
    Document,
    "id" | "slug" | "title" | "summary" | "onboarding_order" | "onboarding_roles"
  >[];
  const ackedIds = (acks ?? []).map((a: { doc_id: string }) => a.doc_id);

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <header className="flex items-start gap-4">
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-brand-600 text-white">
          <GraduationCap size={28} />
        </span>
        <div>
          <h1 className="text-2xl font-extrabold text-text">เส้นทางพนักงานใหม่</h1>
          <p className="mt-1 text-muted">
            เลือกสายงานของคุณ แล้วอ่าน + กดรับทราบทีละหัวข้อให้ครบ
            เพื่อเริ่มงานอย่างมั่นใจ
          </p>
        </div>
      </header>

      <OnboardingTracks docs={steps} ackedIds={ackedIds} initialRole={role} />
    </div>
  );
}
