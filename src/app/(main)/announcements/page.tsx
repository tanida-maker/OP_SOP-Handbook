import { Megaphone, Pin } from "lucide-react";
import { createClient } from "@/lib/supabase/server";
import T from "@/components/T";
import type { Announcement } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "ประกาศ" };

const LEVEL: Record<
  string,
  { ring: string; badge: string; th: string; en: string }
> = {
  info: {
    ring: "border-brand-200",
    badge: "bg-brand-100 text-brand-700",
    th: "ข้อมูล",
    en: "Info",
  },
  warning: {
    ring: "border-amber-200",
    badge: "bg-amber-100 text-amber-700",
    th: "ควรทราบ",
    en: "Notice",
  },
  critical: {
    ring: "border-red-200",
    badge: "bg-red-100 text-red-700",
    th: "สำคัญมาก",
    en: "Critical",
  },
};

function formatDate(iso: string | null) {
  if (!iso) return "";
  return new Date(iso).toLocaleDateString("th-TH", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

export default async function AnnouncementsPage() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("announcements")
    .select("*")
    .eq("published", true)
    .order("pinned", { ascending: false })
    .order("published_at", { ascending: false });

  const items = (data ?? []) as Announcement[];

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <header className="flex items-center gap-3">
        <span className="grid h-12 w-12 place-items-center rounded-2xl bg-brand-50 text-brand-600">
          <Megaphone size={24} />
        </span>
        <h1 className="text-2xl font-extrabold text-text">
          <T th="ประกาศ" en="Announcements" />
        </h1>
      </header>

      {items.length === 0 ? (
        <p className="rounded-xl border border-dashed border-border bg-surface p-8 text-center text-muted">
          <T th="ยังไม่มีประกาศ" en="No announcements yet" />
        </p>
      ) : (
        <div className="space-y-4">
          {items.map((a) => {
            const lv = LEVEL[a.level] ?? LEVEL.info;
            return (
              <article
                key={a.id}
                className={`rounded-2xl border bg-surface p-5 ${lv.ring}`}
              >
                <div className="mb-2 flex items-center gap-2">
                  {a.pinned && <Pin size={16} className="text-brand-600" />}
                  <span
                    className={`rounded-full px-2.5 py-0.5 text-[11px] font-semibold ${lv.badge}`}
                  >
                    <T th={lv.th} en={lv.en} />
                  </span>
                  <span className="ml-auto text-xs text-muted">
                    {formatDate(a.published_at)}
                  </span>
                </div>
                <h2 className="text-lg font-bold text-text">{a.title}</h2>
                {a.body_html && (
                  <div
                    className="prose mt-2"
                    dangerouslySetInnerHTML={{ __html: a.body_html }}
                  />
                )}
              </article>
            );
          })}
        </div>
      )}
    </div>
  );
}
