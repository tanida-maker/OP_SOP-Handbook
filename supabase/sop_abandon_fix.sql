-- ============================================================
-- AIRPORTELs SOP Hub — SOP-OPS 023/2026 (Abandoned Luggage Disposal)
--   Faithful re-render from source PDF (12 pages): full sections,
--   readable tables + timeline + scripts, section dividers.
--   Fixes the document code to SOP-OPS-023/2026 (self-referenced in the
--   source's SOP-Relationship section; cover header 021 was a typo).
-- Idempotent. Content served dynamically (no redeploy needed).
-- ============================================================
begin;
update sop.documents
set content_html = '<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px}
.prose table.sop-tbl td{min-width:170px;max-width:360px;vertical-align:top;font-size:13.5px;line-height:1.6}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:150px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.prose .sop-tblwrap{overflow-x:auto;-webkit-overflow-scrolling:touch;margin:10px 0;border:1px solid var(--border,#e5e7eb);border-radius:8px}
.prose .sop-tblwrap table.sop-tbl{margin:0;border:0;min-width:640px}
.prose hr.sop-hr{border:0;border-top:1px solid var(--border,#e5e7eb);margin:26px 0;opacity:.8}
.prose h4{margin-top:16px}
.prose li{margin:5px 0;line-height:1.7}
.sop-en{color:var(--text-muted,#6b7280)}
.sop-note{background:var(--surface-2);border-left:3px solid #f59e0b;border-radius:6px;padding:10px 14px;margin:10px 0;font-size:14px;line-height:1.65}
.sop-tl{display:grid;grid-template-columns:112px 1fr;border:1px solid var(--border,#e5e7eb);border-radius:10px;margin:10px 0;overflow:hidden}
.sop-tl>.d{display:flex;flex-direction:column;align-items:center;justify-content:center;background:var(--surface-2);padding:12px 8px;text-align:center;border-right:1px solid var(--border,#e5e7eb)}
.sop-tl>.d b{font-size:15px;color:#1a66e0;line-height:1.15}
.sop-tl>.d span{font-size:11px;font-weight:800;letter-spacing:.5px;color:var(--text-muted,#6b7280);margin-top:3px}
.sop-tl>.c{padding:11px 15px}
.sop-tl>.c .h{font-weight:700;margin-bottom:4px}
.sop-tl ul{list-style:none;margin:0;padding:0}
.sop-tl li{position:relative;padding-left:18px}
.sop-tl li::before{content:"▸";position:absolute;left:0;color:#f59e0b}
.sop-step{display:grid;grid-template-columns:44px 1fr;border:1px solid var(--border,#e5e7eb);border-radius:10px;margin:12px 0;overflow:hidden}
.sop-step>.n{display:flex;align-items:center;justify-content:center;background:var(--surface-2);font-weight:800;font-size:18px;color:#1a66e0;border-right:1px solid var(--border,#e5e7eb)}
.sop-step>.c{padding:11px 15px}
.sop-step .c h4{margin:0 0 6px}
.sop-script{background:var(--surface-2);border-left:3px solid #1a66e0;border-radius:6px;padding:9px 13px;margin:8px 0;font-size:13.5px;line-height:1.6}
.sop-script .en{color:var(--text-muted,#6b7280);font-style:italic}
.sop-case{border:1px solid var(--border,#e5e7eb);border-radius:8px;padding:8px 14px;margin:8px 0}
</style>

<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 023/2026 &nbsp;·&nbsp; <strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 พฤษภาคม 2569 &nbsp;·&nbsp; <strong>หน่วยงาน:</strong> Operations</p></blockquote>

<h3>📎 อ้างอิง / Reference</h3>
<ul>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/FTsVwAwIOixPSfkldG6ljlPcg5b?from=from_copylink" target="_blank" rel="noopener">(TH) Terms and Conditions 2026</a> / <a href="https://ssglsj0spi27.sg.larksuite.com/wiki/Y8OCwI9k4iu1tmkE4B1lmNfNg2e?from=from_copylink" target="_blank" rel="noopener">(EN) Terms and Conditions 2026</a></li>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/LC9Bwdsn0ilyjXktbColAdMpg4g?from=from_copylink" target="_blank" rel="noopener">SOP : ขั้นตอนปฏิบัติมาตรฐานกรณีลูกค้ามารับสัมภาระล่าช้า – เกณฑ์และโครงสร้างส่วนลด (SOP-OPS:016)</a></li>
</ul>

<hr class="sop-hr">
<h3>🔹 วัตถุประสงค์ / Purpose</h3>
<p>กำหนดขั้นตอนมาตรฐานการจัดการสัมภาระที่ลูกค้าไม่ติดต่อ ไม่มารับ หรือทอดทิ้ง ภายหลังจาก SOP-OPS:016 (Delayed Collection) ไม่สามารถติดต่อลูกค้าได้ เพื่อคุ้มครองสิทธิ์ของบริษัท ป้องกันพื้นที่จัดเก็บเต็ม และดำเนินการทางกฎหมายอย่างถูกต้อง</p>
<p class="sop-en"><em>To define the standard procedure for handling luggage that is unclaimed, abandoned, or where the customer has failed to respond — following escalation from SOP-OPS:016. This protects company rights, prevents storage capacity issues, and ensures legally compliant disposal.</em></p>

<hr class="sop-hr">
<h3>🔗 ความสัมพันธ์กับ SOP อื่น / SOP Relationship</h3>
<ul>
<li><strong>SOP-OPS:016</strong> (Delayed Collection) → เมื่อลูกค้าไม่ติดต่อ/ไม่มารับ → ส่งต่อมายัง <strong>SOP-OPS:023</strong> นี้ <span class="sop-en">| SOP-OPS:016 handles delayed but contactable customers. If uncontactable → escalate here.</span></li>
<li><strong>SOP-OPS:021</strong> (Lost &amp; Found) → ใช้เมื่อลูกค้ายังต้องการกระเป๋าและแจ้งสูญหาย ≠ SOP นี้ <span class="sop-en">| Handles active lost reports; this SOP handles unclaimed/abandoned cases.</span></li>
<li><strong>SOP-OPS:022</strong> (Damage Claim) → ใช้หลังจากลูกค้ารับกระเป๋าแล้วและพบความเสียหาย <span class="sop-en">| Applies after retrieval and damage is reported.</span></li>
</ul>

<hr class="sop-hr">
<h3>🔹 ขอบเขตและคำจำกัดความ / Scope &amp; Definitions</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ครอบคลุม / Applies To</th><th>ยกเว้น / Excludes</th></tr></thead><tbody><tr><td>ลูกค้าทุกประเภทที่ฝากสัมภาระกับ AIRPORTELs<br><span class="sop-en">All customers storing luggage at any AIRPORTELs location</span></td><td>กรณีที่ลูกค้าติดต่อกลับแล้ว → ส่งคืน SOP-OPS:016<br><span class="sop-en">If customer responds → revert to SOP-OPS:016</span></td></tr><tr><td>ทุกสาขาและช่องทาง (Walk-in, Call Center, Email, Line, Facebook)<br><span class="sop-en">All branches and contact channels</span></td><td>กรณีลูกค้าแจ้งสูญหาย → SOP-OPS:021<br><span class="sop-en">Active lost reports → SOP-OPS:021</span></td></tr><tr><td>Guest Service Staff, Branch Manager, CS Team, Operations Manager, Legal/BD</td><td>กระเป๋าที่มีเจ้าของติดต่อภายในระยะเวลากำหนด<br><span class="sop-en">Bags with owners who contact within the stipulated period</span></td></tr></tbody></table></div>

<h4>คำจำกัดความ / Key Definitions</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>คำศัพท์ / Term</th><th>ความหมาย / Definition</th></tr></thead><tbody><tr><td>Delayed Collection</td><td>ลูกค้ายังติดต่อได้แต่มารับล่าช้า → จัดการโดย SOP-OPS:016<br><span class="sop-en">Customer is contactable but late to collect — handled by SOP-OPS:016</span></td></tr><tr><td>Unclaimed Luggage</td><td>กระเป๋าที่ครบกำหนดและยังไม่มีการรับคืน แต่ยังอยู่ในช่วงติดตาม<br><span class="sop-en">Luggage past due date, still in follow-up period</span></td></tr><tr><td>Abandoned Bag</td><td>กระเป๋าที่ลูกค้าไม่ติดต่อกลับหลัง 3 รอบ Follow-up ครบ Notice Period<br><span class="sop-en">No response after 3 follow-ups and notice period elapsed</span></td></tr><tr><td>Notice Period</td><td>ระยะเวลาที่บริษัทแจ้งเตือนลูกค้าก่อนดำเนินการทิ้ง/จำหน่าย (30 วัน)<br><span class="sop-en">30-day formal notice period before disposal action</span></td></tr><tr><td>Disposal</td><td>การดำเนินการกับกระเป๋าที่ถูกทอดทิ้ง: บริจาค / ขายทอดตลาด / ทำลาย ตาม T&amp;C<br><span class="sop-en">Donate / auction / destroy per T&C</span></td></tr><tr><td>Ex-Gratia</td><td>ส่วนลดพิเศษที่มอบให้ลูกค้า VIP/กรณีพิเศษ อนุมัติโดย BD/COO/CEO เท่านั้น<br><span class="sop-en">Special goodwill discount for VIP/special cases, approved by BD/COO/CEO only</span></td></tr></tbody></table></div>

<hr class="sop-hr">
<h3>🔹 เส้นเวลาและเกณฑ์เวลา / Timeline &amp; Trigger Points</h3>
<p class="sop-note">🧭 กำหนดเวลาหลัก (นับจากวันครบกำหนดรับกระเป๋า) — ทุก milestone อ้างอิงจาก T&amp;C ฉบับ 29 เมษายน 2569 และนโยบาย SOP-OPS:016</p>
<div class="sop-tl"><div class="d"><b>Day 0</b><span>TRIGGER</span></div><div class="c"><div class="h">สัมภาระครบกำหนดรับ</div><ul><li>กระเป๋าถึงวันครบกำหนดตาม Booking <span class="sop-en">| Booking end date reached</span></li><li>ระบบแจ้งเตือนอัตโนมัติ / Lark notification ส่งถึง GS</li></ul></div></div>
<div class="sop-tl"><div class="d"><b>Day 1–7</b><span>FOLLOW-UP 1</span></div><div class="c"><div class="h">ติดตามครั้งที่ 1 — GS / CS</div><ul><li>GS/CS โทรหรือส่งอีเมล/LINE แจ้งลูกค้า <span class="sop-en">| Call/Email/LINE the customer</span></li><li>บันทึกการติดต่อใน CRM / Lark</li><li>หากลูกค้าตอบรับ → ส่งกลับ SOP-OPS:016</li></ul></div></div>
<div class="sop-tl"><div class="d"><b>Day 15</b><span>FOLLOW-UP 2</span></div><div class="c"><div class="h">ติดตามครั้งที่ 2 — CS</div><ul><li>ส่ง Formal Notice Email แจ้งค่าฝากค้างชำระ + กำหนดเวลา</li><li>แนบรายละเอียด: ขนาดสัมภาระ, วันฝาก, ยอดค้างชำระ, กำหนดรับ 30 วัน</li><li>หากลูกค้าตอบรับ → ส่งกลับ SOP-OPS:016</li></ul></div></div>
<div class="sop-tl"><div class="d"><b>Day 25</b><span>FOLLOW-UP 3</span></div><div class="c"><div class="h">ติดตามครั้งที่ 3 — OP Manager</div><ul><li>OP Manager ส่ง Final Notice — แจ้ง 5 วันสุดท้าย</li><li>ระบุชัดเจน: หากไม่มารับ/ติดต่อ กระเป๋าจะถูก Disposal ตาม T&amp;C</li><li>ช่องทาง: Email + LINE + โทรศัพท์ (บันทึกทุกช่องทาง)</li></ul></div></div>
<div class="sop-tl"><div class="d"><b>Day 30</b><span>ABANDONED</span></div><div class="c"><div class="h">กำหนดสถานะ Abandoned</div><ul><li>หากยังไม่มีการติดต่อ → เปลี่ยนสถานะเป็น ''Abandoned''</li><li>OP Manager จัดทำ Abandonment Report + ขออนุมัติ BD/CEO</li></ul></div></div>
<div class="sop-tl"><div class="d"><b>Day 31+</b><span>DISPOSAL</span></div><div class="c"><div class="h">ดำเนินการ Disposal</div><ul><li>ดำเนินการตามช่องทาง Disposal (ดูหัวข้อ Disposal Options)</li><li>บันทึกผลลัพธ์ รูปถ่าย และเอกสารครบ เก็บอย่างน้อย 1 ปี</li></ul></div></div>

<hr class="sop-hr">
<h3>🔹 ขั้นตอนการปฏิบัติสำหรับพนักงาน / Staff Procedure</h3>
<h4>ลำดับที่ 1: ก่อนถึง Day 30 — ติดตามและป้องกัน Abandon (Pre-Abandonment Follow-Up)</h4>
<div class="sop-step"><div class="n">1</div><div class="c"><h4>ตรวจสอบรายวัน — ระบบแจ้งเตือน / Daily Check — System Alert</h4><ul><li>GS ตรวจสอบ Dashboard Lark / ระบบจัดการทุกเช้า</li><li>กรองรายการ: Overdue (เกินกำหนด) + No Contact (ยังไม่ได้ติดต่อ)</li><li>Priority: Long-term (≥6 เดือน) → OP Manager รับทราบด้วย</li></ul></div></div>
<div class="sop-step"><div class="n">2</div><div class="c"><h4>Follow-Up ครั้งที่ 1 (Day 1–7) / First Contact Attempt</h4><ul><li>โทรศัพท์ก่อน → ถ้าไม่รับ ส่ง SMS/LINE/Email ตาม Contact ที่มีในระบบ</li><li>ใช้ Script การติดต่อ (ดูหัวข้อ Scripts)</li><li>บันทึกใน CRM: วันเวลา, ช่องทาง, ผลการติดต่อ</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016 (Discount Structure)</li><li>ลูกค้าไม่ตอบ ❌ → รอ Day 15 Follow-Up 2</li></ul></div></div>
<div class="sop-step"><div class="n">3</div><div class="c"><h4>Formal Notice Email (Day 15) / Second Contact — Formal Notice</h4><ul><li>CS ส่ง Formal Notice Email (ดู Template)</li><li>เนื้อหาต้องระบุ: ยอดค้างชำระ | วันฝาก | ขนาดสัมภาระ | กำหนดรับ 30 วัน | ผลที่ตามมาถ้าไม่มารับ</li><li>บันทึก Email Sent Date ใน Lark + แนบสำเนา Email</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016</li></ul></div></div>
<div class="sop-step"><div class="n">4</div><div class="c"><h4>Final Notice (Day 25) / Third Contact — Final Warning</h4><ul><li>OP Manager ส่ง Final Notice (Email + LINE + โทร)</li><li>ระบุชัด: หากไม่มีการติดต่อหรือชำระภายใน 5 วัน กระเป๋าจะถูก Abandoned Disposal</li><li>บันทึกการส่ง Final Notice ทุกช่องทาง + screenshot</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016 (ขออนุมัติ Operation Manager สำหรับ Long-term)</li></ul></div></div>
<h4>ลำดับที่ 2: Day 30+ — จัดการ Abandoned Bag (Abandonment &amp; Disposal Process)</h4>
<div class="sop-step"><div class="n">5</div><div class="c"><h4>เปลี่ยนสถานะ Abandoned (Day 30) / Mark as Abandoned</h4><ul><li>OP Manager ยืนยันว่าครบ 3 Follow-ups + ครบ Notice Period</li><li>เปลี่ยนสถานะในระบบ Lark เป็น ''Abandoned''</li><li>จัดทำ Abandonment Report: ชื่อลูกค้า | Order ID | วันฝาก | ระยะเวลา | ยอดค้าง | ประวัติการติดต่อ</li><li>ถ่ายภาพสัมภาระก่อนดำเนินการ (บันทึกสภาพ)</li></ul></div></div>
<div class="sop-step"><div class="n">6</div><div class="c"><h4>ขออนุมัติ Disposal / Request Disposal Approval</h4><ul><li>OP Manager ส่ง Abandonment Report ให้ CEO/BD ผ่านกลุ่ม Business Gank! หรือ Lark</li><li>รอการอนุมัติก่อนดำเนินการ Disposal ทุกกรณี</li><li>เนื้อหา Report: สรุปกรณี | ช่องทาง Disposal ที่แนะนำ | มูลค่าประมาณ | เหตุผล</li></ul></div></div>
<div class="sop-step"><div class="n">7</div><div class="c"><h4>ดำเนินการ Disposal (หลังได้รับอนุมัติ) / Execute Disposal</h4><ul><li>เลือก Disposal Channel ตามตารางด้านล่าง</li><li>ถ่ายภาพ/วิดีโอขณะดำเนินการ Disposal</li><li>บันทึกผลลัพธ์ใน Disposal Record: วันที่ | ช่องทาง | มูลค่า (ถ้ามี) | ผู้อนุมัติ</li><li>เก็บเอกสารและภาพถ่ายอย่างน้อย 1 ปี</li></ul></div></div>
<div class="sop-step"><div class="n">8</div><div class="c"><h4>แจ้งลูกค้า (ถ้าติดต่อได้ภายหลัง) / Notify Customer Post-Disposal</h4><ul><li>หากลูกค้าติดต่อมาหลัง Disposal แล้ว: แจ้งสถานะและให้ Disposal Record</li><li>ไม่มีภาระผูกพันทางการเงินแก่บริษัทหลัง Disposal ตาม T&amp;C</li><li>หากลูกค้าโต้แย้ง: Escalate ถึง BD/CEO + Legal (ถ้าจำเป็น)</li></ul></div></div>

<hr class="sop-hr">
<h3>🔹 ช่องทาง Disposal และตารางอนุมัติ / Disposal Options &amp; Approval Authority</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ช่องทาง / Channel</th><th>เงื่อนไข / Condition</th><th>ผู้อนุมัติ / Approver</th><th>หมายเหตุ / Notes</th></tr></thead><tbody><tr><td>🎁 บริจาค / Donate</td><td>สัมภาระสภาพดี ไม่มีมูลค่าตลาดสูง | ลูกค้าไม่ติดต่อครบ Notice Period</td><td>OP Manager</td><td>บันทึกองค์กรที่รับบริจาค + ภาพถ่าย</td></tr><tr><td>🔨 ขายทอดตลาด / Auction</td><td>สัมภาระมีมูลค่า (กระเป๋าแบรนด์, ถุงกอล์ฟ) | ยอดค้างสูง</td><td>BD / CEO</td><td>รายได้หักค่าฝากก่อน ส่วนที่เหลือ (ถ้ามี) เก็บไว้ 90 วัน</td></tr><tr><td>🗑️ ทำลาย / Destroy</td><td>สัมภาระสภาพแย่ / เสื่อมสภาพ / มีของต้องห้าม / บริจาคหรือขายไม่ได้</td><td>CLO + ถ่ายรูป</td><td>บันทึกเหตุผล + ถ่ายวิดีโอขณะทำลาย</td></tr><tr><td>📦 เก็บต่อ / Pending</td><td>กรณี VIP / Corporate / กำลังอยู่ในกระบวนการกฎหมาย</td><td>CEO / BD / Legal</td><td>กำหนดระยะเวลาเก็บต่อและเงื่อนไขให้ชัดเจน</td></tr></tbody></table></div>

<h4>ตารางอนุมัติส่วนลด (เชื่อมต่อจาก SOP-OPS:016) / Discount Approval Matrix</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ส่วนลด / Discount</th><th>ระยะเวลาฝาก</th><th>ผู้อนุมัติ</th><th>เงื่อนไข</th></tr></thead><tbody><tr><td>≤ 25%</td><td>ทุกช่วงเวลา</td><td>Guest Service Exe.</td><td>อนุมัติผ่านกลุ่ม Lark ได้ทันที</td></tr><tr><td>>25% ถึง 50%</td><td>≥ 6 เดือน (Long-term)</td><td>Operation Manager</td><td>ต้องมีเอกสาร + Approval Request Email + หลักฐาน | ขั้นต่ำชำระ 50% ของยอดเต็ม</td></tr><tr><td>>50%</td><td>VIP / Ex-Gratia เท่านั้น</td><td>BD / COO / CEO</td><td>ไม่อนุมัติในกรณีทั่วไป | เฉพาะ VIP Corporate หรือกรณีพิเศษที่ CEO พิจารณา</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3>📌 ตัวอย่างกรณี / Example Cases</h3>
<div class="sop-case"><p><strong>📑 Case 1: Long-term + ลูกค้ากลับมาก่อน Disposal</strong></p><ul><li>ฝาก 7 เดือน | กระเป๋า Large | ยอดค้าง 22,000 THB (Very High)</li><li>Base Table = 15% → Duration ≥ 6 เดือน → Special Discount 25–50%</li><li>OP Manager อนุมัติ 50% → จ่าย 11,000 THB (ขั้นต่ำ 50% ตาม Rule)</li><li>⚑ ต้องแนบเอกสาร + ส่ง Approval Request ก่อนยืนยันลูกค้า</li></ul></div>
<div class="sop-case"><p><strong>📑 Case 2: Long-term + ไม่ติดต่อ → Abandoned</strong></p><ul><li>ฝาก 9 เดือน | กระเป๋า Medium | ยอดค้าง 6,000 THB | ไม่ตอบ 3 Follow-ups</li><li>Day 30 → Abandonment Report | CEO อนุมัติ Dispose → บริจาค (สภาพดี)</li><li>บันทึก: ภาพก่อน-หลัง + องค์กรที่รับบริจาค + วันที่ + ผู้ดำเนินการ</li></ul></div>
<div class="sop-case"><p><strong>📑 Case 3: ลูกค้าโทรมาหลัง Disposal แล้ว</strong></p><ul><li>แจ้งสถานะ: กระเป๋าถูก Dispose ตาม T&amp;C (Notice Period ครบ)</li><li>มอบ Disposal Record ให้ลูกค้า</li><li>ไม่มีภาระผูกพันทางการเงินแก่บริษัท | หากโต้แย้ง → BD/Legal</li></ul></div>

<hr class="sop-hr">
<h3>📄 เอกสารที่ต้องใช้ / Required Documents</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>เอกสาร / Document</th><th>ใช้ช่วง / When</th><th>จัดทำโดย / By</th><th>เก็บที่ / Stored In</th></tr></thead><tbody><tr><td>Contact Attempt Log</td><td>Follow-up ทุกครั้ง (Day 1–25)</td><td>GS / CS</td><td>CRM / Lark</td></tr><tr><td>Formal Notice Email</td><td>Day 15</td><td>CS</td><td>Email Sent Folder + Lark</td></tr><tr><td>Final Notice (Email + LINE)</td><td>Day 25</td><td>OP Manager</td><td>Email + LINE Screenshot + Lark</td></tr><tr><td>Abandonment Report</td><td>Day 30</td><td>OP Manager</td><td>Lark Base + อีเมล CEO/BD</td></tr><tr><td>Disposal Record + Photos</td><td>หลัง Disposal</td><td>OP Manager</td><td>Lark Base + เก็บ 1 ปี</td></tr><tr><td>Approval Request Email</td><td>ส่วนลด >25% หรือ Disposal</td><td>CS / OP Manager</td><td>Email Chain + Lark</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3>💬 Scripts การสื่อสาร / Communication Scripts</h3>
<div class="sop-script"><strong>1️⃣ การรับเรื่องจากลูกค้า (เริ่มต้น)</strong><br>TH: สวัสดีค่ะ/ครับ ขอบคุณที่ติดต่อ AIRPORTELs รบกวนขอชื่อ-นามสกุล และรหัสการจอง เพื่อให้ทีมงานตรวจสอบข้อมูลการฝากสัมภาระของคุณลูกค้าค่ะ<br><span class="en">EN: Hello, thank you for contacting AIRPORTELs. May I have your full name and booking reference so our team can check your storage details?</span></div>
<div class="sop-script"><strong>2️⃣ กรณีลูกค้าแจ้งล่วงหน้า</strong><br>TH: หากคุณลูกค้าแจ้งล่วงหน้าก่อนถึงวันรับจริง เราสามารถช่วยจัดการได้ค่ะ เช่น เสนอการส่งสัมภาระให้ หรือพิจารณาลดค่าฝากตามที่กำหนดได้เลยค่ะ<br><span class="en">EN: If you inform us in advance, we can arrange solutions such as delivery or apply a discount on your storage fee per our policy.</span></div>
<div class="sop-script"><strong>3️⃣ กรณีไม่แจ้ง แต่มีเหตุสุดวิสัย</strong><br>TH: หากคุณลูกค้าไม่สามารถแจ้งล่วงหน้าได้ แต่มีเหตุสุดวิสัยพร้อมเอกสารยืนยัน เช่น ตั๋วเครื่องบินที่เลื่อน/ยกเลิก หรือใบรับรองแพทย์ เราสามารถพิจารณาส่วนลดให้ได้ค่ะ รบกวนส่งเอกสารมาที่อีเมลหรือ LINE ของเราด้วยนะคะ<br><span class="en">EN: If you couldn''t notify us due to force majeure and have supporting documents (flight cancellation, medical certificate), we can consider a discount. Please send documents via email or LINE.</span></div>
<div class="sop-script"><strong>4️⃣ แจ้งผลอนุมัติส่วนลด</strong><br>TH: เรียนคุณลูกค้า ทางทีมงานได้พิจารณาแล้ว และอนุมัติส่วนลด [XX%] สำหรับค่าฝากสัมภาระในครั้งนี้ค่ะ ขอบคุณที่ไว้วางใจใช้บริการ AIRPORTELs<br><span class="en">EN: Dear Customer, we are pleased to inform you that your discount request has been approved at [XX%]. Thank you for choosing AIRPORTELs.</span></div>
<div class="sop-script"><strong>5️⃣ แจ้งสถานะ Abandoned (หลัง Disposal)</strong><br>TH: เรียนคุณลูกค้า สัมภาระของท่านได้ผ่านกระบวนการแจ้งเตือนครบ 3 ครั้ง และครบระยะเวลา Notice Period 30 วันแล้ว ทางบริษัทจึงได้ดำเนินการตาม T&amp;C เรียบร้อยแล้ว หากต้องการเอกสารประกอบ กรุณาติดต่อทีมงานค่ะ<br><span class="en">EN: Dear Customer, your luggage has completed the 3-notice follow-up process and the 30-day Notice Period. The disposal has been completed per our T&C. Please contact us if you require documentation.</span></div>
<div class="sop-script"><strong>6️⃣ ชวนรีวิว Google</strong><br>TH: หากคุณลูกค้าพึงพอใจกับการบริการ รบกวนช่วยรีวิว AIRPORTELs ทาง Google Review ด้วยนะคะ ความเห็นของคุณลูกค้ามีคุณค่ามากสำหรับการพัฒนาบริการของเราค่ะ<br><span class="en">EN: If you are satisfied with our service, we would appreciate a Google Review. Your feedback helps us improve.</span></div>

<hr class="sop-hr">
<h3>👤 คู่มือลูกค้า — ของหายและกระเป๋าถูกทิ้ง / Customer Guide</h3>
<p class="sop-en"><em>ส่วนนี้จัดทำขึ้นสำหรับแจกหรือส่งอีเมลให้ลูกค้าโดยตรง สามารถพิมพ์หรือแชร์ได้</em></p>
<h4>1. กระเป๋าของฉันอยู่ที่ไหน? / Where is my luggage?</h4>
<p>หากคุณฝากกระเป๋าไว้กับ AIRPORTELs และไม่ได้มารับตามกำหนด กระเป๋าของคุณยังอยู่ที่สาขาที่ฝากไว้ AIRPORTELs จะพยายามติดต่อคุณ 3 ครั้ง ก่อนดำเนินการใดๆ</p>
<ul><li>ติดตาม Order ของคุณที่: <a href="https://app.airportels.asia/tracking" target="_blank" rel="noopener">app.airportels.asia/tracking</a></li><li>หรือติดต่อ: <strong>center@airportels.asia</strong> | LINE Official</li></ul>
<h4>2. ขั้นตอนหลังเกินกำหนด / What happens after the due date?</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ช่วงเวลา / Period</th><th>AIRPORTELs ทำอะไร?</th><th>ลูกค้าต้องทำ?</th></tr></thead><tbody><tr><td>Day 1–7</td><td>GS/CS ติดต่อครั้งที่ 1 (โทร/Email/LINE)</td><td>ตอบรับและยืนยันวันรับกระเป๋า</td></tr><tr><td>Day 15</td><td>ส่ง Formal Notice Email พร้อมยอดค้าง</td><td>ติดต่อกลับ + เตรียมเอกสาร (ถ้ามีเหตุสุดวิสัย)</td></tr><tr><td>Day 25</td><td>ส่ง Final Notice (5 วันสุดท้าย)</td><td>ติดต่อกลับทันที ก่อนสิ้นสุดกำหนด</td></tr><tr><td>Day 30</td><td>กระเป๋าถูกกำหนดสถานะ Abandoned</td><td>หากยังต้องการกระเป๋า ติดต่อทันทีก่อน Disposal</td></tr><tr><td>Day 31+</td><td>ดำเนินการ Disposal ตาม T&amp;C</td><td>ขอ Disposal Record ได้ที่ ops@airportels.com</td></tr></tbody></table></div>
<h4>3. ขอส่วนลดค่าฝากได้หรือไม่? / Can I request a discount?</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>กรณี / Case</th><th>ส่วนลดที่ได้รับ</th><th>เอกสารที่ต้องแสดง</th></tr></thead><tbody><tr><td>แจ้งล่วงหน้าก่อนวันรับ</td><td>ตามตาราง Base Table</td><td>ไม่ต้องมีเอกสารพิเศษ</td></tr><tr><td>ไม่แจ้ง มีเหตุสุดวิสัย</td><td>พิจารณาตามกรณี</td><td>ตั๋วสายการบิน / ใบรับรองแพทย์ / หนังสือราชการ</td></tr><tr><td>Long-term ≥ 6 เดือน</td><td>25–50% (ขั้นต่ำจ่าย 50%)</td><td>ประวัติการฝาก + เหตุผล + อนุมัติ OP Manager</td></tr><tr><td>VIP / Corporate</td><td>พิจารณาเป็นกรณี</td><td>Email ฝ่ายการตลาด/BD | Customer profile</td></tr><tr><td>ไม่ตรงเงื่อนไข</td><td>ไม่มีส่วนลด</td><td>ต้องชำระเต็มจำนวน</td></tr></tbody></table></div>
<h4>4. ติดต่อ AIRPORTELs / Contact Us</h4>
<ul><li>Official notifications from: <strong>center@airportels.asia</strong></li><li>Website: <a href="https://www.airportels.asia" target="_blank" rel="noopener">www.airportels.asia</a> | T&amp;C: <a href="https://www.airportels.asia/terms-conditions/" target="_blank" rel="noopener">www.airportels.asia/terms-conditions/</a></li><li>Hours: ตามเวลาทำการของสาขา | Branch operating hours apply</li></ul>

<div class="sop-note"><strong>✔ Checklist สำหรับลูกค้า (กรณีเกินกำหนดรับ)</strong><ul><li>ติดต่อ AIRPORTELs ทันทีที่ทราบว่าไม่สามารถมารับได้ตามกำหนด</li><li>เตรียมเอกสารหลักฐาน (ถ้ามีเหตุสุดวิสัย): ตั๋วสายการบิน / ใบรับรองแพทย์ / เอกสารราชการ</li><li>ยืนยันวันที่จะมารับกระเป๋า หรือขอให้จัดส่งถึงที่</li><li>หากได้รับ Formal Notice Email → ตอบกลับทันทีอย่าเพิกเฉย</li><li>หากต้องการข้อมูล Disposal Record → ติดต่อ Customer Service</li></ul></div>

<hr class="sop-hr">
<h3>🔹 ประวัติการแก้ไข / Document Control</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Version</th><th>วันที่ / Date</th><th>แก้ไขโดย / Author</th><th>รายละเอียด / Notes</th></tr></thead><tbody><tr><td>1.0</td><td>10 May 2026</td><td>Operations Team</td><td>Initial release / เอกสารฉบับแรก</td></tr></tbody></table></div>',
    doc_code = 'SOP-OPS-023/2026',
    summary = 'SOP-OPS 023 — ขั้นตอนจัดการสัมภาระที่ลูกค้าไม่ติดต่อ/ไม่มารับ/ทอดทิ้ง ต่อจาก SOP-OPS:016 เส้นเวลาติดตาม 3 ครั้ง (Day 1–25) การกำหนดสถานะ Abandoned (Day 30) ช่องทางการกำจัด (บริจาค/ขายทอดตลาด/ทำลาย) และสคริปต์สื่อสาร'
where slug = 'abandoned-luggage-disposal';
commit;
