import { FileText, GraduationCap } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import OnboardingTracks from "@/components/OnboardingTracks";
import Day1Checklist from "@/components/Day1Checklist";
import T from "@/components/T";
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

  const [{ data: docs }, { data: acks }, { data: checklist }] =
    await Promise.all([
      supabase
        .from("documents")
        .select("id, slug, title, summary, onboarding_order, onboarding_roles")
        .eq("status", "published")
        .eq("is_onboarding", true)
        .order("onboarding_order", { ascending: true, nullsFirst: false }),
      supabase.from("onboarding_acks").select("doc_id"),
      supabase.from("checklist_progress").select("item_key"),
    ]);

  const steps = (docs ?? []) as Pick<
    Document,
    "id" | "slug" | "title" | "summary" | "onboarding_order" | "onboarding_roles"
  >[];
  const ackedIds = (acks ?? []).map((a: { doc_id: string }) => a.doc_id);
  const checkedKeys = (checklist ?? []).map(
    (c: { item_key: string }) => c.item_key
  );

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <header className="flex items-start gap-4">
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-brand-600 text-white">
          <GraduationCap size={28} />
        </span>
        <div>
          <h1 className="text-2xl font-extrabold text-text">
            <T th="เส้นทางพนักงานใหม่" en="New Staff Onboarding" />
          </h1>
          <p className="mt-1 text-muted">
            <T
              th="เลือกสายงานของคุณ แล้วอ่าน + กดรับทราบทีละหัวข้อให้ครบ เพื่อเริ่มงานอย่างมั่นใจ"
              en="Choose your role, then read and acknowledge each topic to start work with confidence"
            />
          </p>
          <a
            href="/sop-hub-login-guide.pdf"
            target="_blank"
            rel="noopener"
            className="mt-3 inline-flex items-center gap-1.5 rounded-lg border border-brand-200 bg-brand-50 px-3 py-1.5 text-sm font-semibold text-brand-700 transition hover:border-brand-400 hover:bg-brand-100"
          >
            <FileText size={15} />
            <T th="คู่มือเข้าใช้งานครั้งแรก (PDF)" en="First-time login guide (PDF)" />
          </a>
        </div>
      </header>

      <Day1Checklist checkedKeys={checkedKeys} />

      <div className="pt-2">
        <h2 className="mb-1 text-lg font-bold text-text">
          <T th="เส้นทางเรียนรู้ตามสายงาน" en="Learning track by role" />
        </h2>
        <p className="mb-4 text-sm text-muted">
          <T
            th="อ่าน + กดรับทราบทีละหัวข้อให้ครบตามสายงานของคุณ"
            en="Read and acknowledge each topic for your role"
          />
        </p>
        <OnboardingTracks docs={steps} ackedIds={ackedIds} initialRole={role} />
      </div>
    </div>
  );
}
