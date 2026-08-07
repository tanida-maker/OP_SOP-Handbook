-- ============================================================
-- AIRPORTELs SOP Hub — standardized document control codes
--   Format: SOP-OPS-NNN/YYYY (3-digit, zero-padded, effective year)
--   Resolves the duplicate "021" (lost-found vs abandoned) and fills
--   in missing / inconsistent codes. Idempotent.
-- Run in the Supabase SQL Editor.
-- ============================================================
begin;

alter table sop.documents add column if not exists doc_code text;

update sop.documents set doc_code = 'SOP-OPS-001/2025' where slug = 'dress-code-guest-service';
update sop.documents set doc_code = 'SOP-OPS-002/2025' where slug = 'cashless-payment-policy';
update sop.documents set doc_code = 'SOP-OPS-003/2025' where slug = 'open-close-counter';
update sop.documents set doc_code = 'SOP-OPS-004/2025' where slug = 'emergency-airport';
update sop.documents set doc_code = 'SOP-OPS-005/2025' where slug = 'emergency-mall';
update sop.documents set doc_code = 'SOP-OPS-006/2025' where slug = 'inventory-stock-update';
update sop.documents set doc_code = 'SOP-OPS-007/2025' where slug = 'online-credit-card-payment';
update sop.documents set doc_code = 'SOP-OPS-008/2025' where slug = 'osl-radiation-badge';
update sop.documents set doc_code = 'SOP-OPS-009/2025' where slug = 'manual-baggage-check-xray-down';
update sop.documents set doc_code = 'SOP-OPS-010/2025' where slug = 'handheld-metal-detector';
update sop.documents set doc_code = 'SOP-OPS-011/2025' where slug = 'pos-order-receiving';
update sop.documents set doc_code = 'SOP-OPS-012/2025' where slug = 'authorized-person-pickup';
update sop.documents set doc_code = 'SOP-OPS-013/2025' where slug = 'yoowifi-service';
update sop.documents set doc_code = 'SOP-OPS-014/2025' where slug = 'safe-luggage-storage';
update sop.documents set doc_code = 'SOP-OPS-015/2025' where slug = 'cross-branch-travel-allowance';
update sop.documents set doc_code = 'SOP-OPS-016/2025' where slug = 'delayed-pickup-discount';
update sop.documents set doc_code = 'SOP-OPS-017/2025' where slug = 'edc-machine';
update sop.documents set doc_code = 'SOP-OPS-018/2025' where slug = 'same-day-delivery';
update sop.documents set doc_code = 'SOP-OPS-019/2025' where slug = 'booking-photo-rotate';
update sop.documents set doc_code = 'SOP-OPS-020/2026' where slug = 'dmk-airport-service';
update sop.documents set doc_code = 'SOP-OPS-021/2026' where slug = 'lost-found-claim';
update sop.documents set doc_code = 'SOP-OPS-022/2026' where slug = 'abandoned-luggage-disposal';
update sop.documents set doc_code = 'SOP-OPS-023/2026' where slug = 'complaint-handling';
update sop.documents set doc_code = 'SOP-OPS-024/2026' where slug = 'baggage-inspection-lock-report';
update sop.documents set doc_code = 'SOP-OPS-025/2026' where slug = 'ntw-5day-booking';
update sop.documents set doc_code = 'SOP-OPS-026/2025' where slug = 'respond-io-guide';
update sop.documents set doc_code = 'SOP-OPS-027/2025' where slug = '3cx-guide';
update sop.documents set doc_code = 'SOP-OPS-028/2025' where slug = 'luggage-delivery-google-sheet';
update sop.documents set doc_code = 'SOP-OPS-028.1/2025' where slug = 'google-sheet-donts';
update sop.documents set doc_code = 'T&C-2026' where slug = 'terms-and-conditions-2025';

notify pgrst, 'reload schema';
commit;
