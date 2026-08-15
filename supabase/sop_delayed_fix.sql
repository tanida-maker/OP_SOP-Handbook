-- ============================================================
-- AIRPORTELs SOP Hub — SOP-OPS 0016/2025 (Delayed Collection – Discount)
--   Faithful re-render from source PDF: readable text + all 3 tables
--   (Discount Structure, Specific Conditions by Case, Size Factor) as
--   scrollable HTML tables, section dividers, and the 3 reference links.
-- Idempotent. Content served dynamically (no redeploy needed).
-- ============================================================
begin;
update sop.documents
set content_html = '<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px}
.prose table.sop-tbl td{min-width:150px;max-width:340px;vertical-align:top;font-size:13.5px;line-height:1.6}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:130px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.prose .sop-tblwrap{overflow-x:auto;-webkit-overflow-scrolling:touch;margin:10px 0;border:1px solid var(--border,#e5e7eb);border-radius:8px}
.prose .sop-tblwrap table.sop-tbl{margin:0;border:0;min-width:560px}
.prose hr.sop-hr{border:0;border-top:1px solid var(--border,#e5e7eb);margin:26px 0;opacity:.8}
.prose hr.sop-subhr{border:0;border-top:1px dashed var(--border,#e5e7eb);margin:20px 0 16px;opacity:.7}
.prose h4{margin-top:24px;margin-bottom:8px}
.prose ol,.prose ul{margin:8px 0}
.prose ol>li{margin:9px 0;line-height:1.75;padding-left:4px}
.prose li{margin:6px 0;line-height:1.72}
.prose ol ul{margin:6px 0}
.sop-en{color:var(--text-muted,#6b7280)}
.sop-note{background:var(--surface-2);border-left:3px solid #f59e0b;border-radius:6px;padding:10px 14px;margin:10px 0;font-size:14px;line-height:1.65}
.sop-case{border:1px solid var(--border,#e5e7eb);border-radius:8px;padding:8px 14px;margin:8px 0}
.sop-script{background:var(--surface-2);border-left:3px solid #1a66e0;border-radius:6px;padding:9px 13px;margin:8px 0;font-size:13.5px;line-height:1.6}
.sop-script .en{color:var(--text-muted,#6b7280);font-style:italic}
</style>

<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 0016/2025 &nbsp;·&nbsp; <strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 ตุลาคม 2568 &nbsp;·&nbsp; <strong>หน่วยงาน:</strong> Operations</p></blockquote>

<h3>📎 อ้างอิง / Reference</h3>
<ul>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/FTsVwAwIOixPSfkldG6ljlPcg5b?from=from_copylink" target="_blank" rel="noopener">(TH) Terms and Conditions 2026</a> / <a href="https://ssglsj0spi27.sg.larksuite.com/wiki/Y8OCwI9k4iu1tmkE4B1lmNfNg2e?from=from_copylink" target="_blank" rel="noopener">(EN) Terms and Conditions 2026</a></li>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/NRNcwv3zQiwkaekwfaClYn3eg0T?from=from_copylink" target="_blank" rel="noopener">SOP: ขั้นตอนปฏิบัติมาตรฐานสำหรับการจัดการและการกำจัดสัมภาระที่ถูกทิ้ง (SOP-OPS:023)</a></li>
</ul>

<hr class="sop-hr">
<h3>🎯 วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดมาตรฐานการดำเนินการเมื่อลูกค้าไม่สามารถมารับสัมภาระตามกำหนดเวลา โดยมีแนวทางการพิจารณาส่วนลดที่เป็นธรรม สร้างความพึงพอใจให้ลูกค้า ป้องกันการทิ้งสัมภาระ และคงไว้ซึ่งรายได้ของบริษัท</p>

<hr class="sop-hr">
<h3>📌 ขอบเขต (Scope)</h3>
<ul>
<li>ใช้กับการให้บริการลูกค้าทุกประเภทที่ฝากสัมภาระกับ AIRPORTELs ทั้งสาขาหน้าร้าน และช่องทางออนไลน์ (Call Center, Email, Line, Facebook)</li>
<li>ครอบคลุมพนักงานทุกตำแหน่งที่เกี่ยวข้อง ได้แก่ Guest Service Staff, Branch Manager และ Customer Service Team</li>
<li>ใช้กับทุกกรณีของ <strong>การรับกระเป๋าล่าช้า (Delayed Collection)</strong> <strong>ยกเว้น</strong> กรณีลูกค้าไม่ติดต่อ/ไม่มารับเลย ซึ่งต้องเข้าสู่ขั้นตอน Lost &amp; Found / Disposal ตามนโยบายบริษัท</li>
</ul>

<hr class="sop-hr">
<h3>💰 Discount Policy (Duration ≥ 6 เดือน)</h3>
<h4>1. Criteria (เกณฑ์พิจารณา)</h4>
<ul>
<li><strong>Size Factor:</strong> Small / Medium / Large / Oversize or Special</li>
<li><strong>Fee Factor:</strong> Low / Medium / High / Very High</li>
<li><strong>Duration Factor (ระยะเวลาฝาก):</strong>
  <ul>
  <li><strong>Short-term:</strong> ≤ 3 เดือน → ใช้โครงสร้าง Base Table ปกติ</li>
  <li><strong>Mid-term:</strong> 3–6 เดือน → ใช้ Base Table + ส่วนลดเพิ่มเล็กน้อย (+5–10%)</li>
  <li><strong>Long-term:</strong> ≥ 6 เดือน → เข้าสู่เงื่อนไขพิเศษ (25–50%)</li>
  </ul>
</li>
</ul>

<h4>Discount Structure (ตามยอดเงิน + ขนาด)</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Size \ Fee</th><th>&lt; 5,000</th><th>5,000–10,000</th><th>10,001–20,000</th><th>&gt; 20,000</th></tr></thead><tbody><tr><td>Small</td><td>10%</td><td>15%</td><td>20%</td><td>25%</td></tr><tr><td>Medium</td><td>5%</td><td>10%</td><td>15%</td><td>20%</td></tr><tr><td>Large</td><td>0%</td><td>5%</td><td>10%</td><td>15%</td></tr><tr><td>Oversize / Special</td><td>0%</td><td>0–5%</td><td>5%</td><td>10%</td></tr></tbody></table></div>

<h4>Duration Adjustment</h4>
<ul>
<li>≤ 3 เดือน → ใช้ส่วนลดตามตารางเท่านั้น</li>
<li>3–6 เดือน → เพิ่มส่วนลดได้ +5–10% จากตารางส่วนลด (รวมแล้วไม่เกิน 30%)</li>
<li>≥ 6 เดือน → ใช้ <strong>Special Duration Discount</strong>:
  <ul>
  <li>ส่วนลดรวมอยู่ในช่วง <strong>25–50%</strong> (ขึ้นกับขนาด/ยอด/เหตุผลลูกค้า)</li>
  <li>แต่ต้องจ่าย <strong>ขั้นต่ำ 50% ของยอดเต็ม</strong></li>
  </ul>
</li>
</ul>

<h4>Approval Authority</h4>
<ul>
<li>ส่วนลดรวม <strong>≤ 25%</strong> → Guest Service Exe. อนุมัติได้</li>
<li>ส่วนลดรวม <strong>&gt;25% ถึง 50%</strong> (กรณี ≥ 6 เดือน) → ต้องขออนุมัติจาก <strong>Operation Manager</strong></li>
<li>ส่วนลดรวม <strong>&gt;50%</strong> → ไม่อนุมัติ ยกเว้นกรณี VIP (BD / COO / CEO approval)</li>
</ul>

<hr class="sop-hr">
<h3>📌 ตัวอย่างกรณี (Example Cases)</h3>
<div class="sop-case"><p><strong>Case 1:</strong> ลูกค้าฝาก 7 เดือน / กระเป๋า Large / ยอดค้าง 22,000 บาท (Very High)</p><ul><li>Base Table = 15%</li><li>Duration ≥ 6 เดือน → ปรับเป็น Special Duration Discount 25–50%</li><li>หาก Operation Manager อนุมัติ → ลดได้สูงสุด 50% (เหลือจ่าย 11,000 บาท)</li></ul></div>
<div class="sop-case"><p><strong>Case 2:</strong> ลูกค้าฝาก 8 เดือน / กระเป๋า Small / ยอดค้าง 6,000 บาท (Medium)</p><ul><li>Base Table = 15%</li><li>Duration ≥ 6 เดือน → ปรับใหม่เป็น 25–50%</li><li>อนุมัติ 30% → จ่าย 4,200 บาท (ขั้นต่ำต้องจ่าย 3,000 บาท ตาม rule 50%)</li></ul></div>

<hr class="sop-hr">
<h3>📋 Conditions &amp; Required Documents for Discount Consideration</h3>
<h4>1. General Conditions (เงื่อนไขทั่วไป)</h4>
<ul>
<li>a. ลูกค้าต้อง <strong>ติดต่อกลับมา</strong> และแสดงความประสงค์จะชำระหรือรับกระเป๋า (ไม่ใช่ abandon case)</li>
<li>b. ลูกค้าต้องชำระ <strong>ขั้นต่ำ 50% ของยอดค้างชำระเต็ม</strong></li>
<li>c. ส่วนลด <strong>≤25%</strong> → อนุมัติได้โดย Guest Service Exe.</li>
<li>d. ส่วนลด <strong>26–50%</strong> → ต้องมี เอกสารหลักฐาน + ส่งรายงานขออนุมัติ Operation Manager</li>
<li>e. ส่วนลด <strong>&gt;50%</strong> → อนุมัติได้เฉพาะกรณี VIP / Ex-gratia โดย BD หรือ CEO เท่านั้น</li>
</ul>

<h4>2. Specific Conditions by Case (กรณีและหลักฐานประกอบ)</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Case</th><th>เงื่อนไขการพิจารณา</th><th>เอกสาร/หลักฐานที่ต้องใช้</th></tr></thead><tbody><tr><td>แจ้งล่วงหน้า</td><td>ลูกค้าแจ้งก่อนถึงวันรับจริง</td><td>- Email/ข้อความจากลูกค้า<br>- Chat log หรือ CRM note</td></tr><tr><td>ไม่แจ้ง แต่มีเหตุสุดวิสัย</td><td>มีเหตุผลชัดเจนและมีหลักฐาน เช่น เที่ยวบิน/สุขภาพ/เอกสารทางราชการ</td><td>- เอกสารจากสายการบิน (Flight delay/cancel)<br>- ใบรับรองแพทย์<br>- หนังสือราชการ/เอกสารยืนยันอื่นๆ</td></tr><tr><td>ไม่แจ้ง และไม่มีเหตุผลสมควร</td><td>ลูกค้าไม่ติดต่อ/ไม่มีเอกสารยืนยัน</td><td>- บันทึกในระบบว่าได้ follow up แล้ว แต่ไม่มี response</td></tr><tr><td>Special Case (VIP / Corporate)</td><td>กรณีรักษาลูกค้าระยะยาว, สัญญา corporate, retention, หรือ case พิเศษ</td><td>- Email จากฝ่ายการตลาด/BD Manager<br>- Customer profile ระบุ VIP/Corp</td></tr><tr><td>Long-term storage ≥ 6 เดือน</td><td>ลูกค้าฝากยาวผิดปกติ และต้องการส่วนลดพิเศษ (25–50%)</td><td>- สัญญาฝาก/ระบบ transaction log ยืนยันระยะเวลา<br>- บันทึกการติดต่อกับลูกค้า</td></tr></tbody></table></div>

<h4>Process &amp; Documentation Flow (ขั้นตอนและการบันทึก)</h4>
<p><strong>Guest Service Staff / Branch Manager</strong></p>
<ul>
<li>ตรวจสอบข้อมูลลูกค้า (Size, Fee, Duration)</li>
<li>ขอเอกสาร/หลักฐานจากลูกค้า (ถ้ามี)</li>
<li>บันทึกใน Sales report หรือ Incident report</li>
</ul>
<p><strong>GS Team Lead</strong></p>
<ul>
<li>ตรวจสอบความถูกต้องของเอกสาร</li>
<li>อนุมัติทันทีถ้า Discount ≤25%</li>
<li>ถ้าเกิน 25% → forward <strong>Approval Request</strong> ไปยัง Operation Manager</li>
</ul>
<p><strong>Operation Manager</strong></p>
<ul>
<li>ตรวจสอบหลักฐาน, เหตุผลธุรกิจ (retention/VIP/long-term)</li>
<li>อนุมัติหรือปรับลด % ส่วนลดตาม policy (25–50%)</li>
<li>บันทึกการอนุมัติใน Sales Report หรือ อาจจัดทำเอกสาร Approve หรือระบบ Approve Lark</li>
</ul>

<hr class="sop-hr">
<h3>🧳 Criteria: ขนาดสัมภาระ (Size Factor)</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ประเภท</th><th>เกณฑ์ที่วัด (Criteria)</th><th>ตัวอย่างสัมภาระ (Examples)</th><th>หมายเหตุ</th></tr></thead><tbody><tr><td>Small</td><td>≤ 20 นิ้ว (carry-on)<br>หรือ น้ำหนัก ≤ 10 กก.</td><td>- กระเป๋าล้อลากเล็ก (cabin size)<br>- Backpack ใบกลาง<br>- กระเป๋า tote/duffle เล็ก / Shopping bag</td><td>ใช้เกณฑ์ด้านยาวที่สุด ≤ 20 นิ้ว เป็นหลัก</td></tr><tr><td>Medium</td><td>21–26 นิ้ว<br>หรือ น้ำหนัก ~ 10–20 กก.</td><td>- กระเป๋าล้อลาก 24 นิ้ว<br>- Duffle bag ขนาดใหญ่<br>- กล่องพัสดุขนาดกลาง</td><td>ขนาดที่ใช้เดินทาง 3–7 วัน</td></tr><tr><td>Large</td><td>27–32 นิ้ว<br>หรือ น้ำหนัก ~ 20–32 กก.</td><td>- กระเป๋าล้อลาก 29–30 นิ้ว<br>- กล่องเดินทางใหญ่</td><td>เป็นกระเป๋า check-in ใบใหญ่สำหรับเดินทาง</td></tr><tr><td>Oversize / Special</td><td>&gt; 32 นิ้ว หรือเกินมาตรฐานรูปทรง <strong>หรือ</strong> เป็นสิ่งของพิเศษ</td><td>- กระเป๋ากอล์ฟ<br>- จักรยาน (ใส่กล่อง)<br>- อุปกรณ์ดนตรี<br>- กล่องใหญ่พิเศษ/ลังไม้</td><td>วัดจาก: น้ำหนักเกิน 32 กก. หรือมีรูปทรงไม่สามารถวางซ้อนได้</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3>🔄 ขั้นตอนดำเนินการ (Walk-in vs Call Center / Online)</h3>
<h4>กรณีลูกค้า Walk-in</h4>
<ol>
<li>รับคำร้องขอ: พนักงานเคาน์เตอร์สอบถามข้อมูล → เลขฝาก, วันที่ฝาก, ระยะเวลา, เหตุผลที่มารับช้า</li>
<li>ตรวจสอบข้อมูลระบบ: ขนาดสัมภาระ (Size Factor) | ยอดค้างชำระ (Fee Factor) | ระยะเวลาฝาก (Duration Factor) | สถานะการติดต่อก่อนหน้า (มี follow-up หรือไม่)</li>
<li>ขอหลักฐาน (ถ้ามี): เช่น เอกสารสายการบิน, ใบรับรองแพทย์, เอกสารราชการอื่นๆ</li>
<li>คำนวณค่าฝาก + ส่วนลดตามโครงสร้าง
  <ul><li>ถ้าส่วนลด ≤25% → ประสานงานแจ้ง Guest Service Exe. อนุมัติผ่านกลุ่ม Lark ได้</li><li>ถ้าเกิน 25% → ประสานงานแจ้ง Case + ส่งต่อขออนุมัติไปยัง Operation Manager ผ่านกลุ่ม Lark</li></ul>
</li>
<li>แจ้งลูกค้า: สรุปยอดสุทธิที่ต้องจ่าย + เงื่อนไข (เช่น ต้องจ่ายขั้นต่ำ 50%)</li>
<li>ดำเนินการรับชำระ / คืนสัมภาระ</li>
<li>บันทึกใน Sales report / ระบบ: ระบุ case type + ส่วนลดที่อนุมัติ + แนบเอกสาร</li>
</ol>
<hr class="sop-subhr">
<h4>กรณีลูกค้าติดต่อผ่าน Call Center / Online (โทร, อีเมล, LINE, FB)</h4>
<ol>
<li>รับเรื่อง: CS บันทึกข้อมูลการติดต่อ → เลขฝาก, วันที่ฝาก, เหตุผล</li>
<li>ตรวจสอบข้อมูลในระบบ: ขนาดสัมภาระ / ยอดค้าง / ระยะเวลาฝาก</li>
<li>ขอให้ลูกค้าส่งหลักฐาน (ถ้าต้องใช้) ผ่าน Email / Line Official → attach file</li>
<li>คำนวณค่าฝาก + ส่วนลดเบื้องต้น ตามเกณฑ์</li>
<li>ดำเนินการอนุมัติ
  <ul><li>≤25% → CS แจ้ง Guest Service Exe. อนุมัติและ confirm ลูกค้าได้เลย</li><li>&gt;25% → CS ต้องทำ "Approval Request Email" ส่ง Operation Manager พร้อมแนบหลักฐาน</li></ul>
</li>
<li>แจ้งลูกค้า:
  <ul><li>ถ้าอนุมัติ → ส่งสรุปยอดสุทธิ + ช่องทางการชำระเงิน (โอน/QR/ชำระที่สาขา)</li><li>ถ้ายังรออนุมัติ → แจ้งลูกค้าว่าจะได้รับการยืนยันภายใน [xx] ชั่วโมง</li></ul>
</li>
<li>หลังลูกค้าชำระแล้ว → Update ข้อมูลในระบบ + แจ้งสาขาให้เตรียมกระเป๋าเพื่อรับหรือส่งกลับ</li>
</ol>

<hr class="sop-hr">
<h3>💬 Script (TH / EN – Updated)</h3>
<div class="sop-script"><strong>1. การรับเรื่องจากลูกค้า</strong><br>TH: "สวัสดีค่ะ/ครับ ขอบคุณที่ติดต่อ AIRPORTELs รบกวนขอชื่อ-นามสกุล และรหัสการจอง เพื่อให้ทีมงานตรวจสอบข้อมูลการฝากสัมภาระของคุณลูกค้าค่ะ"<br><span class="en">EN: "Hello, thank you for contacting AIRPORTELs. May I have your full name and booking reference so that we can check your storage details?"</span></div>
<div class="sop-script"><strong>2. กรณีลูกค้าแจ้งล่วงหน้า</strong><br>TH: "หากคุณลูกค้าแจ้งล่วงหน้าก่อนถึงวันรับจริง เราสามารถช่วยจัดการได้ค่ะ เช่น เสนอการส่งสัมภาระให้ หรือพิจารณาลดค่าฝากตามที่กำหนดได้เลยค่ะ"<br><span class="en">EN: "If you inform us in advance before the scheduled pick-up date, we can arrange solutions such as delivery service or apply a discount on your storage fee."</span></div>
<div class="sop-script"><strong>3. กรณีไม่แจ้ง แต่มีเหตุสุดวิสัย</strong><br>TH: "หากคุณลูกค้าไม่สามารถแจ้งล่วงหน้าได้ แต่มีเหตุสุดวิสัยพร้อมเอกสารยืนยัน เช่น ตั๋วเครื่องบินที่เลื่อน/ยกเลิก หรือใบรับรองแพทย์ เราสามารถลดให้ได้ xx% ค่ะ เนื่องจากค่าฝากแบบรายเดือนเป็นราคาเหมารวมอยู่แล้ว"<br><span class="en">EN: "If you were unable to notify us in advance but have a valid reason with supporting documents (e.g., flight delay/cancellation, medical certificate), we can offer a xx% discount, since monthly storage is already based on a flat rate."</span></div>
<div class="sop-script"><strong>4. การแจ้งลูกค้าให้อดทนรอผลการอนุมัติ</strong><br>TH: "ขอบคุณสำหรับข้อมูลและเอกสารค่ะ ตอนนี้ทีมงานกำลังตรวจสอบและจะรีบแจ้งผลการพิจารณาให้คุณลูกค้าทราบโดยเร็วที่สุดค่ะ"<br><span class="en">EN: "Thank you for providing the information and documents. Our team is reviewing your case, and we will update you with the decision as soon as possible."</span></div>
<div class="sop-script"><strong>5. การแจ้งผลอนุมัติส่วนลด</strong><br>TH: "เรียนคุณลูกค้า ทางทีมงานได้พิจารณาแล้ว และอนุมัติส่วนลด [XX%] สำหรับค่าฝากสัมภาระในครั้งนี้ค่ะ ขอบคุณที่ไว้วางใจใช้บริการ AIRPORTELs และหวังว่าจะได้ให้บริการอีกในอนาคตนะคะ"<br><span class="en">EN: "Dear Customer, we are pleased to inform you that your discount request has been approved at [XX%] for this storage. Thank you for choosing AIRPORTELs, and we look forward to serving you again."</span></div>
<div class="sop-script"><strong>6. การชวนลูกค้ารีวิว (Google Review)</strong><br>TH: "หากคุณลูกค้าพึงพอใจกับการบริการ รบกวนช่วยรีวิว AIRPORTELs ทาง Google Review ได้ไหมคะ ความเห็นของคุณลูกค้ามีคุณค่ามากสำหรับการพัฒนาบริการของเรา"<br><span class="en">EN: "If you are satisfied with our service, we would greatly appreciate it if you could leave us a review on Google. Your feedback means a lot to us."</span><br><br>TH: "ทางเราขอพิจารณาส่วนลดพิเศษจากราคา xx,xxx บาท เหลือเพียง x,xxx บาทค่ะ และหากคุณลูกค้าได้รับความพึงพอใจจากการให้บริการของพนักงานและสาขา รบกวนช่วยรีวิวใน Google Map เพื่อเป็นกำลังใจให้ทีมงานด้วยนะคะ"<br><span class="en">EN: "We are pleased to offer you a special discount from xx,xxx THB to only x,xxx THB. If you are satisfied with our staff and service, we would greatly appreciate it if you could leave us a 5-star review on Google Maps to support our team. Thank you very much."</span></div>'
where slug = 'delayed-pickup-discount';
commit;
