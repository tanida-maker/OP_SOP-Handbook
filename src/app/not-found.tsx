import Link from "next/link";

export default function NotFound() {
  return (
    <div className="grid min-h-screen place-items-center bg-bg px-4">
      <div className="text-center">
        <p className="text-5xl font-extrabold text-brand-600">404</p>
        <h1 className="mt-2 text-xl font-bold text-text">ไม่พบหน้าที่ค้นหา</h1>
        <p className="mt-1 text-muted">หน้านี้อาจถูกย้ายหรือลบไปแล้ว</p>
        <Link
          href="/"
          className="mt-5 inline-block rounded-lg bg-brand-600 px-5 py-2.5 text-sm font-semibold text-white hover:bg-brand-700"
        >
          กลับหน้าแรก
        </Link>
      </div>
    </div>
  );
}
