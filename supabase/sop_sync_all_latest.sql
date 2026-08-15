-- ============================================================
-- AIRPORTELs SOP Hub — SYNC ALL latest content fixes (one run)
--   SOP-020 (DMK), SOP-016 (Delayed), SOP-023 (Abandoned),
--   SOP-026 (Complaint). Readable content, scrollable tables,
--   correct doc codes + links, mobile & desktop responsive.
-- Idempotent — safe to re-run. Run once in Supabase SQL Editor.
-- ============================================================

-- ===== sop_dmk_fix =====
--   phone numbers, real Prohibited-Items table, related-document links.
begin;
update sop.documents
set content_html = '<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:14px}
.prose table.sop-tbl td{min-width:200px;max-width:420px;vertical-align:top;font-size:14px;line-height:1.6}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:180px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.sop-note{background:var(--surface-2);border-left:3px solid #f59e0b;border-radius:6px;padding:10px 14px;margin:10px 0;font-size:14.5px;line-height:1.65}
.sop-danger{border:1px solid rgba(220,38,38,.38);background:rgba(220,38,38,.07);border-radius:12px;padding:6px 18px 12px;margin:14px 0}
.sop-danger h3{color:#dc2626;margin:12px 0 8px}
.sop-en{color:var(--text-muted,#6b7280)}
.prose .sop-callout{background:var(--surface-2);border-left:3px solid #dc2626;border-radius:6px;padding:8px 14px;margin:6px 0}
.prose hr.sop-hr{border:0;border-top:1px solid var(--border,#e5e7eb);margin:26px 0;opacity:.8}
.prose h3{scroll-margin-top:70px;padding-top:2px}
.prose h4{margin-top:16px}
.prose li{margin:5px 0;line-height:1.7}
@media (max-width:480px){
.prose .sop-tblwrap table.sop-tbl{min-width:460px}
.prose table.sop-tbl th,.prose table.sop-tbl td{font-size:12.5px;min-width:120px}
.prose .sop-tl{grid-template-columns:82px 1fr}
.prose .sop-hstep{grid-template-columns:44px 1fr}
.prose .sop-hstep>.n{font-size:16px}
.prose .sop-step{grid-template-columns:38px 1fr}
.prose blockquote{padding:8px 12px}
}
</style>

<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 020/2026 &nbsp;·&nbsp; <strong>เวอร์ชัน:</strong> ปรับปรุงครั้งที่ 1<br><strong>วันที่บังคับใช้:</strong> 1 มกราคม 2569 &nbsp;·&nbsp; <strong>หน่วยงาน:</strong> Operations</p></blockquote>

<h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>เพื่อกำหนดขั้นตอนการรับและส่งมอบกระเป๋าเดินทาง ณ ท่าอากาศยานดอนเมือง ให้เป็นไปตามข้อกำหนดด้านความปลอดภัยของการท่าฯ (ทอท.) และใช้เป็นแนวปฏิบัติจริงสำหรับพนักงานหน้าสาขา</p>
<p class="sop-en"><em>To establish operational procedures for luggage acceptance and release at Don Mueang Airport in compliance with AOT security regulations.</em></p>

<hr class="sop-hr">
<h3>📌 ขอบเขตการใช้งาน / Scope</h3>
<p>ใช้สำหรับพนักงาน AIRPORTELs ประจำสาขาดอนเมือง (DMK) ทุกตำแหน่งที่เกี่ยวข้องกับการรับ ฝาก ส่งมอบ และตรวจสอบกระเป๋า</p>
<p class="sop-en"><em>Applicable to all AIRPORTELs staff involved in luggage acceptance, storage, delivery, and X-ray screening at DMK.</em></p>

<hr class="sop-hr">
<h3>คำจำกัดความ (Definitions)</h3>
<ul>
<li><strong>พนักงานหน้าสาขา (Guest Service &amp; Porter):</strong> พนักงานที่ให้บริการลูกค้า ณ จุดบริการ</li>
<li><strong>ผู้รับมอบฉันทะ:</strong> บุคคลที่ได้รับมอบอำนาจเป็นลายลักษณ์อักษรจากเจ้าของกระเป๋า</li>
<li><strong>ทอท. (AOT):</strong> บริษัท ท่าอากาศยานไทย จำกัด (มหาชน)</li>
</ul>

<hr class="sop-hr">
<h3>บทบาทและความรับผิดชอบ (Roles &amp; Responsibilities)</h3>
<h4>พนักงานหน้าสาขาทุกตำแหน่ง (Guest Service &amp; Porter)</h4>
<ul>
<li>ตรวจสอบการจองและเอกสารลูกค้า</li>
<li>ชี้แจงเงื่อนไขการให้บริการและข้อกำหนดด้านความปลอดภัย</li>
<li>ปฏิบัติตามขั้นตอน SOP อย่างเคร่งครัด</li>
<li>หยุดกระบวนการและรายงานเมื่อพบความเสี่ยง</li>
</ul>
<h4>หัวหน้าสาขา (Branch Manager) / ผู้ควบคุมงาน (Operation Team)</h4>
<ul>
<li>กำกับดูแลการปฏิบัติงานให้เป็นไปตาม SOP</li>
<li>ประสานงานกับเจ้าหน้าที่ ทอท. ในกรณีผิดปกติ</li>
</ul>

<hr class="sop-hr">
<h3>ขั้นตอนการปฏิบัติงาน (Operational Procedures)</h3>
<h4>🧳 ขั้นตอนการรับฝากกระเป๋า (Luggage Acceptance)</h4>
<ol>
<li>รับลูกค้าและตรวจสอบการจองในระบบ</li>
<li>ขอเอกสารประจำตัว ID Card / Passport เพื่อบันทึกข้อมูลลงในระบบ POS</li>
<li>ตรวจสอบกระเป๋า หรือสัมภาระ ร่วมกับผู้ใช้บริการ ทั้งภายนอกและภายใน</li>
<li>ชี้แจงข้อกำหนดด้านความปลอดภัยของ ทอท. และแจ้งว่ากระเป๋าทุกใบต้องผ่านการตรวจ X-ray</li>
<li>ขอความยินยอมจากลูกค้าเพื่อดำเนินการตรวจ X-ray</li>
<li>หากไม่ยินยอม ให้ปฏิเสธการให้บริการทันที</li>
<li>นำกระเป๋าเข้าตรวจด้วยเครื่อง X-ray โดยผู้ได้รับอนุญาต</li>
<li>จัดประเภทผล X-ray:
  <ul>
  <li><strong>Clear:</strong> ดำเนินการรับกระเป๋าเข้าระบบ</li>
  <li><strong>Prohibited Item:</strong> แยกสิ่งของออก และส่งมอบคืนให้ผู้ใช้บริการ</li>
  <li><strong>Suspicious Item:</strong> หยุดกระบวนการ ห้ามเปิดกระเป๋า และประสาน ทอท. ตรวจสอบทันที ที่เบอร์โทร <strong>02-535 1616</strong></li>
  </ul></li>
<li>ติด Tag / Label และบันทึกข้อมูลกระเป๋าในระบบ</li>
</ol>

<h4>📤 ขั้นตอนการส่งมอบกระเป๋า (Luggage Release)</h4>
<ol>
<li>ผู้มารับกระเป๋าแสดงเอกสารรับกระเป๋า</li>
<li>ตรวจสอบว่าผู้รับเป็นเจ้าของกระเป๋าหรือผู้รับมอบฉันทะ</li>
<li>ตรวจสอบเอกสารประจำตัว / หนังสือมอบฉันทะ (ถ้ามี)</li>
<li>ตรวจสอบ Tag / Label ให้ตรงกับข้อมูลในระบบ</li>
<li>ส่งมอบกระเป๋าให้ผู้รับ</li>
<li>บันทึกการส่งมอบในระบบ</li>
</ol>

<figure><img src="/sop/dmk-airport-service/fig2.jpg" alt="แผนผังกระบวนการรับ–ส่งมอบกระเป๋า (Process Flowchart)" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /><figcaption style="font-size:12.5px;color:var(--text-muted,#6b7280);text-align:center;margin-top:4px">แผนผังกระบวนการรับ–ส่งมอบกระเป๋า (Process Flowchart)</figcaption></figure>

<hr class="sop-hr">
<div class="sop-danger">
<h3>🚫 ข้อห้ามและข้อควรระวัง (Prohibitions &amp; Precautions)</h3>
<ul>
<li>ห้ามรับกระเป๋าที่ไม่ผ่านการตรวจ X-ray</li>
<li>ห้ามเปิดกระเป๋าด้วยตนเองในทุกกรณี</li>
<li>ห้ามรับกระเป๋าที่พบสิ่งของต้องห้ามตามข้อกำหนดสนามบิน</li>
<li>ต้องปฏิบัติตามคำสั่งของเจ้าหน้าที่ ทอท. อย่างเคร่งครัด</li>
</ul>
</div>

<hr class="sop-hr">
<h3>📄 เอกสารที่เกี่ยวข้อง (Related Documents)</h3>
<ul>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/CRaPwR0lXi7D2mk2iENlmjd4gUe?from=from_copylink" target="_blank" rel="noopener">SOP : AIRPORT LUGGAGE STORAGE / DELIVERY SERVICE AT DMK AIPORT</a></li>
<li><a href="https://ssglsj0spi27.sg.larksuite.com/wiki/QJBWwtlRXiqL8MkOxijlg5HKg8b?from=from_copylink" target="_blank" rel="noopener">SOP: การให้ผู้อื่นมารับกระเป๋าแทน / Authorized Person Pickup</a></li>
</ul>

<hr class="sop-hr">
<h3>⛔ รายการสิ่งของต้องห้าม (Prohibited Items)</h3>
<p>❌ ห้ามจัดส่งสิ่งของดังต่อไปนี้ : <a href="https://ssglsj0spi27.sg.larksuite.com/wiki/OovBwWiQhi0Rhjk7gUdly8Yfgyf?from=from_copylink" target="_blank" rel="noopener">Prohibit Items</a></p>
<table class="sop-tbl">
<thead><tr><th>ประเภทสิ่งของต้องห้าม</th><th>ตัวอย่าง (Examples)</th></tr></thead>
<tbody>
<tr><td>ของมีค่า / ของสำคัญ</td><td>เงินสด, ทอง, เพชร, เช็ค, บัตรประชาชน, พาสปอร์ต</td></tr>
<tr><td>สินค้าผิดกฎหมาย / อันตราย</td><td>ยาเสพติด, อาวุธ, วัตถุไวไฟ, แบตเตอรี่, สารเคมี</td></tr>
<tr><td>ของเหลว / ของเน่าเสียง่าย</td><td>เครื่องดื่ม, น้ำหอม, เนื้อสัตว์, ผักผลไม้</td></tr>
<tr><td>สิ่งมีชีวิต</td><td>สัตว์เลี้ยง, ปลา, นก</td></tr>
<tr><td>สื่อผิดกฎหมาย / ลามก</td><td>ภาพหรือสื่ออนาจาร, ลอตเตอรี่, สินค้าละเมิดลิขสิทธิ์</td></tr>
</tbody>
</table>

<div class="sop-note">
<p>💡 <strong>หมายเหตุ:</strong> ของเหลว (Liquid) สามารถรับได้เฉพาะกรณี</p>
<ul>
<li>ไม่เป็นสเปรย์</li>
<li>บรรจุภัณฑ์ไม่เกิน 100 ml.</li>
<li>มีฉลากระบุชัดเจนและอยู่ในบรรจุภัณฑ์เดิม ภายใต้เงื่อนไข ไม่เกิน 100 ml.</li>
</ul>
</div>

<p>📘 <strong>สิ่งของที่แตกหักง่าย และเปราะบาง:</strong> หากลูกค้ายืนยันต้องการนำส่งให้แจ้งเงื่อนไขให้ชัดเจนทุกครั้ง</p>
<ul>
<li>AIRPORTELs จะไม่รับผิดชอบต่อสิ่งของที่เปราะบาง มีค่า เป็นของเหลว เป็นอุปกรณ์อิเล็กทรอนิกส์ หรือสิ่งของต้องห้าม</li>
<li class="sop-en"><em>AIRPORTELs are not responsible for fragile, valuable, liquid, electronic, or prohibited items.</em></li>
</ul>

<hr class="sop-hr">
<h3>🛡️ ข้อกำหนดด้านความปลอดภัย (ทอท.) | AOT Security Requirements</h3>
<ul>
<li>กระเป๋าทุกใบต้องผ่านการตรวจด้วยเครื่อง X-ray ก่อนรับเข้าระบบ <span class="sop-en">/ All luggage must undergo X-ray screening prior to acceptance.</span></li>
<li>ผู้ใช้งานเครื่อง X-ray ต้องผ่านการอบรมและได้รับอนุญาตจาก ทอท. <span class="sop-en">/ X-ray operators must be certified and authorized by AOT.</span></li>
<li>กรณีพบสิ่งของต้องห้ามหรือสิ่งน่าสงสัย ต้องหยุดกระบวนการและประสานเจ้าหน้าที่ ทอท. ทันที ที่เบอร์โทร <strong>02-535 1616</strong> <span class="sop-en">/ Any prohibited or suspicious items must be reported to AOT immediately.</span></li>
</ul>'
where slug = 'dmk-airport-service';
commit;

-- ===== sop_delayed_fix =====
--   (Discount Structure, Specific Conditions by Case, Size Factor) as
--   scrollable HTML tables, section dividers, and the 3 reference links.
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
@media (max-width:480px){
.prose .sop-tblwrap table.sop-tbl{min-width:460px}
.prose table.sop-tbl th,.prose table.sop-tbl td{font-size:12.5px;min-width:120px}
.prose .sop-tl{grid-template-columns:82px 1fr}
.prose .sop-hstep{grid-template-columns:44px 1fr}
.prose .sop-hstep>.n{font-size:16px}
.prose .sop-step{grid-template-columns:38px 1fr}
.prose blockquote{padding:8px 12px}
}
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
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Case</th><th>เงื่อนไขการพิจารณา</th><th>เอกสาร/หลักฐานที่ต้องใช้</th><th>วิธีการดำเนินการ</th></tr></thead><tbody><tr><td>แจ้งล่วงหน้า</td><td>ลูกค้าแจ้งก่อนถึงวันรับจริง</td><td>- Email/ข้อความจากลูกค้า<br>- Chat log หรือ CRM note</td><td>- เสนอบริการจัดส่ง</td></tr><tr><td>ไม่แจ้ง แต่มีเหตุสุดวิสัย</td><td>มีเหตุผลชัดเจนและมีหลักฐาน เช่น เที่ยวบิน/สุขภาพ/เอกสารทางราชการ</td><td>- เอกสารจากสายการบิน (Flight delay/cancel)<br>- ใบรับรองแพทย์<br>- หนังสือราชการ/เอกสารยืนยันอื่นๆ</td><td>- ส่งเรื่องตามลำดับขั้นเพื่อพิจารณาอนุมัติ</td></tr><tr><td>ไม่แจ้ง และไม่มีเหตุผลสมควร</td><td>ลูกค้าไม่ติดต่อ/ไม่มีเอกสารยืนยัน</td><td>- บันทึกในระบบว่าได้ follow up แล้ว แต่ไม่มี response</td><td>- กรณี walk in ให้ต่อรองตามสถานการณ์ และส่งเรื่องพิจารณาตามลำดับขั้น</td></tr><tr><td>Special Case (VIP / Corporate)</td><td>กรณีรักษาลูกค้าระยะยาว, สัญญา corporate, retention, หรือ case พิเศษ</td><td>- Email จากฝ่ายการตลาด/BD Manager<br>- Customer profile ระบุ VIP/Corp</td><td>-</td></tr><tr><td>Long-term storage ≥ 6 เดือน</td><td>ลูกค้าฝากยาวผิดปกติ และต้องการส่วนลดพิเศษ (25–50%)</td><td>- สัญญาฝาก/ระบบ transaction log ยืนยันระยะเวลา<br>- บันทึกการติดต่อกับลูกค้า</td><td>-</td></tr></tbody></table></div>

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

-- ===== sop_abandon_fix =====
--   readable tables + timeline + scripts, section dividers.
--   source's SOP-Relationship section; cover header 021 was a typo).
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
@media (max-width:480px){
.prose .sop-tblwrap table.sop-tbl{min-width:460px}
.prose table.sop-tbl th,.prose table.sop-tbl td{font-size:12.5px;min-width:120px}
.prose .sop-tl{grid-template-columns:82px 1fr}
.prose .sop-hstep{grid-template-columns:44px 1fr}
.prose .sop-hstep>.n{font-size:16px}
.prose .sop-step{grid-template-columns:38px 1fr}
.prose blockquote{padding:8px 12px}
}
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

-- ===== sop_complaint_fix =====
--   handling procedures as numbered lists (TH+EN), Escalation Matrix,
--   Priority Matrix/SLA, RCA, scripts, KPIs, checklist — with scrollable
begin;
update sop.documents
set content_html = '<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px}
.prose table.sop-tbl td{min-width:150px;max-width:340px;vertical-align:top;font-size:13.5px;line-height:1.6}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:120px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.prose .sop-tblwrap{overflow-x:auto;-webkit-overflow-scrolling:touch;margin:10px 0;border:1px solid var(--border,#e5e7eb);border-radius:8px}
.prose .sop-tblwrap table.sop-tbl{margin:0;border:0;min-width:560px}
.prose hr.sop-hr{border:0;border-top:1px solid var(--border,#e5e7eb);margin:26px 0;opacity:.8}
.prose hr.sop-subhr{border:0;border-top:1px dashed var(--border,#e5e7eb);margin:20px 0 16px;opacity:.7}
.prose h4{margin-top:22px;margin-bottom:8px}
.prose ol,.prose ul{margin:8px 0}
.prose ol>li{margin:11px 0;line-height:1.72;padding-left:4px}
.prose li{margin:6px 0;line-height:1.72}
.sop-en{color:var(--text-muted,#6b7280)}
.sop-hstep{display:grid;grid-template-columns:56px 1fr;border:1px solid var(--border,#e5e7eb);border-radius:8px;margin:12px 0;overflow:hidden}
.sop-hstep>.n{display:flex;align-items:center;justify-content:center;background:#f4ecc2;color:#6b5e12;font-weight:800;font-size:19px}
.sop-hstep>.c{padding:12px 16px}
.sop-hstep .th{font-weight:700;font-size:15px;line-height:1.4}
.sop-hstep .enh{font-style:italic;color:var(--text-muted,#6b7280);margin:2px 0 9px}
.sop-hstep .thd{line-height:1.6}
.sop-hstep .end{font-style:italic;color:var(--text-muted,#6b7280);line-height:1.55;margin-top:4px}
.sop-chan{background:var(--surface-2);border-left:4px solid #1a66e0;border-radius:8px;padding:10px 16px;margin:14px 0}
.sop-chan .t{font-weight:800;font-size:16px}
.sop-note{background:var(--surface-2);border-left:3px solid #f59e0b;border-radius:6px;padding:10px 14px;margin:10px 0;font-size:14px;line-height:1.65}
.sop-script{background:var(--surface-2);border-left:3px solid #1a66e0;border-radius:6px;padding:9px 13px;margin:8px 0;font-size:13.5px;line-height:1.65}
.sop-script .en{color:var(--text-muted,#6b7280);font-style:italic}
.sop-danger{border:1px solid rgba(220,38,38,.38);background:rgba(220,38,38,.07);border-radius:12px;padding:6px 18px 12px;margin:14px 0}
.sop-danger h3,.sop-danger h4{color:#dc2626}
@media (max-width:480px){
.prose .sop-tblwrap table.sop-tbl{min-width:460px}
.prose table.sop-tbl th,.prose table.sop-tbl td{font-size:12.5px;min-width:120px}
.prose .sop-tl{grid-template-columns:82px 1fr}
.prose .sop-hstep{grid-template-columns:44px 1fr}
.prose .sop-hstep>.n{font-size:16px}
.prose .sop-step{grid-template-columns:38px 1fr}
.prose blockquote{padding:8px 12px}
}
</style>

<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 026/2026 &nbsp;·&nbsp; <strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 พฤษภาคม 2569 &nbsp;·&nbsp; <strong>หน่วยงาน:</strong> Operations</p></blockquote>

<h3>🔹 วัตถุประสงค์ / Purpose</h3>
<p>กำหนดขั้นตอนมาตรฐานในการ <strong>รับเรื่อง จัดการ และแก้ไข</strong> ข้อร้องเรียนจากลูกค้าของ AIRPORTELs ผ่านทุกช่องทาง เพื่อลดความเสียหาย รักษาภาพลักษณ์ และสร้างความพึงพอใจสูงสุด</p>
<p class="sop-en"><em>This SOP defines standard steps for receiving, managing, and resolving customer complaints across all channels.</em></p>

<hr class="sop-hr">
<h3>🔹 ขอบเขตการใช้งาน / Scope</h3>
<ul>
<li>ครอบคลุม 3 ช่องทาง: <strong>หน้าสาขา (Walk-in)</strong> | <strong>Customer Service Online</strong></li>
<li>ผู้รับผิดชอบ: Guest Service Staff / CS Staff / Branch Manager / CS Team Lead / Operation Co. / Operations Manager</li>
<li>ใช้กับทุกสาขาที่ให้บริการรับฝากและจัดส่งกระเป๋า</li>
</ul>

<hr class="sop-hr">
<h3>⏸️ คำจำกัดความ / Definitions</h3>
<ul>
<li><strong>CS Staff:</strong> พนักงาน Customer Service ระดับ Front-line</li>
<li><strong>CS Team Lead:</strong> หัวหน้าทีม Customer Service</li>
<li><strong>OP Manager:</strong> Operations Manager – ผู้มีอำนาจตัดสินใจสูงสุด</li>
<li><strong>Branch Manager / Ops Co.:</strong> หัวหน้าสาขา หรือ Operations Coordinator</li>
<li><strong>Escalation:</strong> การส่งต่อเรื่องร้องเรียนไปยังระดับที่สูงขึ้น</li>
<li><strong>SLA:</strong> Service Level Agreement – ระยะเวลามาตรฐานในการตอบสนอง</li>
<li><strong>P1 / P2 / P3:</strong> Priority Level (P1 = Urgent, P2 = High, P3 = Standard)</li>
<li><strong>Complaint Log:</strong> แบบบันทึกรายละเอียดเคสข้อร้องเรียน</li>
</ul>

<hr class="sop-hr">
<h3>⏸️ บทบาท / ความรับผิดชอบ / Roles &amp; Responsibilities</h3>
<ul>
<li><strong>Guest Service Staff / CS Staff:</strong> รับเรื่อง ฟัง บันทึก และแก้ไขเบื้องต้น | ส่งต่อเมื่อเกินขีดความสามารถ</li>
<li><strong>Branch Manager / Ops Coordinator:</strong> รับเรื่องระดับ 2 | ตัดสินใจแก้ปัญหาและชดเชยในขอบเขตที่กำหนด | รายงาน OP Manager (ช่องทาง Lark Group แต่ละสาขา)</li>
<li><strong>CS Team Lead:</strong> ดูแล CS Online | ติดตาม SLA | รายงานสรุปรายสัปดาห์</li>
<li><strong>Operations Manager:</strong> อนุมัติการแก้ไขระดับสูง | อนุมัติค่าชดเชย | ดูแล RCA (Root Cause Analysis) และมาตรการป้องกัน</li>
</ul>

<hr class="sop-hr">
<h3>⏸️ โครงสร้างการส่งต่อ / Escalation Matrix</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ช่องทาง / Channel</th><th>ระดับ 1 / Level 1</th><th>ระดับ 2 / Level 2</th><th>ระดับ 3 / Level 3</th></tr></thead><tbody><tr><td>หน้าสาขา / Branch</td><td>Guest Service Staff</td><td>Branch Manager / Ops Coordinator</td><td>Operations Manager</td></tr><tr><td>CS Online (Email/Chat/Social)</td><td>CS Staff</td><td>CS Team Lead</td><td>Operations Manager</td></tr></tbody></table></div>
<p class="sop-note">หมายเหตุ: Operations Manager = ผู้มีอำนาจตัดสินใจสูงสุดในทุกกรณี</p>

<hr class="sop-hr">
<div class="sop-chan"><div class="t">📍 ช่องทางที่ 1 — หน้าสาขา (Walk-in Complaint)</div><div class="sop-en">Channel 1 — Branch / Walk-in</div></div>

<h4>⚙️ ขั้นตอนการรับมือ / Handling Procedure</h4>
<div class="sop-hstep"><div class="n">1</div><div class="c"><div class="th">รับเรื่องและฟังอย่างตั้งใจ</div><div class="enh">Receive &amp; Listen Actively</div><div class="thd">ต้อนรับลูกค้า แนะนำตัว ฟังโดยไม่ขัดจังหวะ จดบันทึกปัญหาสำคัญ</div><div class="end">Greet customer, introduce yourself, listen without interruption, note key details.</div></div></div>
<div class="sop-hstep"><div class="n">2</div><div class="c"><div class="th">ยืนยันและสรุปปัญหา</div><div class="enh">Acknowledge &amp; Summarise</div><div class="thd">ทวนสิ่งที่ลูกค้าแจ้งเพื่อยืนยันความเข้าใจที่ถูกต้อง</div><div class="end">Repeat the issue back to confirm correct understanding before proceeding.</div></div></div>
<div class="sop-hstep"><div class="n">3</div><div class="c"><div class="th">ประเมินระดับความเร่งด่วน</div><div class="enh">Assess Urgency Level</div><div class="thd">ปัญหาทั่วไป → Staff จัดการเอง | ซับซ้อน/อารมณ์สูง → ส่งต่อ Branch Manager</div><div class="end">Simple: Staff resolves. Complex/emotional: escalate to Branch Manager.</div></div></div>
<div class="sop-hstep"><div class="n">4</div><div class="c"><div class="th">เสนอทางแก้ไข</div><div class="enh">Propose Resolution</div><div class="thd">นำเสนอแนวทางในขอบเขตอำนาจ Staff เช่น ขอโทษ ชดเชย จัดการสิ่งของ</div><div class="end">Offer resolution within staff authority: apology, compensation, item care.</div></div></div>
<div class="sop-hstep"><div class="n">5</div><div class="c"><div class="th">บันทึกเรื่องร้องเรียน</div><div class="enh">Log the Complaint</div><div class="thd">กรอก Complaint Form (เมื่อมีระบบแจ้ง) ปัจจุบันให้แจ้งผ่านกลุ่ม Lark ที่กำหนดหลังจบการสนทนา — รายละเอียดที่ต้องมี: Order No. / Name / Case detail / การแก้ไขหรือการตอบกลับเบื้องต้นที่ดำเนินการไปแล้ว / สิ่งที่ลูกค้าต้องการหรือต่อรอง / ข้อมูลอื่นที่จำเป็น</div><div class="end">Complete the Complaint Log form immediately after the interaction.</div></div></div>
<div class="sop-hstep"><div class="n">6</div><div class="c"><div class="th">ติดตามผล</div><div class="enh">Follow-up</div><div class="thd">แก้ไขทันที → แจ้งลูกค้า | ต้องรอ → แจ้งระยะเวลาที่คาดหวัง</div><div class="end">Resolved on-spot: confirm with customer. Pending: communicate expected timeline.</div></div></div>

<hr class="sop-subhr">
<h4>1. การส่งต่อข้อมูล / Escalation Triggers</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>เงื่อนไขการส่งต่อ / Escalation Trigger</th><th>ผู้รับผิดชอบ / Responsible Party</th></tr></thead><tbody><tr><td>ลูกค้าปฏิเสธคำขอโทษ / ต้องการค่าชดเชย<br><span class="sop-en">Customer rejects apology or demands compensation</span></td><td>Branch Manager / Ops Coordinator</td></tr><tr><td>กระเป๋าสูญหาย / เสียหาย<br><span class="sop-en">Lost or damaged luggage claim</span></td><td>Branch Manager → OP Manager</td></tr><tr><td>ลูกค้าขู่ร้องเรียนต่อสาธารณะ / กฎหมาย<br><span class="sop-en">Threat of public complaint or legal action</span></td><td>OP Manager ทันที / Immediately</td></tr></tbody></table></div>

<hr class="sop-subhr">
<h4>2. สคริปต์การสื่อสาร / Communication Scripts</h4>
<div class="sop-script"><strong>การเปิดรับเรื่อง / Opening</strong><br>💬 ภาษาไทย: "สวัสดีครับ/ค่ะ ขอโทษที่ทำให้คุณลำบากใจนะครับ (ค่ะ) ช่วยเล่าให้ฟังหน่อยได้ไหมครับ ว่าเกิดอะไรขึ้น" · "ผม/ดิฉัน [ชื่อ] จะดูแลเรื่องนี้เองนะครับ/ค่ะ"<br><span class="en">English: "Good [morning/afternoon]. I''m so sorry to hear about this. My name is [Name], and I''m here to help." · "Could you please walk me through what happened? I want to make sure I fully understand."</span></div>
<div class="sop-script"><strong>การขอโทษและเสนอทางออก / Apology &amp; Resolution</strong><br>💬 ภาษาไทย: "ต้องขอโทษจริงๆ สำหรับความไม่สะดวกที่เกิดขึ้น เราจะ [ระบุแนวทาง] ให้เลยครับ/ค่ะ" · "หากใช้เวลานานกว่านี้ ผม/ดิฉันจะแจ้งให้ทราบทันทีนะครับ/ค่ะ"<br><span class="en">English: "Please accept our sincere apologies. We will [state action] for you right away." · "If this takes longer than expected, I will keep you updated every step of the way."</span></div>

<hr class="sop-hr">
<div class="sop-chan"><div class="t">💻 ช่องทางที่ 2 — Customer Service Online</div><div class="sop-en">Channel 2 — Online CS (Email / Chat / Social Media)</div></div>

<h4>⚙️ ขั้นตอนการรับมือ / Handling Procedure</h4>
<div class="sop-hstep"><div class="n">1</div><div class="c"><div class="th">ติดตามและรับเรื่อง</div><div class="enh">Monitor &amp; Receive</div><div class="thd">CS Staff ตรวจสอบ email, chat, social ตาม SLA ที่กำหนด</div><div class="end">CS Staff monitors all channels per defined SLA intervals.</div></div></div>
<div class="sop-hstep"><div class="n">2</div><div class="c"><div class="th">ส่งข้อความยืนยันรับเรื่อง</div><div class="enh">Send Acknowledgement</div><div class="thd">ตอบรับ ≤1 ชม. (Urgent) / ≤4 ชม. (Standard)</div><div class="end">Acknowledgement within 1hr (urgent) / 4hrs (standard).</div></div></div>
<div class="sop-hstep"><div class="n">3</div><div class="c"><div class="th">จัดประเภทและกำหนด Priority</div><div class="enh">Categorise &amp; Prioritise</div><div class="thd">ใช้ Priority Matrix (P1/P2/P3) เพื่อกำหนดระดับความเร่งด่วน</div><div class="end">Apply Priority Matrix to assign urgency level (P1 / P2 / P3).</div></div></div>
<div class="sop-hstep"><div class="n">4</div><div class="c"><div class="th">สืบค้นและประสานงาน</div><div class="enh">Investigate &amp; Coordinate</div><div class="thd">ตรวจสอบ booking ประสานทีมหน้าสาขาหรือทีมที่เกี่ยวข้องหากจำเป็น</div><div class="end">Review booking records; coordinate with Guest Service or related team as needed.</div></div></div>
<div class="sop-hstep"><div class="n">5</div><div class="c"><div class="th">แก้ไขและแจ้งผล</div><div class="enh">Resolve &amp; Communicate</div><div class="thd">แจ้งผลการแก้ไขผ่านช่องทางเดิมที่ลูกค้าติดต่อมา</div><div class="end">Inform customer of resolution via the same channel they used.</div></div></div>
<div class="sop-hstep"><div class="n">6</div><div class="c"><div class="th">ปิดเคสและบันทึกผ่านระบบ Respond</div><div class="enh">Close &amp; Log</div><div class="thd">บันทึกเคสในระบบ ระบุวันปิด สาเหตุ และแนวทางแก้ไข</div><div class="end">Log case closure: date, root cause, and resolution method applied.</div></div></div>

<hr class="sop-subhr">
<h4>3. Priority Matrix และ SLA</h4>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Priority</th><th>ประเภทปัญหา / Issue Type</th><th>ยืนยัน / Ack.</th><th>แก้ไข / Resolve</th></tr></thead><tbody><tr><td>P1 Urgent</td><td>กระเป๋าสูญหาย, ความปลอดภัย, กฎหมาย<br><span class="sop-en">Lost luggage, safety, legal threat</span></td><td>≤ 1 ชม./hr</td><td>≤ 4 ชม./hrs</td></tr><tr><td>P2 High</td><td>กระเป๋าเสียหาย, booking ผิด, ชำระผิดพลาด<br><span class="sop-en">Damaged item, booking error, payment issue</span></td><td>≤ 2 ชม./hrs</td><td>≤ 24 ชม./hrs</td></tr><tr><td>P3 Standard</td><td>ข้อร้องเรียนทั่วไป, นโยบาย, คืนเงิน<br><span class="sop-en">General complaint, policy query, refund</span></td><td>≤ 4 ชม./hrs</td><td>≤ 48 ชม./hrs</td></tr></tbody></table></div>

<hr class="sop-subhr">
<h4>4. ตัวอย่างการตอบกลับ / Response Templates</h4>
<div class="sop-script"><strong>📩 ข้อความยืนยันรับเรื่อง / Acknowledgement (Email / Chat)</strong><br>ภาษาไทย: เรียนคุณ [ชื่อ] – ขอบคุณที่ติดต่อ AIRPORTELs นะคะ/ครับ เราได้รับเรื่องร้องเรียนแล้ว และกำลังดำเนินการตรวจสอบ จะติดต่อกลับภายใน [X ชั่วโมง] ด้วยความเคารพ – Customer Service Team, AIRPORTELs<br><span class="en">English: Dear [Name], – Thank you for contacting AIRPORTELs. We have received your complaint and are currently looking into the matter. We will get back to you within [X hours]. Warm regards – AIRPORTELs Customer Service Team</span></div>
<div class="sop-script"><strong>📞 สคริปต์ทางโทรศัพท์ / Phone Response Script</strong><br>ภาษาไทย: "สวัสดีครับ/ค่ะ AIRPORTELs Customer Service ผม/ดิฉัน [ชื่อ] ยินดีช่วยเหลือครับ/ค่ะ" · หลังฟัง: "ขอบคุณที่แจ้งให้ทราบ ขออภัยในความไม่สะดวก ขอหมายเลขอ้างอิงได้ไหมครับ/ค่ะ"<br><span class="en">English: "Thank you for calling AIRPORTELs Customer Service. This is [Name], how may I help you today?" · After listening: "Thank you. I sincerely apologise for the inconvenience. May I have your booking reference?"</span></div>

<hr class="sop-subhr">
<div class="sop-danger">
<h4>5. กรณีผิดปกติ / Exceptions &amp; Incident Handling</h4>
<ul>
<li><strong>ลูกค้าขู่ / ใช้ความรุนแรง:</strong> แจ้ง รปภ. ทันที อย่าโต้เถียง (กรณีหน้าสาขา) และแจ้ง OP Team Lead</li>
<li><strong>กระเป๋าสูญหายมูลค่าสูง:</strong> ถ่ายภาพ บันทึกรายละเอียด แจ้ง Branch Manager → OP Team Lead ทันที ดำเนินการตามนโยบายชดเชย</li>
<li><strong>ลูกค้าจะโพสต์ Social Media เชิงลบ:</strong> แจ้ง Branch Manager / CS Team Lead → OP Manager ทันที เพื่อประสานตอบสนองเชิงรุก</li>
</ul>
</div>

<hr class="sop-subhr">
<h4>6. การวิเคราะห์สาเหตุ / Root Cause Analysis (RCA)</h4>
<p>หลังปิดเคส <strong>P1 และ P2 ทุกเคส</strong> ต้องผ่านกระบวนการ RCA ดังนี้:</p>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ขั้นตอน RCA / Step</th><th>ผู้รับผิดชอบ / Owner</th></tr></thead><tbody><tr><td>ระบุสาเหตุหลัก (5 Whys) / Identify root cause via 5 Whys method</td><td>CS Team Lead / Branch Manager</td></tr><tr><td>เสนอมาตรการป้องกัน / Propose preventive actions</td><td>CS Team Lead / Branch Manager</td></tr><tr><td>อนุมัติและสั่งการ / Approve &amp; assign action items</td><td>Operations Manager</td></tr><tr><td>ติดตามผลภายใน 14 วัน / Follow-up within 14 business days</td><td>CS Team Lead</td></tr></tbody></table></div>

<hr class="sop-subhr">
<h4>7. บันทึกและการควบคุม / Documentation &amp; Controls</h4>
<p><strong>ข้อมูลที่ต้องบันทึกทุกเคส / Required fields for every complaint log:</strong></p>
<ul>
<li>วันที่-เวลา / Date &amp; Time</li>
<li>ช่องทาง / Channel (Branch / Online / Google Review)</li>
<li>ชื่อลูกค้า + เลขการจอง / Customer name &amp; Order no.</li>
<li>ประเภทปัญหา + Priority Level / Issue category &amp; priority</li>
<li>การดำเนินการที่ทำ / Actions taken</li>
<li>ผลลัพธ์ / Outcome &amp; resolution</li>
<li>ชื่อผู้ปิดเคส / Closed by (name &amp; role)</li>
</ul>
<p><strong>รายงานสรุป / Summary Reports:</strong></p>
<ul>
<li>รายสัปดาห์: CS Team Lead → OP Manager (จำนวนเคส, SLA compliance, trends)</li>
<li>รายเดือน: OP Manager รายงาน pattern และมาตรการ preventive ต่อฝ่ายบริหาร</li>
</ul>

<hr class="sop-subhr">
<h4>8. ตัวชี้วัด / KPIs &amp; Audit</h4>
<ul>
<li><strong>SLA Compliance:</strong> P1 ≥ 95% | P2 ≥ 90% | P3 ≥ 85% ภายในระยะเวลามาตรฐาน</li>
<li><strong>Resolution Rate:</strong> แก้ไขได้ใน First Contact ≥ 70%</li>
<li><strong>Customer Satisfaction:</strong> ติดตาม CSAT หลังปิดเคส ≥ 4.0 / 5.0</li>
<li><strong>Audit:</strong> CS Team Lead ทบทวน Complaint Log รายสัปดาห์ | OP Manager รายเดือน</li>
</ul>

<div class="sop-note"><strong>✔ Checklist — CS Team &amp; Branch Staff (Quick Reference)</strong><ul><li>รับเรื่องลูกค้า → ฟัง → ยืนยันปัญหา → ประเมิน Priority</li><li>ตอบรับภายใน SLA กำหนด พร้อมเลขอ้างอิง</li><li>แก้ไข หรือส่งต่อตาม Escalation Matrix ทันที</li><li>บันทึก Complaint Log ทุกเคส (ห้ามข้าม)</li><li>ปิดเคส → บันทึกผล → รายงาน Team Lead</li><li>P1 / P2: ทำ RCA หลังปิดเคส ภายใน 3 วันทำการ</li></ul></div>

<hr class="sop-hr">
<h3>⏸️ รายละเอียดที่ต้องมีในการแจ้งปัญหา</h3>
<p>💬 แจ้งผ่าน Lark group แต่ละสาขา (เร่งด่วน ให้โทรแจ้งเบื้องต้น และส่งรายละเอียดตามมา):</p>
<ul>
<li>Order No.</li>
<li>Customer Name</li>
<li>Case detail (รายละเอียดปัญหา)</li>
<li>การแก้ไข หรือการตอบกลับปัญหาเบื้องต้น</li>
<li>มูลค่าความเสียหาย (ถ้ามี)</li>
<li>รายละเอียดอื่นๆ ที่เกี่ยวข้อง</li>
</ul>

<hr class="sop-hr">
<h3>🔹 ประวัติการแก้ไข / Document Control</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>Version</th><th>วันที่ / Date</th><th>แก้ไขโดย / Author</th><th>รายละเอียด / Notes</th></tr></thead><tbody><tr><td>1.0</td><td>10 May 2026</td><td>Operations Team</td><td>Initial release / เอกสารฉบับแรก</td></tr></tbody></table></div>',
    doc_code = 'SOP-OPS-026/2026',
    summary = 'SOP-OPS 026/2026 — ขั้นตอนมาตรฐานการรับเรื่อง จัดการ และแก้ไขข้อร้องเรียนจากลูกค้าทุกช่องทาง (หน้าสาขา / CS Online) — บทบาท/Escalation Matrix, Priority Matrix & SLA, สคริปต์สื่อสาร, RCA, KPIs และ Checklist'
where slug = 'complaint-handling';
commit;

