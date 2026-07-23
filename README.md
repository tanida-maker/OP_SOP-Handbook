# AIRPORTELs SOP Hub

ศูนย์รวมคู่มือการทำงาน (SOP / WI / คู่มือ) สำหรับพนักงานหน้าสาขา AIRPORTELs
เปิดดูได้ทั้งมือถือและคอมพิวเตอร์ โดยไม่ต้องดาวน์โหลด แอดมินแก้ไข/อัปเดตเนื้อหาเองได้
รองรับรูปภาพและวิดีโอในคู่มือ พร้อมระบบ Onboarding พนักงานใหม่ และระบบประกาศ

Built with **Next.js 16** + **Supabase** (Database, Auth, Storage) + **Tailwind CSS**.

---

## คุณสมบัติ (Features)

- 📱 **ใช้ได้ทุกอุปกรณ์** — Responsive มือถือ/แท็บเล็ต/เดสก์ท็อป, มีโหมดสว่าง-มืด
- 🔐 **ต้องล็อกอินก่อนดู** — ใช้ Supabase Auth (email/password หรือ magic link)
- 📚 **หมวดหมู่ + ค้นหา** — จัดกลุ่ม SOP ตามงาน และค้นหาได้ทันที
- 🎬 **รูปภาพ + วิดีโอ** — แทรกรูป, อัปโหลดวิดีโอ, หรือฝัง YouTube ในคู่มือ
- 🎓 **Onboarding** — เส้นทางเรียนรู้แบบเป็นขั้นตอนสำหรับพนักงานใหม่ (มี checklist)
- 📢 **ประกาศ** — แทน announcement ในแอป scheduling
- ✏️ **Admin แก้ไขเองได้** — Rich text editor ไม่ต้องเขียนโค้ด

---

## การติดตั้ง (Setup)

### 1) สร้างโปรเจกต์ Supabase
1. ไปที่ [supabase.com](https://supabase.com) → New Project
2. เมื่อสร้างเสร็จ ไปที่ **Project Settings → API** จดค่า:
   - `Project URL`
   - `anon public` key

### 2) สร้างตารางฐานข้อมูล
1. ใน Supabase → **SQL Editor → New query**
2. คัดลอกเนื้อหาทั้งหมดจากไฟล์ [`supabase/schema.sql`](supabase/schema.sql) มาวาง แล้วกด **Run**
   - จะสร้างตาราง, สิทธิ์การเข้าถึง (RLS), storage bucket และหมวดหมู่เริ่มต้นให้อัตโนมัติ

### 3) ตั้งค่า Environment
คัดลอก `.env.local.example` เป็น `.env.local` แล้วใส่ค่าจากขั้นตอนที่ 1:
```
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=xxxx
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

### 4) รันในเครื่อง
```bash
npm install
npm run dev
```
เปิด http://localhost:3000

### 5) สร้างผู้ใช้ + ตั้งเป็น Admin คนแรก
1. ใน Supabase → **Authentication → Users → Add user** (ใส่อีเมล + รหัสผ่าน)
   หรือให้พนักงานกด "ส่งลิงก์เข้าสู่ระบบทางอีเมล" ที่หน้า Login
2. ตั้งให้เป็นแอดมิน โดยรันใน SQL Editor (แก้อีเมลให้ตรง):
   ```sql
   update public.profiles set role = 'admin'
   where id = (select id from auth.users where email = 'op.dept@airportels.asia');
   ```
3. ล็อกอิน → จะเห็นเมนู **ระบบจัดการ (Admin)**

---

## การเพิ่มพนักงาน (Users)

พนักงานทุกคนที่ถูกเพิ่มใน Supabase Authentication จะเป็น role `staff` โดยอัตโนมัติ
(ดูคู่มือได้ แต่แก้ไขไม่ได้) เฉพาะคนที่ตั้ง role เป็น `admin` เท่านั้นที่แก้ไขเนื้อหาได้

---

## Deploy ขึ้น Vercel

1. push โค้ดขึ้น GitHub
2. ไปที่ [vercel.com](https://vercel.com) → New Project → เลือก repo นี้
3. ใส่ Environment Variables (เหมือน `.env.local`) โดยตั้ง
   `NEXT_PUBLIC_SITE_URL` เป็นโดเมนจริง เช่น `https://airportels-sop.vercel.app`
4. ใน Supabase → **Authentication → URL Configuration** เพิ่ม Redirect URL:
   `https://<โดเมนของคุณ>/auth/callback`
5. Deploy

### เชื่อมกับแอป Scheduling
เพิ่มปุ่ม/ลิงก์ในแอป scheduling ชี้มาที่โดเมนของ SOP Hub เช่น
`<a href="https://airportels-sop.vercel.app">คู่มือการทำงาน (SOP)</a>`

> **Single Login (ล็อกอินเดียวกับ Scheduling):** ถ้าแอป scheduling ใช้ Supabase Auth อยู่แล้ว
> ให้ตั้งค่า SOP Hub ให้ใช้ **Supabase project เดียวกัน** (URL + anon key เดียวกัน)
> ผู้ใช้จะล็อกอินบัญชีเดียวใช้ได้ทั้งสองระบบทันที
> ดูรายละเอียดเพิ่มเติมที่ท้ายไฟล์นี้

---

## โครงสร้างโค้ด

```
src/
├── proxy.ts                  # auth gate (Next.js 16 "proxy" = เดิมคือ middleware)
├── lib/supabase/             # Supabase clients (browser/server/proxy)
├── components/               # UI ที่ใช้ร่วมกัน + Rich text editor (Tiptap)
└── app/
    ├── (main)/               # หน้าพนักงาน: หน้าแรก, หมวดหมู่, คู่มือ, ค้นหา, onboarding, ประกาศ
    ├── login/                # หน้าเข้าสู่ระบบ
    ├── auth/callback/        # รับ magic link
    └── admin/                # ระบบจัดการ (เฉพาะ admin)
supabase/schema.sql           # โครงสร้างฐานข้อมูล + สิทธิ์ + seed
```

---

## หมายเหตุด้านความปลอดภัย

- **Row Level Security (RLS)** เปิดทุกตาราง: staff เห็นเฉพาะเนื้อหาที่ "เผยแพร่แล้ว",
  เฉพาะ admin เท่านั้นที่เพิ่ม/แก้ไข/ลบได้ (ตรวจสอบซ้ำใน server actions ด้วย)
- **Storage bucket `sop-media`** ตั้งเป็น public-read เพื่อให้รูป/วิดีโอแสดงในหน้าเว็บได้ทันที
  (ใครมีลิงก์ไฟล์โดยตรงจะเปิดดูได้ — เหมาะกับสื่อการสอนภายในที่ไม่เป็นความลับ)
  หากต้องการปิด ให้เปลี่ยน bucket เป็น private แล้วปรับไปใช้ signed URL
