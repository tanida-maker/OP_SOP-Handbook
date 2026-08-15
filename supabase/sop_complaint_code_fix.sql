-- ============================================================
-- AIRPORTELs SOP Hub — Complaint Handling: fix document code 023 -> 026
--   Source (SOP: ขั้นตอนการปฏิบัติมาตราฐานการรับมือข้อร้องเรียน) states
--   Document Code SOP-OPS: 026/2026. Resolves the 023 clash with the
--   Abandoned Luggage SOP (which is the correct 023).
-- Idempotent: precise full-code replaces only; safe to re-run.
-- ============================================================
begin;
update sop.documents
set doc_code = 'SOP-OPS-026/2026',
    content_html = replace(replace(replace(content_html,
        'SOP-OPS-023/2026', 'SOP-OPS-026/2026'),
        'SOP-OPS: 023/2026', 'SOP-OPS: 026/2026'),
        'SOP-OPS 023/2026', 'SOP-OPS 026/2026'),
    summary = replace(replace(replace(summary,
        'SOP-OPS-023/2026', 'SOP-OPS-026/2026'),
        'SOP-OPS: 023/2026', 'SOP-OPS: 026/2026'),
        'SOP-OPS 023/2026', 'SOP-OPS 026/2026')
where slug = 'complaint-handling';
commit;
