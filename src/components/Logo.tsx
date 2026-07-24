// AIRPORTELs logo — uses the official image asset (public/airportels-logo.avif).
// Rendered inside a rounded dark tile so a transparent/gold mark stays crisp
// in both light and dark themes (matches the Scheduling app's brand chip).

export default function Logo({
  size = 44,
  className = "",
}: {
  size?: number;
  className?: string;
}) {
  return (
    <span
      className={`grid shrink-0 place-items-center overflow-hidden rounded-2xl shadow-sm ${className}`}
      style={{ width: size, height: size, background: "#0b1220" }}
    >
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src="/airportels-logo.avif"
        alt="AIRPORTELs"
        width={size}
        height={size}
        style={{ width: "100%", height: "100%", objectFit: "contain" }}
      />
    </span>
  );
}
