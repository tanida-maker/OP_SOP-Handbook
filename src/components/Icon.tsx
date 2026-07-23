import {
  BadgeCheck,
  Briefcase,
  CreditCard,
  FileText,
  GraduationCap,
  PackageCheck,
  Siren,
  Truck,
  Wrench,
  type LucideIcon,
} from "lucide-react";

// Map category icon names (stored in DB) to lucide components.
const MAP: Record<string, LucideIcon> = {
  BadgeCheck,
  Briefcase,
  CreditCard,
  FileText,
  GraduationCap,
  PackageCheck,
  Siren,
  Truck,
  Wrench,
};

export default function Icon({
  name,
  size = 22,
  className,
}: {
  name?: string | null;
  size?: number;
  className?: string;
}) {
  const Cmp = (name && MAP[name]) || FileText;
  return <Cmp size={size} className={className} />;
}
