-- ============================================================
-- AIRPORTELs SOP Hub — ISOLATED schema for the SHARED Supabase project
-- (the same project the Scheduling app uses).
--
-- SAFE BY DESIGN:
--   * Everything lives in a dedicated "sop" schema.
--   * Does NOT touch public.profiles / public.announcements / public.staff /
--     public.wiki, nor the existing is_admin()/handle_new_user() functions,
--     nor the on_auth_user_created trigger.
--   * Creates NO trigger on auth.users.
--   * Reuses the shared auth.users (→ single login with Scheduling).
--
-- Run this in the Supabase SQL Editor of the shared project.
-- Re-runnable.
-- ============================================================

create schema if not exists sop;
grant usage on schema sop to anon, authenticated;

-- ---------- admins (who can edit SOP content) ----------
create table if not exists sop.admins (
  user_id  uuid primary key references auth.users (id) on delete cascade,
  added_at timestamptz not null default now()
);

-- SOP-admin check (independent from the Scheduling app's is_admin()).
create or replace function sop.is_admin()
returns boolean
language sql
security definer
set search_path = sop, public
stable
as $$
  select exists (select 1 from sop.admins where user_id = auth.uid());
$$;

-- ---------- categories ----------
create table if not exists sop.categories (
  id          uuid primary key default gen_random_uuid(),
  slug        text unique not null,
  name        text not null,
  description text,
  icon        text,
  color       text,
  sort_order  int not null default 100,
  created_at  timestamptz not null default now()
);

-- ---------- documents (SOP / WI / manuals) ----------
create table if not exists sop.documents (
  id                uuid primary key default gen_random_uuid(),
  slug              text unique not null,
  title             text not null,
  summary           text,
  category_id       uuid references sop.categories (id) on delete set null,
  content_html      text not null default '',
  cover_image       text,
  tags              text[] default '{}',
  status            text not null default 'draft' check (status in ('draft','published')),
  is_onboarding     boolean not null default false,
  onboarding_order  int,
  version           int not null default 1,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  updated_by        uuid references auth.users (id) on delete set null
);
create index if not exists sop_documents_category_idx on sop.documents (category_id);
create index if not exists sop_documents_status_idx on sop.documents (status);
create index if not exists sop_documents_onboarding_idx on sop.documents (is_onboarding, onboarding_order);

create or replace function sop.touch_document()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  if tg_op = 'UPDATE' then new.version := old.version + 1; end if;
  return new;
end;
$$;
drop trigger if exists sop_documents_touch on sop.documents;
create trigger sop_documents_touch
  before update on sop.documents
  for each row execute function sop.touch_document();

-- ---------- announcements (SOP Hub's own, separate from public.announcements) ----------
create table if not exists sop.announcements (
  id            uuid primary key default gen_random_uuid(),
  title         text not null,
  body_html     text not null default '',
  level         text not null default 'info' check (level in ('info','warning','critical')),
  pinned        boolean not null default false,
  published     boolean not null default true,
  published_at  timestamptz default now(),
  created_at    timestamptz not null default now(),
  created_by    uuid references auth.users (id) on delete set null
);

-- ============================================================
-- Row Level Security
-- ============================================================
alter table sop.admins        enable row level security;
alter table sop.categories    enable row level security;
alter table sop.documents     enable row level security;
alter table sop.announcements enable row level security;

drop policy if exists "sop admins self-read" on sop.admins;
create policy "sop admins self-read" on sop.admins
  for select using (user_id = auth.uid() or sop.is_admin());
drop policy if exists "sop admins manage" on sop.admins;
create policy "sop admins manage" on sop.admins
  for all using (sop.is_admin()) with check (sop.is_admin());

drop policy if exists "sop categories read" on sop.categories;
create policy "sop categories read" on sop.categories
  for select using (auth.role() = 'authenticated');
drop policy if exists "sop categories write" on sop.categories;
create policy "sop categories write" on sop.categories
  for all using (sop.is_admin()) with check (sop.is_admin());

drop policy if exists "sop documents read" on sop.documents;
create policy "sop documents read" on sop.documents
  for select using (
    (auth.role() = 'authenticated' and status = 'published') or sop.is_admin()
  );
drop policy if exists "sop documents write" on sop.documents;
create policy "sop documents write" on sop.documents
  for all using (sop.is_admin()) with check (sop.is_admin());

drop policy if exists "sop announcements read" on sop.announcements;
create policy "sop announcements read" on sop.announcements
  for select using (
    (auth.role() = 'authenticated' and published = true) or sop.is_admin()
  );
drop policy if exists "sop announcements write" on sop.announcements;
create policy "sop announcements write" on sop.announcements
  for all using (sop.is_admin()) with check (sop.is_admin());

-- ============================================================
-- Grants (RLS still governs row access)
-- ============================================================
grant select, insert, update, delete on all tables in schema sop to authenticated;
grant select on all tables in schema sop to anon;
alter default privileges in schema sop
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema sop grant select on tables to anon;
grant execute on function sop.is_admin() to anon, authenticated;

-- ============================================================
-- Storage bucket for images/video (public-read; only SOP admins write)
-- ============================================================
insert into storage.buckets (id, name, public)
values ('sop-media', 'sop-media', true)
on conflict (id) do nothing;

drop policy if exists "sop-media public read" on storage.objects;
create policy "sop-media public read" on storage.objects
  for select using (bucket_id = 'sop-media');
drop policy if exists "sop-media admin write" on storage.objects;
create policy "sop-media admin write" on storage.objects
  for insert with check (bucket_id = 'sop-media' and sop.is_admin());
drop policy if exists "sop-media admin update" on storage.objects;
create policy "sop-media admin update" on storage.objects
  for update using (bucket_id = 'sop-media' and sop.is_admin());
drop policy if exists "sop-media admin delete" on storage.objects;
create policy "sop-media admin delete" on storage.objects
  for delete using (bucket_id = 'sop-media' and sop.is_admin());

-- ============================================================
-- Seed categories
-- ============================================================
insert into sop.categories (slug, name, description, icon, sort_order) values
  ('onboarding',      'พนักงานใหม่ / Onboarding', 'เริ่มต้นที่นี่ — คู่มือสำหรับพนักงานเข้าใหม่', 'GraduationCap', 10),
  ('counter-service', 'บริการหน้าเคาน์เตอร์',      'การเปิด-ปิดเคาน์เตอร์ การรับฝาก-ส่งกระเป๋า และการบริการลูกค้า', 'Briefcase', 20),
  ('payment',         'การรับชำระเงิน',             'POS, EDC, บัตรเครดิต, QR, Alipay/WeChat และนโยบายไร้เงินสด', 'CreditCard', 30),
  ('delivery',        'บริการขนส่งสัมภาระ',          'การบันทึกออเดอร์ การจัดส่ง และกรณีรับล่าช้า', 'Truck', 40),
  ('inventory',       'สต๊อกและการรับของ',           'การอัปเดตสต๊อกและการรับของประจำสาขา', 'PackageCheck', 50),
  ('emergency',       'เหตุฉุกเฉิน',                 'ขั้นตอนปฏิบัติเมื่อเกิดเหตุฉุกเฉิน ณ จุดบริการ', 'Siren', 60),
  ('tools',           'เครื่องมือและระบบ',            'Respond.io, 3CX, Google Sheet และเครื่องมืออื่นๆ', 'Wrench', 70),
  ('standards',       'มาตรฐานพนักงาน',              'การแต่งกายและมาตรฐานการให้บริการ Guest Service', 'BadgeCheck', 80)
on conflict (slug) do nothing;

insert into sop.announcements (title, body_html, level, pinned)
select 'ยินดีต้อนรับสู่ AIRPORTELs SOP Hub',
       '<p>ศูนย์รวมคู่มือการทำงาน (SOP/WI) สำหรับพนักงานหน้าสาขา เปิดดูได้ทั้งมือถือและคอมพิวเตอร์ โดยไม่ต้องดาวน์โหลด</p>',
       'info', true
where not exists (select 1 from sop.announcements);

-- ============================================================
-- Bootstrap SOP admins
--   1) everyone who is already an admin in the Scheduling app
--   2) the known operations accounts (edit if needed)
-- ============================================================
insert into sop.admins (user_id)
select u.id from auth.users u
join public.profiles p on p.id = u.id
where p.is_admin = true
on conflict do nothing;

insert into sop.admins (user_id)
select id from auth.users
where email in ('op.dept@airportels.asia', 'tanida@airportels.co')
on conflict do nothing;

-- Tell PostgREST to pick up the new schema immediately.
notify pgrst, 'reload schema';
