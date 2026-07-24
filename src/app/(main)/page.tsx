import Link from "next/link";
import { ArrowRight, GraduationCap, Megaphone, Pin } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import KnowledgeBase from "@/components/KnowledgeBase";
import SearchBox from "@/components/SearchBox";
import type { Announcement, Category, DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";

export default async function HomePage() {
  const supabase = await createClient();

  const [{ data: categories }, { data: docs }, { data: announcements }] =
    await Promise.all([
      supabase.from("categories").select("*").order("sort_order"),
      supabase
        .from("documents")
        .select("*, category:categories(id,name,slug,icon,color)")
        .eq("status", "published")
        .order("updated_at", { ascending: false }),
      supabase
        .from("announcements")
        .select("*")
        .eq("published", true)
        .order("pinned", { ascending: false })
        .order("published_at", { ascending: false })
        .limit(1),
    ]);

  const cats = (categories ?? []) as Category[];
  const allDocs = (docs ?? []) as DocumentWithCategory[];
  const pinned = (announcements ?? [])[0] as Announcement | undefined;

  return (
    <div className="space-y-8">
      {/* Header + search */}
      <header className="space-y-4">
        <div className="flex flex-wrap items-end justify-between gap-4">
          <div>
            <p className="text-sm font-semibold text-brand-600">AIRPORTELs</p>
            <h1 className="text-3xl font-extrabold tracking-tight text-text">
              คู่มือการทำงาน 📚
            </h1>
            <p className="mt-1 text-muted">
              SOP · Work Instruction · คู่มือต่างๆ สำหรับพนักงานหน้าสาขา
            </p>
          </div>
        </div>
        <div className="max-w-xl">
          <SearchBox />
        </div>
      </header>

      {/* Pinned announcement (compact) */}
      {pinned && (
        <Link
          href="/announcements"
          className="flex items-center gap-3 rounded-2xl border border-brand-200 bg-brand-50 px-4 py-3 transition hover:border-brand-400"
        >
          {pinned.pinned ? (
            <Pin size={17} className="shrink-0 text-brand-600" />
          ) : (
            <Megaphone size={17} className="shrink-0 text-brand-600" />
          )}
          <span className="clamp-1 flex-1 text-sm font-semibold text-brand-900">
            {pinned.title}
          </span>
          <span className="hidden shrink-0 text-xs font-medium text-brand-600 sm:block">
            ดูประกาศ →
          </span>
        </Link>
      )}

      {/* Onboarding CTA */}
      <Link
        href="/onboarding"
        className="group flex items-center gap-4 overflow-hidden rounded-2xl border border-border p-5 transition hover:-translate-y-0.5 hover:shadow-md"
        style={{ background: "linear-gradient(135deg,#efe9ff 0%,#e4f1ff 100%)" }}
      >
        <span className="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-white/70 text-brand-700">
          <GraduationCap size={28} />
        </span>
        <div className="flex-1">
          <h2 className="font-extrabold text-brand-900">พนักงานใหม่เริ่มที่นี่</h2>
          <p className="text-sm text-brand-800/80">
            เส้นทางการเรียนรู้แบบเป็นขั้นตอนสำหรับ Onboarding
          </p>
        </div>
        <ArrowRight className="text-brand-700 transition group-hover:translate-x-1" />
      </Link>

      {/* Knowledge base — pills + cards */}
      <KnowledgeBase docs={allDocs} categories={cats} />
    </div>
  );
}
