// AIRPORTELs logo — official image asset (public/airportels-logo.avif).
// The mark is black + gold on a transparent background, so it sits on a WHITE
// rounded tile (with padding) to stand out clearly in both light and dark themes.

export default function Logo({
  size = 44,
  className = "",
}: {
  size?: number;
  className?: string;
}) {
  return (
    <span
      className={`grid shrink-0 place-items-center overflow-hidden rounded-2xl bg-white shadow-sm ring-1 ring-black/10 ${className}`}
      style={{ width: size, height: size }}
    >
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src="/airportels-logo.avif"
        alt="AIRPORTELs"
        width={size}
        height={size}
        style={{ width: "82%", height: "82%", objectFit: "contain" }}
      />
    </span>
  );
}
