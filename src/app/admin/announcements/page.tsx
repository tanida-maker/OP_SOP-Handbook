import { createClient } from "@/lib/supabase/server";
import AnnouncementManager from "./AnnouncementManager";
import type { Announcement } from "@/lib/types";

export const dynamic = "force-dynamic";
export const metadata = { title: "จัดการประกาศ" };

export default async function AdminAnnouncements() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("announcements")
    .select("*")
    .order("pinned", { ascending: false })
    .order("created_at", { ascending: false });

  return <AnnouncementManager items={(data ?? []) as Announcement[]} />;
}
