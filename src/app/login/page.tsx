import { Suspense } from "react";
import type { Metadata } from "next";
import LoginForm from "./LoginForm";

export const metadata: Metadata = { title: "เข้าสู่ระบบ" };

export default function LoginPage() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-bg px-4 py-10">
      <div className="w-full max-w-md">
        <div className="mb-6 text-center">
          <div className="mx-auto mb-3 grid h-14 w-14 place-items-center rounded-2xl bg-brand-600 text-2xl font-extrabold text-white">
            A
          </div>
          <h1 className="text-xl font-extrabold text-text">
            AIRPORTELs SOP Hub
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
