import type { Metadata, Viewport } from "next";
import { Noto_Sans_Thai } from "next/font/google";
import "./globals.css";
import { LanguageProvider } from "@/components/LanguageProvider";

const notoThai = Noto_Sans_Thai({
  variable: "--font-noto-thai",
  subsets: ["thai", "latin"],
  weight: ["400", "500", "600", "700", "800"],
  display: "swap",
});

export const metadata: Metadata = {
  title: {
    default: "Operations Knowledge Center · AIRPORTELs",
    template: "%s · Operations Knowledge Center",
  },
  description:
    "AIRPORTELs Operations Knowledge Center — ศูนย์รวมคู่มือการทำงาน SOP / WI สำหรับพนักงานหน้าสาขา",
  applicationName: "AIRPORTELs SOP Hub",
  appleWebApp: {
    capable: true,
    title: "AIRPORTELs SOP Hub",
    statusBarStyle: "black-translucent",
  },
};

export const viewport: Viewport = {
  themeColor: "#1a66e0",
  width: "device-width",
  initialScale: 1,
};

// Set the theme + language before hydration to avoid a flash of the wrong state.
const themeScript = `
(function() {
  try {
    var t = localStorage.getItem('sop-theme');
    if (!t) t = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', t);
    var l = localStorage.getItem('sop-lang');
    if (l === 'en' || l === 'th') document.documentElement.setAttribute('lang', l);
  } catch (e) {}
})();
`;

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="th" className={`${notoThai.variable} h-full`} suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: themeScript }} />
      </head>
      <body className="min-h-full flex flex-col">
        <LanguageProvider>{children}</LanguageProvider>
      </body>
    </html>
  );
}
