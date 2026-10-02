"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { ClipboardList, Download, ListChecks, Loader2, PieChart, Radio } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useT } from "@/components/LanguageProvider";
import {
  Q4_AREA_HELP, Q4_BRANCHES, Q4_CATEGORIES, Q4_CATEGORY_NAMES, Q4_CLOSED, Q4_PRIORITIES,
  Q4_STATUSES, Q4_STATUS_TH, Q4_TEAMS, q4AreasFor,
  type Q4Entry, type Q4Plan, type Q4Priority, type Q4Review,
} from "@/lib/q4";

type Tab = "form" | "list" | "summary";
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

export default function Q4App({
  userId, isAdmin, fullName,
}: { userId: string | null; isAdmin: boolean; fullName: string }) {
  const t = useT();
  const supabase = useMemo(() => createClient(), []);

  const [tab, setTab] = useState<Tab>("form");
  const [entries, setEntries] = useState<Q4Entry[]>([]);
  const [reviews, setReviews] = useState<Record<string, Q4Review>>({});
  const [plans, setPlans] = useState<Record<string, Q4Plan>>({});
  const [loading, setLoading] = useState(true);
  const [live, setLive] = useState(false);
  const [loadErr, setLoadErr] = useState("");
  const [myName, setMyName] = useState(fullName);
  const [toast, setToast] = useState("");

  // ---------- data ----------
  const loadAll = useCallback(async () => {
    const [e, r, p] = await Promise.all([
      supabase.from("q4_entries").select("*").order("created_at", { ascending: false }),
      supabase.from("q4_reviews").select("*"),
      supabase.from("q4_plans").select("*"),
    ]);
    if (e.error) { setLoadErr(e.error.message); setLoading(false); return; }
    setLoadErr("");
    setEntries((e.data ?? []) as Q4Entry[]);
    const rm: Record<string, Q4Review> = {};
    (r.data ?? []).forEach((x) => { rm[(x as Q4Review).entry_id] = x as Q4Review; });
    setReviews(rm);
    const pm: Record<string, Q4Plan> = {};
    (p.data ?? []).forEach((x) => { pm[(x as Q4Plan).category] = x as Q4Plan; });
    setPlans(pm);
    setLoading(false);
  }, [supabase]);

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

  async function saveReview(id: string, status: string, team: string, action: string) {
    const { error } = await supabase.from("q4_reviews").upsert({
      entry_id: id, status, team: team || null, action: action.trim() || null,
      updated_by: userId, updated_at: new Date().toISOString(),
    });
    if (error) flash(t("อัปเดตไม่สำเร็จ: ", "Update failed: ") + error.message);
    else { flash(t("อัปเดตสถานะแล้ว", "Status updated")); loadAll(); }
  }

  async function savePlan(category: string, plan: string) {
    if ((plans[category]?.plan ?? "") === plan.trim()) return;
    const { error } = await supabase.from("q4_plans").upsert({
      category, plan: plan.trim(), updated_by: userId, updated_at: new Date().toISOString(),
    });
    if (error) flash(t("บันทึกแผนไม่สำเร็จ", "Plan save failed")); else { flash(t("บันทึกแผน Support แล้ว", "Plan saved")); loadAll(); }
  }

  const statusOf = useCallback((e: Q4Entry) => reviews[e.id]?.status ?? "New", [reviews]);
  const teamOf = useCallback((e: Q4Entry) => reviews[e.id]?.team ?? "", [reviews]);

  // ---------- export (CSV in Lark import column order) ----------
  function exportCsv() {
    const head = [
      "No.", "Branch / Team", "Service Area", "Category", "Issue / Situation from Previous Year", "Impact",
      "Support Required from Central", "Priority", "Proposed Solution / Preparation", "Responsible Team",
      "Status", "Additional Notes", "Period", "Central Action", "Submitted By", "Submitted At",
    ];
    const rows = [...entries]
      .sort((a, b) => a.created_at.localeCompare(b.created_at))
      .map((e, i) => [
        String(i + 1), e.branch, e.service_area, e.category, e.issue, e.impact, e.support, e.priority,
        e.prep ?? "", teamOf(e), statusOf(e), e.notes ?? "", e.period ?? "", reviews[e.id]?.action ?? "",
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
                onClick={() => { setFBranch(b); setTab("list"); }}
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
        ] as const).map(([k, label, Icon]) => (
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
          entries={entries} reviews={reviews} loading={loading} userId={userId} isAdmin={isAdmin}
          statusOf={statusOf} fBranch={fBranch} setFBranch={setFBranch}
          onEdit={startEdit} onDelete={remove} onReview={saveReview}
        />
      )}
      {tab === "summary" && (
        <SummaryView
          entries={entries} plans={plans} isAdmin={isAdmin} statusOf={statusOf} teamOf={teamOf}
          onPlan={savePlan} onExport={exportCsv}
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
  entries, reviews, loading, userId, isAdmin, statusOf, fBranch, setFBranch, onEdit, onDelete, onReview,
}: {
  entries: Q4Entry[]; reviews: Record<string, Q4Review>; loading: boolean; userId: string | null; isAdmin: boolean;
  statusOf: (e: Q4Entry) => string; fBranch: string; setFBranch: (b: string) => void;
  onEdit: (e: Q4Entry) => void; onDelete: (e: Q4Entry) => void;
  onReview: (id: string, status: string, team: string, action: string) => void;
}) {
  const t = useT();
  const [q, setQ] = useState("");
  const [fCat, setFCat] = useState("");
  const [fPri, setFPri] = useState("");
  const [fSt, setFSt] = useState("");
  const [mine, setMine] = useState(false);

  const rows = useMemo(() => {
    const s = q.trim().toLowerCase();
    const rank: Record<string, number> = { High: 0, Medium: 1, Low: 2 };
    return entries
      .filter((e) =>
        (!fBranch || e.branch === fBranch) && (!fCat || e.category === fCat) && (!fPri || e.priority === fPri) &&
        (!fSt || statusOf(e) === fSt) && (!mine || e.created_by === userId) &&
        (!s || [e.branch, e.service_area, e.category, e.period, e.issue, e.impact, e.support, e.prep, e.notes, reviews[e.id]?.action]
          .join(" ").toLowerCase().includes(s)))
      .sort((a, b) => rank[a.priority] - rank[b.priority] || b.created_at.localeCompare(a.created_at));
  }, [entries, reviews, q, fBranch, fCat, fPri, fSt, mine, userId, statusOf]);

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
        <label className="flex items-center gap-1.5 text-sm text-muted">
          <input type="checkbox" checked={mine} onChange={(e) => setMine(e.target.checked)} /> {t("เฉพาะที่ฉันส่ง", "Mine only")}
        </label>
      </div>

      {!entries.length ? (
        <Empty title={t("ยังไม่มีข้อมูล", "No issues yet")} body={t("เริ่มจากแท็บ “กรอกข้อมูล” แล้วรายการจะขึ้นที่นี่ทันทีสำหรับทุกคน", "Submit the first issue and it appears here for everyone")} />
      ) : !rows.length ? (
        <Empty title={t("ไม่พบรายการที่ตรงกับตัวกรอง", "Nothing matches")} body={t("ลองล้างตัวกรองหรือคำค้นหา", "Clear the filters or search")} />
      ) : (
        <div className="space-y-3">
          {rows.map((e) => (
            <TagCard key={`${e.id}-${reviews[e.id]?.updated_at ?? ""}`} e={e} r={reviews[e.id]} status={statusOf(e)}
              canModify={isAdmin || (!!userId && e.created_by === userId)} isAdmin={isAdmin}
              onEdit={() => onEdit(e)} onDelete={() => onDelete(e)} onReview={onReview} />
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
  e, r, status, canModify, isAdmin, onEdit, onDelete, onReview,
}: {
  e: Q4Entry; r?: Q4Review; status: string; canModify: boolean; isAdmin: boolean;
  onEdit: () => void; onDelete: () => void; onReview: (id: string, status: string, team: string, action: string) => void;
}) {
  const t = useT();
  const [st, setSt] = useState(status);
  const [team, setTeam] = useState(r?.team ?? "");
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
            <b>Central action{r.team ? ` (${r.team})` : ""}:</b> {r.action}
          </div>
        )}
        {isAdmin && (
          <div className="mb-3 grid gap-2 rounded-lg bg-surface-2 p-3 md:grid-cols-[170px_170px_minmax(0,1fr)_auto] md:items-end">
            <label className="text-xs text-muted">{t("สถานะ", "Status")}
              <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={st} onChange={(x) => setSt(x.target.value)}>
                {Q4_STATUSES.map((s) => <option key={s}>{s}</option>)}
              </select>
            </label>
            <label className="text-xs text-muted">Responsible Team
              <select className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={team} onChange={(x) => setTeam(x.target.value)}>
                <option value="">{t("ยังไม่มอบหมาย", "Unassigned")}</option>
                {Q4_TEAMS.map((x) => <option key={x}>{x}</option>)}
              </select>
            </label>
            <label className="text-xs text-muted">Central action
              <input className="mt-0.5 w-full rounded-md border border-border bg-surface px-2 py-1.5 text-sm text-text" value={action}
                onChange={(x) => setAction(x.target.value)} placeholder={t("สิ่งที่ส่วนกลางจะทำ กำหนดเสร็จ", "What Central will do, by when")} />
            </label>
            <button onClick={() => onReview(e.id, st, team, action)} className="rounded-md bg-[#14232E] px-3 py-1.5 text-sm font-semibold text-[#CFE2F3]">
              {t("บันทึก", "Save")}
            </button>
          </div>
        )}
        <div className="flex flex-wrap items-center justify-between gap-2 border-t border-border pt-2.5 text-sm text-muted">
          <span>
            <span className={`rounded-full border px-2.5 py-0.5 text-xs font-bold ${
              status === "Completed" ? "border-ok bg-ok/10 text-ok" : closed ? "border-border" : status === "Waiting for Support" ? "border-warn bg-warn/10 text-text" : "border-border bg-surface-2 text-text"}`}>
              {status} · {Q4_STATUS_TH[status]}
            </span>
            {r?.team && !r.action && <span className="ml-2">{t("ทีม", "Team")}: {r.team}</span>}
          </span>
          <span className="flex items-center gap-2">
            {e.created_name || t("พนักงาน", "Staff")}, {fmt(e.created_at)}{e.updated_at !== e.created_at && ` (${t("แก้ไขแล้ว", "edited")})`}
            {canModify && (
              <>
                <button onClick={onEdit} className="rounded-md border border-border px-2 py-0.5 text-text hover:bg-surface-2">{t("แก้ไข", "Edit")}</button>
                <button onClick={onDelete} className="rounded-md border border-border px-2 py-0.5 text-danger hover:bg-surface-2">{t("ลบ", "Delete")}</button>
              </>
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
function Bars({ pairs, redKey }: { pairs: [string, number][]; redKey?: string }) {
  const max = Math.max(1, ...pairs.map((p) => p[1]));
  if (!pairs.length) return <p className="text-sm text-muted">-</p>;
  return (
    <div className="space-y-2">
      {pairs.map(([k, v]) => (
        <div key={k} className="grid grid-cols-[140px_minmax(0,1fr)_32px] items-center gap-2.5 text-sm">
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
  entries, plans, isAdmin, statusOf, teamOf, onPlan, onExport,
}: {
  entries: Q4Entry[]; plans: Record<string, Q4Plan>; isAdmin: boolean;
  statusOf: (e: Q4Entry) => string; teamOf: (e: Q4Entry) => string;
  onPlan: (c: string, p: string) => void; onExport: () => void;
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
          <p className="mb-3 text-sm text-muted">{t("เฉพาะประเด็นที่ยังไม่ปิด", "Open issues only")}</p>
          <Bars pairs={tally((e) => teamOf(e) || unassigned, open)} redKey={unassigned} />
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
