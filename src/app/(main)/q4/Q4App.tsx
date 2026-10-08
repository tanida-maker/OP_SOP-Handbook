"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { UserCog, NotebookText, ClipboardList, Download, ListChecks, Loader2, PieChart, Presentation, Radio, Users } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/LanguageProvider";
import {
  Q4_AREA_HELP, Q4_BRANCHES, Q4_CATEGORIES, Q4_CATEGORY_NAMES, Q4_CLOSED, Q4_PRIORITIES,
  Q4_STATUSES, Q4_STATUS_TH, Q4_TEAMS, q4AreasFor,
  type Q4Entry, type Q4Plan, type Q4Priority, type Q4Review, type Q4TeamMember, type Q4Analysis, type Q4Task, type Q4Attachment,
} from "@/lib/q4";

type Tab = "form" | "list" | "summary" | "present" | "team" | "users" | "meet";
type Q4Role = "review" | "assign" | "edit" | null;
type Draft = {
  branch: string; service_area: string; category: string; period: string;
  issue: string; impact: string; support: string; prep: string; priority: Q4Priority | ""; notes: string;
};
const EMPTY: Draft = {
  branch: "", service_area: "", category: "", period: "", issue: "", impact: "",
  support: "", prep: "", priority: "", notes: "",
};

const PRI_STYLE: Record<string, string> = {
  High: "bg-danger text-white",
  Medium: "bg-warn text-white",
  Low: "bg-brand-500 text-white",
};
const fmt = (iso: string) => {
  try { return new Date(iso).toLocaleString("th-TH", { dateStyle: "medium", timeStyle: "short" }); }
  catch { return ""; }
};
const short = (cat: string) => cat.split(" / ")[0];
const UNASSIGNED = "__none";

export default function Q4App({
  userId, isAdmin: sopAdmin, fullName, initialTab = "form", initialTeam = "", external = false, company = false, role = null,
}: { userId: string | null; isAdmin: boolean; fullName: string; initialTab?: Tab; initialTeam?: string; external?: boolean; company?: boolean; role?: Q4Role }) {
  // Q4 roles (User Management): edit = Q4 admin · assign = assign teams / status · review = see all, read-only
  const isAdmin = sopAdmin || role === "edit";
  const canAssign = isAdmin || role === "assign";
  const seesAll = canAssign || role === "review";
  const t = useT();
  const supabase = useMemo(() => createClient(), []);

  // External Support members (invited by e-mail) only get Summary / Presentation / Support team
  // Access levels: Scheduling staff = all tabs · company e-mail = all but the form · other invited = 3 tabs
  const limited = external && !company && !role;
  const canSubmit = !external;
  const [tab, setTab] = useState<Tab>(
    limited && !["summary", "present", "team"].includes(initialTab) ? "team"
      : !canSubmit && initialTab === "form" ? "list" : initialTab);
  const [entries, setEntries] = useState<Q4Entry[]>([]);
  const [reviews, setReviews] = useState<Record<string, Q4Review>>({});
  const [plans, setPlans] = useState<Record<string, Q4Plan>>({});
  const [notes, setNotes] = useState<Record<string, Record<string, string>>>({});
  const [tasks, setTasks] = useState<Record<string, Record<string, Q4Task>>>({});
  const [files, setFiles] = useState<Record<string, Q4Attachment[]>>({});
  const [loading, setLoading] = useState(true);
  const [live, setLive] = useState(false);
  const [loadErr, setLoadErr] = useState("");
  const [myName, setMyName] = useState(fullName);
  const [toast, setToast] = useState("");
  const [myTeams, setMyTeams] = useState<string[]>([]);
  const [teamMembers, setTeamMembers] = useState<Q4TeamMember[]>([]);
  const [analysis, setAnalysis] = useState<Q4Analysis | null>(null);

  // ---------- data ----------
  const loadAll = useCallback(async () => {
    const [e, r, p, n] = await Promise.all([
      supabase.from("q4_entries").select("*").order("created_at", { ascending: false }),
      supabase.from("q4_reviews").select("*"),
      supabase.from("q4_plans").select("*"),
      supabase.from("q4_team_notes").select("entry_id, team, note"),
    ]);
    if (e.error) { setLoadErr(e.error.message); setLoading(false); return; }
    setLoadErr("");
    setEntries((e.data ?? []) as Q4Entry[]);
    const nm: Record<string, Record<string, string>> = {};
    ((n.data ?? []) as { entry_id: string; team: string; note: string }[]).forEach((x) => {
      (nm[x.entry_id] = nm[x.entry_id] || {})[x.team] = x.note;
    });
    setNotes(nm);
    const tk = await supabase.from("q4_team_tasks").select("entry_id, team, assignee, assignee_email, assignee_name");
    const tkm: Record<string, Record<string, Q4Task>> = {};
    ((tk.data ?? []) as Q4Task[]).forEach((x) => { (tkm[x.entry_id] = tkm[x.entry_id] || {})[x.team] = x; });
    setTasks(tkm);
    const at = await supabase.from("q4_attachments").select("*").order("created_at");
    const atm: Record<string, Q4Attachment[]> = {};
    ((at.data ?? []) as Q4Attachment[]).forEach((x) => { (atm[x.entry_id] = atm[x.entry_id] || []).push(x); });
    setFiles(atm);
    const rm: Record<string, Q4Review> = {};
    (r.data ?? []).forEach((x) => { rm[(x as Q4Review).entry_id] = x as Q4Review; });
    setReviews(rm);
    const pm: Record<string, Q4Plan> = {};
    (p.data ?? []).forEach((x) => { pm[(x as Q4Plan).category] = x as Q4Plan; });
    setPlans(pm);
    const an = await supabase.from("q4_analysis").select("*").order("created_at", { ascending: false }).limit(1);
    setAnalysis(((an.data ?? [])[0] as Q4Analysis | undefined) ?? null);
    let mine: string[] = [];
    if (userId) {
      const tm = await supabase.from("q4_team_members").select("team").eq("user_id", userId);
      mine = (tm.data ?? []).map((x) => (x as { team: string }).team);
      setMyTeams(mine);
    }
    if (seesAll || mine.length) {
      // admins get every team, team members only their own teams (filtered in SQL)
      const lm = await supabase.rpc("q4_list_team_members");
      setTeamMembers((lm.data ?? []) as Q4TeamMember[]);
    }
    setLoading(false);
  }, [supabase, userId, seesAll]);

  const reloadTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  useEffect(() => {
    const schedule = (delay = 300) => {
      if (reloadTimer.current) clearTimeout(reloadTimer.current);
      reloadTimer.current = setTimeout(loadAll, delay);
    };
    schedule(0);
    const ch = supabase
      .channel("q4-live")
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_entries" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_reviews" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_plans" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_team_members" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_team_notes" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_team_tasks" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_attachments" }, () => schedule())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_analysis" }, () => schedule())
      .subscribe((status) => setLive(status === "SUBSCRIBED"));
    return () => {
      if (reloadTimer.current) clearTimeout(reloadTimer.current);
      supabase.removeChannel(ch);
    };
  }, [supabase, loadAll]);

  // ---------- form state + profile prefill ----------
  const [draft, setDraft] = useState<Draft>(EMPTY);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [formErr, setFormErr] = useState("");

  useEffect(() => {
    (async () => {
      const { data } = await supabase.rpc("q4_my_profile");
      if (!data || typeof data !== "object") return;
      const p = data as Record<string, unknown>;
      const name = [p.full_name, p.name, p.nickname, p.display_name].find((v) => typeof v === "string" && v);
      if (name) setMyName(String(name));
      const raw = [p.branch, p.branch_code, p.location, p.site].find((v) => typeof v === "string" && v);
      if (raw) {
        const s = String(raw).toUpperCase();
        const hit = Q4_BRANCHES.find((b) => s === b.toUpperCase() || s.includes(b.toUpperCase()));
        if (hit) setDraft((d) => (d.branch ? d : { ...d, branch: hit, service_area: hit === "Online - CS" ? "Online - CS" : "" }));
      }
    })();
  }, [supabase]);

  const set = (k: keyof Draft, v: string) => setDraft((d) => ({ ...d, [k]: v }));
  const pickBranch = (b: string) =>
    setDraft((d) => {
      const areas = q4AreasFor(b);
      return { ...d, branch: b, service_area: areas.includes(d.service_area) ? d.service_area : areas.length === 1 ? areas[0] : "" };
    });
  const pickArea = (a: string) =>
    setDraft((d) => ({ ...d, service_area: a, category: a === "Porter" && !d.category ? "Porter / งานขนย้ายกระเป๋า" : d.category }));

  const flash = (m: string) => { setToast(m); setTimeout(() => setToast(""), 2600); };

  async function submit() {
    setFormErr("");
    const miss: string[] = [];
    if (!draft.branch) miss.push("Branch / Team");
    if (!draft.service_area) miss.push("Service Area");
    if (!draft.category) miss.push("Category");
    if (!draft.issue.trim()) miss.push(t("ปัญหา", "Issue"));
    if (!draft.impact.trim()) miss.push(t("ผลกระทบ", "Impact"));
    if (!draft.support.trim()) miss.push(t("สิ่งที่ต้องการให้ Support", "Support required"));
    if (!draft.priority) miss.push("Priority");
    if (miss.length) { setFormErr(t("ยังขาด: ", "Missing: ") + miss.join(", ")); return; }

    setSaving(true);
    const row = {
      branch: draft.branch, service_area: draft.service_area, category: draft.category,
      period: draft.period.trim() || null, issue: draft.issue.trim(), impact: draft.impact.trim(),
      support: draft.support.trim(), prep: draft.prep.trim() || null, priority: draft.priority,
      notes: draft.notes.trim() || null,
    };
    const res = editingId
      ? await supabase.from("q4_entries").update(row).eq("id", editingId)
      : await supabase.from("q4_entries").insert({ ...row, created_by: userId, created_name: myName || null });
    setSaving(false);
    if (res.error) { setFormErr(t("บันทึกไม่สำเร็จ: ", "Save failed: ") + res.error.message); return; }
    flash(editingId ? t("บันทึกการแก้ไขแล้ว", "Changes saved") : t("ส่งข้อมูลแล้ว เพิ่มประเด็นถัดไปได้เลย", "Submitted. Add the next issue"));
    setEditingId(null);
    setDraft((d) => ({ ...EMPTY, branch: d.branch, service_area: d.service_area }));
    loadAll();
  }

  function startEdit(e: Q4Entry) {
    if (!userId || e.created_by !== userId) return;
    setEditingId(e.id);
    setDraft({
      branch: e.branch, service_area: e.service_area, category: e.category, period: e.period ?? "",
      issue: e.issue, impact: e.impact, support: e.support, prep: e.prep ?? "", priority: e.priority, notes: e.notes ?? "",
    });
    setTab("form");
    window.scrollTo({ top: 0, behavior: "smooth" });
  }

  async function remove(e: Q4Entry) {
    if (!confirm(t(`ลบประเด็นของ ${e.branch} (${short(e.category)}) ใช่ไหม`, `Delete this ${e.branch} issue?`))) return;
    const { error } = await supabase.from("q4_entries").delete().eq("id", e.id);
    if (error) flash(t("ลบไม่สำเร็จ", "Delete failed")); else { flash(t("ลบแล้ว", "Deleted")); loadAll(); }
  }

  // Team member (not admin): may change status + action of issues assigned to their team.
  // Lark notification (group + reporter DM) when the status really changed. Never blocks the save.
  async function notifyLark(id: string, prev: string, next: string, prevTeams: string[], nextTeams: string[], assigned = false) {
    const added = nextTeams.some((x) => !prevTeams.includes(x));
    if (prev === next && !added && !assigned) return;
    try {
      const res = await fetch("/api/q4/notify", {
        method: "POST", headers: { "content-type": "application/json" },
        body: JSON.stringify({ entry_id: id, prev_status: prev, prev_teams: prevTeams, assigned }),
      });
      const j = await res.json().catch(() => ({}));
      if (j.group === "sent" || j.branch === "sent" || j.dm === "sent") flash(t("อัปเดตแล้ว และแจ้ง Lark แล้ว", "Updated and sent to Lark"));
    } catch { /* notification is best-effort */ }
  }

  // Team workspace: status + delegate to other teams + team comment + person in the team, in one save.
  async function saveTask(id: string, team: string, status: string, addTeams: string[], note: string, assigneeEmail: string) {
    const prev = reviews[id]?.status ?? "New";
    const prevTeams = reviews[id]?.teams ?? [];
    const teams = Array.from(new Set([...prevTeams, team, ...addTeams]));
    const u = await supabase.from("q4_reviews").update({ status, teams, updated_as: team }).eq("entry_id", id).select("entry_id");
    if (u.error || !u.data?.length) { flash(t("อัปเดตไม่สำเร็จ (ไม่มีสิทธิ์ในเรื่องนี้)", "Update failed (no permission)")); return false; }
    const err = await writeNotes(id, { [team]: note });
    if (err) { flash(t("บันทึกความเห็นไม่สำเร็จ: ", "Comment failed: ") + err); return false; }
    let assigned = false;
    const cur = (tasks[id]?.[team]?.assignee_email ?? "").toLowerCase();
    if (assigneeEmail.trim().toLowerCase() !== cur) {
      let r = await supabase.rpc("q4_assign_task", { p_entry: id, p_team: team, p_email: assigneeEmail.trim() || null });
      if (!r.error && r.data === "not_found") {
        // no account yet: create it and add to the team, then assign
        if (!(await inviteToTeam(assigneeEmail.trim(), team))) return false;
        r = await supabase.rpc("q4_assign_task", { p_entry: id, p_team: team, p_email: assigneeEmail.trim() });
      }
      if (r.error) { flash(t("มอบหมายผู้รับงานไม่สำเร็จ: ", "Assign failed: ") + r.error.message); return false; }
      if (r.data === "not_found") { flash(t("ไม่พบบัญชีอีเมลนี้", "No account with this e-mail")); return false; }
      assigned = true;
    }
    flash(t("อัปเดตแล้ว", "Updated"));
    loadAll();
    notifyLark(id, prev, status, prevTeams, teams, assigned);
    return true;
  }

  // ---------- attachments (Supabase Storage bucket "q4-files", private) ----------
  async function uploadFiles(entryId: string, team: string, list: FileList | File[]) {
    let ok = 0;
    for (const file of Array.from(list)) {
      if (file.size > 10 * 1024 * 1024) { flash(t(`${file.name} ใหญ่เกิน 10 MB`, `${file.name} is over 10 MB`)); continue; }
      const safe = file.name.replace(/[^\w.\-]+/g, "_").slice(-80);
      const path = `${entryId}/${crypto.randomUUID()}-${safe}`;
      const up = await supabase.storage.from("q4-files").upload(path, file, { contentType: file.type || undefined });
      if (up.error) { flash(t("อัปโหลดไม่สำเร็จ: ", "Upload failed: ") + up.error.message); continue; }
      const ins = await supabase.from("q4_attachments").insert({
        entry_id: entryId, team, path, name: file.name, mime: file.type || null, size: file.size, uploaded_by: userId,
      });
      if (ins.error) { await supabase.storage.from("q4-files").remove([path]); flash(t("บันทึกไฟล์ไม่สำเร็จ: ", "Save failed: ") + ins.error.message); continue; }
      ok++;
    }
    if (ok) { flash(t(`อัปโหลดแล้ว ${ok} ไฟล์`, `Uploaded ${ok} file(s)`)); loadAll(); }
  }
  async function openFile(a: Q4Attachment) {
    const r = await supabase.storage.from("q4-files").createSignedUrl(a.path, 60 * 60, { download: false });
    if (r.error || !r.data) { flash(t("เปิดไฟล์ไม่สำเร็จ", "Could not open file")); return; }
    window.open(r.data.signedUrl, "_blank", "noopener");
  }
  async function downloadFile(a: Q4Attachment) {
    const r = await supabase.storage.from("q4-files").createSignedUrl(a.path, 60 * 60, { download: a.name });
    if (r.error || !r.data) { flash(t("ดาวน์โหลดไม่สำเร็จ", "Download failed")); return; }
    window.location.href = r.data.signedUrl;
  }
  async function deleteFile(a: Q4Attachment) {
    if (!confirm(t(`ลบไฟล์ ${a.name} ใช่ไหม`, `Delete ${a.name}?`))) return;
    const d = await supabase.from("q4_attachments").delete().eq("id", a.id);
    if (d.error) { flash(t("ลบไม่สำเร็จ", "Delete failed")); return; }
    await supabase.storage.from("q4-files").remove([a.path]);
    loadAll();
  }
  const fileOps = { upload: uploadFiles, open: openFile, download: downloadFile, remove: deleteFile };

  // Upsert non-empty notes, delete emptied ones, for the given teams only.
  async function writeNotes(id: string, teamNotes: Record<string, string>) {
    const up = Object.entries(teamNotes).filter(([, v]) => v.trim()).map(([team, v]) => ({ entry_id: id, team, note: v.trim() }));
    const del = Object.entries(teamNotes).filter(([, v]) => !v.trim()).map(([team]) => team);
    if (up.length) {
      const r = await supabase.from("q4_team_notes").upsert(up, { onConflict: "entry_id,team" });
      if (r.error) return r.error.message;
    }
    if (del.length) {
      const r = await supabase.from("q4_team_notes").delete().eq("entry_id", id).in("team", del);
      if (r.error) return r.error.message;
    }
    return null;
  }

  // Team member (not admin): status of an issue assigned to their team + their own team's comment.
  async function saveTeamReview(id: string, status: string, teams: string[], updatedAs: string, teamNotes: Record<string, string>) {
    const prev = reviews[id]?.status ?? "New";
    const { data, error } = await supabase.from("q4_reviews")
      .update({ status, teams, updated_as: updatedAs || null }).eq("entry_id", id).select("entry_id");
    if (error || !data?.length) { flash(t("อัปเดตไม่สำเร็จ (ไม่มีสิทธิ์ในเรื่องนี้)", "Update failed (no permission)")); return; }
    const err = await writeNotes(id, teamNotes);
    if (err) flash(t("บันทึกความเห็นทีมไม่สำเร็จ: ", "Team comment failed: ") + err);
    else {
      flash(t("อัปเดตแล้ว", "Updated")); loadAll();
      notifyLark(id, prev, status, reviews[id]?.teams ?? [], teams);
    }
  }

  // Save a summary that an admin produced in claude.ai (pasted back) so every team can read it.
  async function saveAnalysis(content: string) {
    const text = content.trim();
    if (!text) return false;
    const { error } = await supabase.from("q4_analysis")
      .insert({ content: text, entry_count: entries.length, model: "claude.ai", created_by: userId });
    if (error) { flash(t("บันทึกไม่สำเร็จ: ", "Save failed: ") + error.message); return false; }
    flash(t("บันทึกสรุปแล้ว ทุกทีมเห็นได้ทันที", "Summary saved for all teams"));
    loadAll();
    return true;
  }

  // Adds a person to a team; creates a login account for people without one (e.g. external / Gmail).
  async function inviteToTeam(email: string, team: string): Promise<boolean> {
    try {
      const res = await fetch("/api/q4/invite", {
        method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify({ email, team }),
      });
      const j = await res.json().catch(() => ({}));
      if (!res.ok) {
        const map: Record<string, string> = {
          bad_email: t("อีเมลไม่ถูกต้อง", "Invalid e-mail"),
          not_allowed: t("เพิ่มได้เฉพาะคนในทีมนี้หรือ Admin", "Only this team or Admin can add"),
          missing_service_key: t("ยังไม่ได้ตั้งค่า SUPABASE_SERVICE_ROLE_KEY ใน Vercel", "SUPABASE_SERVICE_ROLE_KEY not set"),
        };
        flash(map[j.error] ?? t("เพิ่มไม่สำเร็จ: ", "Failed: ") + (j.error ?? res.status));
        return false;
      }
      flash(j.created
        ? t(`เพิ่ม ${email} แล้ว (บัญชีใหม่) ให้ Login ด้วย Google หรือส่งลิงก์ทางอีเมล`, `Added ${email} (new account)`)
        : t(`เพิ่ม ${email} เข้าทีม ${team} แล้ว`, `Added ${email} to ${team}`));
      return true;
    } catch {
      flash(t("เชื่อมต่อไม่สำเร็จ", "Connection failed"));
      return false;
    }
  }
  async function addTeamMember(email: string, team: string) {
    if (await inviteToTeam(email, team)) loadAll();
  }
  async function removeTeamMember(m: Q4TeamMember) {
    if (!confirm(t(`เอา ${m.full_name || m.email} ออกจากทีม ${m.team} ใช่ไหม`, `Remove ${m.email} from ${m.team}?`))) return;
    const { error } = await supabase.from("q4_team_members").delete().eq("user_id", m.user_id).eq("team", m.team);
    if (error) flash(t("ลบไม่สำเร็จ", "Remove failed")); else { flash(t("นำออกแล้ว", "Removed")); loadAll(); }
  }

  async function saveReview(id: string, status: string, teams: string[], action: string, teamNotes: Record<string, string>, updatedAs = "") {
    const prev = reviews[id]?.status ?? "New";
    const { error } = await supabase.from("q4_reviews").upsert({
      entry_id: id, status, teams, team: teams[0] ?? null, action: action.trim() || null, updated_as: updatedAs || null,
      updated_by: userId, updated_at: new Date().toISOString(),
    });
    if (error) { flash(t("อัปเดตไม่สำเร็จ: ", "Update failed: ") + error.message); return; }
    // drop comments of teams that were un-assigned
    const removed = Object.keys(notes[id] ?? {}).filter((tm) => !teams.includes(tm));
    const all: Record<string, string> = { ...teamNotes };
    removed.forEach((tm) => { all[tm] = ""; });
    const err = await writeNotes(id, all);
    if (err) flash(t("บันทึกความเห็นทีมไม่สำเร็จ: ", "Team comment failed: ") + err);
    else {
      flash(t("อัปเดตสถานะแล้ว", "Status updated")); loadAll();
      notifyLark(id, prev, status, reviews[id]?.teams ?? [], teams);
    }
  }

  async function savePlan(category: string, plan: string) {
    if ((plans[category]?.plan ?? "") === plan.trim()) return;
    const { error } = await supabase.from("q4_plans").upsert({
      category, plan: plan.trim(), updated_by: userId, updated_at: new Date().toISOString(),
    });
    if (error) flash(t("บันทึกแผนไม่สำเร็จ", "Plan save failed")); else { flash(t("บันทึกแผน Support แล้ว", "Plan saved")); loadAll(); }
  }

  const statusOf = useCallback((e: Q4Entry) => reviews[e.id]?.status ?? "New", [reviews]);
  const teamsOf = useCallback((e: Q4Entry): string[] => {
    const r = reviews[e.id];
    if (!r) return [];
    if (r.teams && r.teams.length) return r.teams;
    return r.team ? [r.team] : [];
  }, [reviews]);
  const teamOf = useCallback((e: Q4Entry) => teamsOf(e).join(", "), [teamsOf]);

  // ---------- export (CSV in Lark import column order) ----------
  function exportCsv() {
    const head = [
      "No.", "Branch / Team", "Service Area", "Category", "Issue / Situation from Previous Year", "Impact",
      "Support Required from Central", "Priority", "Proposed Solution / Preparation", "Responsible Team",
      "Status", "Additional Notes", "Period", "Central Action", "Team Comments", "Submitted By", "Submitted At",
    ];
    const rows = [...entries]
      .sort((a, b) => a.created_at.localeCompare(b.created_at))
      .map((e, i) => [
        String(i + 1), e.branch, e.service_area, e.category, e.issue, e.impact, e.support, e.priority,
        e.prep ?? "", teamOf(e), statusOf(e), e.notes ?? "", e.period ?? "", reviews[e.id]?.action ?? "",
        Object.entries(notes[e.id] ?? {}).map(([tm, v]) => `${tm}: ${v}`).join(" | "),
        e.created_name ?? "", fmt(e.created_at),
      ]);
    const cell = (v: string) => `"${String(v).replace(/"/g, '""')}"`;
    const csv = "\uFEFF" + [head, ...rows].map((r) => r.map(cell).join(",")).join("\r\n");
    const url = URL.createObjectURL(new Blob([csv], { type: "text/csv;charset=utf-8" }));
    const a = document.createElement("a");
    const d = new Date();
    a.href = url;
    a.download = `Q4_NewYear_Support_${d.getFullYear()}${String(d.getMonth() + 1).padStart(2, "0")}${String(d.getDate()).padStart(2, "0")}.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }

  // ---------- derived ----------
  const byBranch = useMemo(() => {
    const m: Record<string, { n: number; hi: number }> = {};
    entries.forEach((e) => {
      m[e.branch] = m[e.branch] || { n: 0, hi: 0 };
      m[e.branch].n++;
      if (e.priority === "High" && !Q4_CLOSED.has(statusOf(e))) m[e.branch].hi++;
    });
    return m;
  }, [entries, statusOf]);
  const responded = Q4_BRANCHES.filter((b) => byBranch[b]).length;

  const [fBranch, setFBranch] = useState("");
  const [fTeam, setFTeam] = useState(initialTeam);

  return (
    <div className="space-y-6">
      {/* ===== Header + branch coverage board ===== */}
      <section className="rounded-2xl bg-[#14232E] p-5 text-[#E9F1F8] md:p-7">
        <p className="mb-1 flex items-center gap-2 text-sm font-semibold text-[#CFE2F3]">
          <span className="inline-block h-2 w-2 rounded-full bg-[#E23744]" />
          Q4 & New Year Readiness
        </p>
        <h1 className="text-2xl font-extrabold md:text-3xl">
          {t("เตรียมความพร้อม Q4 และช่วงปีใหม่", "Q4 & New Year preparation")}
        </h1>
        <p className="mt-1 max-w-3xl text-sm text-[#C2D3E2] md:text-base">
          {t(
            "แจ้งปัญหาที่เคยเกิดในช่วง Q4 / ปีใหม่ที่ผ่านมา และสิ่งที่ต้องการให้ส่วนกลาง Support กรอก 1 รายการต่อ 1 ประเด็น",
            "Report last year's Q4 / New Year issues and the support you need from Central. One entry per issue."
          )}
        </p>
        <div className="mb-2 mt-5 flex flex-wrap items-baseline justify-between gap-2">
          <strong className="text-[#CFE2F3]">
            {t("สาขา/ทีมที่ส่งข้อมูลแล้ว", "Branches/teams responded")} {responded}/{Q4_BRANCHES.length}
          </strong>
          <span className="flex items-center gap-1.5 text-xs text-[#9FB6C9]">
            <Radio size={14} className={live ? "text-emerald-400" : "text-slate-500"} />
            {live ? t("อัปเดตสด", "Live") : t("กำลังเชื่อมต่อ", "Connecting")}
          </span>
        </div>
        <div className="grid grid-cols-[repeat(auto-fill,minmax(82px,1fr))] gap-1.5">
          {Q4_BRANCHES.map((b) => {
            const s = byBranch[b];
            return (
              <button
                key={b}
                onClick={() => { if (limited) return; setFBranch(b); setTab("list"); }}
                className={`flex min-h-[60px] flex-col justify-between rounded-md p-2 text-left transition ${
                  s ? "bg-[#CFE2F3] text-[#14232E]" : "border border-dashed border-[#3A5163] text-[#7F97AA] hover:border-[#CFE2F3]"
                } ${s?.hi ? "shadow-[inset_0_-3px_0_#E23744]" : ""}`}
              >
                <span className={`font-bold leading-none tracking-wide ${b.length > 5 ? "text-sm" : "text-xl"}`}>{b}</span>
                <span className="text-[11px]">{s ? `${s.n} ${t("ประเด็น", "issues")}` : t("ยังไม่ส่ง", "None yet")}</span>
              </button>
            );
          })}
        </div>
      </section>

      {/* ===== Tabs ===== */}
      <div className="flex gap-1 overflow-x-auto border-b border-border">
        {([
          ["form", t("กรอกข้อมูล", "Submit"), ClipboardList],
          ["list", `${t("รายการทั้งหมด", "All issues")}${entries.length ? ` (${entries.length})` : ""}`, ListChecks],
          ["summary", t("สรุปผล", "Summary"), PieChart],
          ["present", t("Presentation", "Presentation"), Presentation],
          ...((seesAll || myTeams.length || external) ? [["team", t("ทีม Support", "Support team"), Users] as const] : []),
          ["meet", t("Minute Meeting", "Minute Meeting"), NotebookText],
          ...(isAdmin ? [["users", t("ผู้ใช้งาน Q4", "Q4 users"), UserCog] as const] : []),
        ] as const).filter(([k]) => (k !== "form" || canSubmit) && (!limited || k === "summary" || k === "present" || k === "team" || k === "meet")).map(([k, label, Icon]) => (
          <button
            key={k}
            onClick={() => setTab(k)}
            className={`flex items-center gap-2 whitespace-nowrap border-b-[3px] px-4 py-3 text-sm font-semibold transition ${
              tab === k ? "border-[#E23744] text-text" : "border-transparent text-muted hover:text-text"
            }`}
          >
            <Icon size={17} /> {label}
          </button>
        ))}
      </div>

      {loadErr && (
        <div className="rounded-xl border border-danger/40 bg-danger/5 p-3 text-sm">
          {t("โหลดข้อมูลไม่สำเร็จ: ", "Could not load data: ")}{loadErr}
        </div>
      )}

      {tab === "form" && (
        <FormView
          draft={draft} set={set} pickBranch={pickBranch} pickArea={pickArea}
          editing={!!editingId} saving={saving} err={formErr} submit={submit}
          cancel={() => { setEditingId(null); setDraft((d) => ({ ...EMPTY, branch: d.branch, service_area: d.service_area })); }}
          myName={myName}
        />
      )}
      {tab === "list" && (
        <ListView
          entries={entries} reviews={reviews} loading={loading} userId={userId} isAdmin={isAdmin} canAssign={canAssign}
          statusOf={statusOf} teamsOf={teamsOf} fBranch={fBranch} setFBranch={setFBranch} fTeam={fTeam} setFTeam={setFTeam}
          onEdit={startEdit} onDelete={remove} onReview={saveReview}
          myTeams={myTeams} onTeamReview={saveTeamReview} notes={notes} tasks={tasks}
        />
      )}
      {tab === "summary" && (
        <SummaryView
          entries={entries} plans={plans} isAdmin={isAdmin} statusOf={statusOf} teamsOf={teamsOf}
          onPlan={savePlan} onExport={exportCsv}
          teamMembers={teamMembers} onAddMember={addTeamMember} onRemoveMember={removeTeamMember}
          analysis={analysis} onSaveAnalysis={saveAnalysis}
          onPickTeam={(team) => { setFTeam(team); setTab("list"); window.scrollTo({ top: 0, behavior: "smooth" }); }}
        />
      )}

      {tab === "present" && <PresentationView />}
      {tab === "users" && isAdmin && <UsersView userId={userId} flash={flash} />}
      {tab === "meet" && <MeetingsView canEdit={isAdmin} userId={userId} flash={flash} />}
      {tab === "team" && (
        <MyTeamView
          isAdmin={isAdmin} seesAll={seesAll} canAssign={canAssign} myTeams={myTeams} members={teamMembers} userId={userId}
          entries={entries} statusOf={statusOf} teamsOf={teamsOf} notes={notes} tasks={tasks} onSaveTask={saveTask}
          files={files} fileOps={fileOps} external={limited}
          onAdd={addTeamMember} onRemove={removeTeamMember}
          onOpenList={(team) => { setFTeam(team); setTab("list"); window.scrollTo({ top: 0, behavior: "smooth" }); }}
        />
      )}

      {toast && (
        <div className="fixed bottom-6 left-1/2 z-50 -translate-x-1/2 rounded-lg bg-[#14232E] px-4 py-2.5 text-sm text-white shadow-lg">
          {toast}
        </div>
      )}
    </div>
  );
}

/* ====================================================================== */
/* Form                                                                   */
/* ====================================================================== */
const card = "rounded-xl border border-border bg-surface p-5";
const input = "w-full rounded-lg border border-border bg-surface px-3 py-2 text-[15px] outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-100";
const chip = (on: boolean) =>
  `rounded-lg border px-3 py-1.5 text-sm font-semibold transition ${
    on ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface text-text hover:border-brand-400"
  }`;

function FormView({
  draft, set, pickBranch, pickArea, editing, saving, err, submit, cancel, myName,
}: {
  draft: Draft; set: (k: keyof Draft, v: string) => void; pickBranch: (b: string) => void; pickArea: (a: string) => void;
  editing: boolean; saving: boolean; err: string; submit: () => void; cancel: () => void; myName: string;
}) {
  const t = useT();
  const guide = Q4_CATEGORIES.find((c) => c.name === draft.category);
  const steps: [keyof Draft, string, string, boolean, boolean][] = [
    ["issue", t("ปัญหา / สิ่งที่เคยเกิดขึ้นในปีที่ผ่านมา", "Issue / situation last year"), "เช่น ช่วง 17:00–20:00 มีลูกค้าและกระเป๋าเข้าพร้อมกันจำนวนมาก", true, false],
    ["impact", t("ผลกระทบ", "Impact"), "เช่น ลูกค้ารอและเกิด Queue", true, false],
    ["support", t("สิ่งที่ต้องการให้ส่วนกลาง Support", "Support required from Central"), "เช่น ต้องการเพิ่มกำลัง Guest Service ในช่วง Peak", true, true],
    ["prep", t("แนวทางที่ทีมสามารถเตรียมเองได้", "What the team can prepare itself"), "เช่น สาขาจะจัด Shift และเตรียม Backup Staff", false, false],
  ];

  return (
    <div className="grid gap-6 lg:grid-cols-[minmax(0,1fr)_300px]">
      <div className="space-y-4">
        <div className={card}>
          <div className="mb-1 flex flex-wrap items-baseline justify-between gap-2">
            <h2 className="text-lg font-bold">{editing ? t("แก้ไขประเด็น", "Edit issue") : t("ผู้แจ้งข้อมูล", "Reported by")}</h2>
            {myName && <span className="text-sm text-muted">{t("ผู้กรอก", "Submitted as")}: {myName}</span>}
          </div>
          <p className="mb-4 text-sm text-muted">
            {t("สาขาที่มี Porter (DMK / BKK) ให้แยกประเด็น Porter ออกจาก Guest Service", "DMK / BKK: report Porter issues separately from Guest Service")}
          </p>
          <p className="mb-1.5 text-[15px] font-semibold">Branch / Team <span className="text-danger">*</span></p>
          <div className="mb-4 flex flex-wrap gap-1.5">
            {Q4_BRANCHES.map((b) => (
              <button key={b} type="button" onClick={() => pickBranch(b)} className={chip(draft.branch === b)}>{b}</button>
            ))}
          </div>
          <p className="mb-1.5 text-[15px] font-semibold">Service Area <span className="text-danger">*</span></p>
          {draft.branch ? (
            <div className="grid gap-1.5 sm:grid-cols-2 lg:grid-cols-3">
              {q4AreasFor(draft.branch).map((a) => (
                <button key={a} type="button" onClick={() => pickArea(a)} className={`${chip(draft.service_area === a)} text-left`}>
                  {a}
                  <span className={`block text-xs font-normal ${draft.service_area === a ? "text-[#CFE2F3]/80" : "text-muted"}`}>
                    {Q4_AREA_HELP[a]}
                  </span>
                </button>
              ))}
            </div>
          ) : (
            <p className="text-sm text-muted">{t("เลือกสาขา/ทีมก่อน", "Pick a branch/team first")}</p>
          )}
        </div>

        <div className={card}>
          <h2 className="mb-3 text-lg font-bold">{t("หมวดหมู่ของประเด็น", "Category")}</h2>
          <label className="mb-1.5 block text-[15px] font-semibold" htmlFor="q4cat">Category <span className="text-danger">*</span></label>
          <select id="q4cat" className={`${input} mb-4`} value={draft.category} onChange={(e) => set("category", e.target.value)}>
            <option value="">{t("เลือกหมวดหมู่", "Choose a category")}</option>
            {Q4_CATEGORY_NAMES.map((c) => <option key={c}>{c}</option>)}
          </select>
          <label className="mb-1.5 block text-[15px] font-semibold" htmlFor="q4period">{t("ช่วงเวลา / วันที่ที่เกิด", "When it happens")}</label>
          <input id="q4period" className={input} value={draft.period} onChange={(e) => set("period", e.target.value)}
            placeholder="เช่น 17:00–20:00 น. / 28 ธ.ค. – 2 ม.ค." />
        </div>

        <div className={card}>
          <h2 className="mb-1 text-lg font-bold">{t("รายละเอียดประเด็น", "Details")}</h2>
          <p className="mb-4 text-sm text-muted">ปัญหา → ผลกระทบ → สิ่งที่ต้องการให้ส่วนกลาง Support → แนวทางที่ทีมเตรียมเองได้</p>
          <ol>
            {steps.map(([k, label, ph, req, central], i) => (
              <li key={k} className="relative grid grid-cols-[34px_minmax(0,1fr)] gap-3 pb-4 last:pb-0">
                {i < steps.length - 1 && <span className="absolute bottom-0 left-4 top-9 w-0.5 bg-border" />}
                <span className={`grid h-[34px] w-[34px] place-items-center rounded-full border text-sm font-bold ${
                  central ? "border-[#E23744] bg-[#E23744] text-white" : "border-border bg-surface-2"}`}>{i + 1}</span>
                <div>
                  <label className="mb-1.5 block text-[15px] font-semibold" htmlFor={`q4-${k}`}>
                    {label} {req && <span className="text-danger">*</span>}
                  </label>
                  <textarea id={`q4-${k}`} rows={3} className={input} value={draft[k]} placeholder={ph}
                    onChange={(e) => set(k, e.target.value)} />
                </div>
              </li>
            ))}
          </ol>
        </div>

        <div className={card}>
          <h2 className="mb-3 text-lg font-bold">Priority <span className="text-danger">*</span></h2>
          <div className="grid gap-2 sm:grid-cols-3">
            {([
              ["High", t("กระทบลูกค้า / รายได้ / ความปลอดภัยโดยตรง ต้องแก้ก่อน Peak", "Directly hits customers, revenue or safety")],
              ["Medium", t("ทำให้งานช้าหรือเสี่ยงเกิดปัญหา ควรเตรียมล่วงหน้า", "Slows work or creates risk")],
              ["Low", t("ปรับปรุงได้ ไม่เร่งด่วน", "Improvement, not urgent")],
            ] as const).map(([p, d]) => {
              const on = draft.priority === p;
              const tone = p === "High" ? "border-danger bg-danger/10" : p === "Medium" ? "border-warn bg-warn/10" : "border-brand-500 bg-brand-50";
              return (
                <button key={p} type="button" onClick={() => set("priority", p)}
                  className={`rounded-lg border p-2.5 text-left transition ${on ? `${tone} border-2` : "border-border bg-surface hover:border-brand-400"}`}>
                  <b className="block">{p}</b>
                  <small className="block text-xs leading-snug text-muted">{d}</small>
                </button>
              );
            })}
          </div>
          <label className="mb-1.5 mt-4 block text-[15px] font-semibold" htmlFor="q4notes">{t("หมายเหตุเพิ่มเติม", "Notes")}</label>
          <textarea id="q4notes" rows={2} className={input} value={draft.notes} onChange={(e) => set("notes", e.target.value)} />
          <div className="mt-4 flex flex-wrap items-center gap-3">
            <button type="button" onClick={submit} disabled={saving}
              className="flex items-center gap-2 rounded-lg bg-[#E23744] px-5 py-2.5 font-semibold text-white transition hover:brightness-95 disabled:opacity-60">
              {saving && <Loader2 size={16} className="animate-spin" />}
              {editing ? t("บันทึกการแก้ไข", "Save changes") : t("ส่งข้อมูล", "Submit")}
            </button>
            {editing && (
              <button type="button" onClick={cancel} className="rounded-lg border border-border px-4 py-2.5 font-semibold">
                {t("ยกเลิกการแก้ไข", "Cancel edit")}
              </button>
            )}
            {err && <span role="alert" className="text-sm text-danger">{err}</span>}
          </div>
        </div>
      </div>

      <aside className="space-y-4">
        <div className={`${card} lg:sticky lg:top-6`}>
          <h3 className="mb-1 font-bold">{guide ? guide.name : t("คำถามช่วยคิด", "Prompts")}</h3>
          {guide ? (
            <>
              <p className="text-sm text-muted">{guide.ex}</p>
              <ul className="mt-2 list-disc space-y-1 pl-5 text-sm">{guide.q.map((q) => <li key={q}>{q}</li>)}</ul>
            </>
          ) : (
            <p className="text-sm text-muted">{t("เลือกหมวดหมู่เพื่อดูหัวข้อที่ควรพิจารณา", "Choose a category to see prompts")}</p>
          )}
          <h3 className="mb-1 mt-5 font-bold">{t("ตัวอย่างการกรอก", "Example")}</h3>
          <ol className="list-decimal space-y-1 pl-5 text-sm">
            <li>ช่วง 17:00–20:00 มีลูกค้าและกระเป๋าเข้าพร้อมกันจำนวนมาก</li>
            <li>ลูกค้ารอและเกิด Queue</li>
            <li>ต้องการเพิ่มกำลัง Guest Service ในช่วง Peak</li>
            <li>สาขาจะจัด Shift และเตรียม Backup Staff</li>
          </ol>
        </div>
      </aside>
    </div>
  );
}

/* ====================================================================== */
/* List                                                                   */
/* ====================================================================== */
function ListView({
  entries, reviews, loading, userId, isAdmin, canAssign, statusOf, teamsOf, fBranch, setFBranch, fTeam, setFTeam, onEdit, onDelete, onReview,
  myTeams, onTeamReview, notes, tasks,
}: {
  tasks: Record<string, Record<string, Q4Task>>;
  myTeams: string[]; onTeamReview: (id: string, status: string, teams: string[], updatedAs: string, teamNotes: Record<string, string>) => void;
  notes: Record<string, Record<string, string>>;
  entries: Q4Entry[]; reviews: Record<string, Q4Review>; loading: boolean; userId: string | null; isAdmin: boolean; canAssign: boolean;
  statusOf: (e: Q4Entry) => string; teamsOf: (e: Q4Entry) => string[];
  fBranch: string; setFBranch: (b: string) => void; fTeam: string; setFTeam: (t: string) => void;
  onEdit: (e: Q4Entry) => void; onDelete: (e: Q4Entry) => void;
  onReview: (id: string, status: string, teams: string[], action: string, teamNotes: Record<string, string>, updatedAs?: string) => void;
}) {
  const t = useT();
  const [q, setQ] = useState("");
  const [fCat, setFCat] = useState("");
  const [fPri, setFPri] = useState("");
  const [fSt, setFSt] = useState("");
  const [mine, setMine] = useState(false);
  const [copied, setCopied] = useState(false);

  const rows = useMemo(() => {
    const s = q.trim().toLowerCase();
    const rank: Record<string, number> = { High: 0, Medium: 1, Low: 2 };
    return entries
      .filter((e) =>
        (!fBranch || e.branch === fBranch) && (!fCat || e.category === fCat) && (!fPri || e.priority === fPri) &&
        (!fSt || statusOf(e) === fSt) && (!mine || e.created_by === userId) &&
        (!fTeam || (fTeam === UNASSIGNED ? !teamsOf(e).length : teamsOf(e).includes(fTeam))) &&
        (!s || [e.branch, e.service_area, e.category, e.period, e.issue, e.impact, e.support, e.prep, e.notes, reviews[e.id]?.action]
          .join(" ").toLowerCase().includes(s)))
      .sort((a, b) => rank[a.priority] - rank[b.priority] || b.created_at.localeCompare(a.created_at));
  }, [entries, reviews, q, fBranch, fCat, fPri, fSt, fTeam, mine, userId, statusOf, teamsOf]);

  // Hand-off message for the assigned team (paste into their LINE group).
  async function copyTeamMessage() {
    const mineOpen = entries.filter((e) => teamsOf(e).includes(fTeam) && !Q4_CLOSED.has(statusOf(e)));
    const hi = mineOpen.filter((e) => e.priority === "High").length;
    const link = `${window.location.origin}/q4?tab=list&team=${encodeURIComponent(fTeam)}`;
    const lines = [
      `📌 งาน Q4 & ปีใหม่ ที่มอบหมายให้ทีม ${fTeam}`,
      `ยังไม่ปิด ${mineOpen.length} เรื่อง${hi ? ` (High ${hi})` : ""}`,
      ...mineOpen.slice(0, 10).map((e, i) => `${i + 1}. [${e.branch}] ${short(e.category)}: ${e.support}`),
      ...(mineOpen.length > 10 ? [`และอีก ${mineOpen.length - 10} เรื่อง`] : []),
      `ดูรายละเอียดและ Central action: ${link}`,
    ];
    try {
      await navigator.clipboard.writeText(lines.join("\n"));
      setCopied(true);
      setTimeout(() => setCopied(false), 2500);
    } catch {
      window.prompt(t("คัดลอกข้อความนี้", "Copy this message"), lines.join("\n"));
    }
  }

  const sel = "rounded-lg border border-border bg-surface px-2.5 py-2 text-sm";
  if (loading) return <p className="py-10 text-center text-muted"><Loader2 className="mr-2 inline animate-spin" size={18} />{t("กำลังโหลด", "Loading")}</p>;

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center gap-2">
        <input className={`${sel} min-w-[200px] flex-1`} placeholder={t("ค้นหาข้อความ", "Search")} value={q} onChange={(e) => setQ(e.target.value)} />
        <select className={sel} value={fBranch} onChange={(e) => setFBranch(e.target.value)}>
          <option value="">{t("ทุกสาขา/ทีม", "All branches")}</option>{Q4_BRANCHES.map((b) => <option key={b}>{b}</option>)}
        </select>
        <select className={sel} value={fCat} onChange={(e) => setFCat(e.target.value)}>
          <option value="">{t("ทุกหมวด", "All categories")}</option>{Q4_CATEGORY_NAMES.map((c) => <option key={c}>{c}</option>)}
        </select>
        <select className={sel} value={fPri} onChange={(e) => setFPri(e.target.value)}>
          <option value="">{t("ทุกระดับ", "All priorities")}</option>{Q4_PRIORITIES.map((p) => <option key={p}>{p}</option>)}
        </select>
        <select className={sel} value={fSt} onChange={(e) => setFSt(e.target.value)}>
          <option value="">{t("ทุกสถานะ", "All statuses")}</option>
          {Q4_STATUSES.map((s) => <option key={s} value={s}>{s} ({Q4_STATUS_TH[s]})</option>)}
        </select>
        <select className={sel} value={fTeam} onChange={(e) => setFTeam(e.target.value)} aria-label="Responsible Team">
          <option value="">{t("ทุกทีมรับผิดชอบ", "All teams")}</option>
          <option value={UNASSIGNED}>{t("ยังไม่มอบหมาย", "Unassigned")}</option>
          {Q4_TEAMS.map((x) => <option key={x}>{x}</option>)}
        </select>
        <label className="flex items-center gap-1.5 text-sm text-muted">
          <input type="checkbox" checked={mine} onChange={(e) => setMine(e.target.checked)} /> {t("เฉพาะที่ฉันส่ง", "Mine only")}
        </label>
      </div>

      {!canAssign && myTeams.length > 0 && (
        <div className="flex flex-wrap items-center gap-2 rounded-xl border border-[#E23744]/30 bg-[#E23744]/5 px-4 py-3 text-sm">
          <span>{t("คุณเป็นผู้รับผิดชอบทีม", "You handle team")}</span>
          {myTeams.map((tm) => {
            const n = entries.filter((e) => teamsOf(e).includes(tm) && !Q4_CLOSED.has(statusOf(e))).length;
            return (
              <button key={tm} onClick={() => setFTeam(tm)}
                className={`rounded-lg border px-2.5 py-1 font-semibold ${fTeam === tm ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface"}`}>
                {tm} · {n} {t("เรื่องค้าง", "open")}
              </button>
            );
          })}
          <span className="text-muted">{t("อัปเดตสถานะและ Central action ของทีมได้บนการ์ด", "Update status and action on the cards")}</span>
        </div>
      )}

      {fTeam && fTeam !== UNASSIGNED && (
        <div className="flex flex-wrap items-center justify-between gap-3 rounded-xl border border-border bg-surface-2 px-4 py-3 text-sm">
          <span>
            {t("งานของทีม", "Team")} <b>{fTeam}</b>: {rows.length} {t("เรื่อง", "issues")}
          </span>
          <button onClick={copyTeamMessage}
            className="rounded-lg bg-[#14232E] px-3 py-1.5 font-semibold text-[#CFE2F3]">
            {copied ? t("คัดลอกแล้ว ✓ วางในกลุ่ม LINE ได้เลย", "Copied ✓") : t("คัดลอกข้อความแจ้งทีม (ส่ง LINE)", "Copy hand-off message")}
          </button>
        </div>
      )}

      {!entries.length ? (
        <Empty title={t("ยังไม่มีข้อมูล", "No issues yet")} body={t("เริ่มจากแท็บ “กรอกข้อมูล” แล้วรายการจะขึ้นที่นี่ทันทีสำหรับทุกคน", "Submit the first issue and it appears here for everyone")} />
      ) : !rows.length ? (
        <Empty title={t("ไม่พบรายการที่ตรงกับตัวกรอง", "Nothing matches")} body={t("ลองล้างตัวกรองหรือคำค้นหา", "Clear the filters or search")} />
      ) : (
        <div className="space-y-3">
          {rows.map((e) => (
            <TagCard key={`${e.id}-${reviews[e.id]?.updated_at ?? ""}-${JSON.stringify(notes[e.id] ?? {})}`} teamNotes={notes[e.id] ?? {}} teamTasks={tasks[e.id] ?? {}} e={e} r={reviews[e.id]} status={statusOf(e)}
              canEdit={!!userId && e.created_by === userId} canDelete={isAdmin} isAdmin={canAssign}
              teams={teamsOf(e)} canTeamReview={!canAssign && teamsOf(e).some((x) => myTeams.includes(x))}
              myTeams={myTeams}
              onEdit={() => onEdit(e)} onDelete={() => onDelete(e)} onReview={onReview} onTeamReview={onTeamReview} />
          ))}
        </div>
      )}
    </div>
  );
}

function Empty({ title, body }: { title: string; body: string }) {
  return (
    <div className="rounded-xl border border-dashed border-border px-4 py-12 text-center text-muted">
      <b className="mb-1 block text-lg text-text">{title}</b>{body}
    </div>
  );
}

function TagCard({
  e, r, status, teams, myTeams, teamNotes, teamTasks, canEdit, canDelete, isAdmin, canTeamReview, onEdit, onDelete, onReview, onTeamReview,
}: {
  teams: string[]; myTeams: string[]; teamNotes: Record<string, string>; teamTasks: Record<string, Q4Task>;
  e: Q4Entry; r?: Q4Review; status: string; canEdit: boolean; canDelete: boolean; isAdmin: boolean;
  canTeamReview: boolean; onTeamReview: (id: string, status: string, teams: string[], updatedAs: string, teamNotes: Record<string, string>) => void;
  onEdit: () => void; onDelete: () => void; onReview: (id: string, status: string, teams: string[], action: string, teamNotes: Record<string, string>, updatedAs?: string) => void;
}) {
  const t = useT();
  const [st, setSt] = useState(status);
  const [sel, setSel] = useState<string[]>(teams);
  const toggleTeam = (x: string) => setSel((cur) => (cur.includes(x) ? cur.filter((y) => y !== x) : [...cur, x]));
  const teamLabel = teams.join(", ");
  const [nd, setNd] = useState<Record<string, string>>(teamNotes);
  const setNote = (tm: string, v: string) => setNd((cur) => ({ ...cur, [tm]: v }));
  const myOwn = teams.filter((x) => myTeams.includes(x));
  const [asWho, setAsWho] = useState(isAdmin ? "" : myOwn[0] ?? "");
  const noteList = teams.filter((tm) => teamNotes[tm] || teamTasks[tm]);
  const [action, setAction] = useState(r?.action ?? "");

  const flow: [string, string | null, boolean][] = [
    [t("ปัญหา", "Issue"), e.issue, false],
    [t("ผลกระทบ", "Impact"), e.impact, false],
    [t("ต้องการให้ส่วนกลาง Support", "Support required"), e.support, true],
    [t("ทีมเตรียมเอง", "Team will prepare"), e.prep, false],
  ];
  const closed = Q4_CLOSED.has(status);

  return (
    <article className="grid overflow-hidden rounded-xl border border-border bg-surface sm:grid-cols-[118px_minmax(0,1fr)]">
      <div className="relative flex flex-row flex-wrap items-center gap-2 border-b-2 border-dashed border-[#CFE2F3]/30 bg-[#14232E] p-3 text-[#CFE2F3] sm:flex-col sm:items-start sm:border-b-0 sm:border-r-2">
        <span className={`font-bold leading-none tracking-wide ${e.branch.length > 5 ? "text-xl" : "text-3xl"}`}>{e.branch}</span>
        <span className="text-xs opacity-85">{e.service_area}</span>
        <span className={`ml-auto rounded px-2 py-0.5 text-xs font-bold sm:ml-0 sm:mt-auto ${PRI_STYLE[e.priority]}`}>{e.priority}</span>
      </div>
      <div className="p-4">
        <div className="mb-2 flex flex-wrap justify-between gap-2">
          <span className="font-bold">{e.category}</span>
          {e.period && <span className="text-sm text-muted">{t("ช่วงเวลา", "When")}: {e.period}</span>}
        </div>
        <div className="mb-3 grid gap-3 md:grid-cols-4">
          {flow.map(([h, v, sup]) => (
            <div key={h} className={`whitespace-pre-wrap break-words text-sm ${sup ? "rounded-r-md border-l-[3px] border-[#E23744] bg-[#E23744]/5 px-2 py-1" : ""}`}>
              <h4 className="mb-0.5 text-xs font-semibold text-muted">{h}</h4>
              {v || <span className="text-muted">-</span>}
            </div>
          ))}
        </div>
        {e.notes && <p className="mb-2 whitespace-pre-wrap text-sm text-muted">{t("หมายเหตุ", "Notes")}: {e.notes}</p>}
        {r?.action && (
          <div className="mb-2 rounded-lg bg-surface-2 px-3 py-2 text-sm">
            <b>Central action{teamLabel ? ` (${teamLabel})` : ""}:</b> {r.action}
          </div>
        )}
        {noteList.length > 0 && (
          <div className="mb-2 space-y-1 rounded-lg border border-border px-3 py-2 text-sm">
            {noteList.map((tm) => (
              <p key={tm}><b className="mr-1 inline-block rounded bg-[#CFE2F3] px-1.5 text-xs text-[#14232E]">{tm}</b>
                {teamTasks[tm] && <span className="mr-1 text-xs font-semibold text-muted">👤 {teamTasks[tm].assignee_name || teamTasks[tm].assignee_email}</span>}
                {teamNotes[tm]}</p>
            ))}
          </div>
        )}
        {isAdmin && (
          <div className="mb-3 space-y-2 rounded-lg bg-surface-2 p-3">
            <div>
              <span className="text-xs text-muted">Responsible Team <span className="font-normal">({t("เลือกได้หลายทีม", "multiple allowed")})</span></span>
              <div className="mt-1 flex flex-wrap gap-1.5">
                {Q4_TEAMS.map((x) => {
                  const on = sel.includes(x);
                  return (
                    <button key={x} type="button" onClick={() => toggleTeam(x)} aria-pressed={on}
                      className={`rounded-md border px-2.5 py-1 text-xs font-semibold transition ${on ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface text-text hover:border-brand-400"}`}>
                      {on ? "✓ " : ""}{x}
                    </button>
                  );
                })}
              </div>
            </div>
            {sel.length > 0 && (
              <div className="space-y-1.5">
                <span className="text-xs text-muted">{t("ความเห็น / งานของแต่ละทีม", "Comment per team")}</span>
                {sel.map((tm) => (
                  <label key={tm} className="grid grid-cols-[120px_minmax(0,1fr)] items-center gap-2 text-xs font-semibold">
                    <span className="truncate">{tm}</span>
                    <input className="w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm font-normal text-text" value={nd[tm] ?? ""}
                      onChange={(x) => setNote(tm, x.target.value)} placeholder={t(`สิ่งที่ทีม ${tm} ต้องทำ / กำหนดเสร็จ`, `What ${tm} should do, by when`)} />
                  </label>
                ))}
              </div>
            )}
            <div className="grid gap-2 md:grid-cols-[170px_170px_minmax(0,1fr)_auto] md:items-end">
              <label className="text-xs text-muted">{t("อัปเดตในนาม", "Update as")}
                <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={asWho} onChange={(x) => setAsWho(x.target.value)}>
                  <option value="">{t("ส่วนกลาง (Admin)", "Central (Admin)")}</option>
                  {Q4_TEAMS.map((x) => <option key={x}>{x}</option>)}
                </select>
              </label>
              <label className="text-xs text-muted">{t("สถานะ", "Status")}
                <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={st} onChange={(x) => setSt(x.target.value)}>
                  {Q4_STATUSES.map((s) => <option key={s}>{s}</option>)}
                </select>
              </label>
              <label className="text-xs text-muted">Central action
                <input className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={action}
                  onChange={(x) => setAction(x.target.value)} placeholder={t("สิ่งที่ส่วนกลางจะทำ กำหนดเสร็จ", "What Central will do, by when")} />
              </label>
              <button onClick={() => onReview(e.id, st, sel, action, Object.fromEntries(sel.map((tm) => [tm, nd[tm] ?? ""])), asWho)} className="rounded-md bg-[#14232E] px-3 py-1.5 text-sm font-semibold text-[#CFE2F3]">
                {t("บันทึก", "Save")}
              </button>
            </div>
          </div>
        )}
        {canTeamReview && (
          <div className="mb-3 space-y-2 rounded-lg border border-[#E23744]/30 bg-surface-2 p-3">
            <p className="text-xs font-semibold text-[#E23744]">
              {t(`งานของทีม ${myOwn.join(", ")} · มอบหมายต่อ อัปเดตสถานะ และปิดงานได้`, `Your team (${myOwn.join(", ")}): delegate, update and close`)}
            </p>
            <div>
              <span className="text-xs text-muted">{t("มอบหมายต่อให้ทีม (เพิ่มได้ ลบทีมเดิมไม่ได้)", "Delegate to teams (add only)")}</span>
              <div className="mt-1 flex flex-wrap gap-1.5">
                {Q4_TEAMS.map((x) => {
                  const locked = teams.includes(x);
                  const on = sel.includes(x);
                  return (
                    <button key={x} type="button" disabled={locked} onClick={() => toggleTeam(x)} aria-pressed={on}
                      className={`rounded-md border px-2.5 py-1 text-xs font-semibold transition ${on ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface text-text hover:border-brand-400"} ${locked ? "opacity-70" : ""}`}>
                      {on ? "✓ " : ""}{x}
                    </button>
                  );
                })}
              </div>
            </div>
            <div className="grid gap-2 md:grid-cols-[170px_170px_minmax(0,1fr)_auto] md:items-end">
              <label className="text-xs text-muted">{t("อัปเดตในนาม", "Update as")}
                <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={asWho} onChange={(x) => setAsWho(x.target.value)}>
                  {myOwn.map((x) => <option key={x}>{x}</option>)}
                </select>
              </label>
              <label className="text-xs text-muted">{t("สถานะ", "Status")}
                <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={st} onChange={(x) => setSt(x.target.value)}>
                  {Q4_STATUSES.map((s) => <option key={s} value={s}>{s}{s === "Completed" ? ` (${t("ปิดงาน", "close")})` : ""}</option>)}
                </select>
              </label>
              <div className="space-y-1.5">
                {myOwn.map((tm) => (
                  <label key={tm} className="block text-xs text-muted">{t(`ความคืบหน้าทีม ${tm}`, `${tm} progress`)}
                    <input className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={nd[tm] ?? ""}
                      onChange={(x) => setNote(tm, x.target.value)} placeholder={t("สิ่งที่ทีมทำแล้ว / มอบหมายใคร / กำหนดเสร็จ", "Done / delegated to / by when")} />
                  </label>
                ))}
              </div>
              <button onClick={() => onTeamReview(e.id, st, Array.from(new Set([...teams, ...sel])), asWho, Object.fromEntries(myOwn.map((tm) => [tm, nd[tm] ?? ""])))}
                className="rounded-md bg-[#14232E] px-3 py-1.5 text-sm font-semibold text-[#CFE2F3]">
                {t("บันทึก", "Save")}
              </button>
            </div>
          </div>
        )}
        <div className="flex flex-wrap items-center justify-between gap-2 border-t border-border pt-2.5 text-sm text-muted">
          <span>
            <span className={`rounded-full border px-2.5 py-0.5 text-xs font-bold ${
              status === "Completed" ? "border-ok bg-ok/10 text-ok" : closed ? "border-border" : status === "Waiting for Support" ? "border-warn bg-warn/10 text-text" : "border-border bg-surface-2 text-text"}`}>
              {status} · {Q4_STATUS_TH[status]}
            </span>
            {teamLabel && !r?.action && <span className="ml-2">{t("ทีม", "Team")}: {teamLabel}</span>}
            {r?.updated_as && <span className="ml-2">· {t("อัปเดตล่าสุดโดย", "Last update by")} <b className="text-text">{r.updated_as}</b></span>}
          </span>
          <span className="flex items-center gap-2">
            {e.created_name || t("พนักงาน", "Staff")}, {fmt(e.created_at)}{e.updated_at !== e.created_at && ` (${t("แก้ไขแล้ว", "edited")})`}
            {/* Edit: only the person who submitted it. Delete: SOP admins only. Enforced again by RLS. */}
            {canEdit && (
              <button onClick={onEdit} className="rounded-md border border-border px-2 py-0.5 text-text hover:bg-surface-2">{t("แก้ไข", "Edit")}</button>
            )}
            {canDelete && (
              <button onClick={onDelete} className="rounded-md border border-border px-2 py-0.5 text-danger hover:bg-surface-2">{t("ลบ", "Delete")}</button>
            )}
          </span>
        </div>
      </div>
    </article>
  );
}

/* ====================================================================== */
/* Summary                                                                */
/* ====================================================================== */
function Bars({ pairs, redKey, onPick }: { pairs: [string, number][]; redKey?: string; onPick?: (k: string) => void }) {
  const max = Math.max(1, ...pairs.map((p) => p[1]));
  if (!pairs.length) return <p className="text-sm text-muted">-</p>;
  return (
    <div className="space-y-2">
      {pairs.map(([k, v]) => (
        <div key={k} onClick={onPick ? () => onPick(k) : undefined} title={onPick ? "ดูรายการของทีมนี้" : undefined}
          className={`grid grid-cols-[140px_minmax(0,1fr)_32px] items-center gap-2.5 text-sm ${onPick ? "cursor-pointer rounded-md hover:bg-surface-2" : ""}`}>
          <span className="truncate" title={k}>{k}</span>
          <span className="h-2.5 overflow-hidden rounded-full bg-surface-2">
            <span className={`block h-full rounded-full ${k === redKey ? "bg-[#E23744]" : "bg-text"}`} style={{ width: `${(v / max) * 100}%` }} />
          </span>
          <span className="text-right font-semibold tabular-nums">{v}</span>
        </div>
      ))}
    </div>
  );
}

function SummaryView({
  entries, plans, isAdmin, statusOf, teamsOf, onPlan, onExport, onPickTeam,
  teamMembers, onAddMember, onRemoveMember, analysis, onSaveAnalysis,
}: {
  analysis: Q4Analysis | null; onSaveAnalysis: (content: string) => Promise<boolean>;
  teamMembers: Q4TeamMember[]; onAddMember: (email: string, team: string) => void; onRemoveMember: (m: Q4TeamMember) => void;
  entries: Q4Entry[]; plans: Record<string, Q4Plan>; isAdmin: boolean;
  statusOf: (e: Q4Entry) => string; teamsOf: (e: Q4Entry) => string[];
  onPlan: (c: string, p: string) => void; onExport: () => void; onPickTeam: (team: string) => void;
}) {
  const t = useT();
  const total = entries.length;
  const count = (p: string) => entries.filter((e) => e.priority === p).length;
  const responded = new Set(entries.map((e) => e.branch)).size;
  const waiting = entries.filter((e) => ["New", "Under Review", "Waiting for Support"].includes(statusOf(e))).length;

  const catRows = Q4_CATEGORY_NAMES.map((c) => {
    const r = entries.filter((e) => e.category === c);
    const h = r.filter((e) => e.priority === "High").length, m = r.filter((e) => e.priority === "Medium").length, l = r.filter((e) => e.priority === "Low").length;
    return { c, h, m, l, tot: h + m + l };
  }).sort((a, b) => b.h - a.h || b.tot - a.tot);

  const used = Q4_CATEGORY_NAMES.filter((c) => entries.some((e) => e.category === c));
  const cell: Record<string, { n: number; h: number }> = {};
  let heatMax = 1;
  entries.forEach((e) => {
    const k = `${e.branch}|${e.category}`;
    cell[k] = cell[k] || { n: 0, h: 0 };
    cell[k].n++; if (e.priority === "High") cell[k].h++;
    heatMax = Math.max(heatMax, cell[k].n);
  });

  const tally = (f: (e: Q4Entry) => string, list = entries) => {
    const m: Record<string, number> = {};
    list.forEach((e) => { const k = f(e); m[k] = (m[k] || 0) + 1; });
    return Object.entries(m).sort((a, b) => b[1] - a[1]);
  };
  const unassigned = t("ยังไม่มอบหมาย", "Unassigned");
  const open = entries.filter((e) => !Q4_CLOSED.has(statusOf(e)));
  const hiOpen = open.filter((e) => e.priority === "High").sort((a, b) => a.created_at.localeCompare(b.created_at));
  const th = "border-b border-border px-2.5 py-2 text-left text-xs font-semibold text-muted";
  const td = "border-b border-border px-2.5 py-2 align-top";

  return (
    <div className="space-y-4">
      <div className="flex justify-end">
        <button onClick={onExport} disabled={!total}
          className="flex items-center gap-2 rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
          <Download size={16} /> {t("ดาวน์โหลด CSV (Lark Import)", "Download CSV (Lark import)")}
        </button>
      </div>

      <div className="grid grid-cols-2 gap-3 md:grid-cols-4">
        {([
          [String(total), t("ประเด็นทั้งหมด", "Total issues"), false],
          [String(count("High")), "High priority", true],
          [`${responded}/${Q4_BRANCHES.length}`, t("สาขา/ทีมที่ส่งแล้ว", "Responded"), false],
          [String(waiting), t("รอส่วนกลางพิจารณา / Support", "Awaiting Central"), false],
        ] as const).map(([v, k, red]) => (
          <div key={k} className={card}>
            <div className={`text-4xl font-extrabold leading-none ${red ? "text-[#E23744]" : ""}`}>{v}</div>
            <div className="mt-1 text-sm text-muted">{k}</div>
          </div>
        ))}
      </div>

      <div className={card}>
        <h2 className="text-lg font-bold">Central Summary</h2>
        <p className="mb-3 text-sm text-muted">
          {isAdmin ? t("พิมพ์แผน Support ในช่องขวาสุด บันทึกอัตโนมัติเมื่อออกจากช่อง", "Type the Central plan; saves when you leave the field")
            : t("จำนวนประเด็นแยกตามความสำคัญ พร้อมแผน Support ของส่วนกลาง", "Issues by priority with Central's plan")}
        </p>
        <div className="overflow-x-auto">
          <table className="w-full border-collapse text-sm">
            <thead><tr>
              <th className={th}>Category</th><th className={`${th} text-center`}>High</th><th className={`${th} text-center`}>Medium</th>
              <th className={`${th} text-center`}>Low</th><th className={`${th} text-center`}>Total</th><th className={`${th} min-w-[260px]`}>Central Support / Action</th>
            </tr></thead>
            <tbody>
              {catRows.map(({ c, h, m, l, tot }) => (
                <tr key={c} className={tot ? "" : "text-muted opacity-60"}>
                  <td className={td}>{c}</td>
                  <td className={`${td} text-center ${h ? "font-bold text-[#E23744]" : ""}`}>{h}</td>
                  <td className={`${td} text-center`}>{m}</td>
                  <td className={`${td} text-center`}>{l}</td>
                  <td className={`${td} text-center font-bold`}>{tot}</td>
                  <td className={td}>
                    {isAdmin ? (
                      <textarea key={plans[c]?.updated_at ?? "new"} rows={1} defaultValue={plans[c]?.plan ?? ""}
                        onBlur={(e) => onPlan(c, e.target.value)}
                        className="w-full rounded-md border border-border bg-surface px-2 py-1 text-sm" />
                    ) : plans[c]?.plan || <span className="text-muted">-</span>}
                  </td>
                </tr>
              ))}
            </tbody>
            <tfoot><tr>
              <td className={`${td} font-bold`}>{t("รวม", "Total")}</td>
              <td className={`${td} text-center font-bold text-[#E23744]`}>{count("High")}</td>
              <td className={`${td} text-center font-bold`}>{count("Medium")}</td>
              <td className={`${td} text-center font-bold`}>{count("Low")}</td>
              <td className={`${td} text-center font-bold`}>{total}</td><td className={td} />
            </tr></tfoot>
          </table>
        </div>
      </div>

      <div className={card}>
        <h2 className="text-lg font-bold">{t("สาขา × หมวดหมู่", "Branch × category")}</h2>
        <p className="mb-3 text-sm text-muted">{t("ช่องสีเข้มคือจุดที่มีหลายประเด็น ตัวเลขสีแดงคือมี High", "Darker = more issues; red number = has High")}</p>
        {!used.length ? <p className="text-sm text-muted">-</p> : (
          <div className="overflow-x-auto">
            <table className="border-collapse text-sm">
              <thead><tr>
                <th className={th}>{t("สาขา/ทีม", "Branch")}</th>
                {used.map((c) => <th key={c} className={`${th} min-w-[72px] text-center`}>{short(c)}</th>)}
                <th className={`${th} text-center`}>{t("รวม", "Total")}</th>
              </tr></thead>
              <tbody>
                {Q4_BRANCHES.map((b) => {
                  const sum = used.reduce((s, c) => s + (cell[`${b}|${c}`]?.n ?? 0), 0);
                  return (
                    <tr key={b} className={sum ? "" : "opacity-50"}>
                      <td className={`${td} whitespace-nowrap font-bold`}>{b}</td>
                      {used.map((c) => {
                        const x = cell[`${b}|${c}`];
                        return (
                          <td key={c} className={`${td} text-center font-semibold ${x?.h ? "text-[#E23744]" : ""}`}
                            style={x ? { background: `rgba(79,134,181,${0.12 + (x.n / heatMax) * 0.55})` } : undefined}>
                            {x?.n ?? ""}
                          </td>
                        );
                      })}
                      <td className={`${td} text-center font-bold`}>{sum || ""}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <AutoSummaryPanel entries={entries} statusOf={statusOf} teamsOf={teamsOf} />
      <ClaudeSummaryPanel entries={entries} statusOf={statusOf} teamsOf={teamsOf} analysis={analysis}
        isAdmin={isAdmin} total={total} onSave={onSaveAnalysis} />

      {isAdmin && <TeamMembersPanel members={teamMembers} onAdd={onAddMember} onRemove={onRemoveMember} />}

      <div className="grid gap-4 md:grid-cols-2">
        <div className={card}>
          <h2 className="mb-3 text-lg font-bold">{t("แยกตาม Service Area", "By service area")}</h2>
          <Bars pairs={tally((e) => e.service_area)} />
        </div>
        <div className={card}>
          <h2 className="mb-3 text-lg font-bold">{t("สถานะการ Support", "Support status")}</h2>
          <Bars pairs={Q4_STATUSES.map((s) => [`${s} (${Q4_STATUS_TH[s]})`, entries.filter((e) => statusOf(e) === s).length] as [string, number]).filter((x) => x[1])} />
        </div>
        <div className={card}>
          <h2 className="mb-1 text-lg font-bold">{t("งานตามทีมผู้รับผิดชอบ", "Open work by team")}</h2>
          <p className="mb-3 text-sm text-muted">{t("เฉพาะประเด็นที่ยังไม่ปิด กดที่ชื่อทีมเพื่อดูรายการและคัดลอกข้อความแจ้งทีม", "Open issues only. Click a team to see its list")}</p>
          <Bars pairs={(() => {
            const m: Record<string, number> = {};
            open.forEach((e) => { const ts = teamsOf(e); (ts.length ? ts : [unassigned]).forEach((k) => { m[k] = (m[k] || 0) + 1; }); });
            return Object.entries(m).sort((a, b) => b[1] - a[1]);
          })()} redKey={unassigned}
            onPick={(k) => onPickTeam(k === unassigned ? UNASSIGNED : k)} />
        </div>
        <div className={card}>
          <h2 className="mb-3 text-lg font-bold">{t("High Priority ที่ยังไม่ปิด", "Open High priority")}</h2>
          {!hiOpen.length ? <p className="text-sm text-muted">{t("ไม่มี High ค้างอยู่", "None open")}</p> : (
            <ul className="space-y-2">
              {hiOpen.slice(0, 12).map((e) => (
                <li key={e.id} className="grid grid-cols-[64px_minmax(0,1fr)_auto] gap-2 border-b border-border pb-2 text-sm">
                  <b className="text-base">{e.branch}</b>
                  <span><b>{short(e.category)}</b>: {e.support}</span>
                  <span className="text-xs text-muted">{statusOf(e)}</span>
                </li>
              ))}
              {hiOpen.length > 12 && <li className="text-sm text-muted">+{hiOpen.length - 12}</li>}
            </ul>
          )}
        </div>
      </div>
    </div>
  );
}

/* ====================================================================== */
/* Team members (SOP admins only)                                          */
/* ====================================================================== */
function TeamMembersPanel({
  members, onAdd, onRemove,
}: { members: Q4TeamMember[]; onAdd: (email: string, team: string) => void; onRemove: (m: Q4TeamMember) => void }) {
  const t = useT();
  const [email, setEmail] = useState("");
  const [team, setTeam] = useState(Q4_TEAMS[0]);
  const inp = "rounded-lg border border-border bg-surface px-2.5 py-2 text-sm";
  return (
    <div className={card}>
      <h2 className="text-lg font-bold">{t("ผู้รับผิดชอบของแต่ละทีม", "Team members")}</h2>
      <p className="mb-3 text-sm text-muted">
        {t(
          "คนที่อยู่ในรายชื่อนี้อัปเดตสถานะและความคืบหน้าของงานที่มอบหมายให้ทีมตัวเองได้ (เปลี่ยนทีมหรือแก้เรื่องของทีมอื่นไม่ได้)",
          "People listed here can update status and progress of issues assigned to their team only"
        )}
      </p>
      <div className="mb-4 flex flex-wrap gap-2">
        <input className={`${inp} min-w-[220px] flex-1`} type="email" placeholder={t("อีเมลที่ใช้ Login เช่น name@airportels.asia", "Login e-mail")}
          value={email} onChange={(e) => setEmail(e.target.value)} />
        <select className={inp} value={team} onChange={(e) => setTeam(e.target.value)}>
          {Q4_TEAMS.map((x) => <option key={x}>{x}</option>)}
        </select>
        <button disabled={!email.trim()} onClick={() => { onAdd(email, team); setEmail(""); }}
          className="rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
          {t("เพิ่ม", "Add")}
        </button>
      </div>
      {!members.length ? <p className="text-sm text-muted">{t("ยังไม่มีผู้รับผิดชอบ", "No team members yet")}</p> : (
        <div className="overflow-x-auto">
          <table className="w-full border-collapse text-sm">
            <thead><tr>
              <th className="border-b border-border px-2.5 py-2 text-left text-xs font-semibold text-muted">{t("ทีม", "Team")}</th>
              <th className="border-b border-border px-2.5 py-2 text-left text-xs font-semibold text-muted">{t("ชื่อ", "Name")}</th>
              <th className="border-b border-border px-2.5 py-2 text-left text-xs font-semibold text-muted">{t("อีเมล", "E-mail")}</th>
              <th className="border-b border-border px-2.5 py-2" />
            </tr></thead>
            <tbody>
              {members.map((m) => (
                <tr key={`${m.user_id}-${m.team}`}>
                  <td className="border-b border-border px-2.5 py-2 font-semibold">{m.team}</td>
                  <td className="border-b border-border px-2.5 py-2">{m.full_name || "-"}</td>
                  <td className="border-b border-border px-2.5 py-2 text-muted">{m.email}</td>
                  <td className="border-b border-border px-2.5 py-2 text-right">
                    <button onClick={() => onRemove(m)} className="rounded-md border border-border px-2 py-0.5 text-danger hover:bg-surface-2">
                      {t("นำออก", "Remove")}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}

/* ====================================================================== */
/* AI analysis (run by admins, visible to everyone for team presentations) */
/* ====================================================================== */
const escHtml = (x: string) =>
  x.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

// Minimal, safe markdown -> HTML (headings, bullets, bold). Input is escaped first.
function mdToHtml(md: string): string {
  // Safe mini-markdown: # / ## / ### headings, - bullets, 1. numbered lists, | tables |, **bold**, --- rule.
  const out: string[] = [];
  let list: "" | "ul" | "ol" = "";
  let table: string[][] = [];
  const inline = (x: string) => escHtml(x).replace(/\*\*(.+?)\*\*/g, "<b>$1</b>");
  const closeList = () => { if (list) { out.push(`</${list}>`); list = ""; } };
  const flushTable = () => {
    if (!table.length) return;
    const [head, ...body] = table;
    out.push(`<table><thead><tr>${head.map((c) => `<th>${inline(c)}</th>`).join("")}</tr></thead><tbody>${
      body.map((r) => `<tr>${r.map((c) => `<td>${inline(c)}</td>`).join("")}</tr>`).join("")}</tbody></table>`);
    table = [];
  };
  for (const raw of md.split(/\r?\n/)) {
    const l = raw.trim();
    if (l.startsWith("|")) {
      closeList();
      const cells = l.replace(/^\||\|$/g, "").split("|").map((c) => c.trim());
      if (!cells.every((c) => /^:?-{2,}:?$/.test(c))) table.push(cells);
      continue;
    }
    flushTable();
    const bullet = /^[-*•]\s+/.test(l);
    const num = /^\d+[.)]\s+/.test(l);
    if (bullet || num) {
      const want = bullet ? "ul" : "ol";
      if (list !== want) { closeList(); out.push(`<${want}>`); list = want; }
      out.push(`<li>${inline(l.replace(bullet ? /^[-*•]\s+/ : /^\d+[.)]\s+/, ""))}</li>`);
      continue;
    }
    closeList();
    if (/^-{3,}$/.test(l)) out.push("<hr/>");
    else if (l.startsWith("### ")) out.push(`<h4>${inline(l.slice(4))}</h4>`);
    else if (l.startsWith("## ")) out.push(`<h3>${inline(l.slice(3))}</h3>`);
    else if (l.startsWith("# ")) out.push(`<h3>${inline(l.slice(2))}</h3>`);
    else if (l) out.push(`<p>${inline(l)}</p>`);
  }
  flushTable();
  closeList();
  return out.join("");
}

/* Playbook: first-step solutions and suggested team per category (free, no AI). */
const PLAYBOOK: Record<string, { team: string; steps: string[] }> = {
  "Operation / งานหน้าสาขา": { team: "OP Manager", steps: ["ทบทวน Workflow รับฝาก-คืนช่วง Peak และจุดที่เกิด Bottleneck", "เตรียมเคาน์เตอร์/จุดรับฝากชั่วคราว ป้ายบอกทาง และระบบคิว"] },
  "Guest Service / งานบริการหน้าสาขา": { team: "OP Manager", steps: ["ทำ Guideline/Script หน้าเคาน์เตอร์ช่วง Peak", "Briefing ทีม Guest Service ก่อนเข้า Peak"] },
  "Porter / งานขนย้ายกระเป๋า": { team: "OP Manager", steps: ["วาง Shift/OT Porter ตามช่วงเที่ยวบินหนาแน่น", "ตรวจและเพิ่ม Trolley / อุปกรณ์ขนย้าย กำหนดจุด Loading ให้ชัด"] },
  "Customer / ปัญหาหรือ Case ลูกค้า": { team: "Online-CS", steps: ["ทำ Script และขั้นตอน Service Recovery (Delay / Lost / Damage / Refund)", "กำหนดช่องทาง Escalation และผู้ตัดสินใจช่วง Peak"] },
  "Staffing / Manpower": { team: "HR", steps: ["วางแผนกำลังคน OT และพนักงานเสริมช่วง Peak", "จัด Backup ข้ามสาขาและรายชื่อสำรอง"] },
  "System / IT": { team: "IT & Dev.", steps: ["ตรวจอุปกรณ์ Internet สำรอง EDC Printer Scanner ก่อน Peak", "กำหนด Contact IT และขั้นตอนเมื่อระบบล่ม"] },
  "Stock / Material": { team: "MS - Logistic", steps: ["ตรวจ Stock Tag / Receipt / ถุง / Packaging ทุกสาขา", "สั่งเพิ่มล่วงหน้าและกำหนดรอบส่งของก่อน Peak"] },
  "Transport / Delivery": { team: "MS - Logistic", steps: ["วางแผนรถและ Runner สำรองช่วง Peak", "ทบทวน Cut-off และช่องทางประสานงานสาขา-Transport"] },
  "SOP / Training": { team: "OP Manager", steps: ["ปรับ SOP/WI ที่พนักงานยังไม่มั่นใจ", "จัด Training / Simulation / Checklist ก่อนปีใหม่"] },
  "Emergency / Service Recovery": { team: "Management", steps: ["ทำ Emergency Plan: ระบบล่ม คนไม่พอ กระเป๋าตกค้าง สาขาปิด", "ซ้อมขั้นตอนและแจ้งผู้รับผิดชอบแต่ละกรณี"] },
  "Branch / Facility": { team: "Management", steps: ["ตรวจพื้นที่ Counter Storage ไฟฟ้า แอร์ แสงสว่างก่อน Peak", "ประสานห้าง/สนามบินเรื่องพื้นที่เสริม"] },
  "Equipment / Tools": { team: "MS - Logistic", steps: ["ตรวจอุปกรณ์ประจำสาขาและซ่อม/เปลี่ยนก่อน Peak", "เตรียมอุปกรณ์สำรองไว้ส่วนกลาง"] },
  "Sales / Promotion": { team: "BD", steps: ["สรุป Campaign / Promotion ปีใหม่ให้ทุกสาขารู้ล่วงหน้า", "ทำข้อความแนะนำลูกค้าและเงื่อนไขที่ชัดเจน"] },
  "Media / Content / Filming": { team: "MKT", steps: ["วางตารางถ่ายทำไม่ให้ชนช่วง Peak", "แจ้งสาขาล่วงหน้าและกำหนดพื้นที่ถ่ายทำ"] },
  "Communication / Coordination": { team: "Management", steps: ["กำหนด Contact point และกลุ่มสื่อสารช่วง Peak", "สื่อสารเรื่องสำคัญให้ทุกสาขาเข้าใจตรงกันก่อนเข้า Peak"] },
  "Security / Safety": { team: "Management", steps: ["ทบทวนความปลอดภัยของกระเป๋าและการเข้า-ออกพื้นที่", "ตรวจ CCTV และขั้นตอนเมื่อเกิดเหตุ"] },
  "Other / อื่นๆ": { team: "OP Manager", steps: ["พิจารณารายกรณีในที่ประชุมส่วนกลาง"] },
};
const DUE: Record<string, string> = { High: "ก่อน 1 ธ.ค.", Medium: "1-20 ธ.ค.", Low: "ทบทวนหลัง Peak" };

type TeamPlan = { team: string; items: Q4Entry[]; suggested: number; high: number; due: string; steps: string[] };
type AutoData = {
  total: number; responded: number; high: number; open: number; unassigned: number;
  missing: string[]; urgent: Q4Entry[]; teams: TeamPlan[];
  repeated: { category: string; branches: string[]; step: string }[];
};

const clean = (x: string | null | undefined) => (x ?? "").replace(/\s+/g, " ").trim();

function computeAuto(entries: Q4Entry[], statusOf: (e: Q4Entry) => string, teamsOf: (e: Q4Entry) => string[]): AutoData {
  const open = entries.filter((e) => !Q4_CLOSED.has(statusOf(e)));
  const responded = new Set(entries.map((e) => e.branch));
  const rank: Record<string, number> = { High: 0, Medium: 1, Low: 2 };
  const byTeam: Record<string, Q4Entry[]> = {};
  open.forEach((e) => {
    const ts = teamsOf(e);
    (ts.length ? ts : [PLAYBOOK[e.category]?.team ?? "OP Manager"]).forEach((tm) => { (byTeam[tm] = byTeam[tm] || []).push(e); });
  });
  const teams: TeamPlan[] = Object.entries(byTeam).map(([team, items]) => {
    items.sort((a, b) => rank[a.priority] - rank[b.priority] || a.branch.localeCompare(b.branch));
    const high = items.filter((e) => e.priority === "High").length;
    const pr = high ? "High" : items.some((e) => e.priority === "Medium") ? "Medium" : "Low";
    return {
      team, items, high, due: DUE[pr],
      suggested: items.filter((e) => !teamsOf(e).includes(team)).length,
      steps: [...new Set(items.flatMap((e) => PLAYBOOK[e.category]?.steps ?? []))].slice(0, 4),
    };
  }).sort((a, b) => b.high - a.high || b.items.length - a.items.length);
  const repeated = Q4_CATEGORY_NAMES
    .map((c) => ({ category: c, branches: [...new Set(entries.filter((e) => e.category === c).map((e) => e.branch))], step: PLAYBOOK[c]?.steps[0] ?? "" }))
    .filter((r) => r.branches.length >= 2)
    .sort((a, b) => b.branches.length - a.branches.length);
  return {
    total: entries.length, responded: responded.size,
    high: entries.filter((e) => e.priority === "High").length,
    open: open.length, unassigned: open.filter((e) => !teamsOf(e).length).length,
    missing: Q4_BRANCHES.filter((b) => !responded.has(b)),
    urgent: open.filter((e) => e.priority === "High").sort((a, b) => a.branch.localeCompare(b.branch)),
    teams, repeated,
  };
}

// Plain-text version (for copy into LINE / Lark)
function autoToText(d: AutoData, statusOf: (e: Q4Entry) => string, only: string): string {
  const L: string[] = [];
  const teams = only ? d.teams.filter((t) => t.team === only) : d.teams;
  L.push(`สรุปแผน Support Q4 & ปีใหม่${only ? ` · ทีม ${only}` : ""}`);
  L.push(`ทั้งหมด ${d.total} ประเด็น · ส่งแล้ว ${d.responded}/${Q4_BRANCHES.length} สาขา · High ${d.high} · ยังไม่ปิด ${d.open}`);
  teams.forEach((t) => {
    L.push("", `■ ทีม ${t.team} (${t.items.length} เรื่อง · High ${t.high} · กำหนด ${t.due})`);
    L.push(`แนวทาง: ${t.steps.join(" / ")}`);
    t.items.forEach((e, i) => L.push(`${i + 1}. [${e.branch}] ${short(e.category)} (${e.priority}, ${statusOf(e)}): ${clean(e.support)}`));
  });
  return L.join("\n");
}

// Printable HTML (A4, tables) for presenting
function autoToPrintHtml(d: AutoData, statusOf: (e: Q4Entry) => string, only: string): string {
  const teams = only ? d.teams.filter((t) => t.team === only) : d.teams;
  const pri = (p: string) => `<span class="pri ${p}">${p}</span>`;
  const row = (e: Q4Entry) =>
    `<tr><td class="b">${escHtml(e.branch)}</td><td>${escHtml(short(e.category))}</td><td>${pri(e.priority)}</td><td>${escHtml(clean(e.support))}</td><td>${escHtml(statusOf(e))}</td></tr>`;
  const head = `<tr><th>สาขา</th><th>หมวด</th><th>Priority</th><th>ต้องการให้ส่วนกลาง Support</th><th>สถานะ</th></tr>`;
  let h = `<div class="kpis">
    <div><b>${d.total}</b><span>ประเด็นทั้งหมด</span></div>
    <div><b>${d.responded}/${Q4_BRANCHES.length}</b><span>สาขา/ทีมที่ส่ง</span></div>
    <div class="red"><b>${d.high}</b><span>High</span></div>
    <div><b>${d.open}</b><span>ยังไม่ปิด</span></div></div>`;
  if (!only && d.urgent.length) h += `<h2>ประเด็นเร่งด่วนก่อน Peak</h2><table>${head}${d.urgent.map(row).join("")}</table>`;
  h += `<h2>แผนแยกตามทีม</h2>`;
  teams.forEach((t) => {
    h += `<div class="team"><h3>${escHtml(t.team)} <small>${t.items.length} เรื่อง · High ${t.high} · กำหนด ${escHtml(t.due)}</small></h3>
      <p class="steps"><b>แนวทางแก้ไขเบื้องต้น:</b> ${t.steps.map(escHtml).join(" · ")}</p>
      <table>${head}${t.items.map(row).join("")}</table></div>`;
  });
  if (!only && d.repeated.length) {
    h += `<h2>ปัญหาที่เกิดซ้ำหลายสาขา</h2><table><tr><th>หมวด</th><th>จำนวนสาขา</th><th>สาขา</th><th>แนวทางระดับส่วนกลาง</th></tr>${
      d.repeated.map((r) => `<tr><td class="b">${escHtml(short(r.category))}</td><td>${r.branches.length}</td><td>${escHtml(r.branches.join(", "))}</td><td>${escHtml(r.step)}</td></tr>`).join("")}</table>`;
  }
  if (!only && d.missing.length) h += `<p class="miss"><b>ยังไม่ส่งข้อมูล:</b> ${escHtml(d.missing.join(", "))}</p>`;
  return h;
}

function printSummary(title: string, meta: string, html: string) {
  const w = window.open("", "_blank");
  if (!w) return;
  w.document.write(`<!doctype html><html lang="th"><head><meta charset="utf-8"><title>${escHtml(title)}</title>
<style>body{font-family:Sarabun,"Leelawadee UI",Tahoma,sans-serif;max-width:820px;margin:32px auto;padding:0 24px;color:#14232E;line-height:1.6}
h1{font-size:22px;margin:0 0 4px}h3{font-size:18px;margin:22px 0 6px;border-bottom:2px solid #E23744;padding-bottom:4px}
h4{font-size:16px;margin:14px 0 4px}ul{margin:4px 0 8px;padding-left:22px}p{margin:4px 0}.meta{color:#5B6C79;font-size:13px}
h2{font-size:18px;margin:24px 0 8px;padding-bottom:4px;border-bottom:2px solid #E23744}
.team h3{border:0;margin:18px 0 4px;font-size:16px}.team h3 small{font-weight:400;color:#5B6C79;font-size:13px}
table{width:100%;border-collapse:collapse;font-size:12.5px;margin:6px 0 10px;page-break-inside:auto}tr{page-break-inside:avoid}
th{background:#14232E;color:#fff;text-align:left;padding:6px 8px;font-weight:600}td{border-bottom:1px solid #D6E2EC;padding:6px 8px;vertical-align:top}
td.b{font-weight:700;white-space:nowrap}.pri{color:#fff;border-radius:4px;padding:1px 6px;font-size:11px;font-weight:700}
.pri.High{background:#E23744}.pri.Medium{background:#D9912B}.pri.Low{background:#4F86B5}
.kpis{display:flex;gap:10px;margin:12px 0}.kpis div{flex:1;border:1px solid #D6E2EC;border-radius:8px;padding:8px 12px}
.kpis b{display:block;font-size:24px}.kpis span{font-size:12px;color:#5B6C79}.kpis .red b{color:#E23744}
.steps{background:#F3F7FB;border-radius:6px;padding:6px 10px;font-size:13px}.miss{margin-top:16px;font-size:13px}
@page{size:A4;margin:14mm}</style></head>
<body><h1>${escHtml(title)}</h1><p class="meta">${escHtml(meta)}</p>${html}</body></html>`);
  w.document.close();
  w.focus();
  setTimeout(() => w.print(), 300);
}

const proseCls = "mt-3 border-t border-border pt-3 text-[15px] leading-relaxed [&_b]:font-bold [&_h3]:mb-1.5 [&_h3]:mt-5 [&_h3]:border-b-2 [&_h3]:border-[#E23744] [&_h3]:pb-1 [&_h3]:text-lg [&_h3]:font-bold [&_h4]:mb-1 [&_h4]:mt-3 [&_h4]:font-bold [&_li]:my-0.5 [&_p]:my-1 [&_ul]:list-disc [&_ul]:pl-5 [&_ol]:list-decimal [&_ol]:pl-5 [&_table]:my-2 [&_table]:w-full [&_table]:border-collapse [&_table]:text-sm [&_th]:bg-[#14232E] [&_th]:px-3 [&_th]:py-1.5 [&_th]:text-left [&_th]:text-white [&_td]:border-b [&_td]:border-border [&_td]:px-3 [&_td]:py-1.5 [&_td]:align-top [&_hr]:my-4 [&_hr]:border-border";

function AutoSummaryPanel({
  entries, statusOf, teamsOf,
}: { entries: Q4Entry[]; statusOf: (e: Q4Entry) => string; teamsOf: (e: Q4Entry) => string[] }) {
  const t = useT();
  const [only, setOnly] = useState("");
  const [copied, setCopied] = useState(false);
  const d = useMemo(() => computeAuto(entries, statusOf, teamsOf), [entries, statusOf, teamsOf]);
  if (!entries.length) return null;
  const teams = only ? d.teams.filter((x) => x.team === only) : d.teams;
  const th = "bg-[#14232E] px-3 py-2 text-left text-xs font-semibold text-white whitespace-nowrap";
  const td = "border-b border-border px-3 py-2 align-top text-sm";
  const priCls = (p: string) => `inline-block rounded px-1.5 py-0.5 text-[11px] font-bold text-white ${PRI_STYLE[p]}`;
  const title = `สรุปแผน Support: Q4 & ปีใหม่${only ? ` · ทีม ${only}` : ""}`;
  const meta = `จาก ${d.total} ประเด็น · ${fmt(new Date().toISOString())}`;

  const issueTable = (rows: Q4Entry[], showTeam = false) => (
    <div className="overflow-x-auto rounded-lg border border-border">
      <table className="w-full border-collapse">
        <thead><tr>
          <th className={th}>{t("สาขา", "Branch")}</th><th className={th}>{t("หมวด", "Category")}</th>
          <th className={th}>Priority</th><th className={`${th} min-w-[260px]`}>{t("ต้องการให้ส่วนกลาง Support", "Support needed")}</th>
          {showTeam && <th className={th}>{t("ทีม", "Team")}</th>}
          <th className={th}>{t("สถานะ", "Status")}</th>
        </tr></thead>
        <tbody>
          {rows.map((e) => (
            <tr key={e.id} className="even:bg-surface-2/60">
              <td className={`${td} whitespace-nowrap font-bold`}>{e.branch}</td>
              <td className={`${td} whitespace-nowrap`}>{short(e.category)}</td>
              <td className={td}><span className={priCls(e.priority)}>{e.priority}</span></td>
              <td className={td}><span className="line-clamp-3" title={clean(e.support)}>{clean(e.support)}</span></td>
              {showTeam && <td className={`${td} whitespace-nowrap`}>{teamsOf(e).join(", ") || <span className="text-muted">{PLAYBOOK[e.category]?.team} *</span>}</td>}
              <td className={`${td} whitespace-nowrap text-xs`}>{Q4_STATUS_TH[statusOf(e)]}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );

  return (
    <div className={card}>
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <h2 className="text-lg font-bold">{t("สรุปผลและแนวทางแก้ไขเบื้องต้น", "Summary & first-step solutions")}</h2>
          <p className="text-sm text-muted">{t("อัปเดตสดตามข้อมูลล่าสุด · เลือกทีมเพื่อนำเสนอเฉพาะทีมที่เกี่ยวข้อง", "Live. Pick a team to present only its part")}</p>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          <select value={only} onChange={(e) => setOnly(e.target.value)} className="rounded-lg border border-border bg-surface px-3 py-2 text-sm font-semibold">
            <option value="">{t("ทุกทีม (ภาพรวม)", "All teams")}</option>
            {d.teams.map((x) => <option key={x.team} value={x.team}>{x.team} ({x.items.length})</option>)}
          </select>
          <button onClick={() => printSummary(title, meta, autoToPrintHtml(d, statusOf, only))}
            className="rounded-lg bg-[#14232E] px-3 py-2 text-sm font-semibold text-[#CFE2F3]">
            {t("พิมพ์ / บันทึก PDF", "Print / PDF")}
          </button>
          <button onClick={async () => { try { await navigator.clipboard.writeText(autoToText(d, statusOf, only)); setCopied(true); setTimeout(() => setCopied(false), 2000); } catch { /* ignore */ } }}
            className="rounded-lg border border-border px-3 py-2 text-sm font-semibold">
            {copied ? t("คัดลอกแล้ว ✓", "Copied ✓") : t("คัดลอกข้อความ", "Copy text")}
          </button>
        </div>
      </div>

      {/* KPIs */}
      <div className="mt-4 grid grid-cols-2 gap-2 md:grid-cols-5">
        {([
          [String(d.total), t("ประเด็นทั้งหมด", "Issues"), ""],
          [`${d.responded}/${Q4_BRANCHES.length}`, t("สาขา/ทีมที่ส่ง", "Responded"), ""],
          [String(d.high), "High", "text-[#E23744]"],
          [String(d.open), t("ยังไม่ปิด", "Open"), ""],
          [String(d.unassigned), t("ยังไม่มอบหมายทีม", "Unassigned"), d.unassigned ? "text-[#D9912B]" : ""],
        ] as const).map(([v, k, c]) => (
          <div key={k} className="rounded-lg border border-border px-3 py-2">
            <div className={`text-2xl font-extrabold ${c}`}>{v}</div>
            <div className="text-xs text-muted">{k}</div>
          </div>
        ))}
      </div>

      {/* Urgent */}
      {!only && d.urgent.length > 0 && (
        <section className="mt-6">
          <h3 className="mb-2 flex items-center gap-2 text-base font-bold">
            <span className="inline-block h-2.5 w-2.5 rounded-full bg-[#E23744]" />
            {t("ประเด็นเร่งด่วนก่อน Peak", "Urgent before peak")} <span className="text-sm font-normal text-muted">({d.urgent.length})</span>
          </h3>
          {issueTable(d.urgent, true)}
          <p className="mt-1 text-xs text-muted">* {t("ทีมที่ระบบแนะนำ (ยังไม่มอบหมาย)", "Suggested team (not yet assigned)")}</p>
        </section>
      )}

      {/* Per team */}
      <section className="mt-6">
        <h3 className="mb-2 text-base font-bold">{t("แผนแยกตามทีม", "Plan by team")}</h3>
        <div className="space-y-4">
          {teams.map((x) => (
            <div key={x.team} className="overflow-hidden rounded-xl border border-border">
              <div className="flex flex-wrap items-center justify-between gap-2 bg-[#14232E] px-4 py-2.5 text-[#E9F1F8]">
                <span className="text-base font-bold">{x.team}</span>
                <span className="flex flex-wrap gap-1.5 text-xs">
                  <span className="rounded-full bg-white/15 px-2 py-0.5">{x.items.length} {t("เรื่อง", "issues")}</span>
                  {x.high > 0 && <span className="rounded-full bg-[#E23744] px-2 py-0.5 font-bold">High {x.high}</span>}
                  {x.suggested > 0 && <span className="rounded-full bg-[#D9912B] px-2 py-0.5">{t("แนะนำ", "suggested")} {x.suggested}</span>}
                  <span className="rounded-full bg-[#CFE2F3] px-2 py-0.5 font-semibold text-[#14232E]">{t("กำหนด", "Due")} {x.due}</span>
                </span>
              </div>
              <div className="p-3">
                <div className="mb-3 rounded-lg bg-surface-2 px-3 py-2 text-sm">
                  <b>{t("แนวทางแก้ไขเบื้องต้น", "First steps")}</b>
                  <ul className="mt-1 list-disc pl-5">{x.steps.map((st) => <li key={st}>{st}</li>)}</ul>
                </div>
                {issueTable(x.items)}
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Repeated */}
      {!only && d.repeated.length > 0 && (
        <section className="mt-6">
          <h3 className="mb-2 text-base font-bold">{t("ปัญหาที่เกิดซ้ำหลายสาขา (ควรแก้ระดับส่วนกลาง)", "Repeated across branches")}</h3>
          <div className="overflow-x-auto rounded-lg border border-border">
            <table className="w-full border-collapse">
              <thead><tr>
                <th className={th}>{t("หมวด", "Category")}</th><th className={th}>{t("สาขา", "Branches")}</th>
                <th className={`${th} min-w-[240px]`}>{t("แนวทางระดับส่วนกลาง", "Central approach")}</th>
              </tr></thead>
              <tbody>
                {d.repeated.map((r) => (
                  <tr key={r.category} className="even:bg-surface-2/60">
                    <td className={`${td} whitespace-nowrap font-bold`}>{short(r.category)} <span className="font-normal text-muted">({r.branches.length})</span></td>
                    <td className={td}><span className="flex flex-wrap gap-1">{r.branches.map((b) => <span key={b} className="rounded bg-[#CFE2F3] px-1.5 py-0.5 text-xs font-bold text-[#14232E]">{b}</span>)}</span></td>
                    <td className={td}>{r.step}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
      )}

      {/* Missing */}
      {!only && d.missing.length > 0 && (
        <section className="mt-6 flex flex-wrap items-center gap-2 text-sm">
          <b>{t("ยังไม่ส่งข้อมูล:", "Not yet submitted:")}</b>
          {d.missing.map((b) => <span key={b} className="rounded border border-dashed border-border px-2 py-0.5 font-semibold text-muted">{b}</span>)}
        </section>
      )}
    </div>
  );
}

function buildClaudePrompt(entries: Q4Entry[], statusOf: (e: Q4Entry) => string, teamsOf: (e: Q4Entry) => string[]): string {
  const responded = new Set(entries.map((e) => e.branch));
  const missing = Q4_BRANCHES.filter((b) => !responded.has(b));
  const data = entries.map((x) => ({
    branch: x.branch, area: x.service_area, category: x.category, priority: x.priority, period: x.period,
    issue: x.issue, impact: x.impact, support_needed: x.support, team_prep: x.prep, notes: x.notes,
    status: statusOf(x), assigned_teams: teamsOf(x),
  }));
  return `คุณเป็นนักวิเคราะห์ Operation ของ Airportels (บริการรับฝากและส่งกระเป๋า มีสาขาที่สนามบินและในเมือง)
ส่วนกลางกำลังวางแผน Support ทุกสาขาสำหรับ Q4 และช่วงปีใหม่ ด้านล่างคือประเด็นที่สาขา/ทีมแจ้งเข้ามา (JSON)
จำนวนประเด็น: ${entries.length} | ส่งแล้ว: ${responded.size}/${Q4_BRANCHES.length} | ยังไม่ส่ง: ${missing.join(", ") || "ไม่มี"}
ทีมที่รับผิดชอบได้: ${Q4_TEAMS.filter((x) => x !== "Other").join(", ")}

เขียนสรุปภาษาไทยเพื่อนำเสนอในที่ประชุมทุกทีม ใช้ markdown เฉพาะ "## " "### " bullet "- " และ **ตัวหนา** ห้ามใช้ตาราง
โครงสร้าง:
## ภาพรวม
## ประเด็นเร่งด่วนที่ต้องตัดสินใจก่อน Peak
## แนวทางแก้ไขเบื้องต้น แยกตามทีม (ใช้ "### ชื่อทีม" ตาม assigned_teams แต่ละทีมมี ปัญหาที่เกี่ยวข้อง / แนวทางแก้ไขเบื้องต้น / สิ่งที่ต้องเตรียมและกำหนดเวลา)
## ปัญหาที่เกิดซ้ำหลายสาขา
## Timeline แนะนำ (ก่อน 1 ธ.ค. / 1-20 ธ.ค. / ช่วง Peak 20 ธ.ค. - 5 ม.ค.)
## สิ่งที่ยังขาดข้อมูล
อ้างอิงเฉพาะข้อมูลที่ให้มา ห้ามแต่งตัวเลขหรือเหตุการณ์ ข้อเสนอของคุณเองให้เขียนเป็นข้อแนะนำ

DATA:
${JSON.stringify(data)}`;
}

function ClaudeSummaryPanel({
  entries, statusOf, teamsOf, analysis, isAdmin, total, onSave,
}: {
  entries: Q4Entry[]; statusOf: (e: Q4Entry) => string; teamsOf: (e: Q4Entry) => string[];
  analysis: Q4Analysis | null; isAdmin: boolean; total: number; onSave: (content: string) => Promise<boolean>;
}) {
  const t = useT();
  const [copied, setCopied] = useState(false);
  const [pasting, setPasting] = useState(false);
  const [draft, setDraft] = useState("");
  const html = useMemo(() => (analysis ? mdToHtml(analysis.content) : ""), [analysis]);
  if (!analysis && !isAdmin) return null;

  async function copyPrompt() {
    const text = buildClaudePrompt(entries, statusOf, teamsOf);
    try { await navigator.clipboard.writeText(text); setCopied(true); setTimeout(() => setCopied(false), 3000); }
    catch { window.prompt(t("คัดลอกข้อความนี้", "Copy this"), text); }
  }

  return (
    <div className={card}>
      <div className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <h2 className="text-lg font-bold">{t("สรุปเชิงลึกจาก Claude", "In-depth summary from Claude")}</h2>
          <p className="text-sm text-muted">
            {analysis
              ? `${t("บันทึกเมื่อ", "Saved")} ${fmt(analysis.created_at)} · ${t("จาก", "from")} ${analysis.entry_count} ${t("ประเด็น", "issues")}`
              : t("ใช้ Claude ที่มีอยู่ (claude.ai) วิเคราะห์ แล้ววางผลกลับมาให้ทุกทีมเห็น ไม่มีค่าใช้จ่ายเพิ่ม", "Use your existing claude.ai to analyse, then paste the result here")}
          </p>
          {analysis && analysis.entry_count !== total && (
            <p className="mt-1 text-sm font-semibold text-[#E23744]">{t(`ตอนนี้มี ${total} ประเด็นแล้ว`, `Now ${total} issues`)}</p>
          )}
        </div>
        <div className="flex flex-wrap gap-2">
          {isAdmin && (
            <>
              <button onClick={copyPrompt} disabled={!total}
                className="rounded-lg bg-[#14232E] px-3 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
                {copied ? t("คัดลอกแล้ว ✓ ไปวางใน claude.ai", "Copied ✓ paste in claude.ai") : t("① คัดลอกข้อมูลไปถาม Claude", "① Copy data for Claude")}
              </button>
              <button onClick={() => setPasting((v) => !v)} className="rounded-lg bg-[#E23744] px-3 py-2 text-sm font-semibold text-white">
                {t("② วางผลจาก Claude", "② Paste Claude's result")}
              </button>
            </>
          )}
          {analysis && (
            <button onClick={() => printSummary("สรุปวิเคราะห์เพื่อวางแผน Support: Q4 & ปีใหม่", `จาก ${analysis.entry_count} ประเด็น · ${fmt(analysis.created_at)}`, html)}
              className="rounded-lg border border-border px-3 py-2 text-sm font-semibold">
              {t("พิมพ์ / บันทึก PDF", "Print / PDF")}
            </button>
          )}
        </div>
      </div>
      {isAdmin && pasting && (
        <div className="mt-3 rounded-lg bg-surface-2 p-3">
          <p className="mb-2 text-sm text-muted">
            {t("วิธีใช้: กด ① แล้วเปิด claude.ai วางข้อความ (Ctrl+V) ส่ง รอคำตอบ จากนั้นกดปุ่มคัดลอกใต้คำตอบของ Claude แล้ววางในช่องนี้ กดบันทึก", "Press ①, paste into claude.ai, copy the reply, paste here and save")}
          </p>
          <textarea rows={8} value={draft} onChange={(e) => setDraft(e.target.value)}
            className="w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm" placeholder={t("วางคำตอบจาก Claude ที่นี่", "Paste Claude's answer here")} />
          <div className="mt-2 flex gap-2">
            <button disabled={!draft.trim()} onClick={async () => { if (await onSave(draft)) { setDraft(""); setPasting(false); } }}
              className="rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
              {t("บันทึกให้ทุกทีมเห็น", "Save for all teams")}
            </button>
            <button onClick={() => setPasting(false)} className="rounded-lg border border-border px-4 py-2 text-sm font-semibold">{t("ยกเลิก", "Cancel")}</button>
          </div>
        </div>
      )}
      {analysis && <div className={proseCls} dangerouslySetInnerHTML={{ __html: html }} />}
    </div>
  );
}

/* ====================================================================== */
/* Presentation: meeting summary (2 slides, 16:9), full-screen + print    */
/* Content = the agreed meeting deck "สรุปประชุม: เตรียมความพร้อม Q4 & ปีใหม่" */
/* ====================================================================== */
const PRESENT_DATE = "สรุปประชุม 6 ต.ค. 2569";
const PRESENT_LEAD = {
  before: "ความเสี่ยงหลักช่วง Peak คือ ",
  b1: "กะที่มีพนักงานคนเดียว",
  mid: " และ ",
  b2: "พื้นที่เก็บกระเป๋าไม่พอ",
  after1: " ต้องตัดสินใจเรื่องกำลังคนและอุปกรณ์ภายใน ",
  date: "31 ต.ค.",
  after2: " เพราะ BKK, DMK, HKTI และ Online-CS เริ่ม High season ตั้งแต่ พ.ย.",
};
const PRESENT_RISKS: { title: string; branches: string; impact: string; main: boolean }[] = [
  { title: "1. คนไม่พอ / กะคนเดียว", branches: "BKK, DMK, HKTI, CNX, T21, ICS, Online-CS", impact: "คิวยาว ลูกค้าเลิกรอ พนักงานไม่ได้พัก", main: true },
  { title: "2. พื้นที่เก็บเต็ม", branches: "DMK, BKK, HKTI, CTWG, TPY, CNX", impact: "ต้อง Rotate ไปคลัง เสี่ยงส่งผิด / บางสาขาต้องปฏิเสธลูกค้า", main: true },
  { title: "3. ระบบ/อุปกรณ์ช้า", branches: "BKK, HKTD, HKTI, CNX, TPY, MBK", impact: "คอมค้าง ข้อมูลหาย ต้องสร้าง Order ใหม่", main: false },
  { title: "4. เพิ่มรอบรับ-ส่ง / การประสานเข้ารับที่จุด", branches: "Online-CS, HKTI, HKTD, TPY, MIXT", impact: "เข้ารับไม่ทัน 12:00 ภูเก็ตรถติดจนงด Walk-in", main: false },
  { title: "5. ลูกค้าไม่รู้ทางเลือก", branches: "CTWG, HKTI, T21", impact: "ไม่รู้ว่ามี 2 สาขา ไม่มีโปรช่วยระบายกระเป๋า", main: false },
];
const PRESENT_TEAMS: { team: string; items: string[] }[] = [
  { team: "HR", items: [
    "กำลังคนสำรอง, Trainee/ Contact Staff ที่ BKK DMK CNX HKT",
    "Porter BKK กะครบ 24 ชม. · สำรอง DMK (Contact 1 คน) ช่วง Hi-season",
    "Runner สำรอง · สรรหา Contact 3 เดือน",
    "ยกวันหยุด ธ.ค. ไปใช้ ม.ค.–ก.ค. 2570",
  ] },
  { team: "OP", items: [
    "Stock Inventory และอุปกรณ์ (รถเข็น ชั้นวาง)",
    "Queue Card และ Sticker DMK/BKK ตามที่สาขาขอ",
    "Flow ช่วง X-Ray ที่คิวยาว (CNX)",
    "แผน Capacity และขั้นตอน Rotate ไปคลัง",
  ] },
  { team: "IT & Dev.", items: [
    "ตรวจอุปกรณ์/ระบบล่วงหน้า เปลี่ยนคอมที่ช้าสำหรับหน้าสาขา & CS",
    "Laptop/คอมสำรองให้สาขาที่เพิ่มคน",
    "เพิ่มรูปแบบค้นหา Booking, รายงาน AOT",
    "Email/WhatsApp Official สาขาภูเก็ต",
  ] },
  { team: "Logistic", items: [
    "เพิ่มเจ้าหน้าที่และรถเข้ารับ รักษา Pickup Time 12:00",
    "เพิ่มรอบรับ + ทีม Standby ทุกวันช่วง Hi-Season",
    "รอบรถ HKT ช่วง Festival · แจ้งปิดรับล่วงหน้า > 3 ชม.",
    "คนขับเข้ารับหน้าร้านเอง แจ้งค่าจอด ไม่แทรกคิวตอนแพ็ค",
  ] },
  { team: "MKT & BD", items: [
    "โปรส่งกระเป๋าระบายพื้นที่ + เพิ่มช่วงปิดรอบ",
    "Signage CTWH/CTWG · Standee HKTI–HKTD",
    "หน้าเว็บแจ้งเวลาเข้ารับอาจเปลี่ยนช่วง Peak",
  ] },
];

function PresentationView() {
  const t = useT();
  const deck = useRef<HTMLDivElement>(null);
  const slide = "q4-slide relative mx-auto flex min-h-[min(56.25vw,619px)] w-full max-w-[1100px] flex-col rounded-2xl shadow-sm";
  const head = "font-extrabold leading-tight";

  return (
    <div className="space-y-4">
      <style>{`
        .q4-slide{font-size:clamp(8px,1.15vw,13px)}
        #q4-deck:fullscreen{background:#0D171F;overflow:auto;padding:2vh 0}
        #q4-deck:fullscreen .q4-slide{max-width:none;width:96vw;min-height:54vw;font-size:1.15vw;margin-bottom:2vh}
        @media print{
          @page{size:A4 landscape;margin:6mm}
          body *{visibility:hidden}
          #q4-deck,#q4-deck *{visibility:visible}
          #q4-deck{position:absolute;left:0;top:0;width:100%}
          .q4-slide{max-width:none!important;width:100%!important;font-size:12px!important;box-shadow:none!important;border-radius:0!important;
            page-break-after:always;break-after:page;-webkit-print-color-adjust:exact;print-color-adjust:exact}
          .q4-noprint{display:none!important}
        }
      `}</style>

      <div className="q4-noprint flex flex-wrap items-center justify-between gap-2">
        <p className="text-sm text-muted">{t("สรุปประชุมสำหรับนำเสนอและแจ้งทุกทีม 2 หน้า", "Meeting summary for all teams, 2 slides")}</p>
        <div className="flex gap-2">
          <button onClick={() => deck.current?.requestFullscreen?.()} className="rounded-lg bg-[#E23744] px-4 py-2 text-sm font-semibold text-white">
            {t("นำเสนอเต็มจอ", "Present full screen")}
          </button>
          <button onClick={() => window.print()} className="rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3]">
            {t("พิมพ์ / บันทึก PDF", "Print / PDF")}
          </button>
        </div>
      </div>

      <div id="q4-deck" ref={deck} className="space-y-4">
        {/* ---------------- Slide 1: risks ---------------- */}
        <section className={`${slide} bg-[#14232E] px-[6.5%] pb-[3%] pt-[5.5%] text-[#EEF3F7]`}>
          <p className="text-[1.15em] font-semibold text-[#CFE2F3]">Airportels · {PRESENT_DATE}</p>
          <h1 className={`${head} mt-[1.2%] text-[3.4em] text-white`}>เตรียมความพร้อม Q4 &amp; ปีใหม่</h1>
          <p className="mt-[1.6%] text-[1.5em] leading-relaxed text-[#DDE7EF]">
            {PRESENT_LEAD.before}<b className="text-white">{PRESENT_LEAD.b1}</b>{PRESENT_LEAD.mid}<b className="text-white">{PRESENT_LEAD.b2}</b>
            {PRESENT_LEAD.after1}<b className="text-[#FF6B78]">{PRESENT_LEAD.date}</b>{PRESENT_LEAD.after2}
          </p>
          <div className="mt-auto grid grid-cols-5 gap-[1.2%] pt-[3%]">
            {PRESENT_RISKS.map((r) => (
              <div key={r.title} className={`flex flex-col gap-[0.5em] rounded-xl border-t-[0.35em] bg-[#1E3241] p-[7%] ${r.main ? "border-[#E23744]" : "border-[#CFE2F3]"}`}>
                <h3 className="text-[1.3em] font-bold leading-snug text-white">{r.title}</h3>
                <p className="text-[1.1em] leading-snug text-[#CFE2F3]">{r.branches}</p>
                <p className="text-[1.1em] leading-snug text-[#DDE7EF]">{r.impact}</p>
              </div>
            ))}
          </div>
          <p className="mt-[2.5%] text-[1.1em] text-[#8FA6B8]">AI Operation Department · 1 / 2</p>
        </section>

        {/* ---------------- Slide 2: team support ---------------- */}
        <section className={`${slide} border border-border bg-[#F4F7FA] px-[6.5%] pb-[3%] pt-[5.5%] text-[#14232E]`}>
          <h2 className={`${head} text-[2.6em]`}>งานที่ต้องการซัพพอตแต่ละทีม</h2>
          <div className="mt-[2.5%] grid grid-cols-3 gap-[1.4%]">
            {PRESENT_TEAMS.map((x) => (
              <div key={x.team} className="flex flex-col gap-[0.5em] rounded-xl border border-[#D6E2EC] border-l-[0.45em] border-l-[#14232E] bg-white px-[6%] py-[5%]">
                <h3 className="text-[1.5em] font-bold">{x.team}</h3>
                <ul className="list-disc space-y-[0.3em] pl-[1.1em] text-[1.05em] leading-snug">
                  {x.items.map((it) => <li key={it}>{it}</li>)}
                </ul>
              </div>
            ))}
            <div className="flex flex-col justify-center gap-[0.5em] rounded-xl bg-[#E23744] px-[6%] py-[5%] text-white">
              <h3 className="text-[1.5em] font-bold">ทุกทีม</h3>
              <p className="text-[1.35em] font-semibold leading-snug">งานเตรียมเสร็จภายใน 31 ตุลาคม 2569</p>
            </div>
          </div>
          <p className="mt-[2.5%] text-[1.1em] text-[#5B6C79]">เตรียมความพร้อม Q4 &amp; ปีใหม่ · 2 / 2</p>
        </section>
      </div>
    </div>
  );
}

/* ====================================================================== */
/* My team: team members manage their own team (add people by e-mail)     */
/* ====================================================================== */
function MyTeamView({
  isAdmin, seesAll, canAssign, myTeams, members, userId, entries, statusOf, teamsOf, notes, tasks, onSaveTask, onAdd, onRemove, onOpenList,
  files, fileOps, external,
}: {
  files: Record<string, Q4Attachment[]>; fileOps: FileOps; external: boolean;
  isAdmin: boolean; seesAll: boolean; canAssign: boolean; myTeams: string[]; members: Q4TeamMember[]; userId: string | null;
  entries: Q4Entry[]; statusOf: (e: Q4Entry) => string; teamsOf: (e: Q4Entry) => string[];
  notes: Record<string, Record<string, string>>; tasks: Record<string, Record<string, Q4Task>>;
  onSaveTask: (id: string, team: string, status: string, addTeams: string[], note: string, assigneeEmail: string) => Promise<boolean>;
  onAdd: (email: string, team: string) => void; onRemove: (m: Q4TeamMember) => void; onOpenList: (team: string) => void;
}) {
  const t = useT();
  const teams = seesAll ? Q4_TEAMS : myTeams;
  const canWork = (tm: string) => canAssign || myTeams.includes(tm);
  const canManage = (tm: string) => isAdmin || myTeams.includes(tm);
  const [team, setTeam] = useState(teams[0] ?? "");
  const [draft, setDraft] = useState("");
  const [showClosed, setShowClosed] = useState(false);

  if (!teams.length) {
    return <div className="rounded-xl border border-dashed border-border px-4 py-12 text-center text-muted">{t("คุณยังไม่ได้อยู่ในทีมใด ขอให้ Admin หรือคนในทีมเพิ่มอีเมลของคุณ", "You are not in any team yet")}</div>;
  }
  const list = members.filter((m) => m.team === team);
  const rank: Record<string, number> = { High: 0, Medium: 1, Low: 2 };
  const mine = entries.filter((e) => teamsOf(e).includes(team));
  const shown = mine.filter((e) => showClosed || !Q4_CLOSED.has(statusOf(e)))
    .sort((a, b) => rank[a.priority] - rank[b.priority] || a.created_at.localeCompare(b.created_at));
  const open = mine.filter((e) => !Q4_CLOSED.has(statusOf(e))).length;
  const high = mine.filter((e) => e.priority === "High" && !Q4_CLOSED.has(statusOf(e))).length;
  const done = mine.filter((e) => statusOf(e) === "Completed").length;

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center gap-2">
        {teams.map((x) => (
          <button key={x} onClick={() => setTeam(x)}
            className={`rounded-lg border px-3 py-1.5 text-sm font-semibold ${team === x ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface"}`}>
            {x}
          </button>
        ))}
      </div>

      <div className="grid gap-4 lg:grid-cols-[minmax(0,1fr)_320px]">
        {/* ---------- tasks ---------- */}
        <div className="space-y-3">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <h2 className="text-lg font-bold">
              {t("งานของทีม", "Team issues")} {team}
              <span className="ml-2 text-sm font-normal text-muted">{t("ค้าง", "open")} {open} · High {high} · {t("ปิดแล้ว", "done")} {done}</span>
            </h2>
            <label className="flex items-center gap-1.5 text-sm text-muted">
              <input type="checkbox" checked={showClosed} onChange={(e) => setShowClosed(e.target.checked)} /> {t("แสดงงานที่ปิดแล้ว", "Show closed")}
            </label>
          </div>
          {!shown.length ? (
            <div className="rounded-xl border border-dashed border-border px-4 py-10 text-center text-muted">{t("ไม่มีงานค้างของทีมนี้", "No open issues")}</div>
          ) : shown.map((e) => (
            <TeamTaskRow key={`${e.id}-${statusOf(e)}-${notes[e.id]?.[team] ?? ""}-${tasks[e.id]?.[team]?.assignee_email ?? ""}-${teamsOf(e).join("|")}`}
              e={e} team={team} status={statusOf(e)} teams={teamsOf(e)} note={notes[e.id]?.[team] ?? ""}
              assignee={tasks[e.id]?.[team]?.assignee_email ?? ""} members={list} onSave={onSaveTask}
              files={files[e.id] ?? []} fileOps={fileOps} userId={userId} isAdmin={isAdmin} readOnly={!canWork(team)} />
          ))}
          {!external && (
            <button onClick={() => onOpenList(team)} className="text-sm font-semibold text-brand-600 hover:underline">
              {t("ดูการ์ดแบบเต็มในแท็บรายการทั้งหมด", "Open full cards")} →
            </button>
          )}
        </div>

        {/* ---------- members ---------- */}
        <aside className="h-fit space-y-3 rounded-xl border border-border bg-surface p-4">
          <h3 className="font-bold">{t("สมาชิกทีม", "Members")} {team} ({list.length})</h3>
          <p className="text-xs text-muted">{t("คนในทีมเพิ่มสมาชิกเองได้ ใช้ Gmail หรืออีเมลบริษัท ไม่ต้องมีบัญชีระบบตารางงาน", "Add people by Gmail or company e-mail, no Scheduling account needed")}</p>
          {!list.length ? <p className="text-sm text-muted">-</p> : (
            <ul className="divide-y divide-border rounded-lg border border-border">
              {list.map((m) => (
                <li key={`${m.user_id}-${m.team}`} className="flex items-center justify-between gap-2 px-3 py-2 text-sm">
                  <span className="min-w-0">
                    <b className="block truncate">{m.full_name || m.email}{m.user_id === userId ? ` (${t("คุณ", "you")})` : ""}</b>
                    {m.full_name && <span className="block truncate text-xs text-muted">{m.email}</span>}
                  </span>
                  {m.user_id !== userId && canManage(team) && (
                    <button onClick={() => onRemove(m)} className="shrink-0 rounded-md border border-border px-2 py-0.5 text-xs text-danger hover:bg-surface-2">{t("นำออก", "Remove")}</button>
                  )}
                </li>
              ))}
            </ul>
          )}
          {canManage(team) && <div className="flex gap-2">
            <input className="min-w-0 flex-1 rounded-lg border border-border bg-surface px-2.5 py-2 text-sm" type="email"
              placeholder={t("อีเมลที่ใช้ Login", "Login e-mail")} value={draft} onChange={(e) => setDraft(e.target.value)} />
            <button disabled={!draft.trim()} onClick={() => { onAdd(draft.trim(), team); setDraft(""); }}
              className="rounded-lg bg-[#14232E] px-3 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">{t("เพิ่ม", "Add")}</button>
          </div>}
        </aside>
      </div>
    </div>
  );
}

function TeamTaskRow({
  e, team, status, teams, note, assignee, members, onSave, files, fileOps, userId, isAdmin, readOnly,
}: {
  files: Q4Attachment[]; fileOps: FileOps; userId: string | null; isAdmin: boolean; readOnly: boolean;
  e: Q4Entry; team: string; status: string; teams: string[]; note: string; assignee: string; members: Q4TeamMember[];
  onSave: (id: string, team: string, status: string, addTeams: string[], note: string, assigneeEmail: string) => Promise<boolean>;
}) {
  const t = useT();
  const [st, setSt] = useState(status);
  const [nt, setNt] = useState(note);
  const [who, setWho] = useState(assignee);
  const [add, setAdd] = useState<string[]>([]);
  const [busy, setBusy] = useState(false);
  const listId = `q4-members-${team.replace(/[^a-z0-9]/gi, "")}`;
  const input = "mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text";
  return (
    <div className="rounded-xl border border-border bg-surface p-3">
      <div className="mb-2 flex flex-wrap items-center gap-2 text-sm">
        <b className="rounded bg-[#14232E] px-2 py-0.5 text-[#CFE2F3]">{e.branch}</b>
        <span className={`rounded px-1.5 py-0.5 text-xs font-bold text-white ${PRI_STYLE[e.priority]}`}>{e.priority}</span>
        <span className="font-semibold">{short(e.category)}</span>
        <span className="text-xs text-muted">· {teams.join(", ")}</span>
      </div>
      <p className="mb-2 text-sm"><span className="text-muted">{t("ต้องการให้ Support:", "Support needed:")}</span> {e.support}</p>
      <div className="grid gap-2 md:grid-cols-[150px_200px_minmax(0,1fr)]">
        <label className="text-xs text-muted">{t("สถานะ", "Status")}
          <select className={input} value={st} onChange={(x) => setSt(x.target.value)}>
            {Q4_STATUSES.map((s) => <option key={s} value={s}>{s}{s === "Completed" ? ` (${t("ปิดงาน", "close")})` : ""}</option>)}
          </select>
        </label>
        <label className="text-xs text-muted">{t("ผู้รับงานในทีม (อีเมล)", "Assignee (e-mail)")}
          <input className={input} list={listId} value={who} onChange={(x) => setWho(x.target.value)} placeholder={t("เลือกหรือพิมพ์อีเมล", "Pick or type e-mail")} />
          <datalist id={listId}>{members.map((m) => <option key={m.user_id} value={m.email}>{m.full_name || m.email}</option>)}</datalist>
        </label>
        <label className="text-xs text-muted">{t(`ความคืบหน้าทีม ${team}`, `${team} progress`)}
          <input className={input} value={nt} onChange={(x) => setNt(x.target.value)} placeholder={t("ทำแล้ว / จะทำ / กำหนดเสร็จ", "Done / next / due")} />
        </label>
      </div>
      <details className="mt-2 text-xs">
        <summary className="cursor-pointer font-semibold text-muted">{t("มอบหมายต่อให้ทีมอื่น", "Delegate to another team")}{add.length ? ` (${add.join(", ")})` : ""}</summary>
        <div className="mt-1.5 flex flex-wrap gap-1.5">
          {Q4_TEAMS.filter((x) => !teams.includes(x)).map((x) => {
            const on = add.includes(x);
            return (
              <button key={x} type="button" onClick={() => setAdd((c) => (on ? c.filter((y) => y !== x) : [...c, x]))}
                className={`rounded-md border px-2 py-0.5 font-semibold ${on ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface"}`}>
                {on ? "✓ " : ""}{x}
              </button>
            );
          })}
        </div>
      </details>
      <AttachmentBox files={files} fileOps={fileOps} entryId={e.id} team={team} userId={userId} isAdmin={isAdmin} canUpload={!readOnly} />
      {readOnly ? <p className="mt-2 text-right text-xs text-muted">{t("ดูอย่างเดียว (Review)", "Read-only (Review)")}</p> : (
      <div className="mt-2 flex justify-end">
        <button disabled={busy} onClick={async () => { setBusy(true); await onSave(e.id, team, st, add, nt, who); setBusy(false); }}
          className="rounded-md bg-[#14232E] px-4 py-1.5 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
          {busy ? t("กำลังบันทึก", "Saving") : t("บันทึก", "Save")}
        </button>
      </div>
      )}
    </div>
  );
}

type FileOps = {
  upload: (entryId: string, team: string, list: FileList | File[]) => Promise<void>;
  open: (a: Q4Attachment) => Promise<void>;
  download: (a: Q4Attachment) => Promise<void>;
  remove: (a: Q4Attachment) => Promise<void>;
};

function AttachmentBox({
  files, fileOps, entryId, team, userId, isAdmin, canUpload,
}: { files: Q4Attachment[]; fileOps: FileOps; entryId: string; team: string; userId: string | null; isAdmin: boolean; canUpload: boolean }) {
  const t = useT();
  const [busy, setBusy] = useState(false);
  const size = (n: number | null) => (n == null ? "" : n > 1024 * 1024 ? `${(n / 1024 / 1024).toFixed(1)} MB` : `${Math.max(1, Math.round(n / 1024))} KB`);
  return (
    <div className="mt-2 rounded-lg border border-dashed border-border p-2">
      <div className="flex flex-wrap items-center justify-between gap-2">
        <span className="text-xs font-semibold text-muted">📎 {t("ไฟล์ / รูปภาพ", "Files / photos")} ({files.length})</span>
        {canUpload && (
          <label className={`cursor-pointer rounded-md border border-border bg-surface px-2.5 py-1 text-xs font-semibold hover:bg-surface-2 ${busy ? "opacity-50" : ""}`}>
            {busy ? t("กำลังอัปโหลด…", "Uploading…") : t("+ อัปโหลดรูป / ไฟล์", "+ Upload")}
            <input type="file" multiple accept="image/*,application/pdf,.doc,.docx,.xls,.xlsx,.csv" className="hidden" disabled={busy}
              onChange={async (ev) => {
                const list = ev.target.files;
                if (!list?.length) return;
                setBusy(true);
                await fileOps.upload(entryId, team, list);
                setBusy(false);
                ev.target.value = "";
              }} />
          </label>
        )}
      </div>
      {files.length > 0 && (
        <ul className="mt-1.5 space-y-1">
          {files.map((a) => (
            <li key={a.id} className="flex flex-wrap items-center gap-2 text-xs">
              <span>{a.mime?.startsWith("image/") ? "🖼️" : "📄"}</span>
              <button onClick={() => fileOps.open(a)} className="max-w-[260px] truncate font-semibold text-brand-600 hover:underline" title={a.name}>{a.name}</button>
              <span className="text-muted">{size(a.size)}{a.team ? ` · ${a.team}` : ""}</span>
              <button onClick={() => fileOps.download(a)} className="rounded border border-border px-1.5 py-0.5 hover:bg-surface-2">{t("ดาวน์โหลด", "Download")}</button>
              {(isAdmin || a.uploaded_by === userId) && (
                <button onClick={() => fileOps.remove(a)} className="rounded border border-border px-1.5 py-0.5 text-danger hover:bg-surface-2">{t("ลบ", "Delete")}</button>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

/* ====================================================================== */
/* Q4 User Management (Q4 admins): people who see many teams, by e-mail   */
/* ====================================================================== */
type Q4RoleRow = { user_id: string; email: string; name: string | null; role: "review" | "assign" | "edit"; added_at: string };
const ROLE_INFO: Record<string, { th: string; en: string; desc: string }> = {
  review: { th: "Review", en: "Review", desc: "ดูทุกแท็บ ทุกทีม (ยกเว้นฟอร์ม) อ่านอย่างเดียว" },
  assign: { th: "Assign Team", en: "Assign Team", desc: "Review + มอบหมายทีม อัปเดตสถานะ และ Central action ได้ทุกเรื่อง" },
  edit: { th: "Edit", en: "Edit", desc: "แก้ไขได้ทั้งหมดแบบ Admin ของ Q4 รวมจัดการผู้ใช้" },
};

function UsersView({ userId, flash }: { userId: string | null; flash: (m: string) => void }) {
  const t = useT();
  const supabase = useMemo(() => createClient(), []);
  const [rows, setRows] = useState<Q4RoleRow[]>([]);
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [role, setRole] = useState<"review" | "assign" | "edit">("review");
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    const r = await supabase.from("q4_roles").select("user_id, email, name, role, added_at").order("added_at");
    setRows((r.data ?? []) as Q4RoleRow[]);
  }, [supabase]);
  useEffect(() => { const id = setTimeout(load, 0); return () => clearTimeout(id); }, [load]);

  async function add() {
    setBusy(true);
    try {
      const res = await fetch("/api/q4/users", {
        method: "POST", headers: { "content-type": "application/json" },
        body: JSON.stringify({ email: email.trim(), name: name.trim(), role }),
      });
      const j = await res.json().catch(() => ({}));
      if (!res.ok) {
        flash(j.error === "not_allowed" ? t("เฉพาะ Admin ของ Q4", "Q4 admins only")
          : j.error === "missing_service_key" ? t("ยังไม่ได้ตั้งค่า SUPABASE_SERVICE_ROLE_KEY", "Service key missing")
          : t("เพิ่มไม่สำเร็จ: ", "Failed: ") + (j.error ?? res.status));
      } else {
        flash(j.created ? t(`เพิ่ม ${email} แล้ว (บัญชีใหม่ ใช้ Google หรือลิงก์ทางอีเมลเข้าได้เลย)`, `Added ${email} (new account)`) : t(`ตั้งสิทธิ์ ${email} แล้ว`, `Role set for ${email}`));
        setEmail(""); setName(""); load();
      }
    } finally { setBusy(false); }
  }
  async function change(r: Q4RoleRow, next: string) {
    const u = await supabase.from("q4_roles").update({ role: next }).eq("user_id", r.user_id);
    if (u.error) flash(t("เปลี่ยนสิทธิ์ไม่สำเร็จ", "Change failed")); else { flash(t("เปลี่ยนสิทธิ์แล้ว", "Role changed")); load(); }
  }
  async function remove(r: Q4RoleRow) {
    if (!confirm(t(`ยกเลิกสิทธิ์ของ ${r.name || r.email} ใช่ไหม`, `Remove ${r.email}?`))) return;
    const d = await supabase.from("q4_roles").delete().eq("user_id", r.user_id);
    if (d.error) flash(t("ลบไม่สำเร็จ", "Remove failed")); else { flash(t("ยกเลิกสิทธิ์แล้ว", "Removed")); load(); }
  }

  const inp = "rounded-lg border border-border bg-surface px-3 py-2 text-sm";
  return (
    <div className="space-y-4">
      <div className={card}>
        <h2 className="text-lg font-bold">{t("ผู้ใช้งาน Q4 (ไม่ต้องมีบัญชีระบบตารางงาน)", "Q4 users (no Scheduling account needed)")}</h2>
        <p className="mb-3 text-sm text-muted">{t("สำหรับคนที่ต้องเห็นหลายทีม เช่น CEO / MD / BD / Management ใช้ Gmail หรืออีเมลบริษัทก็ได้ เมื่อเพิ่มแล้วเข้าสู่ระบบด้วย Google หรือลิงก์ทางอีเมลได้ทันที", "For people who need to see many teams (CEO, MD, BD, Management). Gmail or company e-mail.")}</p>
        <div className="grid gap-2 md:grid-cols-[minmax(0,1.3fr)_minmax(0,1fr)_200px_auto]">
          <input className={inp} type="email" placeholder={t("อีเมล (Gmail หรืออีเมลบริษัท)", "E-mail")} value={email} onChange={(e) => setEmail(e.target.value)} />
          <input className={inp} placeholder={t("ชื่อ / ตำแหน่ง เช่น คุณเอ (CEO)", "Name / title")} value={name} onChange={(e) => setName(e.target.value)} />
          <select className={inp} value={role} onChange={(e) => setRole(e.target.value as "review" | "assign" | "edit")}>
            {Object.entries(ROLE_INFO).map(([k, v]) => <option key={k} value={k}>{v.th}</option>)}
          </select>
          <button disabled={busy || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim())} onClick={add}
            className="rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
            {busy ? t("กำลังเพิ่ม…", "Adding…") : t("เพิ่ม", "Add")}
          </button>
        </div>
        <ul className="mt-3 grid gap-1 text-xs text-muted md:grid-cols-3">
          {Object.entries(ROLE_INFO).map(([k, v]) => <li key={k}><b className="text-text">{v.th}:</b> {v.desc}</li>)}
        </ul>
      </div>

      <div className={card}>
        <h3 className="mb-2 font-bold">{t("รายชื่อ", "Users")} ({rows.length})</h3>
        {!rows.length ? <p className="text-sm text-muted">{t("ยังไม่มีผู้ใช้", "No users yet")}</p> : (
          <div className="overflow-x-auto">
            <table className="w-full border-collapse text-sm">
              <thead><tr>
                {[t("ชื่อ", "Name"), t("อีเมล", "E-mail"), "Role", t("เพิ่มเมื่อ", "Added"), ""].map((h) => (
                  <th key={h} className="border-b border-border px-2.5 py-2 text-left text-xs font-semibold text-muted">{h}</th>
                ))}
              </tr></thead>
              <tbody>
                {rows.map((r) => (
                  <tr key={r.user_id}>
                    <td className="border-b border-border px-2.5 py-2 font-semibold">{r.name || "-"}</td>
                    <td className="border-b border-border px-2.5 py-2 text-muted">{r.email}</td>
                    <td className="border-b border-border px-2.5 py-2">
                      <select className="rounded-md border border-border bg-surface px-2 py-1 text-sm" value={r.role}
                        disabled={r.user_id === userId} onChange={(e) => change(r, e.target.value)}>
                        {Object.entries(ROLE_INFO).map(([k, v]) => <option key={k} value={k}>{v.th}</option>)}
                      </select>
                    </td>
                    <td className="border-b border-border px-2.5 py-2 text-xs text-muted">{fmt(r.added_at)}</td>
                    <td className="border-b border-border px-2.5 py-2 text-right">
                      {r.user_id !== userId && (
                        <button onClick={() => remove(r)} className="rounded-md border border-border px-2 py-0.5 text-xs text-danger hover:bg-surface-2">{t("ยกเลิกสิทธิ์", "Remove")}</button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}

/* ====================================================================== */
/* Minute Meeting: meeting minutes + files; Q4 admins write, everyone reads */
/* ====================================================================== */
type Meeting = { id: string; title: string; meeting_date: string; content: string; updated_at: string };
type MeetingFile = { id: string; meeting_id: string; path: string; name: string; mime: string | null; size: number | null; uploaded_by: string | null };

function MeetingsView({ canEdit, userId, flash }: { canEdit: boolean; userId: string | null; flash: (m: string) => void }) {
  const t = useT();
  const supabase = useMemo(() => createClient(), []);
  const [rows, setRows] = useState<Meeting[]>([]);
  const [files, setFiles] = useState<MeetingFile[]>([]);
  const [sel, setSel] = useState<string>("");
  const [edit, setEdit] = useState<null | { id: string | null; title: string; date: string; content: string }>(null);
  const [preview, setPreview] = useState(false);
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    const [m, f] = await Promise.all([
      supabase.from("q4_meetings").select("id, title, meeting_date, content, updated_at").order("meeting_date", { ascending: false }),
      supabase.from("q4_meeting_files").select("*").order("created_at"),
    ]);
    const list = (m.data ?? []) as Meeting[];
    setRows(list);
    setFiles((f.data ?? []) as MeetingFile[]);
    setSel((cur) => (cur && list.some((x) => x.id === cur) ? cur : list[0]?.id ?? ""));
  }, [supabase]);
  useEffect(() => {
    const id = setTimeout(load, 0);
    const ch = supabase.channel("q4-meetings")
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_meetings" }, () => load())
      .on("postgres_changes", { event: "*", schema: "sop", table: "q4_meeting_files" }, () => load())
      .subscribe();
    return () => { clearTimeout(id); supabase.removeChannel(ch); };
  }, [supabase, load]);

  const cur = rows.find((x) => x.id === sel) ?? null;
  const curFiles = files.filter((f) => f.meeting_id === sel);
  const html = useMemo(() => (cur ? mdToHtml(cur.content) : ""), [cur]);
  const today = new Date().toISOString().slice(0, 10);
  const dateTh = (d: string) => { try { return new Date(`${d}T00:00:00`).toLocaleDateString("th-TH", { dateStyle: "long" }); } catch { return d; } };

  async function save() {
    if (!edit || !edit.title.trim() || !edit.date) return;
    setBusy(true);
    const row = { title: edit.title.trim(), meeting_date: edit.date, content: edit.content, updated_by: userId, updated_at: new Date().toISOString() };
    const r = edit.id
      ? await supabase.from("q4_meetings").update(row).eq("id", edit.id).select("id").single()
      : await supabase.from("q4_meetings").insert({ ...row, created_by: userId }).select("id").single();
    setBusy(false);
    if (r.error) { flash(t("บันทึกไม่สำเร็จ: ", "Save failed: ") + r.error.message); return; }
    flash(t("บันทึกการประชุมแล้ว", "Meeting saved"));
    setEdit(null); setPreview(false);
    await load();
    setSel((r.data as { id: string }).id);
  }
  async function remove(m: Meeting) {
    if (!confirm(t(`ลบ "${m.title}" ใช่ไหม`, `Delete "${m.title}"?`))) return;
    const paths = files.filter((f) => f.meeting_id === m.id).map((f) => f.path);
    const d = await supabase.from("q4_meetings").delete().eq("id", m.id);
    if (d.error) { flash(t("ลบไม่สำเร็จ", "Delete failed")); return; }
    if (paths.length) await supabase.storage.from("q4-files").remove(paths);
    flash(t("ลบแล้ว", "Deleted")); load();
  }
  async function upload(list: FileList) {
    if (!cur) return;
    let ok = 0;
    for (const file of Array.from(list)) {
      if (file.size > 10 * 1024 * 1024) { flash(t(`${file.name} ใหญ่เกิน 10 MB`, `${file.name} is over 10 MB`)); continue; }
      const path = `meetings/${cur.id}/${crypto.randomUUID()}-${file.name.replace(/[^\w.\-]+/g, "_").slice(-80)}`;
      const up = await supabase.storage.from("q4-files").upload(path, file, { contentType: file.type || undefined });
      if (up.error) { flash(t("อัปโหลดไม่สำเร็จ: ", "Upload failed: ") + up.error.message); continue; }
      const ins = await supabase.from("q4_meeting_files").insert({ meeting_id: cur.id, path, name: file.name, mime: file.type || null, size: file.size, uploaded_by: userId });
      if (ins.error) { await supabase.storage.from("q4-files").remove([path]); flash(ins.error.message); continue; }
      ok++;
    }
    if (ok) { flash(t(`อัปโหลดแล้ว ${ok} ไฟล์`, `Uploaded ${ok}`)); load(); }
  }
  async function openF(f: MeetingFile, download: boolean) {
    const r = await supabase.storage.from("q4-files").createSignedUrl(f.path, 3600, download ? { download: f.name } : undefined);
    if (r.error || !r.data) { flash(t("เปิดไฟล์ไม่สำเร็จ", "Could not open")); return; }
    if (download) window.location.assign(r.data.signedUrl); else window.open(r.data.signedUrl, "_blank", "noopener");
  }
  async function removeF(f: MeetingFile) {
    if (!confirm(t(`ลบไฟล์ ${f.name} ใช่ไหม`, `Delete ${f.name}?`))) return;
    const d = await supabase.from("q4_meeting_files").delete().eq("id", f.id);
    if (d.error) { flash(t("ลบไม่สำเร็จ", "Delete failed")); return; }
    await supabase.storage.from("q4-files").remove([f.path]);
    load();
  }

  const inp = "w-full rounded-lg border border-border bg-surface px-3 py-2 text-sm";
  return (
    <div className="grid gap-4 lg:grid-cols-[260px_minmax(0,1fr)]">
      {/* ---------- meeting list ---------- */}
      <aside className="h-fit space-y-2">
        {canEdit && (
          <button onClick={() => { setEdit({ id: null, title: "", date: today, content: "" }); setPreview(false); }}
            className="w-full rounded-lg bg-[#E23744] px-3 py-2 text-sm font-semibold text-white">
            + {t("เพิ่มการประชุม", "New meeting")}
          </button>
        )}
        {!rows.length && <p className="text-sm text-muted">{t("ยังไม่มีบันทึกการประชุม", "No meetings yet")}</p>}
        {rows.map((m) => {
          const upcoming = m.meeting_date > today;
          return (
            <button key={m.id} onClick={() => { setSel(m.id); setEdit(null); }}
              className={`w-full rounded-lg border px-3 py-2 text-left text-sm ${sel === m.id && !edit ? "border-[#14232E] bg-[#14232E] text-[#CFE2F3]" : "border-border bg-surface hover:border-brand-400"}`}>
              <span className="block text-xs opacity-80">
                {dateTh(m.meeting_date)}{upcoming ? ` · ${t("นัดหมาย", "Upcoming")}` : ""}
              </span>
              <span className="line-clamp-2 font-semibold">{m.title}</span>
            </button>
          );
        })}
      </aside>

      {/* ---------- editor ---------- */}
      {edit ? (
        <div className={`${card} space-y-3`}>
          <h2 className="text-lg font-bold">{edit.id ? t("แก้ไขบันทึกการประชุม", "Edit minutes") : t("การประชุมใหม่", "New meeting")}</h2>
          <div className="grid gap-2 md:grid-cols-[minmax(0,1fr)_200px]">
            <input className={inp} placeholder={t("หัวข้อการประชุม", "Title")} value={edit.title} onChange={(e) => setEdit({ ...edit, title: e.target.value })} />
            <input className={inp} type="date" value={edit.date} onChange={(e) => setEdit({ ...edit, date: e.target.value })} />
          </div>
          <div className="flex gap-2 text-sm">
            <button onClick={() => setPreview(false)} className={`rounded-md px-3 py-1 ${!preview ? "bg-[#14232E] text-[#CFE2F3]" : "border border-border"}`}>{t("เขียน", "Write")}</button>
            <button onClick={() => setPreview(true)} className={`rounded-md px-3 py-1 ${preview ? "bg-[#14232E] text-[#CFE2F3]" : "border border-border"}`}>{t("ดูตัวอย่าง", "Preview")}</button>
          </div>
          {preview ? (
            <div className={proseCls} dangerouslySetInnerHTML={{ __html: mdToHtml(edit.content) }} />
          ) : (
            <>
              <textarea className={`${inp} min-h-[420px] font-mono text-[13px] leading-relaxed`} value={edit.content}
                onChange={(e) => setEdit({ ...edit, content: e.target.value })}
                placeholder={t("วางเนื้อหาสรุปการประชุม หรือวาระการประชุมครั้งหน้า", "Paste the minutes or next meeting agenda")} />
              <p className="text-xs text-muted">
                {t("รูปแบบ: ## หัวข้อ · ### หัวข้อย่อย · - รายการ · 1. ลำดับ · **ตัวหนา** · | ตาราง | ตาราง | · --- เส้นคั่น", "Format: ## heading · - bullet · 1. numbered · **bold** · | table |")}
              </p>
            </>
          )}
          <div className="flex gap-2">
            <button disabled={busy || !edit.title.trim()} onClick={save} className="rounded-lg bg-[#14232E] px-4 py-2 text-sm font-semibold text-[#CFE2F3] disabled:opacity-50">
              {busy ? t("กำลังบันทึก…", "Saving…") : t("บันทึก", "Save")}
            </button>
            <button onClick={() => { setEdit(null); setPreview(false); }} className="rounded-lg border border-border px-4 py-2 text-sm font-semibold">{t("ยกเลิก", "Cancel")}</button>
          </div>
          {!edit.id && <p className="text-xs text-muted">{t("แนบไฟล์ (PDF / สไลด์ / รูป) ได้หลังกดบันทึก", "Attach files after saving")}</p>}
        </div>
      ) : cur ? (
        /* ---------- viewer ---------- */
        <div className={card}>
          <div className="flex flex-wrap items-start justify-between gap-3">
            <div>
              <p className="text-sm text-muted">{dateTh(cur.meeting_date)}{cur.meeting_date > today ? ` · ${t("การประชุมครั้งหน้า", "Next meeting")}` : ""}</p>
              <h2 className="text-xl font-extrabold">{cur.title}</h2>
            </div>
            <div className="flex flex-wrap gap-2">
              <button onClick={() => printSummary(cur.title, dateTh(cur.meeting_date), html)} className="rounded-lg border border-border px-3 py-2 text-sm font-semibold">
                {t("พิมพ์ / บันทึก PDF", "Print / PDF")}
              </button>
              {canEdit && (
                <>
                  <button onClick={() => { setEdit({ id: cur.id, title: cur.title, date: cur.meeting_date, content: cur.content }); setPreview(false); }}
                    className="rounded-lg bg-[#14232E] px-3 py-2 text-sm font-semibold text-[#CFE2F3]">{t("แก้ไข", "Edit")}</button>
                  <button onClick={() => remove(cur)} className="rounded-lg border border-border px-3 py-2 text-sm font-semibold text-danger">{t("ลบ", "Delete")}</button>
                </>
              )}
            </div>
          </div>

          <div className="mt-3 rounded-lg border border-dashed border-border p-2">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <span className="text-xs font-semibold text-muted">📎 {t("ไฟล์แนบ", "Attachments")} ({curFiles.length})</span>
              {canEdit && (
                <label className="cursor-pointer rounded-md border border-border bg-surface px-2.5 py-1 text-xs font-semibold hover:bg-surface-2">
                  + {t("อัปโหลด PDF / สไลด์ / รูป", "Upload")}
                  <input type="file" multiple className="hidden" accept="image/*,application/pdf,.ppt,.pptx,.doc,.docx,.xls,.xlsx"
                    onChange={(e) => { if (e.target.files?.length) upload(e.target.files); e.target.value = ""; }} />
                </label>
              )}
            </div>
            {curFiles.length > 0 && (
              <ul className="mt-1.5 space-y-1">
                {curFiles.map((f) => (
                  <li key={f.id} className="flex flex-wrap items-center gap-2 text-xs">
                    <span>{f.mime?.startsWith("image/") ? "🖼️" : "📄"}</span>
                    <button onClick={() => openF(f, false)} className="max-w-[320px] truncate font-semibold text-brand-600 hover:underline">{f.name}</button>
                    <button onClick={() => openF(f, true)} className="rounded border border-border px-1.5 py-0.5 hover:bg-surface-2">{t("ดาวน์โหลด", "Download")}</button>
                    {canEdit && <button onClick={() => removeF(f)} className="rounded border border-border px-1.5 py-0.5 text-danger hover:bg-surface-2">{t("ลบ", "Delete")}</button>}
                  </li>
                ))}
              </ul>
            )}
          </div>

          {cur.content.trim()
            ? <div className={proseCls} dangerouslySetInnerHTML={{ __html: html }} />
            : <p className="mt-3 text-sm text-muted">{t("ยังไม่มีเนื้อหา", "No content yet")}</p>}
        </div>
      ) : (
        <div className="rounded-xl border border-dashed border-border px-4 py-12 text-center text-muted">{t("เลือกการประชุมจากรายการด้านซ้าย", "Pick a meeting")}</div>
      )}
    </div>
  );
}
