-- ============================================================
-- Onboarding v2: role-based tracks + forced read acknowledgment
-- Run in Supabase SQL Editor (Scheduling project, schema sop). Re-runnable.
-- ============================================================

-- 1) role tags per document: 'gs' = Guest Service / Porter, 'cs' = Customer Service
alter table sop.documents add column if not exists onboarding_roles text[] not null default '{}';

-- 2) acknowledgment log (one row per user per doc)
create table if not exists sop.onboarding_acks (
  user_id  uuid not null references auth.users (id) on delete cascade,
  doc_id   uuid not null references sop.documents (id) on delete cascade,
  acked_at timestamptz not null default now(),
  primary key (user_id, doc_id)
);
alter table sop.onboarding_acks enable row level security;
drop policy if exists "acks own" on sop.onboarding_acks;
create policy "acks own" on sop.onboarding_acks
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
grant select, insert, delete on sop.onboarding_acks to authenticated;

-- 3) assign each onboarding doc to role track(s) + reading order
--    (edit freely later in the DB / admin)
update sop.documents set onboarding_roles = '{}', is_onboarding = false, onboarding_order = null
  where is_onboarding = true; -- reset, then reassign below

-- shared (both tracks) — read first
update sop.documents set onboarding_roles='{gs,cs}', is_onboarding=true, onboarding_order=10 where slug='dress-code-guest-service';

-- Guest Service / Porter track
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=20 where slug='open-close-counter';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=30 where slug='pos-order-receiving';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=40 where slug='edc-machine';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=50 where slug='luggage-delivery-google-sheet';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=60 where slug='authorized-person-pickup';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=70 where slug='dmk-airport-service';
update sop.documents set onboarding_roles='{gs}', is_onboarding=true, onboarding_order=80 where slug='emergency-airport';

-- Customer Service track
update sop.documents set onboarding_roles='{cs}', is_onboarding=true, onboarding_order=20 where slug='respond-io-guide';
update sop.documents set onboarding_roles='{cs}', is_onboarding=true, onboarding_order=30 where slug='3cx-guide';
update sop.documents set onboarding_roles='{cs}', is_onboarding=true, onboarding_order=40 where slug='online-credit-card-payment';
update sop.documents set onboarding_roles='{cs}', is_onboarding=true, onboarding_order=60 where slug='delayed-pickup-discount';
-- NOTE: cashless-payment-policy intentionally NOT in onboarding (removed from CS track).

notify pgrst, 'reload schema';
