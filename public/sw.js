// Minimal service worker — its only job is to make the app installable
// (Add to Home Screen / Install). It deliberately does NOT cache responses,
// so content stays live and never goes stale.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (event) => event.waitUntil(self.clients.claim()));
// A fetch handler must exist for Chrome to consider the app installable.
// This one is a pure passthrough (no respondWith) — the network handles everything.
self.addEventListener("fetch", () => {});
