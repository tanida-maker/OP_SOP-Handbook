-- ============================================================
-- AIRPORTELs SOP Hub — SOP-OPS 020/2026 (DMK Airport Service)
--   Faithful re-render from source PDF: complete content, intact
--   phone numbers, real Prohibited-Items table, related-document links.
-- Idempotent — safe to re-run. Content is served dynamically (no redeploy).
-- ============================================================
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
