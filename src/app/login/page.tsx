import { Suspense } from "react";
import type { Metadata } from "next";
import LoginForm from "./LoginForm";
import Logo from "@/components/Logo";

export const metadata: Metadata = { title: "เข้าสู่ระบบ" };

export default function LoginPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-bg px-4 py-10">
      <div className="w-full max-w-md">
        <div className="mb-6 text-center">
          <div className="mb-3 flex justify-center">
            <Logo size={56} />
          </div>
          <p className="text-sm font-semibold text-brand-600">AIRPORTELs</p>
          <h1 className="text-xl font-extrabold text-text">
            Operations Knowledge Center
          </h1>
          <p className="mt-1 text-sm text-muted">
            เข้าสู่ระบบด้วยบัญชีพนักงาน
          </p>
        </div>

        <div className="rounded-2xl border border-border bg-surface p-6 shadow-md">
          <Suspense fallback={<div className="text-sm text-muted">กำลังโหลด...</div>}>
            <LoginForm />
          </Suspense>
        </div>

        <p className="mt-4 text-center text-xs text-muted">
          หากลืมรหัสผ่านหรือยังไม่มีบัญชี กรุณาติดต่อผู้ดูแลระบบ (Admin)
        </p>
      </div>
    </div>
  );
}
