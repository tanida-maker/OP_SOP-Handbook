// AIRPORTELs official GOLD logo (public/airportels-logo-gold.webp).
// Rendered directly with no background tile — like the Scheduling app.
// Gold reads fine on light surfaces and pops on dark ones, in both themes.

export default function Logo({
  height = 24,
  className = "",
}: {
  height?: number;
  className?: string;
}) {
  return (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src="/airportels-logo-gold.webp"
      alt="AIRPORTELs"
      className={className}
      style={{ height, width: "auto", display: "block" }}
    />
  );
}
