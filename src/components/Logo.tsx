// AIRPORTELs logo — official image asset shown at its natural (horizontal)
// aspect ratio on a white plate that hugs it, so the dark+gold mark stays crisp
// in both themes without being cropped or squeezed into a square.

export default function Logo({
  height = 24,
  className = "",
}: {
  height?: number;
  className?: string;
}) {
  return (
    <span
      className={`inline-flex items-center justify-center rounded-lg bg-white px-1.5 py-1 shadow-sm ring-1 ring-black/10 ${className}`}
    >
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src="/airportels-logo.avif"
        alt="AIRPORTELs"
        style={{ height, width: "auto", display: "block" }}
      />
    </span>
  );
}
