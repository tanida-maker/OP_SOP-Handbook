// Reference data for the Q4 & New Year Branch/Team Support Request.
// Values mirror the Lark import template (Lark_Q4_NewYear_Branch_Team_Support_Import_v2.xlsx).

export const Q4_BRANCHES = [
  "DMK", "BKK", "HKTI", "HKTD", "CNX", "T21", "EMS",
  "CTWH", "CTWG", "MBK", "ICS", "MIXT", "TPY", "Online - CS",
] as const;

export const Q4_PORTER_BRANCHES = new Set(["DMK", "BKK"]);

export type Q4Priority = "High" | "Medium" | "Low";
export const Q4_PRIORITIES: Q4Priority[] = ["High", "Medium", "Low"];

export const Q4_STATUSES = [
  "New", "Under Review", "In Progress", "Waiting for Support", "Completed", "Not Required",
] as const;
export const Q4_STATUS_TH: Record<string, string> = {
  New: "ใหม่",
  "Under Review": "กำลังพิจารณา",
  "In Progress": "กำลังดำเนินการ",
  "Waiting for Support": "รอ Support",
  Completed: "เสร็จแล้ว",
  "Not Required": "ไม่ต้องดำเนินการ",
};
export const Q4_CLOSED = new Set(["Completed", "Not Required"]);

export const Q4_TEAMS = [
  "OP Manager", "OP Co.", "HR", "IT & Dev.", "BD", "MKT", "MS - Logistic", "Management", "FA", "Online-CS", "Other",
];

export const Q4_AREA_HELP: Record<string, string> = {
  "Guest Service": "งานหน้าเคาน์เตอร์ ต้อนรับ รับฝาก-คืนกระเป๋า คิว",
  Porter: "ยก ขน จัดเรียงกระเป๋า Trolley Loading/Unloading",
  "CS / Customer Service": "Complaint, Refund, Claim, ติดตามเคสลูกค้า",
  "Branch Management": "Shift, OT, กำลังคน, พื้นที่, ความปลอดภัย",
  "Operation Support": "Transport/Runner, Stock, ระบบ, อุปกรณ์",
  Other: "ไม่เข้ากลุ่มด้านบน",
  "Online - CS": "ทีม Online customer service",
};

export function q4AreasFor(branch: string): string[] {
  if (branch === "Online - CS") return ["Online - CS"];
  const base = ["Guest Service", "CS / Customer Service", "Branch Management", "Operation Support", "Other"];
  return Q4_PORTER_BRANCHES.has(branch) ? ["Guest Service", "Porter", ...base.slice(1)] : base;
}

export const Q4_CATEGORIES: { name: string; ex: string; q: string[] }[] = [
  { name: "Operation / งานหน้าสาขา", ex: "ขั้นตอนรับฝาก/ส่งกระเป๋า, Peak period, Queue, Bottleneck, Branch workflow",
    q: ["ช่วง Peak มีลูกค้า/กระเป๋าจำนวนมากหรือไม่", "ขั้นตอนไหนเกิด Bottleneck หรือทำงานไม่ทัน", "พื้นที่จัดเก็บ / Queue / Counter / Workflow มีปัญหาหรือไม่"] },
  { name: "Guest Service / งานบริการหน้าสาขา", ex: "ต้อนรับลูกค้า, ให้ข้อมูล, รับฝากกระเป๋า, ตรวจสอบเอกสาร, Service standard",
    q: ["ปัญหาการให้บริการหน้าสาขา", "ขั้นตอนรับฝาก / รับ-ส่งกระเป๋า", "Customer Flow / Queue / Service Standard", "เรื่องที่ต้องการ Guideline หรือ Support เพิ่มเติม"] },
  { name: "Porter / งานขนย้ายกระเป๋า", ex: "ยก/ขน/จัดเรียงกระเป๋า, manpower, trolley, loading/unloading (DMK / BKK)",
    q: ["ปริมาณงานยก/ขน/จัดเรียงกระเป๋า", "จำนวนคน / Shift / OT", "Trolley / อุปกรณ์ขนย้าย", "จุดรับ-ส่ง / Loading / Unloading", "ช่วงเวลาที่ควรมี Porter Backup"] },
  { name: "Customer / ปัญหาหรือ Case ลูกค้า", ex: "ร้องเรียน, refund, delay, lost/damaged, follow-up, service recovery",
    q: ["Case ลูกค้าที่พบบ่อยในช่วง Q4 / ปีใหม่", "Complaint / Refund / Delay / Lost / Damage", "ลูกค้ารอเป็นเวลานาน", "Case ที่พนักงานไม่แน่ใจว่าควรดำเนินการอย่างไร", "ต้องการ Script / Guideline / Service Recovery หรือไม่"] },
  { name: "Staffing / Manpower", ex: "จำนวนคน, Shift, OT, Peak manpower, backup",
    q: ["ช่วงเวลาไหนที่กำลังคนไม่เพียงพอ", "Guest Service / Porter / CS มีคนเพียงพอหรือไม่", "ต้องการกำลังเสริม / OT / ปรับ Shift หรือ Backup อย่างไร"] },
  { name: "System / IT", ex: "ระบบ, Lark, LINE OA, EDC, Internet, device, access",
    q: ["Lark / LINE OA / ระบบอื่นที่เกี่ยวข้อง", "Internet / Device / EDC / Printer / Scanner", "ระบบหรืออุปกรณ์ที่เคยมีปัญหาในช่วง Peak", "สิ่งที่ควรมี Backup หรือเตรียมล่วงหน้า"] },
  { name: "Stock / Material", ex: "ถุง, tag, receipt, stationery, packaging, consumables",
    q: ["Stock หรือ Material ที่เคยขาด", "Tag / Receipt / Packaging / ถุง / อุปกรณ์สำนักงาน", "สิ่งที่ควรเพิ่ม Stock ก่อนเข้าสู่ Peak Season"] },
  { name: "Transport / Delivery", ex: "รถ, Runner, pickup/delivery, cut-off, route, backup transport",
    q: ["ปัญหา Pickup / Delivery / Runner", "รถไม่เพียงพอ / ล่าช้า / Cut-off", "ช่วงเวลาที่ต้องมี Transport Backup", "ปัญหาการประสานงานระหว่างสาขาและ Transport"] },
  { name: "SOP / Training", ex: "SOP/WI, training, knowledge, simulation, checklist",
    q: ["ขั้นตอนที่พนักงานยังไม่มั่นใจ", "SOP / WI ที่ควรปรับปรุง", "Training / Simulation / Checklist ที่ควรจัดก่อนปีใหม่"] },
  { name: "Emergency / Service Recovery", ex: "ระบบล่ม, กระเป๋าตกค้าง, สาขาปิด, emergency case",
    q: ["ระบบล่ม", "คนไม่เพียงพอ", "กระเป๋าตกค้าง", "ลูกค้ารอจำนวนมาก", "สาขาปิด / มีเหตุฉุกเฉิน", "ต้องการ Emergency Plan หรือ Backup Process อะไรเพิ่มเติม"] },
  { name: "Branch / Facility", ex: "พื้นที่, counter, storage, signage, lighting, power, air-con",
    q: ["พื้นที่ / Counter / Storage", "ไฟฟ้า / แอร์ / แสงสว่าง / CCTV"] },
  { name: "Equipment / Tools", ex: "trolley, scanner, printer, phone, EDC, X-Ray/handheld",
    q: ["Trolley / อุปกรณ์ประจำสาขา", "Device / EDC / Printer / Scanner ที่ไม่พอหรือเสีย", "อุปกรณ์ที่ควรมีสำรองก่อน Peak"] },
  { name: "Sales / Promotion", ex: "campaign, promotion, coupon, upsell, sales support",
    q: ["Campaign / Promotion ช่วงปีใหม่ที่หน้าสาขาต้องรู้", "ปัญหาการใช้ Coupon / ราคา / การอธิบายลูกค้า", "Sales support ที่ต้องการ"] },
  { name: "Media / Content / Filming", ex: "ถ่ายภาพ/VDO, filming, influencer, campaign content, branch coordination",
    q: ["การถ่ายภาพ / VDO ที่สาขา", "Filming / Campaign / Influencer", "การเตรียมพื้นที่และประสานงานกับทีม Media", "สิ่งที่ต้องเตรียมล่วงหน้าเพื่อไม่ให้กระทบ Operation"] },
  { name: "Communication / Coordination", ex: "การสื่อสารระหว่างทีม, group, escalation, contact point",
    q: ["เรื่องที่ต้องสื่อสารให้ทุกสาขาเข้าใจตรงกัน", "ช่องทาง Escalation / Contact point ช่วง Peak", "การประสานงานระหว่างสาขา ส่วนกลาง และ Transport"] },
  { name: "Security / Safety", ex: "ความปลอดภัย, unauthorized access, CCTV, incident prevention",
    q: ["ความปลอดภัยของกระเป๋าและพื้นที่ปฏิบัติงาน", "ปัญหาการเข้า-ออกพื้นที่หรือบุคคลภายนอก", "CCTV / การป้องกันเหตุ"] },
  { name: "Other / อื่นๆ", ex: "ประเด็นอื่นที่ไม่อยู่ในหมวดด้านบน",
    q: ["เรื่องอื่น ๆ ที่ต้องการให้ส่วนกลาง Support", "สิ่งที่ควรปรับปรุงก่อน Q4 / ปีใหม่", "แนวทางที่ทีมคิดว่าช่วยลดปัญหาในช่วง Peak ได้"] },
];
export const Q4_CATEGORY_NAMES = Q4_CATEGORIES.map((c) => c.name);

export interface Q4Entry {
  id: string;
  branch: string;
  service_area: string;
  category: string;
  period: string | null;
  issue: string;
  impact: string;
  support: string;
  prep: string | null;
  priority: Q4Priority;
  notes: string | null;
  created_by: string | null;
  created_name: string | null;
  created_at: string;
  updated_at: string;
}
export interface Q4Review {
  entry_id: string;
  status: string;
  team: string | null;
  teams: string[] | null;
  action: string | null;
  updated_as?: string | null;
  updated_at: string;
}
export interface Q4Plan {
  category: string;
  plan: string;
  updated_at: string;
}
export interface Q4TeamMember {
  user_id: string;
  team: string;
  email: string;
  full_name: string | null;
}
   export interface Q4Analysis {
     id: string;
     content: string;
     entry_count: number;
     model: string | null;
     created_at: string;
   }
