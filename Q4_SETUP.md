# Q4 & ปีใหม่ — Branch/Team Support Request (โมดูลใน SOP Hub)

ฟอร์มให้สาขา/ทีมแจ้งปัญหา Q4 / ปีใหม่ + หน้าสรุปผล Realtime
อยู่ในเมนู **Q4 & ปีใหม่** ของ SOP Hub (`/q4`) — ใช้ Login เดิมของ Scheduling / SOP Hub

## สิทธิ์
| ผู้ใช้ | ทำอะไรได้ |
|---|---|
| พนักงานทุกคนที่ Login | ส่งประเด็น, ดูรายการและสรุปผลทั้งหมด, แก้/ลบเฉพาะรายการของตัวเอง |
| SOP Admin (ตาราง `sop.admins`) | ทั้งหมดข้างบน + อัปเดต Status / Responsible Team / Central Action, เขียนแผน Support รายหมวด, แก้/ลบได้ทุกรายการ |
| คนที่ไม่ได้ Login | เข้าไม่ได้ (ถูกส่งไปหน้า Login) |

สิทธิ์ล็อกที่ระดับฐานข้อมูล (RLS) ไม่ใช่แค่ซ่อนปุ่ม

## ขั้นตอนเปิดใช้งาน (ทำครั้งเดียว)
1. **Supabase** (project เดียวกับ Scheduling) → SQL Editor → New query
   → วางไฟล์ `supabase/q4_support.sql` ทั้งหมด → **Run**
   - สร้างเฉพาะ `sop.q4_entries`, `sop.q4_reviews`, `sop.q4_plans` และฟังก์ชัน `sop.q4_my_profile()`
   - ไม่แตะตาราง `public.*` ของ Scheduling และไม่แตะตาราง SOP เดิม
   - เปิด Realtime ให้ 3 ตารางนี้อัตโนมัติ
   - ไม่ต้องตั้ง Exposed schemas เพิ่ม เพราะ `sop` เปิดไว้แล้ว
2. **GitHub** → นำไฟล์ในชุดนี้ไปวางทับใน repo `OP_SOP-Handbook` แล้ว commit/push
3. **Vercel** จะ Deploy ให้อัตโนมัติ — ไม่ต้องเพิ่ม Environment Variable หรือ Redirect URL ใหม่

## ไฟล์ที่เพิ่ม / แก้
- เพิ่ม `src/app/(main)/q4/page.tsx`, `src/app/(main)/q4/Q4App.tsx`, `src/lib/q4.ts`, `supabase/q4_support.sql`
- แก้ `src/components/LeftRail.tsx` และ `src/components/SiteHeader.tsx` (เพิ่มเมนู Q4 & ปีใหม่ 1 บรรทัด + import ไอคอน)

## หมายเหตุ
- ชื่อผู้กรอกและสาขาเริ่มต้นดึงจาก `public.profiles` ของผู้ Login (ถ้ามีคอลัมน์ full_name / branch) ถ้าไม่มี ระบบใช้ชื่อจากบัญชีและให้เลือกสาขาเอง
- Export เป็น CSV (UTF-8) คอลัมน์ตาม Lark import template — นำเข้า Lark Base / Lark Sheet ได้โดยตรง
- ปิดรับข้อมูลหลังจบโครงการ: `revoke insert on sop.q4_entries from authenticated;`
