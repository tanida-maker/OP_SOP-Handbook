import { Suspense } from "react";
import type { Metadata } from "next";
import { FileText } from "lucide-react";
import LoginForm from "./LoginForm";
import Logo from "@/components/Logo";
import T from "@/components/T";

export const metadata: Metadata = { title: "เข้าสู่ระบบ" };

export default function LoginPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-bg px-4 py-10">
      <div className="w-full max-w-md">
        <div className="mb-6 text-center">
          <div className="mb-3 flex justify-center">
            <Logo height={40} />
          </div>
          <p className="text-sm font-semibold text-brand-600">AIRPORTELs</p>
          <h1 className="text-xl font-extrabold text-text">
            Operations Knowledge Center
          </h1>
          <p className="mt-1 text-sm text-muted">
            <T th="เข้าสู่ระบบด้วยบัญชีพนักงาน" en="Sign in with your staff account" />
          </p>
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
