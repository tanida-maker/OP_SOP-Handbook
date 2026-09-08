-- ============================================================
-- AIRPORTELs SOP Hub — SOP-OPS 021 (Lost & Found) table overlap fix
--   The first table column had `white-space:nowrap`, so long category
--   text overflowed and overlapped the next column. Allow it to wrap and
--   make the tables horizontally scrollable.
-- Idempotent: precise CSS replace (no-op if already applied).
-- ============================================================
begin;
update sop.documents
set content_html = replace(
  content_html,
  '.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:140px;white-space:nowrap;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}',
  '.prose table.sop-tbl{display:block;overflow-x:auto;-webkit-overflow-scrolling:touch}
.prose table.sop-tbl td,.prose table.sop-tbl th{word-break:break-word}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:150px;max-width:300px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}'
)
where slug = 'lost-found-claim';
commit;
