# คู่มือเปิดใช้งานจริง (ใช้ Supabase ร่วมกับแอป Scheduling + Vercel)

> **โหมดที่ใช้:** SOP Hub ใช้ **Supabase project เดียวกับแอป Scheduling** โดยแยกตารางไว้ใน
> schema ชื่อ `sop` (ไม่แตะตารางเดิม `profiles`/`staff`/`announcements`/`wiki`)
> → พนักงานล็อกอินด้วยบัญชีเดิมได้ทันที (single login)

---

## ส่วนที่ 1 — ตั้งค่าฐานข้อมูล (ในโปรเจกต์ Scheduling)

### 1.1 รัน SQL 2 ไฟล์
เปิดโปรเจกต์ Scheduling ใน Supabase → **SQL Editor → New query**

1. เปิด [`supabase/schema_sop.sql`](supabase/schema_sop.sql) → ก๊อปทั้งหมด → วาง → **Run**
   (สร้าง schema `sop` + ตาราง + สิทธิ์ + storage + หมวดหมู่ + ตั้งแอดมินให้อัตโนมัติ)
2. **New query** อีกครั้ง → เปิด [`supabase/seed_documents.sql`](supabase/seed_documents.sql) → วาง → **Run**
   (ใส่คู่มือ 17 ฉบับที่ย้ายจาก PDF)

> ⚠️ **อย่ารัน** `supabase/schema.sql` (ตัวเก่า) กับโปรเจกต์นี้ — มันสร้างตาราง/ฟังก์ชันใน `public`
> ที่ชื่อซ้ำกับของ Scheduling และจะทำให้แอป Scheduling พัง ใช้เฉพาะ `schema_sop.sql` เท่านั้น

### 1.2 เปิดใช้งาน schema `sop` ใน API  ← **สำคัญ! ห้ามข้าม**
**Project Settings → API** → หัวข้อ **Exposed schemas** (หรือ "Data API")
→ เพิ่ม `sop` เข้าไปในรายการ (ให้มีทั้ง `public`, `graphql_public`, `sop`) → **Save**
(ถ้าไม่ทำ แอปจะมองไม่เห็นตารางใน schema `sop`)

### 1.3 คัดลอกคีย์
**Project Settings → API** → ก๊อป **Project URL** และ **anon public** key

### 1.4 แอดมิน
`schema_sop.sql` ตั้งแอดมินให้อัตโนมัติแล้ว = (ก) ทุกคนที่ `is_admin = true` ในตาราง profiles เดิม
และ (ข) `op.dept@airportels.asia`, `tanida@airportels.co`

เพิ่มแอดมินคนอื่นภายหลัง (รันใน SQL Editor):
```sql
insert into sop.admins (user_id)
select id from auth.users where email = 'someone@airportels.asia'
on conflict do nothing;
```

---

## ส่วนที่ 2 — รันทดสอบในเครื่อง

แก้ `.env.local` (ค่าจากข้อ 1.3):
```
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon public key>
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```
```bash
npm run dev
```
เปิด http://localhost:3000 → ล็อกอินด้วยบัญชีพนักงานที่มีอยู่ → เห็นคู่มือ + เมนู Admin (ถ้าเป็นแอดมิน)

---

## ส่วนที่ 3 — Deploy ขึ้น Vercel

1. https://vercel.com → **Add New → Project** → Import repo `OP_SOP-Handbook`
2. Next.js ตรวจเจอเอง — ไม่ต้องแก้ Root Directory
3. **Environment Variables** ใส่ 3 ตัว:

   | Name | Value |
   |---|---|
   | `NEXT_PUBLIC_SUPABASE_URL` | Project URL |
   | `NEXT_PUBLIC_SUPABASE_ANON_KEY` | anon public key |
   | `NEXT_PUBLIC_SITE_URL` | โดเมนจริงของ Vercel (ใส่ทีหลังได้) |

4. **Deploy**
5. Supabase → **Authentication → URL Configuration**
   - เพิ่ม Redirect URL: `https://<โดเมน>/auth/callback`
   - (Site URL ของ Scheduling เดิมยังอยู่ได้ เพิ่ม redirect ใหม่เข้าไปเฉยๆ)

---

## ส่วนที่ 4 — เชื่อมกับแอป Scheduling
เพิ่มลิงก์/ปุ่มในแอป scheduling ชี้มาที่โดเมน SOP Hub:
```html
<a href="https://<โดเมน SOP Hub>" target="_blank">📚 คู่มือการทำงาน (SOP)</a>
```
เพราะใช้ Supabase project เดียวกัน พนักงานที่ล็อกอิน Scheduling อยู่แล้วจะเข้าดูคู่มือได้เลย

---

## เพิ่มรูป/วิดีโอในคู่มือ
คู่มือจาก PDF มี marker `[📷 ภาพประกอบ: ...]` (ดูรายการใน `IMAGE_CHECKLIST.md`)
เข้า **Admin → คู่มือ → แก้ไข** แล้วใช้ปุ่มแทรกรูป/วิดีโอวางแทน marker ได้เลย
