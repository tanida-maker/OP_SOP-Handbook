-- ============================================================
-- Day-1 onboarding checklist — per-user tick state.
-- Run in Supabase SQL Editor (Scheduling project, schema sop). Re-runnable.
-- ============================================================
create table if not exists sop.checklist_progress (
  user_id    uuid not null references auth.users (id) on delete cascade,
  item_key   text not null,
  checked_at timestamptz not null default now(),
  primary key (user_id, item_key)
);
alter table sop.checklist_progress enable row level security;
drop policy if exists "checklist own" on sop.checklist_progress;
create policy "checklist own" on sop.checklist_progress
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
grant select, insert, delete on sop.checklist_progress to authenticated;

notify pgrst, 'reload schema';
