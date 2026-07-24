// AIRPORTELs logo — official GOLD mark (public/airportels-logo-gold.webp).
// Gold reads best on a dark surface, so it sits on a dark rounded tile that
// hugs the logo at its natural (horizontal) aspect ratio — crisp in both themes.

export default function Logo({
  height = 24,
  className = "",
}: {
  height?: number;
  className?: string;
}) {
  return (
    <span
      className={`inline-flex items-center justify-center rounded-lg px-2 py-1.5 shadow-sm ring-1 ring-white/10 ${className}`}
      style={{ background: "#0b1220" }}
    >
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src="/airportels-logo-gold.webp"
        alt="AIRPORTELs"
        style={{ height, width: "auto", display: "block" }}
      />
    </span>
  );
}
