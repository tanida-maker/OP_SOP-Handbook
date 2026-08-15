import type { MetadataRoute } from "next";

// Web App Manifest — controls the name/icon when added to a phone or
// desktop home screen (Add to Home Screen / Install).
export default function manifest(): MetadataRoute.Manifest {
  return {
    name: "AIRPORTELs SOP Hub — Operations Knowledge Center",
    short_name: "AI SOP",
    description:
      "AIRPORTELs Operations Knowledge Center — ศูนย์รวมคู่มือการทำงาน SOP / WI สำหรับพนักงานหน้าสาขา",
    start_url: "/",
    scope: "/",
    display: "standalone",
    background_color: "#0d1a30",
    theme_color: "#12326e",
    lang: "th",
    icons: [
      { src: "/icon-192.png", sizes: "192x192", type: "image/png", purpose: "any" },
      { src: "/icon-512.png", sizes: "512x512", type: "image/png", purpose: "any" },
      { src: "/icon-512.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
    ],
  };
}
