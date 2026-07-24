// Official AIRPORTELs "winged-A" emblem (gold), matching the Scheduling app.
// Self-contained inline SVG — no external asset/token dependency.

export function AprtEmblem({ size = 26 }: { size?: number }) {
  return (
    <svg
      width={size}
      height={(size * 96) / 110}
      viewBox="0 0 110 96"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <defs>
        <linearGradient id="aprt-gold" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" stopColor="#8B6914" />
          <stop offset="15%" stopColor="#B8860B" />
          <stop offset="30%" stopColor="#FFD700" />
          <stop offset="50%" stopColor="#FFEB99" />
          <stop offset="70%" stopColor="#DAA520" />
          <stop offset="85%" stopColor="#B8860B" />
          <stop offset="100%" stopColor="#8B6914" />
        </linearGradient>
      </defs>
      <g fill="url(#aprt-gold)">
        <path d="M 2,30 L 32,28 L 34,36 L 5,40 Z" />
        <path d="M 8,44 L 36,42 L 38,50 L 11,53 Z" />
        <path d="M 16,57 L 40,56 L 41,63 L 19,65 Z" />
        <path d="M 78,28 L 108,30 L 105,40 L 76,36 Z" />
        <path d="M 74,42 L 102,44 L 99,53 L 72,50 Z" />
        <path d="M 69,56 L 94,57 L 91,65 L 68,63 Z" />
        <path
          fillRule="evenodd"
          d="M 55,4 L 86,90 L 75,90 L 68,72 L 42,72 L 35,90 L 24,90 Z M 46,62 L 64,62 L 55,32 Z"
        />
      </g>
    </svg>
  );
}

// Emblem inside a dark rounded tile (matches Scheduling's dark brand chip).
export default function Logo({
  size = 44,
  className = "",
}: {
  size?: number;
  className?: string;
}) {
  return (
    <span
      className={`grid shrink-0 place-items-center rounded-2xl shadow-sm ${className}`}
      style={{ width: size, height: size, background: "#0b1220" }}
    >
      <AprtEmblem size={size * 0.6} />
    </span>
  );
}
