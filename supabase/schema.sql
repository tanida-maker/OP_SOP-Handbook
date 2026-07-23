-- ============================================================
-- AIRPORTELs SOP Hub — Database schema
-- Run this in the Supabase SQL Editor (Dashboard → SQL → New query).
-- Safe to re-run: uses "if not exists" / "or replace" where possible.
-- ============================================================

-- ---------- Extensions ----------
create extension if not exists "pgcrypto";

-- ============================================================
-- 1) PROFILES  (one row per auth user, holds the role)
-- ============================================================
create table if not exists public.profiles (
  id          uuid primary key references auth.users (id) on delete cascade,
  full_name   text,
  role        text not null default 'staff' check (role in ('admin', 'staff')),
  branch      text,
  created_at  timestamptz not null default now()
);

-- Auto-create a profile whenever a new auth user signs up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', new.email))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Helper: is the current user an admin? SECURITY DEFINER avoids RLS recursion.
create or replace function public.is_admin()
returns boolean
language sql
security definer set search_path = public
stable
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

-- ============================================================
-- 2) CATEGORIES
-- ============================================================
create table if not exists public.categories (
  id          uuid primary key default gen_random_uuid(),
  slug        text unique not null,
  name        text not null,
  description text,
  icon        text,          -- lucide-react icon name
  color       text,          -- optional accent hex
  sort_order  int not null default 100,
  created_at  timestamptz not null default now()
);

-- ============================================================
-- 3) DOCUMENTS  (SOP / WI / manuals)
-- ============================================================
create table if not exists public.documents (
  id                uuid primary key default gen_random_uuid(),
  slug              text unique not null,
  title             text not null,
  summary           text,
  category_id       uuid references public.categories (id) on delete set null,
  content_html      text not null default '',
  cover_image       text,
  tags              text[] default '{}',
  status            text not null default 'draft' check (status in ('draft', 'published')),
  is_onboarding     boolean not null default false,
  onboarding_order  int,
  version           int not null default 1,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  updated_by        uuid references auth.users (id) on delete set null
);

create index if not exists documents_category_idx on public.documents (category_id);
create index if not exists documents_status_idx on public.documents (status);
create index if not exists documents_onboarding_idx on public.documents (is_onboarding, onboarding_order);

-- Keep updated_at + version fresh on every edit.
create or replace function public.touch_document()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  if tg_op = 'UPDATE' then
    new.version := old.version + 1;
  end if;
  return new;
end;
$$;

drop trigger if exists documents_touch on public.documents;
create trigger documents_touch
  before update on public.documents
  for each row execute function public.touch_document();

-- ============================================================
-- 4) ANNOUNCEMENTS  (replaces the scheduling app's announcement box)
-- ============================================================
create table if not exists public.announcements (
  id            uuid primary key default gen_random_uuid(),
  title         text not null,
  body_html     text not null default '',
  level         text not null default 'info' check (level in ('info', 'warning', 'critical')),
  pinned        boolean not null default false,
  published     boolean not null default true,
  published_at  timestamptz default now(),
  created_at    timestamptz not null default now(),
  created_by    uuid references auth.users (id) on delete set null
);

-- ============================================================
-- 5) ROW LEVEL SECURITY
-- ============================================================
alter table public.profiles      enable row level security;
alter table public.categories    enable row level security;
alter table public.documents     enable row level security;
alter table public.announcements enable row level security;

-- ---- profiles ----
drop policy if exists "profiles read own or admin" on public.profiles;
create policy "profiles read own or admin" on public.profiles
  for select using (id = auth.uid() or public.is_admin());

drop policy if exists "profiles update own name" on public.profiles;
create policy "profiles update own name" on public.profiles
  for update using (id = auth.uid() or public.is_admin());

drop policy if exists "profiles admin manage" on public.profiles;
create policy "profiles admin manage" on public.profiles
  for all using (public.is_admin()) with check (public.is_admin());

-- ---- categories ----
drop policy if exists "categories read" on public.categories;
create policy "categories read" on public.categories
  for select using (auth.role() = 'authenticated');

drop policy if exists "categories admin write" on public.categories;
create policy "categories admin write" on public.categories
  for all using (public.is_admin()) with check (public.is_admin());

-- ---- documents ----
-- Staff see published docs; admins see everything.
drop policy if exists "documents read" on public.documents;
create policy "documents read" on public.documents
  for select using (
    (auth.role() = 'authenticated' and status = 'published')
    or public.is_admin()
  );

drop policy if exists "documents admin write" on public.documents;
create policy "documents admin write" on public.documents
  for all using (public.is_admin()) with check (public.is_admin());

-- ---- announcements ----
drop policy if exists "announcements read" on public.announcements;
create policy "announcements read" on public.announcements
  for select using (
    (auth.role() = 'authenticated' and published = true)
    or public.is_admin()
  );

drop policy if exists "announcements admin write" on public.announcements;
create policy "announcements admin write" on public.announcements
  for all using (public.is_admin()) with check (public.is_admin());

-- ============================================================
-- 6) STORAGE  (images + video for the manuals)
-- Public-read bucket so media embeds without downloads/signed URLs.
-- Only admins can upload/modify.
-- ============================================================
insert into storage.buckets (id, name, public)
values ('sop-media', 'sop-media', true)
on conflict (id) do nothing;

drop policy if exists "sop-media public read" on storage.objects;
create policy "sop-media public read" on storage.objects
  for select using (bucket_id = 'sop-media');

drop policy if exists "sop-media admin write" on storage.objects;
create policy "sop-media admin write" on storage.objects
  for insert with check (bucket_id = 'sop-media' and public.is_admin());

drop policy if exists "sop-media admin update" on storage.objects;
create policy "sop-media admin update" on storage.objects
  for update using (bucket_id = 'sop-media' and public.is_admin());

drop policy if exists "sop-media admin delete" on storage.objects;
create policy "sop-media admin delete" on storage.objects
  for delete using (bucket_id = 'sop-media' and public.is_admin());

-- ============================================================
-- 7) SEED DATA — categories based on the existing AIRPORTELs SOP library
-- ============================================================
insert into public.categories (slug, name, description, icon, sort_order) values
  ('onboarding',      'พนักงานใหม่ / Onboarding', 'เริ่มต้นที่นี่ — คู่มือสำหรับพนักงานเข้าใหม่', 'GraduationCap', 10),
  ('counter-service', 'บริการหน้าเคาน์เตอร์',      'การเปิด-ปิดเคาน์เตอร์ การรับฝาก-ส่งกระเป๋า และการบริการลูกค้า', 'Briefcase', 20),
  ('payment',         'การรับชำระเงิน',             'POS, EDC, บัตรเครดิต, QR, Alipay/WeChat และนโยบายไร้เงินสด', 'CreditCard', 30),
  ('delivery',        'บริการขนส่งสัมภาระ',          'การบันทึกออเดอร์ การจัดส่ง และกรณีรับล่าช้า', 'Truck', 40),
  ('inventory',       'สต๊อกและการรับของ',           'การอัปเดตสต๊อกและการรับของประจำสาขา', 'PackageCheck', 50),
  ('emergency',       'เหตุฉุกเฉิน',                 'ขั้นตอนปฏิบัติเมื่อเกิดเหตุฉุกเฉิน ณ จุดบริการ', 'Siren', 60),
  ('tools',           'เครื่องมือและระบบ',            'Respond.io, 3CX, Google Sheet และเครื่องมืออื่นๆ', 'Wrench', 70),
  ('standards',       'มาตรฐานพนักงาน',              'การแต่งกายและมาตรฐานการให้บริการ Guest Service', 'BadgeCheck', 80)
on conflict (slug) do nothing;

-- A welcome announcement so the board is not empty on first launch.
insert into public.announcements (title, body_html, level, pinned)
select 'ยินดีต้อนรับสู่ AIRPORTELs SOP Hub',
       '<p>ศูนย์รวมคู่มือการทำงาน (SOP/WI) สำหรับพนักงานหน้าสาขา เปิดดูได้ทั้งมือถือและคอมพิวเตอร์ โดยไม่ต้องดาวน์โหลด</p>',
       'info', true
where not exists (select 1 from public.announcements);

-- ============================================================
-- 8) BOOTSTRAP YOUR FIRST ADMIN
-- After you sign up / are added as a user, run (replace the email):
--   update public.profiles set role = 'admin'
--   where id = (select id from auth.users where email = 'op.dept@airportels.asia');
-- ============================================================
