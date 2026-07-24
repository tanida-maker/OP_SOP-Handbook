// Pastel theme per category — drives the illustrated card headers
// (inspired by modern knowledge-base UIs). Colors stay light in both
// themes since the header is its own decorative surface.

export interface Pastel {
  grad: string; // header background gradient
  ink: string; // text/icon color on the pastel header
  chip: string; // chip background on the header
}

const THEMES: Record<string, Pastel> = {
  lavender: {
    grad: "linear-gradient(135deg,#efe9ff 0%,#e0d4ff 100%)",
    ink: "#6d28d9",
    chip: "rgba(109,40,217,0.12)",
  },
  sky: {
    grad: "linear-gradient(135deg,#e4f1ff 0%,#c8e1ff 100%)",
    ink: "#1d4ed8",
    chip: "rgba(29,78,216,0.12)",
  },
  mint: {
    grad: "linear-gradient(135deg,#dcfce7 0%,#b6f0cf 100%)",
    ink: "#047857",
    chip: "rgba(4,120,87,0.12)",
  },
  peach: {
    grad: "linear-gradient(135deg,#ffe9df 0%,#ffd4c4 100%)",
    ink: "#c2410c",
    chip: "rgba(194,65,12,0.12)",
  },
  amber: {
    grad: "linear-gradient(135deg,#fef3c7 0%,#fde3a0 100%)",
    ink: "#b45309",
    chip: "rgba(180,83,9,0.14)",
  },
  rose: {
    grad: "linear-gradient(135deg,#ffe4ee 0%,#fbc9de 100%)",
    ink: "#be185d",
    chip: "rgba(190,24,93,0.12)",
  },
  teal: {
    grad: "linear-gradient(135deg,#d5f6f6 0%,#aee9ec 100%)",
    ink: "#0e7490",
    chip: "rgba(14,116,144,0.12)",
  },
  violet: {
    grad: "linear-gradient(135deg,#f0e9ff 0%,#e6d0ff 100%)",
    ink: "#7c3aed",
    chip: "rgba(124,58,237,0.12)",
  },
};

// Stable mapping from the seeded categories to a pastel theme.
const BY_SLUG: Record<string, keyof typeof THEMES> = {
  onboarding: "lavender",
  "counter-service": "sky",
  payment: "mint",
  delivery: "peach",
  inventory: "amber",
  emergency: "rose",
  tools: "violet",
  standards: "teal",
};

const ORDER = Object.keys(THEMES);

export function categoryPastel(slug?: string | null): Pastel {
  if (slug && BY_SLUG[slug]) return THEMES[BY_SLUG[slug]];
  // Deterministic fallback for any unmapped category slug.
  let h = 0;
  for (const c of slug ?? "x") h = (h * 31 + c.charCodeAt(0)) >>> 0;
  return THEMES[ORDER[h % ORDER.length]];
}
