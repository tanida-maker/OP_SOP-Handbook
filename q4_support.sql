-- ============================================================
-- AIRPORTELs SOP Hub — Q4 & New Year Branch/Team Support Request
-- Adds 3 tables to the existing isolated "sop" schema of the
-- SHARED Supabase project (same project as Scheduling + SOP Hub).
--
-- SAFE BY DESIGN:
--   * Creates only sop.q4_* objects. Does NOT touch public.*,
--     auth triggers, or any existing sop table/policy.
--   * Reuses auth.users  -> staff log in with their existing account.
--   * Central team = existing SOP admins (sop.is_admin()).
--   * "sop" is already an exposed API schema, so no settings change.
-- Re-runnable.
-- ============================================================

-- ---------- 1. Issues submitted by branches / teams ----------
create table if not exists sop.q4_entries (
  id            uuid primary key default gen_random_uuid(),
  branch        text not null check (branch in
                 ('DMK','BKK','HKTI','HKTD','CNX','T21','EMS','CTWH','CTWG','MBK','ICS','MIXT','Online - CS')),
  service_area  text not null check (service_area in
                 ('Guest Service','Porter','CS / Customer Service','Online - CS','Branch Management','Operation Support','Other')),
  category      text not null,
  period        text,
  issue         text not null check (length(trim(issue)) > 0),
  impact        text not null check (length(trim(impact)) > 0),
  support       text not null check (length(trim(support)) > 0),
  prep          text,
  priority      text not null check (priority in ('High','Medium','Low')),
  notes         text,
  created_by    uuid default auth.uid() references auth.users (id) on delete set null,
  created_name  text,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now(),
  -- Porter is only valid for DMK / BKK (per the Q4 brief)
  constraint q4_porter_branch check (service_area <> 'Porter' or branch in ('DMK','BKK'))
);
create index if not exists q4_entries_branch_idx on sop.q4_entries (branch);
create index if not exists q4_entries_created_idx on sop.q4_entries (created_at);

create or replace function sop.q4_touch()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  new.created_by := old.created_by;   -- owner can never be reassigned
  new.created_at := old.created_at;
  return new;
end;
$$;
drop trigger if exists q4_entries_touch on sop.q4_entries;
create trigger q4_entries_touch before update on sop.q4_entries
  for each row execute function sop.q4_touch();

-- ---------- 2. Central review per issue (status / team / action) ----------
create table if not exists sop.q4_reviews (
  entry_id    uuid primary key references sop.q4_entries (id) on delete cascade,
  status      text not null default 'New' check (status in
               ('New','Under Review','In Progress','Waiting for Support','Completed','Not Required')),
  team        text check (team is null or team in
               ('OP','CS','Online-CS','HR','IT','Transport','Purchasing','Marketing / Media','Management','Other')),
  action      text,
  updated_by  uuid default auth.uid() references auth.users (id) on delete set null,
  updated_at  timestamptz not null default now()
);

-- ---------- 3. Central support plan per category ----------
create table if not exists sop.q4_plans (
  category    text primary key,
  plan        text not null default '',
  updated_by  uuid default auth.uid() references auth.users (id) on delete set null,
  updated_at  timestamptz not null default now()
);

-- ---------- Profile helper: name + branch of the logged-in user ----------
-- Returns the caller's own public.profiles row as JSON (works whatever
-- columns the Scheduling app's profiles table has).
create or replace function sop.q4_my_profile()
returns jsonb
language sql
security definer
set search_path = public, sop
stable
as $$
  select to_jsonb(p) from public.profiles p where p.id = auth.uid();
$$;

-- ============================================================
-- Row Level Security
-- ============================================================
alter table sop.q4_entries enable row level security;
alter table sop.q4_reviews enable row level security;
alter table sop.q4_plans   enable row level security;

-- Entries: every logged-in staff reads all (shared dashboard),
-- inserts as themselves, edits/deletes only their own; SOP admins all.
drop policy if exists "q4 entries read"   on sop.q4_entries;
create policy "q4 entries read" on sop.q4_entries
  for select using (auth.role() = 'authenticated');
drop policy if exists "q4 entries insert" on sop.q4_entries;
create policy "q4 entries insert" on sop.q4_entries
  for insert with check (auth.uid() is not null and created_by = auth.uid());
drop policy if exists "q4 entries update" on sop.q4_entries;
create policy "q4 entries update" on sop.q4_entries
  for update using (created_by = auth.uid() or sop.is_admin())
  with check (created_by = auth.uid() or sop.is_admin());
drop policy if exists "q4 entries delete" on sop.q4_entries;
create policy "q4 entries delete" on sop.q4_entries
  for delete using (created_by = auth.uid() or sop.is_admin());

-- Reviews & plans: everyone reads, only SOP admins (central team) write.
drop policy if exists "q4 reviews read"  on sop.q4_reviews;
create policy "q4 reviews read" on sop.q4_reviews
  for select using (auth.role() = 'authenticated');
drop policy if exists "q4 reviews write" on sop.q4_reviews;
create policy "q4 reviews write" on sop.q4_reviews
  for all using (sop.is_admin()) with check (sop.is_admin());

drop policy if exists "q4 plans read"  on sop.q4_plans;
create policy "q4 plans read" on sop.q4_plans
  for select using (auth.role() = 'authenticated');
drop policy if exists "q4 plans write" on sop.q4_plans;
create policy "q4 plans write" on sop.q4_plans
  for all using (sop.is_admin()) with check (sop.is_admin());

-- ============================================================
-- Grants (RLS still governs row access). No anon access.
-- ============================================================
revoke all on sop.q4_entries, sop.q4_reviews, sop.q4_plans from anon;
grant select, insert, update, delete on sop.q4_entries, sop.q4_reviews, sop.q4_plans to authenticated;
revoke all on function sop.q4_my_profile() from public, anon;
grant execute on function sop.q4_my_profile() to authenticated;

-- ============================================================
-- Realtime: push inserts/updates/deletes to every open dashboard
-- ============================================================
alter table sop.q4_entries replica identity full;
alter table sop.q4_reviews replica identity full;
alter table sop.q4_plans   replica identity full;
do $$
declare t text;
begin
  foreach t in array array['q4_entries','q4_reviews','q4_plans'] loop
    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime' and schemaname = 'sop' and tablename = t
    ) then
      execute format('alter publication supabase_realtime add table sop.%I', t);
    end if;
  end loop;
end $$;

notify pgrst, 'reload schema';
