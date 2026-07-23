# คู่มือเปิดใช้งานจริง (Supabase + Vercel)

ทำตามลำดับนี้ ใช้เวลารวมประมาณ 15–20 นาที

---

## ส่วนที่ 1 — Supabase (ฐานข้อมูล + ล็อกอิน + ที่เก็บรูป/วิดีโอ)

### 1.1 สร้างโปรเจกต์
- ไปที่ https://supabase.com → **Sign in** → **New project**
- ตั้งชื่อ เช่น `airportels-sop` เลือก Region ใกล้ไทย (`Southeast Asia (Singapore)`)
- ตั้ง Database password (จดเก็บไว้) → **Create new project** (รอสัก 1–2 นาที)

### 1.2 คัดลอกคีย์
- เมนูซ้าย → **Project Settings** (รูปเฟือง) → **API**
- คัดลอก 2 ค่านี้ไว้:
  - **Project URL** → `https://xxxxx.supabase.co`
  - **anon public** key (ยาวๆ)

### 1.3 สร้างตาราง + ข้อมูลเริ่มต้น
- เมนูซ้าย → **SQL Editor** → **New query**
- เปิดไฟล์ [`supabase/schema.sql`](supabase/schema.sql) คัดลอกทั้งหมด → วาง → **Run** (ต้องขึ้น Success)
- **New query** อีกครั้ง → เปิดไฟล์ [`supabase/seed_documents.sql`](supabase/seed_documents.sql) (คู่มือที่ย้ายมาจาก PDF) → วาง → **Run**

### 1.4 ตั้งค่าล็อกอิน
- เมนูซ้าย → **Authentication** → **Providers** → เปิด **Email** (ค่าเริ่มต้นเปิดอยู่)
- ถ้าอยากให้ทดสอบง่ายช่วงแรก: **Authentication → Sign In / Providers → Email** ปิด "Confirm email" ชั่วคราวได้

### 1.5 สร้างผู้ใช้ + ตั้งเป็นแอดมิน
- **Authentication → Users → Add user** ใส่อีเมล `op.dept@airportels.asia` + รหัสผ่าน
- กลับไป **SQL Editor** รันคำสั่งนี้เพื่อตั้งเป็นแอดมิน:
  ```sql
  update public.profiles set role = 'admin'
  where id = (select id from auth.users where email = 'op.dept@airportels.asia');
  ```

---

## ส่วนที่ 2 — รันทดสอบในเครื่อง (ไม่บังคับ แต่แนะนำ)

แก้ไฟล์ `.env.local` ในโฟลเดอร์โปรเจกต์ ใส่ค่าจากข้อ 1.2:
```
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon public key>
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```
แล้วรัน:
```bash
npm run dev
```
เปิด http://localhost:3000 → ล็อกอิน → ควรเห็นคู่มือทั้งหมด และเมนู Admin

---

## ส่วนที่ 3 — Deploy ขึ้น Vercel

### 3.1 push โค้ดขึ้น GitHub
- สร้าง repo ใหม่ (ว่างๆ) ที่ https://github.com/new เช่นชื่อ `airportels-sop-hub` (ตั้งเป็น Private ได้)
- ในโฟลเดอร์โปรเจกต์ รัน (แทน `<URL>` ด้วยของ repo คุณ):
  ```bash
  git remote add origin <URL ของ repo>
  git branch -M main
  git push -u origin main
  ```

### 3.2 เชื่อม Vercel
- ไปที่ https://vercel.com → **Add New… → Project** → **Import** repo ที่เพิ่ง push
- ในหน้า config → **Environment Variables** ใส่ 3 ตัว:
  | Name | Value |
  |---|---|
  | `NEXT_PUBLIC_SUPABASE_URL` | (Project URL จากข้อ 1.2) |
  | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | (anon key จากข้อ 1.2) |
  | `NEXT_PUBLIC_SITE_URL` | `https://<โดเมนที่ Vercel จะให้>` |
- กด **Deploy** (รอ 1–2 นาที)

### 3.3 ตั้ง redirect ให้ล็อกอินทำงานบนโดเมนจริง
- Supabase → **Authentication → URL Configuration**
  - **Site URL**: `https://<โดเมนของคุณ>`
  - **Redirect URLs**: เพิ่ม `https://<โดเมนของคุณ>/auth/callback`

---

## ส่วนที่ 4 — เชื่อมกับแอป Scheduling

เพิ่มปุ่ม/ลิงก์ในแอป scheduling ชี้มาที่โดเมน SOP Hub เช่น:
```html
<a href="https://<โดเมน SOP Hub>" target="_blank">📚 คู่มือการทำงาน (SOP)</a>
```

### ล็อกอินเดียวกับ Scheduling (Single Login)
ถ้าแอป scheduling **ใช้ Supabase Auth อยู่แล้ว**: ให้ SOP Hub ใช้ **Supabase project เดียวกัน**
(ใส่ URL + anon key ตัวเดียวกันในข้อ 3.2) — ผู้ใช้จะล็อกอินบัญชีเดียวใช้ได้ทั้งสองระบบทันที
ถ้าใช้ระบบอื่น แจ้งมาได้ จะได้วางแผนวิธีเชื่อมที่เหมาะสม

---

## เพิ่มรูป/วิดีโอในคู่มือ (หลังระบบขึ้นแล้ว)
คู่มือที่ย้ายจาก PDF จะมีเครื่องหมาย `[📷 ภาพประกอบ: ...]` ตรงจุดที่ควรมีรูป
เข้า **Admin → คู่มือ → แก้ไข** แล้วใช้ปุ่มแทรกรูป/วิดีโอในตัวแก้ไข วางรูปแทนเครื่องหมายนั้นได้เลย
