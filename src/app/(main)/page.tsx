import Link from "next/link";
import { ArrowRight, GraduationCap, Megaphone, Pin } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import CategoryCard from "@/components/CategoryCard";
import DocumentCard from "@/components/DocumentCard";
import SearchBox from "@/components/SearchBox";
import type { Announcement, Category, DocumentWithCategory } from "@/lib/types";

export const dynamic = "force-dynamic";

const LEVEL_STYLES: Record<string, string> = {
  info: "border-brand-200 bg-brand-50 text-brand-800",
  warning: "border-amber-200 bg-amber-50 text-amber-800",
  critical: "border-red-200 bg-red-50 text-red-800",
};

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
        .limit(3),
    ]);

  const cats = (categories ?? []) as Category[];
  const allDocs = (docs ?? []) as DocumentWithCategory[];
  const anns = (announcements ?? []) as Announcement[];

  const counts = allDocs.reduce<Record<string, number>>((acc, d) => {
    if (d.category_id) acc[d.category_id] = (acc[d.category_id] ?? 0) + 1;
    return acc;
  }, {});

  const recent = allDocs.slice(0, 6);

  return (
    <div className="space-y-10">
      {/* Hero */}
      <section className="overflow-hidden rounded-2xl border border-border bg-gradient-to-br from-brand-600 to-brand-800 p-6 text-white md:p-10">
        <h1 className="text-2xl font-extrabold leading-tight md:text-3xl">
          คู่มือการทำงาน ครบ จบ ในที่เดียว
        </h1>
        <p className="mt-2 max-w-xl text-sm text-brand-100 md:text-base">
          SOP, Work Instruction และคู่มือต่างๆ สำหรับพนักงานหน้าสาขา
          เปิดดูได้ทุกที่ทั้งมือถือและคอมพิวเตอร์
        </p>
        <div className="mt-5 max-w-xl [&_input]:border-transparent">
          <SearchBox />
        </div>
      </section>

      {/* Announcements */}
      {anns.length > 0 && (
        <section className="space-y-3">
          <div className="flex items-center justify-between">
            <h2 className="flex items-center gap-2 text-lg font-bold text-text">
              <Megaphone size={20} className="text-brand-600" /> ประกาศล่าสุด
            </h2>
            <Link
              href="/announcements"
              className="text-sm font-medium text-brand-600 hover:underline"
            >
              ดูทั้งหมด
            </Link>
          </div>
          <div className="grid gap-3">
            {anns.map((a) => (
              <Link
                key={a.id}
                href="/announcements"
                className={`flex items-start gap-3 rounded-xl border p-4 ${
                  LEVEL_STYLES[a.level] ?? LEVEL_STYLES.info
                }`}
              >
                {a.pinned ? (
                  <Pin size={18} className="mt-0.5 shrink-0" />
                ) : (
                  <Megaphone size={18} className="mt-0.5 shrink-0" />
                )}
                <div>
                  <p className="font-semibold">{a.title}</p>
                </div>
              </Link>
            ))}
          </div>
        </section>
      )}

      {/* Onboarding CTA */}
      <section>
        <Link
          href="/onboarding"
          className="flex items-center gap-4 rounded-2xl border border-brand-200 bg-brand-50 p-5 transition hover:border-brand-400"
        >
          <span className="grid h-14 w-14 shrink-0 place-items-center rounded-xl bg-brand-600 text-white">
            <GraduationCap size={28} />
          </span>
          <div className="flex-1">
            <h2 className="font-bold text-brand-900">พนักงานใหม่เริ่มที่นี่</h2>
            <p className="text-sm text-brand-800/80">
              เส้นทางการเรียนรู้แบบเป็นขั้นตอนสำหรับการ Onboarding
            </p>
          </div>
          <ArrowRight className="text-brand-600" />
        </Link>
      </section>

      {/* Categories */}
      <section id="categories" className="scroll-mt-20 space-y-4">
        <h2 className="text-lg font-bold text-text">หมวดหมู่ทั้งหมด</h2>
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {cats.map((c) => (
            <CategoryCard key={c.id} category={c} count={counts[c.id] ?? 0} />
          ))}
        </div>
      </section>

      {/* Recently updated */}
      {recent.length > 0 && (
        <section className="space-y-4">
          <h2 className="text-lg font-bold text-text">อัปเดตล่าสุด</h2>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {recent.map((d) => (
              <DocumentCard key={d.id} doc={d} />
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
