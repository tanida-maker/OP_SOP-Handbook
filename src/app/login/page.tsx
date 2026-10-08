import { Suspense } from "react";
import type { Metadata } from "next";
import { FileText } from "lucide-react";
import LoginForm from "./LoginForm";
import CompanyAccess from "./CompanyAccess";
import Logo from "@/components/Logo";
import T from "@/components/T";

// Temporary Q4 site (Vercel project "airportels-q4" sets NEXT_PUBLIC_APP_MODE=q4).
const Q4_MODE = process.env.NEXT_PUBLIC_APP_MODE === "q4";

export const metadata: Metadata = {
  title: Q4_MODE ? "เข้าสู่ระบบ | แจ้งปัญหา Q4 & ปีใหม่" : "เข้าสู่ระบบ",
};

export default function LoginPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-bg px-4 py-10">
      <div className="w-full max-w-md">
        <div className="mb-6 text-center">
          <div className="mb-3 flex justify-center">
            <Logo height={40} />
          </div>
          <p className="text-sm font-semibold text-brand-600">AIRPORTELs</p>
          {Q4_MODE ? (
            <>
              <h1 className="text-xl font-extrabold text-text">
                <T th="แจ้งปัญหา & ขอ Support ช่วง Q4 / ปีใหม่" en="Q4 & New Year Support Request" />
              </h1>
              <p className="mt-1 text-sm text-muted">
                <T
                  th="สำหรับสาขาและทีม Operation เข้าสู่ระบบด้วยบัญชีเดียวกับระบบตารางงาน"
                  en="For branches and Operation teams. Sign in with your Scheduling account"
                />
              </p>
            </>
          ) : (
            <>
              <h1 className="text-xl font-extrabold text-text">
                Operations Knowledge Center
              </h1>
              <p className="mt-1 text-sm text-muted">
                <T th="เข้าสู่ระบบด้วยบัญชีพนักงาน" en="Sign in with your staff account" />
              </p>
            </>
          )}
        </div>

        <div className="rounded-2xl border border-border bg-surface p-6 shadow-md">
          <Suspense
            fallback={
              <div className="text-sm text-muted">
                <T th="กำลังโหลด..." en="Loading..." />
              </div>
            }
          >
            <LoginForm />
          </Suspense>
        </div>

        {Q4_MODE && <CompanyAccess />}

        {Q4_MODE && (
          <div className="mt-4 rounded-2xl border border-border bg-surface p-5 text-sm shadow-sm">
            <p className="mb-2 font-bold text-text">
              <T th="สำหรับสาขา: วิธีกรอกฟอร์ม (ประมาณ 3 นาที/ประเด็น)" en="For branches: how to fill in the form (about 3 min per issue)" />
            </p>
            <ol className="list-decimal space-y-1.5 pl-5 text-muted">
              <li>
                <T th="เข้าสู่ระบบด้วยบัญชีเดียวกับระบบตารางงาน (Google หรืออีเมล)" en="Sign in with your Scheduling account (Google or email)" />
              </li>
              <li>
                <T th="เลือกสาขา/ทีม และ Service Area (DMK / BKK ให้แยก Porter ออกจาก Guest Service)" en="Pick your branch/team and service area (DMK / BKK: report Porter separately)" />
              </li>
              <li>
                <T th="เลือกหมวด แล้วกรอก: ปัญหา → ผลกระทบ → สิ่งที่ต้องการให้ส่วนกลาง Support → แนวทางที่ทีมเตรียมเองได้" en="Pick a category, then fill in: issue → impact → support needed from Central → what your team will prepare" />
              </li>
              <li>
                <T th="เลือก Priority แล้วกด ส่งข้อมูล" en="Choose a priority and press Submit" />
              </li>
            </ol>
            <p className="mt-3 rounded-lg bg-surface-2 px-3 py-2 text-xs text-muted">
              <T
                th="กรอก 1 รายการต่อ 1 ประเด็น ส่งได้หลายรายการ และแก้ไขรายการของตัวเองได้ภายหลัง"
                en="One entry per issue. You can submit several and edit your own entries later"
              />
            </p>
          </div>
        )}

        {Q4_MODE && (
          <div className="mt-4 rounded-2xl border border-[#14232E]/30 bg-surface p-5 text-sm shadow-sm">
            <p className="mb-2 font-bold text-text">
              <T th="สำหรับทีม Support (OP, HR, IT & Dev., BD, MKT, MS - Logistic, FA ฯลฯ)" en="For Support teams" />
            </p>
            <ol className="list-decimal space-y-1.5 pl-5 text-muted">
              <li>
                <T th="อีเมลบริษัท: เปิดใช้งานในกล่องด้านบนได้เอง · Gmail / ภายนอก: ให้หัวหน้าทีมเพิ่มอีเมลก่อน แล้วเข้าสู่ระบบด้วย Google หรือลิงก์ทางอีเมล และเปิดแท็บ “ทีม Support”" en="Sign in with Google (Gmail / company e-mail) or the e-mail login link, using the address your team lead added. No Scheduling account needed. Then open the “Support team” tab" />
              </li>
              <li>
                <T th="เลือกทีมของคุณ ดูงานที่มอบหมาย เรียงงาน High ก่อน" en="Pick your team to see its assigned issues, High first" />
              </li>
              <li>
                <T th="อัปเดตสถานะ ใส่ความคืบหน้า เลือกผู้รับงานในทีม หรือมอบหมายต่อให้ทีมอื่น แล้วกด บันทึก" en="Update status and progress, pick an assignee, or delegate to another team, then Save" />
              </li>
              <li>
                <T th="ทำเสร็จแล้วเลือกสถานะ Completed เพื่อปิดงาน ระบบแจ้ง Lark ให้อัตโนมัติ" en="Choose Completed to close; Lark is notified automatically" />
              </li>
            </ol>
            <p className="mt-3 rounded-lg bg-surface-2 px-3 py-2 text-xs text-muted">
              <T
                th="ยังเข้าไม่ได้? ให้หัวหน้าทีมเพิ่มอีเมลของคุณในแท็บ “ทีม Support” ก่อน (ใช้ Gmail หรืออีเมลบริษัทก็ได้) แล้วกลับมาเข้าสู่ระบบด้วยอีเมลนั้น"
                en="Not in a team yet? Ask your team lead or an Admin to add your login e-mail in the “Support team” tab"
              />
            </p>
            <a href="/login?next=%2Fq4%3Ftab%3Dteam"
              className="mt-3 flex items-center justify-center rounded-lg bg-[#14232E] py-2.5 text-sm font-semibold text-[#CFE2F3] hover:opacity-90">
              <T th="ทีม Support: เข้าสู่ระบบแล้วไปหน้างานของทีม" en="Support team: sign in and go to team work" /> →
            </a>
          </div>
        )}

        {!Q4_MODE && (
        <a
          href="/sop-hub-login-guide.pdf"
          target="_blank"
          rel="noopener"
          className="mt-4 flex items-center justify-center gap-2 rounded-lg border border-brand-200 bg-brand-50 py-2.5 text-sm font-semibold text-brand-700 transition hover:border-brand-400 hover:bg-brand-100"
        >
          <FileText size={16} />
          <T
            th="คู่มือเข้าใช้งานครั้งแรก (PDF)"
            en="First-time login guide (PDF)"
          />
        </a>
        )}

        <p className="mt-4 text-center text-xs text-muted">
          <T
            th="หากลืมรหัสผ่านหรือยังไม่มีบัญชี กรุณาติดต่อผู้ดูแลระบบ (Admin)"
            en="Forgot your password or don't have an account? Please contact your Admin"
          />
        </p>
      </div>
    </div>
  );
}
