-- ============================================================
-- AIRPORTELs SOP Hub — CONSOLIDATED content migration (batch 1 + 2)
--   * Terms & Conditions -> 2026 bilingual TH/EN (archive 2025, guarded)
--   * Update late-pickup discount SOP (+figures)
--   * Insert 12 new SOP documents
--   * All figures/screenshots served from /public/sop/* (already deployed)
-- Small + idempotent. Run ONCE in the Supabase SQL Editor.
-- ============================================================
begin;

-- allow an 'archived' status (old versions kept for reference, not "draft")
alter table sop.documents drop constraint if exists documents_status_check;
alter table sop.documents add constraint documents_status_check
  check (status in ('draft','published','archived'));

-- move any previously-archived rows out of 'draft' into 'archived'
update sop.documents set status = 'archived' where slug like '%-archive';

-- standardized document control codes (SOP-OPS-NNN/YYYY)
alter table sop.documents add column if not exists doc_code text;
update sop.documents set doc_code = 'SOP-OPS-001/2025' where slug = 'dress-code-guest-service';
update sop.documents set doc_code = 'SOP-OPS-002/2025' where slug = 'cashless-payment-policy';
update sop.documents set doc_code = 'SOP-OPS-003/2025' where slug = 'open-close-counter';
update sop.documents set doc_code = 'SOP-OPS-004/2025' where slug = 'emergency-airport';
update sop.documents set doc_code = 'SOP-OPS-005/2025' where slug = 'emergency-mall';
update sop.documents set doc_code = 'SOP-OPS-006/2025' where slug = 'inventory-stock-update';
update sop.documents set doc_code = 'SOP-OPS-007/2025' where slug = 'online-credit-card-payment';
update sop.documents set doc_code = 'SOP-OPS-008/2025' where slug = 'osl-radiation-badge';
update sop.documents set doc_code = 'SOP-OPS-009/2025' where slug = 'manual-baggage-check-xray-down';
update sop.documents set doc_code = 'SOP-OPS-010/2025' where slug = 'handheld-metal-detector';
update sop.documents set doc_code = 'SOP-OPS-011/2025' where slug = 'pos-order-receiving';
update sop.documents set doc_code = 'SOP-OPS-012/2025' where slug = 'authorized-person-pickup';
update sop.documents set doc_code = 'SOP-OPS-013/2025' where slug = 'yoowifi-service';
update sop.documents set doc_code = 'SOP-OPS-014/2025' where slug = 'safe-luggage-storage';
update sop.documents set doc_code = 'SOP-OPS-015/2025' where slug = 'cross-branch-travel-allowance';
update sop.documents set doc_code = 'SOP-OPS-016/2025' where slug = 'delayed-pickup-discount';
update sop.documents set doc_code = 'SOP-OPS-017/2025' where slug = 'edc-machine';
update sop.documents set doc_code = 'SOP-OPS-018/2025' where slug = 'same-day-delivery';
update sop.documents set doc_code = 'SOP-OPS-019/2025' where slug = 'booking-photo-rotate';
update sop.documents set doc_code = 'SOP-OPS-020/2026' where slug = 'dmk-airport-service';
update sop.documents set doc_code = 'SOP-OPS-021/2026' where slug = 'lost-found-claim';
update sop.documents set doc_code = 'SOP-OPS-022/2026' where slug = 'abandoned-luggage-disposal';
update sop.documents set doc_code = 'SOP-OPS-023/2026' where slug = 'complaint-handling';
update sop.documents set doc_code = 'SOP-OPS-024/2026' where slug = 'baggage-inspection-lock-report';
update sop.documents set doc_code = 'SOP-OPS-025/2026' where slug = 'ntw-5day-booking';
update sop.documents set doc_code = 'SOP-OPS-026/2025' where slug = 'respond-io-guide';
update sop.documents set doc_code = 'SOP-OPS-027/2025' where slug = '3cx-guide';
update sop.documents set doc_code = 'SOP-OPS-028/2025' where slug = 'luggage-delivery-google-sheet';
update sop.documents set doc_code = 'SOP-OPS-028.1/2025' where slug = 'google-sheet-donts';
update sop.documents set doc_code = 'T&C-2026' where slug = 'terms-and-conditions-2025';

-- ===== terms-and-conditions-2025: archive current (guarded) then update =====
insert into sop.documents (slug, title, summary, category_id, content_html, cover_image, tags, status, is_onboarding, onboarding_order, version)
select 'terms-and-conditions-2025-archive', title || ' — เก็บถาวร ปี 2025 (Archive)', summary, category_id, content_html, cover_image,
       coalesce(tags,'{}') || array['archive'], 'archived', false, null, version
from sop.documents where slug = 'terms-and-conditions-2025'
  and not exists (select 1 from sop.documents where slug = 'terms-and-conditions-2025-archive');

update sop.documents set
  title = 'ข้อกำหนดและเงื่อนไขการให้บริการ 2026 (Terms & Conditions)', summary = 'ข้อกำหนดและเงื่อนไขมาตรฐานการใช้บริการของบริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด ปี 2026 (อัปเดต 29/04/2026) — แสดงสองภาษา ไทย/อังกฤษ ตามปุ่มเปลี่ยนภาษา ครอบคลุมการยอมรับเงื่อนไข ราคาและการชำระเงิน ความรับผิดชอบ สิ่งของต้องห้าม การจอง/ยกเลิก/คืนเงิน และค่าชดเชย', content_html = '<style>[lang="en"] .sop-lang-th{display:none}[lang="th"] .sop-lang-en{display:none}.tc-page{display:block;margin:0 auto 12px;max-width:100%;border:1px solid #e5e7eb;border-radius:8px}</style><div class="sop-lang-th"><blockquote><p><strong>อัปเดตล่าสุด:</strong> 29/04/2026 &nbsp;·&nbsp; เอกสารนี้แสดงสองภาษา — กดปุ่ม <strong>EN/TH</strong> ด้านซ้ายเพื่อสลับภาษา</p></blockquote>
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p1.jpg" alt="Terms & Conditions th page 1" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p2.jpg" alt="Terms & Conditions th page 2" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p3.jpg" alt="Terms & Conditions th page 3" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p4.jpg" alt="Terms & Conditions th page 4" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p5.jpg" alt="Terms & Conditions th page 5" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p6.jpg" alt="Terms & Conditions th page 6" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p7.jpg" alt="Terms & Conditions th page 7" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p8.jpg" alt="Terms & Conditions th page 8" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p9.jpg" alt="Terms & Conditions th page 9" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p10.jpg" alt="Terms & Conditions th page 10" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p11.jpg" alt="Terms & Conditions th page 11" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p12.jpg" alt="Terms & Conditions th page 12" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p13.jpg" alt="Terms & Conditions th page 13" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p14.jpg" alt="Terms & Conditions th page 14" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p15.jpg" alt="Terms & Conditions th page 15" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p16.jpg" alt="Terms & Conditions th page 16" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p17.jpg" alt="Terms & Conditions th page 17" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p18.jpg" alt="Terms & Conditions th page 18" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p19.jpg" alt="Terms & Conditions th page 19" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p20.jpg" alt="Terms & Conditions th page 20" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p21.jpg" alt="Terms & Conditions th page 21" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/th-p22.jpg" alt="Terms & Conditions th page 22" loading="lazy" /></div><div class="sop-lang-en"><blockquote><p><strong>Last updated:</strong> 29/04/2026 &nbsp;·&nbsp; This document is bilingual — use the <strong>EN/TH</strong> button to switch language</p></blockquote>
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p1.jpg" alt="Terms & Conditions en page 1" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p2.jpg" alt="Terms & Conditions en page 2" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p3.jpg" alt="Terms & Conditions en page 3" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p4.jpg" alt="Terms & Conditions en page 4" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p5.jpg" alt="Terms & Conditions en page 5" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p6.jpg" alt="Terms & Conditions en page 6" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p7.jpg" alt="Terms & Conditions en page 7" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p8.jpg" alt="Terms & Conditions en page 8" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p9.jpg" alt="Terms & Conditions en page 9" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p10.jpg" alt="Terms & Conditions en page 10" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p11.jpg" alt="Terms & Conditions en page 11" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p12.jpg" alt="Terms & Conditions en page 12" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p13.jpg" alt="Terms & Conditions en page 13" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p14.jpg" alt="Terms & Conditions en page 14" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p15.jpg" alt="Terms & Conditions en page 15" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p16.jpg" alt="Terms & Conditions en page 16" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p17.jpg" alt="Terms & Conditions en page 17" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p18.jpg" alt="Terms & Conditions en page 18" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p19.jpg" alt="Terms & Conditions en page 19" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p20.jpg" alt="Terms & Conditions en page 20" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p21.jpg" alt="Terms & Conditions en page 21" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p22.jpg" alt="Terms & Conditions en page 22" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p23.jpg" alt="Terms & Conditions en page 23" loading="lazy" />
<img class="tc-page" src="/sop/terms-and-conditions-2025/en-p24.jpg" alt="Terms & Conditions en page 24" loading="lazy" /></div>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://app.airportels.asia/tracking" target="_blank" rel="noopener">โดยใส่รหัสคำสั่งซื้อ</a></li></ul>'
where slug = 'terms-and-conditions-2025';

-- ===== delayed-pickup-discount: archive current (guarded) then update =====
insert into sop.documents (slug, title, summary, category_id, content_html, cover_image, tags, status, is_onboarding, onboarding_order, version)
select 'delayed-pickup-discount-archive', title || ' — ฉบับก่อนหน้า (Archive)', summary, category_id, content_html, cover_image,
       coalesce(tags,'{}') || array['archive'], 'archived', false, null, version
from sop.documents where slug = 'delayed-pickup-discount'
  and not exists (select 1 from sop.documents where slug = 'delayed-pickup-discount-archive');

update sop.documents set
  title = 'การจัดการกรณีลูกค้ามารับสัมภาระล่าช้า – เกณฑ์และโครงสร้างส่วนลด', summary = 'ขั้นตอนปฏิบัติมาตรฐาน (SOP-OPS 0016/2025) เมื่อลูกค้ามารับสัมภาระล่าช้า — เกณฑ์พิจารณา (ขนาด/ค่าฝาก/ระยะเวลา) โครงสร้างส่วนลด อำนาจอนุมัติ ตัวอย่างเคส และสคริปต์สื่อสารกับลูกค้า (TH/EN)', content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0016/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 ตุลาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<p>อ้างอิง / Reference:</p>
<ul><li>(TH)Terms and Conditions2026 / (EN)Terms and Conditions2026</li><li>SOP: ของหาย &amp; กระเป๋าถูกทิ้ง</li></ul>
<h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดมาตรฐานการดำเนินการเมื่อลูกค้าไม่สามารถมารับสัมภาระตามกำหนดเวลา โดยมีแนวทางการพิจารณา ส่วนลดที่เป็นธรรม สร้างความพึงพอใจให้ลูกค้า ป้องกันการทิ้งสัมภาระ และคงไว้ซึ่งรายได้ของบริษัท</p>
<h3>ขอบเขต (Scope)</h3>
<ul><li>ใช้กับการให้บริการลูกค้าทุกประเภทที่ฝากสัมภาระกับ AIRPORTELs ทั้งสาขาหน้าร้าน และช่องทางออนไลน์</li></ul>
<p>(Call Center, Email, Line, Facebook)</p>
<ul><li>ครอบคลุมพนักงานทุกตำแหน่งที่เกี่ยวข้อง ได้แก่ Guest Service Staff, Branch Manager และ</li></ul>
<p>Cีustomer Service Team</p>
<ul><li>ใช้กับทุกกรณีของ การรับกระเป๋าล่าช้า (Delayed Collection) ยกเว้น กรณี ลูกค้าไม่ติดต่อ/ไม่มารับเลย ซึ่ง</li></ul>
<p>ต้องเข้าสู่ขั้นตอน Lost &amp; Found / Disposal ตามนโยบายบริษัท</p>
<h3>Discount Policy (Duration ≥ 6 เดือน)</h3>
<p><strong>1. Criteria (เกณฑ์พิจารณา)</strong></p>
<p><strong>2. Size Factor : Small / Medium / Large / Oversize or Special</strong></p>
<p><strong>3. Fee Factor – Low / Medium / High / Very High</strong></p>
<p><strong>4. Duration Factor (ระยะเวลาฝาก)</strong></p>
<ul><li>Short-term: ≤ 3 เดือน → ใช้โครงสร้าง Base Table ปกติ</li><li>Mid-term: 3–6 เดือน → ใช้ Base Table + ส่วนลดเพิ่มเล็กน้อย (+5–10%)</li><li>Long-term: ≥ 6 เดือน → เข้าสู่เงื่อนไขพิเศษ (25–50%)</li></ul>
<h3>Discount Structure</h3>
<ul><li>Discount Structure (ตามยอดเงิน + ขนาด)</li><li>Duration Adjustment</li><li>≤ 3 เดือน → ใช้ส่วนลดตามตาราง เท่านั้น</li><li>3–6 เดือน → เพิ่มส่วนลดได้ +5–10% จากตารางส่วนลด (รวมแล้วไม่เกิน 30%)</li><li>≥ 6 เดือน → ใช้ Special Duration Discount:</li><li>ส่วนลดรวมอยู่ในช่วง 25–50% (ขึ้นกับขนาด/ยอด/เหตุผลลูกค้า)</li><li>แต่ต้องจ่ายขั้นต่ำ 50% ของยอดเต็ม</li><li>Approval Authority</li><li>ส่วนลดรวม ≤25% → Guest Service Exe. อนุมัติได้</li><li>ส่วนลดรวม &gt;25% ถึง 50% (กรณี ≥ 6 เดือน) → ต้องขออนุมัติจาก ฺOperation Manager</li><li>ส่วนลดรวม &gt;50% → ไม่อนุมัติ ยกเว้นกรณี VIP ( BD / COO / CEO approval)</li><li>Example Cases</li></ul>
<p>Case 1: ลูกค้า ฝาก 7 เดือน / กระเป๋า Large / ยอดค้าง 22,000 บาท (Very High)</p>
<ul><li>Base Table = 15%</li><li>Duration ≥ 6 เดือน → ปรับเป็น Special Duration Discount 25–50%</li><li>หาก Operation Manager อนุมัติ → ลดได้สูงสุด 50% (เหลือจ่าย 11,000 บาท)</li></ul>
<p>Case 2: ลูกค้า ฝาก 8 เดือน / กระเป๋า Small / ยอดค้าง 6,000 บาท (Medium)</p>
<ul><li>Base Table = 15%</li><li>Duration ≥ 6 เดือน → ปรับใหม่เป็น 25–50%</li><li>อนุมัติ 30% → จ่าย 4,200 บาท (ขั้นต่ำต้องจ่าย 3,000 บาท ตาม rule 50%)</li></ul>
<h3>Conditions &amp; Required Documents for Discount Consideration</h3>
<p><strong>1. General Conditions (เงื่อนไขทั่วไป)</strong></p>
<ul><li>a. ลูกค้าต้อง ติดต่อกลับมา และแสดงความประสงค์จะชำระหรือรับกระเป๋า (ไม่ใช่ abandon case)</li><li>b. ลูกค้าต้องชำระ ขั้นต่ำ 50% ของยอดค้างชำระเต็ม</li><li>c. ส่วนลด ≤25% → อนุมัติได้โดย Guest Service Exe.</li><li>d. ส่วนลด 26–50% → ต้องมี เอกสารหลักฐาน + ส่งรายงานขออนุมัติ Operation Manager</li><li>e. ส่วนลด &gt;50% → อนุมัติได้เฉพาะกรณี VIP / Ex-gratia โดย BD หรือ CEO เท่านั้น</li></ul>
<p><strong>2. Specific Conditions by Case (กรณีและหลักฐานประกอบ)</strong></p>
<ul><li>Process &amp; Documentation Flow (ขั้นตอนและการบันทึก)</li><li>Guest Service Staff / Branch Manager</li><li>ตรวจสอบข้อมูลลูกค้า (Size, Fee, Duration)</li><li>ขอเอกสาร/หลักฐานจากลูกค้า (ถ้ามี)</li><li>บันทึกใน Sales report หรือ Incedent report</li><li>GS Team Lead</li><li>ตรวจสอบความถูกต้องของเอกสาร</li><li>อนุมัติทันทีถ้า Discount ≤25%</li><li>ถ้าเกิน 25% → forward Approval Request ไปยัง Operation Manager</li><li>Operation Manager</li><li>ตรวจสอบหลักฐาน, เหตุผลธุรกิจ (retention/VIP/long-term)</li><li>อนุมัติหรือปรับลด % ส่วนลดตาม policy (25–50%)</li><li>บันทึกการอนุมัติใน Sales Report หรือ อาจจัดทำเอกสาร Approve หรือระบบ Approve Lark</li></ul>
<h3>Criteria: ขนาดสัมภาระ (Size Factor)</h3>
<h3>ขั้นตอนดำเนินการ (Walk-in vs Call Center/Online)</h3>
<p><strong>1. กรณีลูกค้า Walk-in</strong></p>
<p><strong>2. รับคำร้องขอ: พนักงานเคาน์เตอร์สอบถามข้อมูล → เลขฝาก, วันที่ฝาก, ระยะเวลา, เหตุผลที่มารับช้า</strong></p>
<p><strong>3. ตรวจสอบข้อมูลระบบ:</strong></p>
<ul><li>ขนาดสัมภาระ (Size Factor)</li><li>ยอดค้างชำระ (Fee Factor)</li><li>ระยะเวลาฝาก (Duration Factor)</li><li>สถานะการติดต่อก่อนหน้า (มี follow-up หรือไม่)</li></ul>
<p><strong>4. ขอหลักฐาน (ถ้ามี): เช่น เอกสารสายการบิน, ใบรับรองแพทย์ , เอกสารราชการ อื่นๆ (ถ้ามี)</strong></p>
<p><strong>5. คำนวณค่าฝาก + ส่วนลดตามโครงสร้าง</strong></p>
<ul><li>ถ้าส่วนลด ≤25% → ประสานงานแจ้ง Guest Service Exe. อนุมัติผ่านกลุ่ม Lark ได้</li><li>ถ้าเกิน 25% → ประสานงานแจ้ง Case + ส่งต่อขออนุมัติไปยัง Operation Manager ผ่านกลุ่ม Lark</li></ul>
<p><strong>6. แจ้งลูกค้า: สรุปยอดสุทธิที่ต้องจ่าย + เงื่อนไข (เช่น ต้องจ่ายขั้นต่ำ 50%)</strong></p>
<p><strong>7. ดำเนินการรับชำระ/คืนสัมภาระ</strong></p>
<p><strong>8. บันทึกใน Sales report /ระบบ: ระบุ case type + ส่วนลดที่อนุมัติ + แนบเอกสาร</strong></p>
<p>กรณีลูกค้า ติดต่อผ่าน Call Center / Online (โทร, อีเมล, LINE, FB)</p>
<p><strong>1. รับเรื่อง: CS บันทึกข้อมูลการติดต่อ → เลขฝาก, วันที่ฝาก, เหตุผล</strong></p>
<p><strong>2. ตรวจสอบข้อมูลในระบบ: ขนาดสัมภาระ / ยอดค้าง / ระยะเวลาฝาก</strong></p>
<p><strong>3. ขอให้ลูกค้าส่งหลักฐาน (ถ้าต้องใช้)</strong></p>
<ul><li>ผ่าน Email / Line Official → attach file</li></ul>
<p><strong>4. คำนวณค่าฝาก + ส่วนลดเบื้องต้น ตามเกณฑ์</strong></p>
<p><strong>5. ดำเนินการอนุมัติ</strong></p>
<ul><li>≤25% → CS แจ้ง Guest Service Exe. อนุมัติและ confirm ลูกค้าได้เลย</li><li>25% → CS ต้องทำ “Approval Request Email” ส่ง Operation Manager พร้อมแนบหลักฐาน</li></ul>
<p><strong>6. แจ้งลูกค้า:</strong></p>
<ul><li>ถ้าอนุมัติ → ส่งสรุปยอดสุทธิ + ช่องทางการชำระเงิน (โอน/QR/ชำระที่สาขา)</li><li>ถ้ายังรออนุมัติ → แจ้งลูกค้าว่าจะได้รับการยืนยันภายใน [xx] ชั่วโมง</li></ul>
<p><strong>7. หลังลูกค้าชำระแล้ว → Update ข้อมูลในระบบ + แจ้งสาขาให้เตรียมกระเป๋าเพื่อรับหรือส่งกลับ</strong></p>
<h3>Script (TH/EN – Updated)</h3>
<p><strong>1. การรับเรื่องจากลูกค้า</strong></p>
<p>TH “สวัสดีค่ะ/ครับ ขอบคุณที่ติดต่อ AIRPORTELs รบกวนขอชื่อ-นามสกุล และรหัสการจอง เพื่อให้ทีมงานตรวจ สอบข้อมูลการฝากสัมภาระของคุณลูกค้าค่ะ” EN “Hello, thank you for contacting AIRPORTELs. May I have your full name and booking reference so that we can check your storage details?”</p>
<p><strong>2. กรณีลูกค้าแจ้งล่วงหน้า</strong></p>
<p>TH “หากคุณลูกค้าแจ้งล่วงหน้าก่อนถึงวันรับจริง เราสามารถช่วยจัดการได้ค่ะ เช่น เสนอการส่งสัมภาระให้ หรือ พิจารณาลดค่าฝากตามที่กำหนดได้เลยค่ะ” EN “If you inform us in advance before the scheduled pick-up date, we can arrange solutions such as delivery service or apply a discount on your storage fee.”</p>
<p><strong>3. กรณีไม่แจ้ง แต่มีเหตุสุดวิสัย</strong></p>
<p>TH “หากคุณลูกค้าไม่สามารถแจ้งล่วงหน้าได้ แต่มีเหตุสุดวิสัยพร้อมเอกสารยืนยัน เช่น ตั๋วเครื่องบินที่เลื่อน/ ยกเลิก หรือใบรับรองแพทย์ เราสามารถลดให้ได้ xx% ค่ะ เนื่องจากค่าฝากแบบรายเดือนเป็นราคาเหมารวมอยู่แล้ว” EN “If you were unable to notify us in advance but have a valid reason with supporting documents (e.g., flight delay/cancellation, medical certificate), we can offer a xx% discount, since monthly storage is already based on a flat rate.”</p>
<p><strong>4. การแจ้งลูกค้าให้อดทนรอผลการอนุมัติ</strong></p>
<p>TH “ขอบคุณสำหรับข้อมูลและเอกสารค่ะ ตอนนี้ทีมงานกำลังตรวจสอบและจะรีบแจ้งผลการพิจารณาให้คุณลูกค้า ทราบโดยเร็วที่สุดค่ะ” EN “Thank you for providing the information and documents. Our team is reviewing your case, and we will update you with the decision as soon as possible.”</p>
<p><strong>5. การแจ้งผลอนุมัติส่วนลด</strong></p>
<p>TH “เรียนคุณลูกค้า ทางทีมงานได้พิจารณาแล้ว และอนุมัติส่วนลด [XX%] สำหรับค่าฝากสัมภาระในครั้งนี้ค่ะ ขอบคุณที่ไว้วางใจใช้บริการ AIRPORTELs และหวังว่าจะได้ให้บริการอีกในอนาคตนะคะ” EN “Dear Customer, we are pleased to inform you that your discount request has been approved at [XX%] for this storage. Thank you for choosing AIRPORTELs, and we look forward to serving you again.”</p>
<p><strong>6. การชวนลูกค้ารีวิว (Google Review)</strong></p>
<p>TH “หากคุณลูกค้าพึงพอใจกับการบริการ รบกวนช่วยรีวิว AIRPORTELs ทาง Google Review ได้ไหมคะ ความ เห็นของคุณลูกค้ามีคุณค่ามากสำหรับการพัฒนาบริการของเรา” EN “If you are satisfied with our service, we would greatly appreciate it if you could leave us a review on Google. Your feedback means a lot to us” TH "ทางเราขอพิจารณาส่วนลดพิเศษจากราคา xx,xxx บาท เหลือเพียง x,xxx บาทค่ะ และหากคุณลูกค้าได้รับความ พึงพอใจจากการให้บริการของพนักงานและสาขา รบกวนช่วยรีวิวใน Google Map เพื่อเป็นกำลังใจให้ทีมงานด้วยนะ คะ" EN "We are pleased to offer you a special discount from xx,xxx THB to only x,xxx THB If you are satisfied with our staff and service, we would greatly appreciate it if you could leave us a 5-star review on Google Maps to support our team. Thank you very much.</p>
<h3>ตารางประกอบจากเอกสารต้นฉบับ</h3><figure><img src="/sop/delayed-pickup-discount/p2.jpg" alt="ตารางโครงสร้างส่วนลด (Discount Structure) ตามขนาด × ยอดค่าฝาก" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ตารางโครงสร้างส่วนลด (Discount Structure) ตามขนาด × ยอดค่าฝาก</figcaption></figure><figure><img src="/sop/delayed-pickup-discount/p4.jpg" alt="ตารางเงื่อนไขและเอกสารประกอบตามกรณี (Specific Conditions by Case)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ตารางเงื่อนไขและเอกสารประกอบตามกรณี (Specific Conditions by Case)</figcaption></figure><figure><img src="/sop/delayed-pickup-discount/p5.jpg" alt="เกณฑ์ขนาดสัมภาระ (Size Factor)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>เกณฑ์ขนาดสัมภาระ (Size Factor)</figcaption></figure>'
where slug = 'delayed-pickup-discount';

-- ===== NEW: safe-luggage-storage =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('safe-luggage-storage', 'การจัดเก็บกระเป๋าให้ปลอดภัยภายในพื้นที่ที่บริษัทจัดเตรียมไว้ (Safe Luggage Storage)', 'SOP-OPS 014/2025 — ขั้นตอนมาตรฐานการรับฝาก ติดแท็ก และจัดเก็บกระเป๋าอย่างปลอดภัย การควบคุมกุญแจ การส่งต่อกะ และการตรวจนับ เพื่อลดความเสี่ยงสูญหาย/สับเปลี่ยน/เสียหาย',
  (select id from sop.categories where slug = 'counter-service'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 014/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 15 สิงหาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>กำหนดขั้นตอนมาตรฐานในการรับฝาก ติดแท็ก และ จัดเก็บกระเป๋าอย่างปลอดภัย ภายในพื้นที่ที่บริษัทจัดเตรียมไว้ เพื่อลดความเสี่ยงการ สูญหาย/สับเปลี่ยน/เสียหาย และให้สามารถ ตรวจสอบย้อนกลับ (traceability) ได้ตลอด กระบวนการ.</p>
<h3>📌 ขอบเขตการใช้งาน / Scope</h3>
<ul><li>ครอบคลุมทุกสาขาที่มีบริการรับฝากกระเป๋า ทั้ง หน้าเคาน์เตอร์ (Counter) และห้องเก็บของ</li></ul>
<p>(Store/Backroom)</p>
<ul><li>ขอบเขตการรับผิดชอบ สำหรับพนักงานตำแหน่ง Guest Service / Branch Manager / Porter ทุกคนที่ปฏิบัติ</li></ul>
<p>งานหน้าสาขา หรือ ดูแลจุดรับฝากสัมภาระและกระเป๋าเดินทาง.</p>
<h3>คำจำกัดความ (Definitions)</h3>
<ul><li>POS: ระบบขายหน้าร้าน/ระบบทำรายการฝาก (Point of Sale / Order System)</li><li>Luggage Tag (Tag กระเป๋า): ป้ายแท็กที่พิมพ์จากระบบเพื่อผูกกับกระเป๋าแต่ละใบ</li><li>Received Slip: ใบรับฝากส่งมอบให้ลูกค้า</li><li>Store: ห้อง/พื้นที่เก็บกระเป๋าด้านหลัง</li><li>Counter: พื้นที่หน้าเคาน์เตอร์บริการ</li><li>Porter: พนักงานเฝ้าระวังกระเป๋า (เฉพาะบางสาขา)</li><li>Key Control: การควบคุมการเข้าถึงกุญแจ/คีย์การ์ดในพื้นที่เก็บ</li><li>Handover Log: สมุด/แบบฟอร์มบันทึกส่งต่องานระหว่างกะ หรือส่งต่อภายกลุ่มสื่อสารภายในทีม เช่น</li></ul>
<p>Line หรือ Lark</p>
<ul><li>Shelf : ชั้นวางกระเป๋า สำหรับจัดเก็บกระเป๋าในพื้นที่สาขา</li></ul>
<h3>📌 บทบาท/ความรับผิดชอบ (Roles &amp; Responsibilities)</h3>
<ul><li>Guest Service Staff: ทำรายการใน POS ติดแท็ก จัดเก็บตามประเภทสาขา และ ล็อคพื้นที่ ทุกครั้งหลัง</li></ul>
<p>เก็บ</p>
<ul><li>Porter (เฉพาะบางสาขา): เฝ้าระวังจุดเก็บ/จุดรับฝากที่กำหนด</li><li>หัวหน้าสาขา/หัวหน้างาน: กำกับดูแลความเรียบร้อย การควบคุมกุญแจ การตรวจสอบประจำวัน และการ</li></ul>
<p>รายงานเหตุผิดปกติ</p>
<h3>🔁 ขั้นตอนการปฏิบัติ / Procedure</h3>
<p><strong>1. รับฝากและสร้างออเดอร์ในระบบ POS</strong></p>
<ul><li>a. รับกระเป๋าจากลูกค้า ตรวจนับจำนวน และตรวจสภาพเบื้องต้น (รอยฉีกขาด/หูหิ้ว/ซิป)</li><li>b. สร้างรายการฝากใน POS ให้ครบถ้วน และ ปิดรายการ (Complete)</li></ul>
<p><strong>2. พิมพ์สลิปและติดแท็กทุกใบ</strong></p>
<ul><li>a. เมื่อออเดอร์เสร็จ ระบบจะพิมพ์ Luggage Tag และ Received Slip ตามจำนวนกระเป๋า</li><li>b. ติด Tag ให้ตรงกับออเดอร์และ ครบทุกใบ ก่อนนำไปเก็บ (ตรวจสอบหมายเลขออเดอร์/Tag ซ้ำอีกครั้ง)</li></ul>
<p><strong>3. การจัดเก็บตามประเภทสาขา (เลือกแนวทางตามสาขาที่ปฏิบัติ)</strong></p>
<ul><li>a. สาขาที่ไม่มี Store หรือ Store อยู่ไกลจากเคาน์เตอร์</li></ul>
<p>→ เก็บไว้ใน เขตเคาน์เตอร์ แล้ว ปิดประตูและล็อค ทันทีหลังจัดเก็บ หรือ คลุมผ้าทุกครั้งที่ไม่อยู่ในพื้นที่ เคาน์เตอร์</p>
<ul><li>b. สาขาที่มี Store ใกล้เคาน์เตอร์</li></ul>
<p>→ นำกระเป๋าเข้า Store จัดวางตาม โซน/ลำดับเวลาฝาก แล้ว ปิดและล็อคประตู ทุกครั้ง</p>
<ul><li>c. สาขาที่มี Porter (เช่น สนามบิน)</li></ul>
<p>→ มอบหมาย Porter เฝ้าระวัง ตามจุดที่กำหนด และประสานงานกับเคาน์เตอร์ ตัวอย่างการกำหนด:</p>
<ul><li>CTW Hugthai/CTW Groove/PNX/CTPY (ไม่มี Store หรือไกล)</li><li>T21/MBK/MIXT/ICS/EMS/EMP/CNX/HKT/TPY (มี Store ใกล้),</li><li>BKK/DMK (มี Porter)</li></ul>
<p><strong>4. การวาง/จัดโซนในพื้นที่เก็บ</strong></p>
<ul><li>a. จัดวางตาม โซนและเวลา (เช่น โซน A = วันนี้เช้า, โซน B = วันนี้บ่าย ฯลฯ) เพื่อค้นหาได้รวดเร็ว</li><li>b. ของหนักวางล่าง / ของเปราะบางวางบน / หลีกเลี่ยงการกดทับ</li><li>c. ห้ามวาง ขวางทางหนีไฟ/บังกล้องวงจรปิด</li></ul>
<p><strong>5. การออกจากจุดบริการชั่วคราว</strong></p>
<ul><li>a. หากจำเป็นต้อง ออกจากพื้นที่เคาน์เตอร์ ให้แจ้ง หัวหน้าสาขา/OP Team Lead ผ่าน กลุ่มที่บริษัทกำหนด</li></ul>
<p>(LINE/Lark ภายในแต่ละสาขา) พร้อมระบุช่วงเวลาไม่อยู่</p>
<ul><li>กลุ่มไลน์ Respond.io : https://line.me/ti/g/4cn8mCTeFW</li><li>กลุ่มไลน์ AI Gang🧳✈️ : https://line.me/ti/g/Sk3zTEDpd7</li><li>b. ก่อนออกจากพื้นที่ให้ scan หน้าออก และ scan เข้าพื้นที่ หลังจากกลับมา ทุกครั้ง ผ่านระบบ empeo</li><li>c. ล็อคพื้นที่และจัดเจ้าหน้าที่ทดแทน เช่น Porter (ถ้ามี) หรือฝากรปภ. ที่อยู่ใกล้เคียงช่วยเฝ้า</li></ul>
<p><strong>6. การส่งต่องาน (Handover)</strong></p>
<ul><li>a. ก่อนเปลี่ยนกะ สรุปจำนวน กระเป๋าที่เก็บ พร้อม ตำแหน่งจัดเก็บ/โซน และความเคลื่อนไหวระหว่างกะ</li><li>b. บันทึกใน Handover Log หรือแจ้งในกลุ่มงานที่กำหนด เพื่อรับทราบร่วมกัน</li></ul>
<p><strong>7. บันทึกและการควบคุม (Controls)</strong></p>
<ul><li>a. บันทึกรายการฝาก/แท็ก/ตำแหน่งเก็บใน Storage Log (หรือระบบที่สาขากำหนด)</li><li>b. ตรวจนับประจำวันอย่างน้อย 1 ครั้ง เทียบกับ Storage Log และ POS</li><li>c. Key Control: เก็บ/ส่งมอบกุญแจให้เฉพาะผู้ที่เกี่ยวข้อง, จำกัดผู้มีสิทธิ์เข้าถึง</li></ul>
<p>กรณีผิดปกติและการจัดการเหตุ (Exceptions &amp; Incident Handling)</p>
<ul><li>พบแท็กไม่ตรง/แท็กหาย: แยกกระเป๋าออกจากโซนหลัก แจ้งหัวหน้า ตรวจสอบใน POS และ พิมพ์แท็กใหม่</li><li>ผู้ไม่ได้รับอนุญาตเข้าถึงพื้นที่เก็บ: หยุดให้บริการชั่วคราวในโซนดังกล่าว แจ้งหัวหน้า บันทึกเหตุ และประสาน</li></ul>
<p>รปภ./CCTV</p>
<ul><li>กรณีต้องออกจากพื้นที่เคาน์เตอร์ฉุกเฉิน: ล็อคพื้นที่ หรือ คลุมสัมภาระ ให้มิดชิด แจ้งกลุ่มภายในทันที (ดูข้อ 5)</li><li>กระเป๋าเสียหาย/ข้อร้องเรียน: บันทึกภาพ/รายละเอียด, แจ้งรายละเอียดความเสียหาย / สูญหาย ให้หัวหน้างาน</li></ul>
<p>ทราบทันทีและดำเนินการตามนโยบายชดเชย/เคลม</p>
<h3>มาตรการความปลอดภัยหลัก (Security Controls)</h3>
<ul><li>ล็อคพื้นที่เก็บ ทุกครั้งหลังนำเข้า/นำออก</li><li>จัดโซน/ติดป้ายชัดเจน ลดความเสี่ยงสับเปลี่ยน</li><li>CCTV/มุมอับ: รักษามุมกล้องให้เห็นชัด หลีกเลี่ยงการวางสิ่งของบังกล้อง</li><li>Sensitives: แยกเก็บสิ่งของมีค่าตามนโยบายบริษัท (หากมี) และติด Seal/ถ่ายรูปประกอบ</li><li>ทบทวนเหตุฉุกเฉิน: รายไตรมาส (สูญหาย ไฟไหม้ น้ำรั่ว ฯลฯ)</li></ul>
<h3>ตัวชี้วัดและการตรวจติดตาม (KPIs &amp; Audit)</h3>
<ul><li>Zero Loss/Damage: เป้าหมาย = 0 เคส/เดือน (ยกเว้นพิสูจน์ได้ว่าเหตุสุดวิสัย)</li><li>Handover Completeness: ส่งมอบงานครบ 100% ของกะ</li><li>Daily Count Compliance: ตรวจนับครบ ≥ 1 ครั้ง/วัน ทุกวันทำการ</li><li>Audit:</li><li>ระดับสาขา: หัวหน้าสาขา สุ่มตรวจรายสัปดาห์ (Storage Log vs. ของจริง)</li><li>ระดับส่วนกลาง: Operations ตรวจเดือนละครั้ง พร้อมทบทวน CCTV มุมวิกฤต</li></ul>
<p>✔️ Mini Checklist หน้าเคาน์เตอร์</p>
<ul><li>POS เสร็จ → พิมพ์ Tag &amp; Received Slip → ติดแท็ก ครบทุกใบ</li><li>นำเข้าโซนที่ถูกต้อง → ล็อคประตูทุกครั้ง</li><li>ต้องออกจากเคาน์เตอร์ → ปิดล๊อคพื้นที่ และ /หรือ คลุมสัมภาระให้มิดชิด</li></ul>
<p>→ แจ้งหัวหน้า/กลุ่มภายในตามระเบียบ → scan ออก และ เข้า (เมื่อกลับเข้าพื้นที่) ผ่าน empeo ทุกครั้ง</p>

<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://line.me/ti/g/4cn8mCTeFW" target="_blank" rel="noopener">กลุ่มไลน์ Respond.io</a></li><li><a href="https://line.me/ti/g/Sk3zTEDpd7" target="_blank" rel="noopener">กลุ่มไลน์ AI Gang🧳✈️</a></li></ul>', array['storage','safety','counter'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: cross-branch-travel-allowance =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('cross-branch-travel-allowance', 'มาตรฐานค่าเดินทางและการปฏิบัติ กรณีโยกย้ายพนักงานไปช่วยงานต่างสาขา', 'SOP-OPS 0015/2025 — มาตรฐานการเบิกค่าเดินทางและแนวทางปฏิบัติเมื่อพนักงานถูกมอบหมายไปช่วยงานสาขาอื่น รวมถึงกรณีวันหยุด นโยบายตำแหน่ง Runner และตารางค่าเดินทางมาตรฐาน',
  (select id from sop.categories where slug = 'standards'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0015/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 ตุลาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดมาตรฐานการเบิกค่าเดินทางและแนวทางการปฏิบัติสำหรับพนักงาน ที่ถูกมอบหมายให้ไปช่วยงานใน สาขาอื่นที่ไม่ใช่สาขาประจำของตนเอง โดยคำนึงถึงความเป็นธรรม ความโปร่งใส และความสะดวกในการดำเนินงาน</p>
<h3>ขอบเขตการใช้งาน (Scope)</h3>
<p>ใช้กับพนักงานทุกตำแหน่งในสาขาห้าง และสาขาบริการทุกแห่งของบริษัทฯ ที่มีการมอบหมายงานข้ามสาขา</p>
<h3>หลักการปฏิบัติ (Policy &amp; Procedure)</h3>
<p><strong>1. กรณีปฏิบัติงานในวันทำงานปกติ (Working Day Assignment)</strong></p>
<ul><li>พนักงานสามารถเบิกค่าเดินทางได้ตามอัตราที่บริษัทกำหนด (อ้างอิง ตารางมาตรฐานค่าเดินทาง)</li><li>ไม่ถือเป็นการทำงานในวันหยุด</li></ul>
<p><strong>2. กรณีปฏิบัติงานในวันหยุด (Day-off Assignment)</strong></p>
<p>พนักงานสามารถเลือกได้ 2 แนวทาง</p>
<ul><li>เปลี่ยนวันหยุด (Change Day-off) โดย หัวหน้างานจะจัดตารางวันหยุดชดเชยให้</li><li>รับเป็นค่าแรงวันทำงาน (Workday Payment) เท่ากับอัตราค่าจ้าง 1 วัน</li></ul>
<p>ทั้งสองกรณี พนักงานยังสามารถ เบิกค่าเดินทางได้ตามที่กำหนด</p>
<h3>ข้อกำหนดเพิ่มเติมสำหรับตำแหน่ง Runner (Runner Assignment Policy)</h3>
<p><strong>1. พนักงานตำแหน่ง Runner ต้องสามารถ หมุนเวียน (Rotate) ไปปฏิบัติงานได้ทั้ง สาขาห้าง และ สาขาสนามบิน</strong></p>
<p>ตามความจำเป็นของบริษัทฯ</p>
<p><strong>2. พนักงานตำแหน่ง Runner ต้องสามารถเข้าปฏิบัติงาน ตามรอบกะ (Shift Duty) ที่กำหนดได้</strong></p>
<p><strong>3. บริษัทฯ จะจ่าย ค่าเดินทางแบบเหมาจ่าย (Flat-rate Travel Allowance) สำหรับ Runner วันละ 100 บาท ไม่</strong></p>
<p>ว่าปฏิบัติงาน ณ สาขาใด</p>
<h3>ข้อยกเว้น (Exception)</h3>
<ul><li>พนักงานที่ลาหยุดกลับต่างจังหวัดหรือต่างประเทศ และได้แจ้งลาล่วงหน้าแล้ว จะไม่ถูกเรียกให้โยกย้ายหรือ</li></ul>
<p>Stand by</p>
<ul><li>กรณีฉุกเฉิน พนักงานประจำสาขาห้างจะต้องพร้อม Stand by สำหรับการปรับเปลี่ยน/โยกย้าย</li></ul>
<h3>ตารางมาตรฐานค่าเดินทาง (Standard Travel Allowance)</h3>
<ul><li>ตารางเปรียบเทียบระยะทาง และค่าเดินทาง</li></ul>
<h3>ตารางค่าเดินทาง</h3>
<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px}
.prose table.sop-tbl td{min-width:160px;max-width:320px;vertical-align:top;text-align:center;font-size:13.5px;line-height:1.55}
.prose table.sop-tbl td.rh,.prose table.sop-tbl th:first-child{min-width:120px;text-align:left;font-weight:700;white-space:nowrap;position:sticky;left:0;background:var(--surface-2);z-index:1}
.sop-hint{font-size:12px;color:var(--text-muted);margin:2px 0 4px}
</style><h3>ตารางมาตรฐานค่าเดินทาง (Standard Travel Allowance)</h3><p><strong>1) ตารางเปรียบเทียบระยะทางและค่าเดินทาง</strong> (จำนวนสถานี BTS/MRT และค่าเดินทางระหว่างสาขา)</p><p class="sop-hint">⟷ เลื่อนตารางซ้าย-ขวาเพื่อดูทุกคอลัมน์</p><div class="sop-scroll"><table class="sop-tbl"><thead><tr><th>From \ To</th><th>Emporium</th><th>Emsphere</th><th>T21</th><th>CTW</th><th>MBK</th><th>ICON</th><th>Phoenix Pratunam</th><th>MIXT</th></tr></thead><tbody><tr><td class="rh">Emporium</td><td>-</td><td>เดิน . → 0 บ.</td><td>1 สถานี <br>(Phrom Phong → Asok) 50 บ.</td><td>4 สถานี <br>(Phrom Phong → Chidlom) 70 บ.</td><td>6 สถานี <br>(Phrom Phong → National Stadium) → 70 บ.</td><td>15 สถานี <br>(Phrom Phong → Charoen Nakorn) 100 บ.</td><td>6 สถานี <br>(Ratchathewi → Phrom Phong) 70 บ.</td><td>13 สถานี <br>(Phrom Phong → Mo Chit + Motor Cycle) 100 บ.</td></tr><tr><td class="rh">Emsphere</td><td>เดิน → 0 บ.</td><td>-</td><td>1 สถานี <br>(Phrom Phong → Asok) 50 บ.</td><td>4 สถานี <br>(Phrom Phong → Chidlom) 70 บ.</td><td>6 สถานี <br>(Phrom Phong → National Stadium) → 70 บ.</td><td>15 สถานี <br>(Phrom Phong → Charoen Nakorn) 100 บ.</td><td>6 สถานี <br>(Ratchathewi → Phrom Phong) 70 บ.</td><td>13 สถานี <br>(Phrom Phong → Mo Chit + Motor Cycle) 100 บ.</td></tr><tr><td class="rh">T21</td><td>1 สถานี<br> (Asok → Phrom Phong) 50 บ.</td><td>1 สถานี <br>(Asok → Phrom Phong) → 50 บ.</td><td>-</td><td>4 สถานี <br>(Asok → Chidlom) 50 บ.</td><td>5 สถานี <br>(Asok → National Stadium) → 70 บ.</td><td>14 สถานี <br>(Asok → Charoen Nakorn) 100 บ.</td><td>7 สถานี <br>(Ratchathewi → Asok) 70 บ.</td><td>12 สถานี <br>(Asok → Mo Chit + Motor Cycle) 100 บ.</td></tr><tr><td class="rh">CTW</td><td>5 สถานี <br>(Siam → Phrom Phong) 70 บ.</td><td>5 สถานี <br>(Siam → Phrom Phong) 70 บ.</td><td>4 สถานี (Siam → Asok) 50 บ.</td><td>-</td><td>1 สถานี <br>(Siam → National Stadium) → 50 บ.</td><td>10 สถานี <br>(Siam → Charoen Nakorn) 100 บ.</td><td>เดิน . → 0 บ.</td><td>8 สถานี <br>(Siam → Mo Chit + Motor Cycle) 100 บ.</td></tr><tr><td class="rh">MBK</td><td>5 สถานี <br>(National Stadium → Phrom Phong) 70 บ.</td><td>5 สถานี <br>(National Stadium → Phrom Phong) 70 บ.</td><td>5 สถานี (National Stadium → Asok) 50 บ.</td><td>1 สถานี <br>(National Stadium → Siam) 50 บ.</td><td>-</td><td>11 สถานี <br>(National Stadium → Charoen Nakorn) 100 บ.</td><td>1 สถานี <br>(Ratchathewi → National Stadium) 50 บ.</td><td>9 สถานี <br>(National Stadium → Mo Chit + Motor Cycle) 100 บ.</td></tr><tr><td class="rh">ICON</td><td>15 สถานี <br>(Phrom Phong → Charoen Nakorn) 100 บ.</td><td>15 สถานี <br>(Phrom Phong → Charoen Nakorn) 100 บ.</td><td>14 สถานี (Asok → Charoen Nakorn) 100 บ.</td><td>10 สถานี <br>(Siam → Charoen Nakorn) 100 บ.</td><td>11 สถานี <br>(National Stadium → Charoen Nakorn) 100 บ.</td><td>-</td><td>12 สถานี <br>(Ratchathewi → Charoen Nakorn) 100 บ.</td><td>17 สถานี <br>(Mochit → Charoen Nakorn) 100 บ.</td></tr><tr><td class="rh">Phoenix Pratunam</td><td>6 สถานี <br>(Ratchathewi → Phrom Phong) 70 บ.</td><td>6 สถานี <br>(Ratchathewi → Phrom Phong) 70 บ.</td><td>6 สถานี (Ratchathewi → Asok) 70 บ.</td><td>เดิน . → 0 บ.</td><td>1 สถานี <br>(National Stadium → Ratchathewi + Motor Cycle) <br>50 บ.</td><td>12 สถานี <br>(Ratchathewi → Charoen Nakorn) 100 บ.</td><td>-</td><td>7 สถานี <br>(Ratchathewi → Mo Chit + Motor Cycle) 70 บ</td></tr><tr><td class="rh">MIXT</td><td>13 สถานี<br> (Phrom Phong → Mo Chit + Motor Cycle) 100 บ.</td><td>13 สถานี <br>(Phrom Phong → Mo Chit + Motor Cycle) 100 บ.</td><td>12 สถานี (Asok → Mo Chit + Motor Cycle) 100 บ.</td><td>8 สถานี <br>(Siam → Mo Chit + Motor Cycle) 100 บ.</td><td>9 สถานี <br>(National Stadium → Mo Chit + Motor Cycle) 100 บ.</td><td>17 สถานี <br>( Charoen Nakornt → Mochit + Motor Cycle) 100 บ.</td><td>7 สถานี <br>(Ratchathewi → Mo Chit + Motor Cycle) 70 บ</td><td>-</td></tr></tbody></table></div><p><strong>2) ตารางค่าเดินทาง (บาท)</strong></p><p class="sop-hint">⟷ เลื่อนตารางซ้าย-ขวาเพื่อดูทุกคอลัมน์</p><div class="sop-scroll"><table class="sop-tbl"><thead><tr><th>From \ To</th><th>Emporium</th><th>Emsphere</th><th>T21</th><th>CTW</th><th>MBK</th><th>ICON</th><th>Phoenix</th><th>MIXT</th></tr></thead><tbody><tr><td class="rh">Emporium</td><td>-</td><td>0</td><td>50</td><td>70</td><td>70</td><td>100</td><td>70</td><td>100</td></tr><tr><td class="rh">Emsphere</td><td>0</td><td>-</td><td>50</td><td>70</td><td>70</td><td>100</td><td>70</td><td>100</td></tr><tr><td class="rh">T21</td><td>50</td><td>50</td><td>-</td><td>50</td><td>70</td><td>100</td><td>70</td><td>100</td></tr><tr><td class="rh">CTW</td><td>70</td><td>70</td><td>50</td><td>-</td><td>50</td><td>100</td><td>0</td><td>100</td></tr><tr><td class="rh">MBK</td><td>70</td><td>70</td><td>50</td><td>50</td><td>-</td><td>100</td><td>50</td><td>100</td></tr><tr><td class="rh">ICON</td><td>100</td><td>100</td><td>100</td><td>100</td><td>100</td><td>-</td><td>100</td><td>100</td></tr><tr><td class="rh">Phoenix Pratunam</td><td>70</td><td>70</td><td>70</td><td>-</td><td>50</td><td>100</td><td>-</td><td>70</td></tr><tr><td class="rh">MIXT</td><td>100</td><td>100</td><td>100</td><td>100</td><td>100</td><td>100</td><td>70</td><td>-</td></tr></tbody></table></div><p style="font-size:12px;color:var(--color-muted,#6b7280)">※ อัตราค่าเดินทางเหมาจ่ายตามเส้นทางระหว่างสาขา (หน่วย: บาท)</p>', array['travel','allowance','staff','runner'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: handheld-metal-detector =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('handheld-metal-detector', 'การใช้งานเครื่องตรวจจับโลหะแบบพกพา (Handheld Metal Detector)', 'SOP-OPS 010/2025 — วิธีใช้เครื่องตรวจจับโลหะแบบพกพาเพื่อตรวจสอบวัตถุต้องห้ามก่อนรับฝาก/จัดส่งกระเป๋า (ใช้เมื่อเครื่อง X-Ray ใช้งานไม่ได้ หรือเป็นการตรวจเสริม) พร้อมรายการสิ่งของต้องห้าม',
  (select id from sop.categories where slug = 'counter-service'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 010/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 9 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>📌 วัตถุประสงค์ (Objective)</h3>
<p>เพื่อเพิ่มความปลอดภัยในการรับฝาก และจัดส่งกระเป๋าโดยการตรวจสอบวัตถุต้องห้ามที่อาจเป็นอันตรายหรือผิด กฎหมาย โดยใช้เครื่องตรวจจับโลหะแบบพกพาก่อนนำกระเป๋าเข้าสู่กระบวนการจัดเก็บหรือจัดส่ง</p>
<h3>📌 ขอบเขตการใช้งาน</h3>
<p>ใช้ในกรณีที่:</p>
<ul><li>เครื่อง X-Ray อยู่ระหว่างซ่อมแซม หรือไม่สามารถใช้งานได้</li><li>ใช้เป็นเครื่องมือเสริมในการตรวจสอบเบื้องต้น ณ จุดบริการสนามบิน / สาขาหลัก</li></ul>
<h3>🛠 อุปกรณ์ที่ใช้</h3>
<ul><li>เครื่องตรวจจับโลหะแบบพกพา (Hand-held Metal Detector)</li><li>CCTV (ระหว่างการตรวจ ให้อยู่ในมุมมองของกล้อง เพื่อป้องกันการงิวาท กรณีพบวัตถุต้องสงสัย)</li></ul>
<h3>🔄 ขั้นตอนปฏิบัติ (SOP)</h3>
<p>วิธีการใช้งานเครื่องตรวจจับโลหะแบบพกพา (Handheld Metal Detector)</p>
<h3>🚫 สิ่งของต้องห้ามที่ไม่รับฝาก / ส่ง</h3>
<ul><li>สัตว์มีชีวิต / ซากสัตว์</li><li>เงินสด / เช็ค / บัตร</li><li>ของมีค่า เช่น ทองคำ เพชร อัญมณี</li><li>อาวุธ / วัตถุระเบิด / สารเสพติด</li><li>แบตเตอรี่ / ของเหลวไวไฟ</li><li>อาหารเน่าเสีย / ขยะ</li><li>อุปกรณ์อิเล็กทรอนิกส์บางชนิดที่มีแบตเตอรี่</li><li>สิ่งผิดกฎหมายอื่นตามประกาศบริษัท</li></ul>
<p>หมายเหตุ: หากลูกค้าปฏิเสธการตรวจสอบ ทางบริษัทสามารถขอปฏิเสธการให้บริการได้ทันที เพื่อความปลอดภัย สูงสุด</p>
<h3>🚫 สิ่งของต้องห้ามสำหรับการจัดส่ง Nationwide Same-day Delivery</h3>
<h3>ภาพและป้ายประกอบจากเอกสารต้นฉบับ</h3><figure><img src="/sop/handheld-metal-detector/p2.jpg" alt="ขั้นตอนการใช้งาน และตำแหน่งปุ่มควบคุมของเครื่องตรวจจับโลหะแบบพกพา" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ขั้นตอนการใช้งาน และตำแหน่งปุ่มควบคุมของเครื่องตรวจจับโลหะแบบพกพา</figcaption></figure><figure><img src="/sop/handheld-metal-detector/p4.jpg" alt="ป้ายสิ่งของต้องห้ามในการรับฝาก/จัดส่ง (ไทย/อังกฤษ)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ป้ายสิ่งของต้องห้ามในการรับฝาก/จัดส่ง (ไทย/อังกฤษ)</figcaption></figure>', array['security','inspection','metal-detector','x-ray-backup'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: manual-baggage-check-xray-down =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('manual-baggage-check-xray-down', 'การตรวจสอบสัมภาระแบบชั่วคราว กรณีเครื่อง X-Ray ใช้งานไม่ได้ (Manual Baggage Check)', 'SOP-OPS 009/2025 — ขั้นตอนการตรวจสอบกระเป๋าและสัมภาระลูกค้าด้วยมืออย่างปลอดภัยและโปร่งใส ภายใต้กล้องวงจรปิด ในกรณีเครื่อง X-Ray ขัดข้อง/อยู่ระหว่างซ่อม พร้อมสคริปต์แจ้งลูกค้า (TH/EN)',
  (select id from sop.categories where slug = 'counter-service'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 009/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 7 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>Protocol &amp; SOP: Temporary Manual Check Protocol</h3>
<p>หัวข้อ: การตรวจสอบกระเป๋าและสัมภาระลูกค้าแบบชั่วคราว สถานการณ์: เครื่อง X-Ray ขัดข้องอยู่ระหว่างการซ่อม</p>
<h3>Manual Baggage Check (ระหว่างเครื่อง X-Ray ชำรุด)</h3>
<p><strong>1. วัตถุประสงค์ (Objective)</strong></p>
<ul><li>เพื่อให้การให้บริการยังคงปลอดภัย เป็นมืออาชีพ และมีมาตรฐานภายใต้ข้อจำกัดทางเทคนิค</li><li>เพื่อให้การดำเนินการตรวจสอบสัมภาระของลูกค้าอย่างปลอดภัย มีมาตรฐาน และโปร่งใส ในกรณีที่เครื่อง X-</li></ul>
<p>Ray ใช้งานไม่ได้</p>
<p><strong>2. ขอบเขต (Scope)</strong></p>
<p>ใช้สำหรับสาขาสนามบินทุกแห่งของ AIRPORTELs ที่พบปัญหาเครื่อง X-Ray ไม่สามารถใช้งานได้ และอยู่ระหว่างรอ การซ่อม</p>
<p><strong>3. อุปกรณ์ที่ใช้ (Required Tools)</strong></p>
<ul><li>กล้องวงจรปิด (ต้องทำงาน)</li><li>Handheld Metal detector</li><li>พยานร่วม (Guest Service หรือ Porter ที่ทำงานร่วมกันอย่างน้อย 1 คน หรือ CCTV มุมมองชัดเจน)</li></ul>
<h3>🔁 ขั้นตอนการปฏิบัติ (Step-by-Step)</h3>
<h3>Step 1: เตรียมพร้อมก่อนเริ่มการตรวจ</h3>
<ul><li>ยืนยันว่าเครื่อง X-Ray ไม่สามารถใช้งานได้</li><li>แจ้งหัวหน้างาน/ผู้จัดการ และติดป้าย “X-Ray Under Maintenance” ที่จุดให้บริการ</li><li>จัดเตรียมกล้องวงจรปิด (จุดตรวจที่อยู่ในมุมกล้อง) หรือพยานเพื่อทราบ</li><li>เตรียม Hand-held detector ให้พร้อมใช้งาน</li></ul>
<h3>Step 2: แจ้งลูกค้าอย่างสุภาพ</h3>
<p>ใช้ Script ด้านล่างนี้ในการพูดกับลูกค้า: 🔸ภาษาไทย: “ขออภัยค่ะ ขณะนี้เครื่อง X-Ray ของเรากำลังอยู่ระหว่างการซ่อมแซม ทางเราจึงต้องใช้วิธีการตรวจสอบสัมภาระ ด้วยมือเพื่อความปลอดภัยค่ะ ซึ่งจะดำเนินการภายใต้กล้องวงจรปิด และใช้ความระมัดระวังสูงสุด เพื่อความ สบายใจของลูกค้า ขออนุญาตเปิดกระเป๋าเพื่อทำการตรวจสอบนะคะ” 🔸English: “We apologize. Our X-Ray machine is currently under maintenance. As a safety measure, we need to manually inspect your luggage under CCTV supervision. We will handle your belongings with the utmost care. May we proceed to open your bag for inspection?”</p>
<h3>Step 3: ตรวจสอบสัมภาระ (Manual Check)</h3>
<ul><li>ใช้เครื่องตรวจรอบกระเป๋าเดินทาง ทั้งการฝาก และการส่ง ทุกครั้ง</li><li>กรณีพบวัตถุค้องสงสัย : ขออนุญาตเปิดกระเป๋า เฉพาะต่อหน้าลูกค้าและกล้องวงจรปิด</li><li>ตรวจสอบภายในโดยละเอียด แต่ไม่ละเมิดสิทธิส่วนบุคคล</li><li>ไม่จับต้องทรัพย์สินส่วนตัวโดยไม่จำเป็น หรือให้ลูกค้าเป็นผู้หยิบทรัพย์สินให้ตรวจ</li><li>ใช้ Handheld Metal Detector เพื่อตรวจสอบ (ดำเนินการตาม SOP การใช้งานฯ)</li></ul>
<p>SOP: การใช้งานเครื่องตรวจจับโลหะแบบพกพา (Hand-Held Metal Detector)</p>
<h3>Step 4: แจ้งผลการตรวจ</h3>
<ul><li>แจ้งลูกค้าว่าการตรวจเสร็จเรียบร้อย</li><li>หากทำการเปิดตรวจให้ปิดกระเป๋าให้เรียบร้อยและดำเนินการเก็บ/จัดส่งตามบริการที่ลูกค้าเลือก</li><li>ลูกค้าสามารถขอลงชื่อรับทราบใน Log ได้หากต้องการ</li></ul>
<h3>Script สำหรับพนักงาน (2 ภาษา)</h3>
<p>แนวทางเสริมความปลอดภัย &amp; ความโปร่งใส</p>
<ul><li>ตรวจในจุดที่มีกล้องวงจรปิดหรือมีพยานร่วม (หลีกเลี่ยงพื้นที่ปิด)</li><li>ห้ามใช้โทรศัพท์มือถือระหว่างตรวจสอบ</li><li>ห้ามพนักงานทำการตรวจสอบเพียงลำพัง หรือไม่อยู่ในมุมมองของ CCTV</li><li>หากพบสิ่งของต้องสงสัย ให้แจ้งหัวหน้างานทันที</li></ul>
<h3>แบบฟอร์มบันทึกข้อมูล (Manual Check Log)</h3>
<h3>Manual Check Log</h3>
<h3>แบบฟอร์มและป้ายประกอบจากเอกสารต้นฉบับ</h3><figure><img src="/sop/manual-baggage-check-xray-down/p4.jpg" alt="ตัวอย่างแบบฟอร์ม Manual Check Log และป้ายแจ้งลูกค้า (X-Ray Under Maintenance)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ตัวอย่างแบบฟอร์ม Manual Check Log และป้ายแจ้งลูกค้า (X-Ray Under Maintenance)</figcaption></figure>', array['security','inspection','x-ray','contingency'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: osl-radiation-badge =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('osl-radiation-badge', 'การใช้งานและการรับ-ส่งคืนแผ่นวัดรังสี (OSL) สำหรับสาขาสนามบิน', 'SOP-OPS 008/2025 — แนวทางการรับ แจกจ่าย ใช้งาน และส่งคืนแผ่นวัดรังสี (OSL) สำหรับพนักงานสาขาสนามบิน การบันทึกใน Lark การประสานงานกับ OSL/TINT และรอบการเปลี่ยนทุก 3 เดือน',
  (select id from sop.categories where slug = 'standards'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 008/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>🎯 วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดแนวทางปฏิบัติที่ชัดเจนในการรับ แจกจ่าย ใช้งาน และส่งคืนแผ่นวัดรังสี (OSL) สำหรับพนักงานที่มีความ เสี่ยงต่อการได้รับรังสี โดยเน้นความถูกต้อง ความปลอดภัย และการเก็บข้อมูลเป็นหลักฐานที่ตรวจสอบได้</p>
<h3>📌 ขอบเขต (Scope)</h3>
<p>ครอบคลุมถึงพนักงานทุกตำแหน่งที่ปฏิบัติงาน ณ สาขา สนามบิน ที่มีเครื่องสแกน โดยพนักงานที่ได้รับมอบแผ่นวัด รังสี และทีมสนับสนุนที่เกี่ยวข้องกับการเบิก-ส่งคืนอุปกรณ์ และการประสานงานกับหน่วยงานภายนอก (OSL)</p>
<h3>🔄 ขั้นตอนการปฏิบัติงาน (Step-by-Step Procedures)</h3>
<p><strong>1. การรับแผ่นวัดรังสีจาก OSL</strong></p>
<ul><li>หัวหน้าสาขาเป็นผู้รับแผ่นวัดรังสี</li><li>ตรวจสอบรายชื่อและจำนวนว่า ถูกต้อง ครบถ้วน</li><li>ลงบันทึกในระบบ Lark &gt; OSL แผ่นวัดรังสี</li></ul>
<p><strong>2. การแจกจ่ายแผ่นวัดรังสีให้พนักงาน</strong></p>
<ul><li>แจกจ่ายแผ่นวัดรังสีให้พนักงาน ตรงตามชื่อบนอุปกรณ์</li><li>พนักงานตรวจสอบชื่อบนแผ่นวัดรังสีว่าตรงกับตนเองหรือไม่</li><li>หากถูกต้อง:</li><li>ถ่ายภาพ แผ่นวัดรังสี</li><li>แนบภาพในแบบฟอร์มรายบุคคลเพื่อเป็นหลักฐาน</li></ul>
<p>🔗 ลิงก์ฟอร์ม</p>
<p><strong>3. กรณีชื่อผิด / ไม่มีชื่อพนักงาน</strong></p>
<ul><li>มอบแผ่นวัดรังสีให้พนักงานคนที่ยังไม่มีชื่อใช้งานไปก่อน</li><li>จัดทำเอกสารขอเปลี่ยนชื่อผู้ใช้งาน</li><li>ส่งอีเมลแจ้งไปที่:</li><li>osl@tint.or.th</li><li>CC: supervisor@airportels.co , it@airportels.co ,</li></ul>
<p>gsa_alpha@airportels.co</p>
<p><strong>4. กรณีพนักงานใหม่ยังไม่มีแผ่นวัดรังสี</strong></p>
<ul><li>ทำเอกสารขอใช้เพิ่ม</li><li>ส่งอีเมลแจ้งไปที่:</li><li>osl@tint.or.th</li><li>CC: supervisor@airportels.co , it@airportels.co ,</li></ul>
<p>gsa_alpha@airportels.co</p>
<ul><li>ทาง OSL จะตอบกลับเรื่องการชำระเงิน ให้ดำเนินการเบิกกับฝ่ายบัญชี (ประสานงาน Operation Co. - ป๊อป)</li></ul>
<p><strong>5. การเปลี่ยนและส่งคืนแผ่นวัดรังสี (ทุก 3 เดือน)</strong></p>
<ul><li>หัวหน้าสาขารวบรวมแผ่นวัดรังสีของพนักงานทุกคน</li><li>ส่งคืนไปยัง:</li></ul>
<p>สำนักงานใหญ่: เลขที่ 9/9 หมู่ที่ 7 ตำบลทรายมูล อำเภอองครักษ์ จังหวัดนครนายก 26120 โทร. 02-401-9889</p>
<ul><li>ลงบันทึกใน Lark &gt; OSL แผ่นวัดรังสี โดยจะต้องใส่รายละเอียดให้ครบถ้วน</li><li>ต้องขอใบกำกับภาษีทุกครั้ง (กรณีไม่ได้ใช้บริการ MakeSend)</li><li>ที่อยู่ออกใบกำกับภาษี :</li></ul>
<p>บริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด (สำนักงานใหญ๋) ที่อยู่ : เลขที่ 6 หมู่บ้านไพลินปาร์ค ซอยรัตนาธิเบศร์ 28 แยก 2 ต.บางกระสอ อ.เมืองนนทบุรี จ.นนทบุรี 11000 เลขประจำตัวผู้เสัยภาษีอากร : 0-1055-650-9868-7 เบอร์ติดต่อ : +66-2026-6927</p>
<h3>📎 เอกสารและลิงก์ประกอบ</h3>
<ul><li>🔗 แบบฟอร์มรายบุคคล</li><li>🔗 ระบบติดตาม Lark</li></ul>

<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://ssglsj0spi27.sg.larksuite.com/base/LFiobaSkxaTjDOsPafYlKBdFgQd?from=from_copylink" target="_blank" rel="noopener">ลงบันทึกในระบบ Lark &gt;</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgcckxw4dqOU5oyQ1FaLCYme" target="_blank" rel="noopener">ลิงก์ฟอร์ม</a></li><li><a href="mailto:osl@tint.or.th" target="_blank" rel="noopener">osl@tint.or.th</a></li></ul>', array['osl','radiation','airport','compliance'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: ntw-5day-booking =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('ntw-5day-booking', 'ขั้นตอนการจองบริการขนส่งข้ามจังหวัด Nationwide Within 5 Days (NTW)', 'มาตรฐานการปฏิบัติงาน ขั้นตอนการจองบริการ Nationwide Within 5 Days (NTW) — คู่มือทีละขั้นพร้อมภาพหน้าจอการจอง การกรอกข้อมูล และการยืนยันออเดอร์',
  (select id from sop.categories where slug = 'delivery'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0025/2026<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 07 กรกฏาคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ / Purpose</h3>
<p>เพื่อกำหนดมาตรฐานและขั้นตอนการปฏิบัติงานให้พนักงานหน้าสาขาสามารถดำเนินการจองงานบริการ NTW Within 5 Days (Nationwide Within 5 Days) ได้อย่างถูกต้อง ครบถ้วน และเป็นไปในแนวทางเดียวกันทุกสาขา โดยมีเป้าหมายหลักดังนี้</p>
<ul><li>ให้พนักงาน Book MS Order ได้ถูกต้อง เพื่อให้ Planner จัดรถเข้ารับกระเป๋าไปส่งต่อได้ทันรอบ</li><li>ลดข้อผิดพลาดในการกรอกข้อมูลลูกค้า ที่อยู่ปลายทาง และการบันทึกข้อมูลใน Google Sheet</li><li>ให้การส่งต่องานระหว่างสาขาต้นทาง สาขา MIXT และทีมปฏิบัติการ (MS/Planner) เป็นระบบและตรวจสอบย้อน</li></ul>
<p>กลับได้</p>
<ul><li>ควบคุมระยะเวลาการดำเนินการให้อยู่ในกรอบที่แจ้งลูกค้า (โดยประมาณ 5–7 วัน)</li></ul>
<h3>ขอบเขตการใช้งาน / Scope</h3>
<p>SOP ฉบับนี้ครอบคลุมการปฏิบัติงานตั้งแต่รับงานจากลูกค้าที่หน้าสาขา จนถึงการส่งมอบกระเป๋าเข้าสู่กระบวนการ ขนส่ง ประกอบด้วย 3 กระบวนการหลัก</p>
<ul><li>การจองส่ง NTW 5 Days ต้นทาง: พื้นที่กรุงเทพมหานคร (ส่งเข้าคลัง MAKESEND)</li><li>การจองส่ง NTW 5 Days ต้นทางต่างจังหวัด: สนามบินเชียงใหม่ (CNX), สนามบินภูเก็ต (HKT – Domestic &amp;</li></ul>
<p>International), Terminal 21 (Pattaya)</p>
<ul><li>การดำเนินการจองส่ง Goship (Flash Express Bulky) ของสาขา MIXT รวมถึงการเรียกรถเข้ารับ</li></ul>
<p>ระบบและเครื่องมือที่เกี่ยวข้อง: Airportels POS, ระบบ Postels, Google Sheet “Luggage Delivery Record 2025” (ชีท Intown และ ชีท NTW next day), ระบบ Goship / Flash Express Bulky และกลุ่มไลน์ “OP MS x Ai” ข้อยกเว้น: SOP นี้ไม่ครอบคลุมขั้นตอนภายในของทีม MS/Planner การคิดราคาเชิงลึก หรือการจัดการข้อร้อง เรียนหลังการส่งมอบ ซึ่งอยู่ภายใต้ขั้นตอนเฉพาะของแต่ละทีม</p>
<h3>บทบาทและความรับผิดชอบ / Roles &amp; Responsibilities</h3>
<p>ผู้เกี่ยวข้องและหน้าที่รับผิดชอบในกระบวนการ NTW Within 5 Days มีดังนี้</p>
<h3>บทบาท / Role ความรับผิดชอบหลัก / Key Responsibilities</h3>
<p>พนักงานหน้าสาขา ต้นทาง กทม. สร้างออร์เดอร์ LUG, จองเลข MS Order, ลงข้อมูล 2 ชีท (Intown + NTW next day), ติด Tag และถ่ายรูปกระเป๋าส่งกลุ่มไลน์ เพื่อส่งของเข้าคลัง MAKESEND พนักงานหน้าสาขา ต่างจังหวัด (CNX / HKT / T21) สร้างออร์เดอร์ LUG, ปักหมุดปลายทางและจองเลข MS Order, ลงข้อมูล 2 ชีท, ห่อ/ แพ็กกระเป๋า, ดาวน์โหลดและปริ้นซ์ Label แปะกระเป๋า, ส่งมอบให้ขนส่ง Third Party พนักงานสาขา MIXT ตรวจสอบชีท NTW next day รายวัน, จองส่ง Goship (Flash Express Bulky), สร้างและตั้งชื่อไฟล์ Label (PDF), เรียกรถเข้ารับ, นำ Tracking No. ลงชีท Planner / พนักงาน MS รับคำสั่งจองรถเข้ารับกระเป๋าจากสาขาไปคลัง MAKESEND, อ่านหมายเหตุ (Note ภาษาอังกฤษ) ในออร์เดอร์, ประสานการแพ็กและส่งต่อ หัวหน้าสาขา / ผู้ควบคุมงาน กำกับให้ปฏิบัติตาม SOP, ตรวจสอบความครบถ้วนของข้อมูลในชีท, จัดการกรณี ปัญหาและการยกเลิก/แก้ไขที่อยู่</p>
<h3>ขั้นตอนการทำงาน (พร้อมภาพประกอบ) / Work Procedure</h3>
<p><strong>1. ต้นทาง: พื้นที่กรุงเทพมหานคร (ส่งเข้าคลัง MAKESEND จัดส่งโดย J&amp;T)</strong></p>
<p>วัตถุประสงค์ย่อย: Book MS Order เพื่อให้ Planner จองรถมารับกระเป๋าไปแพ็กที่คลัง MAKESEND</p>
<h4>ขั้นที่ 1 — สร้างออร์เดอร์ LUG ใน Airportels POS</h4>
<ul><li>ขอ Passport หรือบัตรประชาชนของลูกค้า เพื่อสร้างรายการในระบบ</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 1: หน้า Access Customer: สแกน Passport / เลือก ID Card ของลูกค้า</p>
<ul><li>กรอกข้อมูลลูกค้าให้ครบ: คำนำหน้าชื่อ, ชื่อ–นามสกุล, ตรวจสอบเลขบัตร/Passport ID, สัญชาติ (ตัวย่อตาม</li></ul>
<p>Passport) แล้วกด Continue</p>
<figure><img src="/sop/ntw-5day-booking/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 2: กรอกข้อมูลลูกค้า: คำนำหน้า ชื่อ-นามสกุล Passport ID และสัญชาติ แล้วกด Continue</p>
<ul><li>เลือกสร้าง New Order แล้วเลือก Luggage Delivery Order</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 3: เลือก New Order (มุมขวาล่าง)</p>
<figure><img src="/sop/ntw-5day-booking/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 4: เลือก Luggage Delivery Order</p>
<ul><li>ให้ลูกค้าสแกน QR Code กรอก Email/เบอร์โทร; Retrieve Location = Hotel หรือ Home/Airbnb (ยังไม่</li></ul>
<p>ต้องระบุรายละเอียดสถานที่); Retrieve Date = +7 วันจากวันสร้างออร์เดอร์ และแจ้งลูกค้าว่าใช้เวลา 5–7 วัน</p>
<figure><img src="/sop/ntw-5day-booking/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 5: ให้ลูกค้าสแกน QR Code / เลือก Retrieve Location (Hotel หรือ Home) และตั้ง Retrieve Date +7 วัน</p>
<ul><li>ชั่งน้ำหนักและแจ้งราคา จากนั้นกด Service: กรอกราคาตามน้ำหนัก, ใส่จำนวนกระเป๋า, ช่อง Tag ใส่</li></ul>
<p>“NTW5” และ note (ภาษาอังกฤษเท่านั้น) แล้วกด Continue</p>
<figure><img src="/sop/ntw-5day-booking/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 6: กด Service: กรอกราคา จำนวนกระเป๋า ใส่ Tag = NTW5 และ Note (ภาษาอังกฤษ)</p>
<ul><li>ตรวจสอบข้อมูลในหน้า Confirm แล้วยืนยัน จากนั้นคิดเงินตามปกติ เมื่อปริ้นสลิปจะได้หมายเลข LUG</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 7: หน้า Confirm ตรวจสอบข้อมูลก่อนยืนยัน</p>
<p>ห้ามลืม! สอบถามและจดบันทึกสถานที่ปลายทาง (ชื่อโรงแรม/จังหวัด) และขอเบอร์โทรที่ติดต่อได้จริงจากลูกค้า เสมอ เพื่อใช้กรอกลงชีท NTW ในภายหลัง</p>
<h4>ขั้นที่ 2 — จองเลข MS Order ในระบบ Postels</h4>
<ul><li>นำหมายเลข LUG ไปค้นหาในระบบหลังบ้าน (Postels)</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 8: ระบบ Postels: ค้นหาด้วยหมายเลข LUG</p>
<ul><li>เลือกเมนู Create Logistic Order</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig9.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 9: เลือกเมนู Create Logistic Order</p>
<ul><li>เลือก Service type = Nationwide Nextday, เลือกวัน/รอบส่งเข้าคลัง, Branch = Makesend hub (SCG</li></ul>
<p>Express) บางซ่อน และกดปิด Drop at Destination (คำจะเปลี่ยนเป็น Drop at Storage)</p>
<figure><img src="/sop/ntw-5day-booking/fig10.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 10: เลือก Nationwide Nextday, Branch = Makesend hub (SCG Express) บางซ่อน, ปิด Drop at</p>
<p>Destination</p>
<ul><li>เมื่อขึ้น Drop at Storage แล้วกด +Create</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig11.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 11: เมื่อขึ้น Drop at Storage แล้วกด +Create</p>
<ul><li>ระบบจะแสดงหมายเลข MS Order ในช่อง Customer’s Note ให้ใช้หมายเลขนี้ดำเนินการต่อ</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig12.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 12: หมายเลข MS Order จะปรากฏในช่อง Customer''s Note</p>
<h4>ขั้นที่ 3 — บันทึก Google Sheet และส่งเข้ากลุ่มไลน์</h4>
<ul><li>บันทึกข้อมูลลง Google Sheet “Luggage Delivery Record 2025” ทั้ง 2 ชีท (Intown และ NTW next</li></ul>
<p>day)</p>
<ul><li>ชีท NTW next day: ชื่อลูกค้า, ราคา, น้ำหนัก, หมายเลข MS, เบอร์โทร, สถานที่รับ — เว้นว่างเฉพาะช่อง</li></ul>
<p>Tracking</p>
<figure><img src="/sop/ntw-5day-booking/fig13.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 13: บันทึกลงชีท NTW next day (เว้นว่างเฉพาะช่อง Tracking)</p>
<ul><li>ชีท Intown: Service Type = NTW5D, หมายเลข LUG, ชื่อลูกค้า, รอบส่ง, ปลายทาง = MAKESEND</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig14.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 14: บันทึกลงชีท Intown: Service Type = NTW5D, ปลายทาง = MAKESEND</p>
<ul><li>ติด Tag กระเป๋า ถ่ายรูปส่งกลุ่มไลน์ “OP MS x Ai” แล้ว Reply รูปตัวเอง ระบุ: MS Order / จำนวน / ชื่อ</li></ul>
<p>ลูกค้า / ลักษณะกระเป๋า / จังหวัดปลายทาง</p>
<figure><img src="/sop/ntw-5day-booking/fig15.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 15: ถ่ายรูปกระเป๋า (ติด Tag) ส่งกลุ่มไลน์ “OP MS x Ai” แล้ว Reply ระบุรายละเอียด</p>
<p>หมายเหตุ (กทม.): ของ NTW 5 Days จะถูกส่งเข้าคลัง MAKESEND ก่อนเสมอ เพื่อรอสาขา MIXT จองส่งต่อกับ Third Party — จบกระบวนการของพนักงานหน้าสาขา กทม. โดยสาขา MIXT ดำเนินการต่อในหัวข้อ 4.3</p>
<p><strong>2. ต้นทางต่างจังหวัด (CNX / HKT / T21 Pattaya) ให้บริการโดย Goship (Flash Express Bulky)</strong></p>
<p>วัตถุประสงค์ย่อย: Book MS Order เพื่อให้ Planner จองรถมารับกระเป๋าที่แพ็กไว้ไปส่งให้ลูกค้า</p>
<h4>ขั้นที่ 1 — สร้างออร์เดอร์ LUG ใน Airportels POS</h4>
<ul><li>ดำเนินการเช่นเดียวกับขั้นที่ 1 ของหัวข้อ 4.1 (ขอเอกสารลูกค้า, กรอกข้อมูล, เลือก Luggage Delivery</li></ul>
<p>Order, สแกน QR Code, Retrieve Location/Date, ชั่งน้ำหนัก, กด Service ใส่ Tag “NTW5” และ note ภาษาอังกฤษ, คิดเงิน) — ดูภาพที่ 1–7 ประกอบ</p>
<h4>ขั้นที่ 2 — ใส่สถานที่ปลายทางและจองเลข MS Order ในระบบ Postels</h4>
<ul><li>นำหมายเลข LUG ค้นหา แล้วในหมวด Order Action กดปุ่ม 3 จุด เลือก Edit เพื่อใส่สถานที่จัดส่ง</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig16.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 16: หมวด Order Action: กดปุ่ม 3 จุด แล้วเลือก Edit</p>
<ul><li>กรอกรายละเอียดการจัดส่ง: ต้นทาง (เช่น CNX), ปลายทาง (ชื่อโรงแรม/ที่อยู่ลูกค้า), รอบจัดส่ง และวันที่ลูกค้า</li></ul>
<p>รับ</p>
<figure><img src="/sop/ntw-5day-booking/fig17.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 17: กรอกสถานที่จัดส่ง: Location (เช่น CNX), Hotel Name และปลายทางลูกค้า</p>
<ul><li>ปักหมุดสถานที่ปลายทาง (Location / Hotel name) ให้เรียบร้อย</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig18.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 18: ปักหมุดสถานที่ปลายทาง (Location / Hotel name)</p>
<ul><li>เลือก Create Logistic Order แล้วเลือก Service type = Nationwide Nextday</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig19.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 19: Create Logistic Order: เลือก Service type = Nationwide Nextday</p>
<ul><li>ตรวจสอบ Origin Location ให้ครบ เลือกวัน/รอบส่ง แล้วกด +Create — ระบบจะแสดงหมายเลข MS Order</li></ul>
<p>ในช่อง Customer’s Note</p>
<figure><img src="/sop/ntw-5day-booking/fig20.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 20: ตรวจสอบ Origin Location เลือกวัน/รอบส่ง แล้วกด +Create</p>
<p>สำคัญ: หากพบที่อยู่ไม่ถูกต้อง ต้องแก้ไขก่อนจองเลข MS ทุกครั้ง และหากจองเลข MS ไปแล้วต้องการแก้ที่อยู่ ให้ แจ้งยกเลิกกับ Planner ก่อน แล้วจึงจองใหม่</p>
<h4>ขั้นที่ 3 — บันทึกชีท แพ็กกระเป๋า และส่งมอบขนส่ง</h4>
<ul><li>บันทึกลง Google Sheet ทั้ง 2 ชีท (NTW next day เว้นว่างเฉพาะ Tracking; Intown: NTW5D, LUG, MS,</li></ul>
<p>ชื่อลูกค้า, รอบส่ง, ปลายทาง = ชื่อสถานที่/โรงแรม/ที่อยู่ปลายทาง)</p>
<ul><li>ถ่ายรูปกระเป๋าก่อนห่อเก็บไว้เสมอ จากนั้นห่อด้วยบับเบิ้ลแล้วหุ้มกระดาษลัง และติด Tag กระเป๋า</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig21.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 21: ห่อกระเป๋าด้วยบับเบิ้ล</p>
<figure><img src="/sop/ntw-5day-booking/fig22.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 22: หุ้มด้วยกระดาษลังและติด Tag กระเป๋า</p>
<p>วิธีห่อกระเป๋าด้วยกระดาษลัง (ทีละขั้นตอน)</p>
<figure><img src="/sop/ntw-5day-booking/fig23.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 23: ขั้นที่ 1: ติด Tag กระเป๋า และพันด้วยบับเบิ้ล</p>
<figure><img src="/sop/ntw-5day-booking/fig24.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 24: ขั้นที่ 2: นำแผ่นกระดาษมาพับหุ้มอีกชั้น</p>
<figure><img src="/sop/ntw-5day-booking/fig25.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 25: ขั้นที่ 3: ตัดกระดาษส่วนเกินให้พอดี</p>
<figure><img src="/sop/ntw-5day-booking/fig26.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 26: ขั้นที่ 4: หุ้มด้านบนจนเรียบร้อย</p>
<figure><img src="/sop/ntw-5day-booking/fig27.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 27: ขั้นที่ 5: ติดเทปกาวรอบกล่องให้แน่นหนา</p>
<figure><img src="/sop/ntw-5day-booking/fig28.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 28: ขั้นที่ 6: ติด Tag / Airway Bill ให้เรียบร้อยก่อนส่ง</p>
<ul><li>ถ่ายรูปกระเป๋าที่ห่อแล้วส่งกลุ่มไลน์ “OP MS x Ai” และ Reply รูปตัวเอง ระบุตามตัวอย่าง</li></ul>
<p>ตัวอย่าง: NTW Within 5 Day / MS2510230006984 / 2 ใบ / Miss Cherezaan Ryklief / **ลูกค้ารับวันที่ 02/11/2025</p>
<figure><img src="/sop/ntw-5day-booking/fig29.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 29: ตัวอย่างการส่งรูป + ข้อความในกลุ่มไลน์ (ต่างจังหวัด)</p>
<ul><li>รอสาขา MIXT จองส่งกับ Third Party (มี Reply แจ้งกลับในกลุ่ม โดยปกติไม่เกิน 1 วัน)</li><li>จากนั้นดาวน์โหลด Label (.pdf) ปริ้นซ์แปะกระเป๋า แล้วรอขนส่ง Third Party เข้ารับ</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig30.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 30: แปะ Label ที่กระเป๋าเพื่อรอขนส่ง Third Party เข้ารับ</p>
<p>หมายเหตุ: หากดำเนินการช่วงเช้าและทันรอบส่ง โดยส่วนมากขนส่ง Third Party จะเข้ารับในเย็นวันนั้น — จบ กระบวนการของพนักงานหน้าสาขาต่างจังหวัด</p>
<p><strong>3. การจองส่ง Goship (Flash Express Bulky) — สาขา MIXT</strong></p>
<h4>ขั้นที่ 1 — ตรวจสอบงานและจองส่ง Goship</h4>
<ul><li>ตรวจสอบชีท NTW next day เป็นประจำทุกวัน เพื่อนำข้อมูลไปจองส่ง Goship (Flash Express Bulky)</li><li>เข้าเว็บไซต์ Goship และ Log in ด้วยบัญชีตามสาขาต้นทาง (ดูตารางบัญชีด้านล่าง) แล้วไปที่ สร้างรายการ</li></ul>
<p>พัสดุ &gt; สร้างรายการพัสดุ บัญชีสำหรับเข้าใช้งานระบบ Goship แยกตามสาขาต้นทาง สาขาต้นทาง ลิงก์เข้าใช้งานร้านค้า User Password T21 พัทยา (TPY) https://T21makesend.gosaas.a pp T21TPY@gmail.com T21tpy!!! สนามบินภูเก็ต HKT (Dome&amp;Inter) https://HKTDomeinterr.gosaas. app HKTDomeinterr@gmail.</p>
<p>com HKTdome1!!!! สนามบินเชียงใหม่ (CNX) https://CNXmakesend.gosaas.a pp CNXairport@gmail.com CNXairport1!!! คลังสินค้า MAKESEND https://WHsmakesend.gosaas. app WHmakesend@gmail.c om WHmakesend1!!! ข้อมูลลับเฉพาะภายใน: บัญชีและรหัสผ่านข้างต้นเป็นข้อมูลสำหรับใช้งานภายในของแต่ละสาขาเท่านั้น ห้ามเปิดเผย ต่อบุคคลภายนอก และควรจำกัดการเข้าถึงเอกสารฉบับนี้เฉพาะพนักงานที่เกี่ยวข้อง ตรวจสอบสถานะพัสดุ (Flash Express Track &amp; Trace): https://www.flashexpress.co.th/fle/tracking</p>
<figure><img src="/sop/ntw-5day-booking/fig31.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 31: หน้า Goship: ไปที่ สร้างรายการพัสดุ</p>
<ul><li>กรอกข้อมูลผู้ส่ง (ต้นทาง) — หากเคยกรอกไว้แล้วเลือกจากรายชื่อเดิมได้ โดยใช้ค่ามาตรฐานดังนี้</li></ul>
<p>ชื่อผู้ส่ง ชื่อต้นทาง เช่น “สาขาเชียงใหม่-airportels สาขาเชียงใหม่” / “Makesend-Makesend Hub” เบอร์โทรศัพท์ 021072131 (เบอร์ CS ของ Makesend) เลขบัตรประชาชน 1111111111111 ที่อยู่ กรอกตามที่อยู่ต้นทางของสาขา</p>
<figure><img src="/sop/ntw-5day-booking/fig32.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 32: กรอกข้อมูลผู้ส่ง (ต้นทาง)</p>
<ul><li>กรอกที่อยู่ปลายทาง (ลูกค้า) — กรณีมากกว่า 1 ใบ ให้ใส่จำนวนต่อท้ายชื่อ</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig33.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 33: กรอกที่อยู่ปลายทาง (ลูกค้า) และขนาด/น้ำหนัก</p>
<ul><li>เลือกขนส่งเป็น Flash Express Bulky และใส่ขนาด/น้ำหนักตามจริงเท่านั้น (อ้างอิงตารางขนาดด้านล่าง)</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig34.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 34: เลือกขนส่งเป็น Flash Express Bulky และใส่ขนาด/น้ำหนักตามจริง</p>
<ul><li>เลือกประเภทสินค้าเป็น สินค้าทั่วไป และใส่ลักษณะกระเป๋า (หากหลายใบให้ระบุทีละใบ)</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig35.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 35: เลือกประเภทสินค้าเป็น สินค้าทั่วไป</p>
<p>ตารางอ้างอิงขนาดกระเป๋า: ขนาดไซส์กระเป๋า ขนาด ก x ย x ส (ซม.) 16–18 นิ้ว 24 x 41 x 43 20 นิ้ว (Carry-On) 35 x 22 x 55 24 นิ้ว 44 x 28 x 67 28 นิ้ว 50 x 33 x 77 30–32 นิ้ว 53 x 35 x 81</p>
<ul><li>กด สร้างรายการ (จองต่อได้จนครบ) จากนั้นตรวจรายการแล้วกด ยืนยันการชำระเงิน</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig36.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 36: ตรวจรายการแล้วกด ยืนยันการชำระเงิน</p>
<h4>ขั้นที่ 2 — ปริ้นใบปะหน้าและตั้งชื่อไฟล์ Label</h4>
<ul><li>ไปที่ การจัดส่ง &gt; ติ๊กถูกหน้ารายการ &gt; พิมพ์เอกสาร &gt; ใบปะหน้าพัสดุ &gt; Flash Express Bulky แล้วเลือกที่อยู่จัด</li></ul>
<p>ส่ง</p>
<figure><img src="/sop/ntw-5day-booking/fig37.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 37: ไปที่ การจัดส่ง &gt; พิมพ์เอกสาร &gt; ใบปะหน้าพัสดุ &gt; Flash Express Bulky</p>
<ul><li>ตัวอย่างใบปะหน้า (Label) ที่ได้</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig38.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 38: ตัวอย่างใบปะหน้า (Label) ที่ปริ้นออกมา</p>
<ul><li>ดาวน์โหลด Label (PDF) แล้วเปลี่ยนชื่อไฟล์ตามแพทเทิร์น (กรณีต้นทาง กทม. ปลายทางต่างจังหวัด)</li></ul>
<p>แพทเทิร์น: NTW Within 5 Days ส่งไป[ปลายทาง] [จำนวน] ใบ [วันที่ส่งออกจากสาขา] ผู้รับ [ชื่อ] [เบอร์โทร] ตัวอย่าง: NTW Within 5 Days ส่งไปภูเก็ต 1 ใบ 01/07/2026 ผู้รับ Miss Nongnapat Jantakhun 0611514624</p>
<figure><img src="/sop/ntw-5day-booking/fig39.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 39: ดาวน์โหลดแล้วคลิกขวา Rename เปลี่ยนชื่อไฟล์ Label ตามแพทเทิร์น</p>
<h4>ขั้นที่ 3 — ส่งข้อมูลเข้ากลุ่มและบันทึก Tracking</h4>
<ul><li>ส่งไฟล์ Label (PDF) ที่เปลี่ยนชื่อแล้ว พร้อมรูปกระเป๋า ลงกลุ่มไลน์ “OP MS x Ai” ตามรูปแบบตัวอย่าง แล้ว</li></ul>
<p>Copy ข้อความส่งอีกครั้งและ Reply ที่รูปภาพ ตัวอย่างข้อความ: NTW Within 5 Days ส่งไปภูเก็ต 2 ใบ 23/06/2026 MS2606230054294 / LUG260623264 / 2 ใบ / Mr KOICHI INOUE / กระเป๋าลากใบใหญ่สีดำ + กล่องพัสดุทรง ยาว Flash Express: TH67018VN0U55B / TH03018VPUAD4B</p>
<figure><img src="/sop/ntw-5day-booking/fig40.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 40: ส่งไฟล์ Label (PDF) + รูปกระเป๋าในกลุ่ม “OP MS x Ai” แล้ว Reply</p>
<ul><li>นำ Tracking No. ที่ได้จากการจอง Goship ไปบันทึกลงชีท NTW next day (ช่อง Tracking ที่เว้นว่างไว้)</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig41.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 41: นำ Tracking No. ลงชีท NTW next day (คอลัมน์ Tracking)</p>
<h4>ขั้นที่ 4 — การเรียกรถเข้ารับ</h4>
<ul><li>ก่อนเรียกรถทุกครั้ง ไปที่ การตั้งค่า แก้ไขเบอร์โทรในระบบให้เป็นเบอร์ของพนักงานที่ประจำสาขา ณ วันนั้น แล้ว</li></ul>
<p>กดบันทึก</p>
<figure><img src="/sop/ntw-5day-booking/fig42.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 42: การตั้งค่า: แก้ไขเบอร์โทรเป็นเบอร์พนักงานประจำสาขา แล้วบันทึก</p>
<ul><li>ไปที่ การจัดส่ง &gt; ติ๊กเลือกรายการทั้งหมดที่ต้องการ &gt; เรียกรถเข้ารับ &gt; Flash Express Bulky</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig43.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 43: การจัดส่ง: ติ๊กเลือกรายการ &gt; เรียกรถเข้ารับ &gt; Flash Express Bulky</p>
<ul><li>กดยืนยัน</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig44.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 44: กดยืนยันการเรียกรถ</p>
<ul><li>ตรวจสอบได้ที่ “ประวัติการเรียกรถเข้ารับ” และหากต้องการยกเลิก ให้กด “x” ด้านขวาแล้วกดยืนยัน</li></ul>
<figure><img src="/sop/ntw-5day-booking/fig45.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p style="font-size:12.5px;color:var(--text-muted,#6b7280);margin:2px 0 8px">ภาพที่ 45: ตรวจสอบประวัติการเรียกรถ / กด x เพื่อยกเลิก</p>
<h3>เอกสารและระบบอ้างอิง / References</h3>
<ul><li>📦 คู่มือการจอง Goship — Flash Express Bulky</li><li>https://docs.google.com/document/d/16i5o6y5Ku8LRfuxT-</li></ul>
<p>jeDZqfBaa1cnoyMRSYLurNaGaU/edit?tab=t.0</p>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://t21makesend.gosaas.app/" target="_blank" rel="noopener">https://T21makesend.gosaas.a</a></li><li><a href="mailto:T21TPY@gmail.com" target="_blank" rel="noopener">T21TPY@gmail.com</a></li><li><a href="https://hktdomeinterr.gosaas.app/" target="_blank" rel="noopener">https://HKTDomeinterr.gosaas.</a></li><li><a href="mailto:HKTDomeinterr@gmail.com" target="_blank" rel="noopener">HKTDomeinterr@gmail.</a></li><li><a href="https://cnxmakesend.gosaas.app/" target="_blank" rel="noopener">https://CNXmakesend.gosaas.a</a></li><li><a href="mailto:CNXairport@gmail.com" target="_blank" rel="noopener">CNXairport@gmail.com</a></li><li><a href="https://whsmakesend.gosaas.app/" target="_blank" rel="noopener">https://WHsmakesend.gosaas.</a></li><li><a href="mailto:WHmakesend@gmail.com" target="_blank" rel="noopener">WHmakesend@gmail.c</a></li><li><a href="https://www.flashexpress.co.th/fle/tracking" target="_blank" rel="noopener">ตรวจสอบสถานะพัสดุ (Flash Express Track &amp; Trace)</a></li><li><a href="https://docs.google.com/document/d/16i5o6y5Ku8LRfuxT-jeDZqfBaa1cnoyMRSYLurNaGaU/edit?tab=t.0" target="_blank" rel="noopener">https://docs.google.com/document/d/16i5o6y5Ku8LRfuxT-</a></li></ul>', array['booking','nationwide','delivery','ntw'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: booking-photo-rotate =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('booking-photo-rotate', 'ขั้นตอนการ Booking อัพโหลดรูป และการแจ้ง Rotate กระเป๋าไปยังคลัง (ฝาก/ส่ง)', 'ขั้นตอนการสร้าง Booking การอัพโหลดรูปกระเป๋า และการแจ้ง Rotate สัมภาระไปยังคลัง ทั้งกรณีฝากและกรณีส่ง — คู่มือทีละขั้นพร้อมภาพหน้าจอ',
  (select id from sop.categories where slug = 'delivery'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 019/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 3 ธันวาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Purpose)</h3>
<p>เพื่อกำหนดขั้นตอนมาตรฐานในการปฏิบัติงานของพนักงาน Guest Service (GS) / Porter ในการ:</p>
<ul><li>รับฝากกระเป๋า (Deposit) และจัดทำ Booking ผ่านระบบ POS ให้ถูกต้อง</li><li>อัปโหลดรูปกระเป๋าเข้าในระบบ Postels ทุกครั้งทั้งรายการฝากและส่ง ตามเงื่อนไขแต่ละสาขา</li><li>ประสานงานและดำเนินการ Rotate กระเป๋า สำหรับกระเป๋าที่ฝากมากกว่า 3-5 วันขึ้นไป (ขึ้นอยู่กับความหนาแน่น</li></ul>
<p>ของพื้นที่จัดเก็บในสาขานั้นๆ) ตามนโยบายความปลอดภัย ของบริษัทฯ</p>
<ul><li>จัดการขั้นตอน Rotate Out / Rotate In ระหว่างสาขาและคลัง MS ให้เป็นไปอย่างถูกต้อง โปร่งใส สามารถ</li></ul>
<p>ตรวจสอบย้อนหลังได้</p>
<ul><li>ลดความผิดพลาดในการจัดเก็บ การรับ-ส่งกระเป๋า และลดความเสี่ยงด้านความปลอดภัย เช่น การสับเปลี่ยนของ</li></ul>
<p>การสูญหาย หรือข้อร้องเรียนจากลูกค้า</p>
<ul><li>สร้างมาตรฐานเดียวกันให้ทุกสาขา ทั้งสาขาสนามบิน DMK/BKK และสาขาห้าง/ต่างจังหวัด เพื่อให้ลูกค้าได้รับ</li></ul>
<p>ประสบการณ์ที่ดีและมีความปลอดภัยสูงสุด</p>
<h3>ขอบเขต (Scope)</h3>
<p>SOP นี้ครอบคลุมการปฏิบัติงานของพนักงาน Guest Service ทุกสาขา รวมถึงสาขาที่มี Porter ในขั้นตอนใดขั้น ตอนหนึ่ง โดยครอบคลุมดังนี้:</p>
<h3>ขอบเขตการทำงาน : SOP นี้ใช้สำหรับ</h3>
<ul><li>การรับฝากกระเป๋า (Deposit / Check-in)</li><li>การส่งกระเป๋า (Pick-up / Delivery)</li><li>การอัปโหลดรูปในระบบ Postels (ทุก Booking จำเป็นต้องถ่ายรูป)</li><li>การทำรายการ Origin / Rotate Out / Rotate In</li><li>การจัดการกระเป๋าที่ฝาก มากกว่า 3 วันขึ้นไป ซึ่งต้องแจ้งและส่งเข้า คลัง MS</li><li>การเตรียมกระเป๋าสำหรับ MS รับออก และการรับกระเป๋ากลับจาก MS</li><li>การตรวจสอบข้อมูล การอัปเดตรูป และการยืนยันสถานะในระบบ Postels</li></ul>
<h3>ขอบเขตตามสาขา</h3>
<p>สาขาสนามบิน DMK / BKK</p>
<ul><li>ลูกค้าที่ฝากเกิน 3-5 วัน (ขึ้นอยู่กับแนวทางแต่ละสาขา) → ต้องแจ้งลูกค้าว่าจะมีการ Rotate</li><li>รูปถ่ายต้อง Upload ที่ Origin /Rotate Out และ Rotate In ตามขั้นตอน</li><li>ต้องประสาน MS ทุกรายการที่เกิน 3 วัน</li></ul>
<p>สาขาห้าง / ต่างจังหวัด (Non-airport branches)</p>
<ul><li>อัปโหลดรูปเฉพาะที่ Origin ทุกกรณี</li></ul>
<h3>ขอบเขตข้อมูลที่เกี่ยวข้อง : ครอบคลุมการใช้ข้อมูลต่อไปนี้</h3>
<ul><li>ข้อมูล Booking ลูกค้าในระบบ POS</li><li>ข้อมูล Order ในระบบ Postels</li><li>รูปถ่ายกระเป๋าที่เห็น Tag ชัดเจน และมุมอื่นๆ</li><li>การแจ้งเตือนผ่าน Lark สำหรับ Order ที่มีการเปลี่ยนแปลง</li><li>ไฟล์ AI Luggage Rotation Center ที่ใช้ติดตาม status ของกระเป๋าที่ Rotate</li></ul>
<p>ผู้มีส่วนเกี่ยวข้อง</p>
<ul><li>พนักงาน Guest Service ทุกสาขา</li><li>Porter (ในสาขาที่มีบริการ)</li><li>ทีมขนส่ง MS (Makesend)</li><li>Customer Service : กรณีลูกค้าแจ้งเปลี่ยนแปลงผ่าน CS</li></ul>
<h3>ขั้นตอนการรับฝากกระเป๋า (Deposit)</h3>
<h3>ขั้นตอนก่อนลงระบบ</h3>
<p><strong>1. ลูกค้าแจ้งฝากกระเป๋า ให้สอบถามระยะเวลาการฝากทุกครั้ง</strong></p>
<p><strong>2. หากลูกค้าต้องการฝากเกิน 3 วันขึ้นไป ต้องแจ้งเงื่อนไขดังนี้</strong></p>
<ul><li>สำหรับสาขา DMK ให้แจ้งทุกครั้งว่าจะมีการ Rotate กระเป๋า ไปเก็บในคลังที่ปลอดภัย กรณีต้องการฝาก 3 วัน</li></ul>
<p>ขึ้นไป</p>
<ul><li>หากต้องการรับกระเป๋าก่อนวัน และ เวลาที่ฝาก ให้แจ้งผ่าน Customer Service ล่วงหน้าทุกครั้งอย่างน้อย</li></ul>
<p>3 ชม. ก่อนเวลาที่ต้องการเข้ามารับ</p>
<ul><li>หากลูกค้ามารับก่อนกำหนดให้ดำเนินการดังนี้</li><li>กรณีแจ้งล่วงหน้าประสานงาน MS เพื่อนำส่งกระเป๋า แจ้งอย่างน้อย 3 ชม. หากต่ำกว่า 3 ชม. ให้สอบถาม</li></ul>
<p>ก่อน และแจ้งระยะเวลารอคอยกระเป๋า กับลูกค้า โดยมีเงื่อนไขดังนี้</p>
<p><strong>1. ถ้าลูกค้ารอได้ แจ้งเคสเร่งด่วนกับ MS ในกลุ่มไลน์ เพื่อประสานงานและดำเนินการจัดส่งโดยเร็วที่สุด</strong></p>
<p><strong>2. หากลูกค้าต้องเดินทางต่อ สามารถแจ้งนำส่งปลายทางแทนได้ (กรณีจำเป็น และภายในประเทศและ</strong></p>
<p>พื้นที่กำหนดเท่านั้น)</p>
<ul><li>กรณีมีรับก่อนวันฝากระยะยาว ที่เก็บเงินแล้ว เช่น แจ้งฝากมากกว่า 26 วัน หรือ ชำระเงินผ่านระบบ</li></ul>
<p>online : จะไม่มีการ Refund เงินคืนทุกกรณี ถือว่าลูกค้าตกลงฝาก และยอมรับเงินไข</p>
<ul><li>กรณีลูกค้าฝากกระเป๋าหลายใบ และจะรับบางส่วน หากชำระเงินแล้วจะไม่มีการคืนเงินทุกกรณี</li><li>กรณียังไม่ชำระเงิน ให้ทำจ่าย order เดิมก่อน และทำฝากใหม่ ทำ Booking order ใหม่ เพื่อป้องกัน</li></ul>
<p>ลูกค้าแอบเอาของออกบางส่วน หรือนำของต้องสงสัยใส่ในกระเป๋าสัมภาระ และอ้างว่าพนักงานเป็นคนทำ</p>
<ul><li>สำหรับสาขา DMK / HKT / CNX : ให้ทำการตรวจสัมภาระผ่านเครื่อง X-Ray ทุกครั้ง</li></ul>
<p><strong>3. เมื่อแจ้งเงื่อนไข การให้บริการแล้ว พนักงานขอ Passport หรือ บัตรประชาชน (ID Card)</strong></p>
<p><strong>4. ดำเนินการ Booking ผ่านระบบ POS</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>5. กรอกข้อมูลลูกค้าให้ครบถ้วน → กด Continue</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>6. และกด New Order</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>7. กด Deposit Order</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>8. กรอกข้อมูลการฝากกระเป๋าให้ครบถ้วน</strong></p>
<ul><li>ใส่จำนวนกระเป๋าที่ลูกค้าต้องการฝาก</li><li>ใส่ Tag เป็นวันที่ลูกค้าต้องการรับกระเป๋า</li><li>ใส่วันที่ในปฎิทินที่ลูกค้าต้องการรับกระเป๋า</li><li>นำโทรศัพท์มา Scan QR เพื่อขอข้อมูลลูกค้าเพิ่มเติม</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>9. ขอข้อมูลลูกค้าเพิ่มเติม</strong></p>
<ul><li>เลือกกด Edit Email and Phone No.</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เมื่อลูกค้ากรอก Email และ เบอร์โทร แล้วกด OK</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เมื่อขึ้นหน้า Thankyou แล้วจึงดำเนินการใน POS ต่อ</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>10. กด Continue</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig9.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>11. พนักงานตรวจสอบข้อมูลแล้วจึงกด Continue หากต้องการแก้ไขให้กด Back</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig10.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>12. เมื่อตรวจสอบข้อมูลครบถ้วนแล้วให้กด Confirm</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig11.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>13. ใส่รหัส PIN</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig12.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>14. ดำเนินการ Booking เสร็จสิ้นสามารถกด Done ได้เลย</strong></p>
<figure><img src="/sop/booking-photo-rotate/fig13.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>15. กรณีลูกค้าฝากตั้งแต่ 26 วัน ให้แจ้งลูกค้าชำระเงินทันที พร้อมย้ำเงื่อนไขอีกครั้งกรณีมีการเปลี่ยนแปลง ให้แจ้ง</strong></p>
<p>ล่วงหน้าอย่างน้อย 3 ชม. ผ่าน Customer Service และ หากชำระเงินแล้วจะไม่มีการคืนเงินทุกกรณี (หากยังไม่ แน่ใจให้แนะนำลูกค้าเลือกฝากแบบรายวัน ที่ไม่ใช่ราคาพิเศษ และ กรณีฝากเกินกำหนดที่แจ้งครั้งแรก ให้ชำระ ส่วนต่างจำนวนวันที่เกินมาแทน)</p>
<p><strong>16. แจ้งย้ำลูกค้าอีกครั้งก่อนออกจากเคาน์เตอร์ เรื่องการ Rotate กระเป๋า ไปเก็บไว้ในพื้นที่จัดเก็บที่ปลอดถัย (All</strong></p>
<p>Safe &amp; Secure) เนื่องจากพื้นที่ตรงนี้มีจำกัด การอัพเดตข้อมูล และอัพโหลดรูปภาพในระบบ POSTELS (ขั้นตอน สำคัญ)</p>
<p><strong>1. เข้าระบบ Postels Welcome Back! Create an Account!</strong></p>
<ul><li>Login</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig14.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>ค้นหา Order ด้วย Order Number</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig15.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>2. การอัปโหลดรูป (จำเป็นต้องดำเนินการทุก Booking)</strong></p>
<ul><li>ถ่ายภาพกระเป๋าทุกครั้ง (ทั้งฝาก / ส่ง)</li><li>เลือกประเภท Upload ตามสาขา:</li></ul>
<p>รายละเอียดการอัปโหลดรูปตามสาขา สาขา DMK และ BKK (สนามบิน)</p>
<ul><li>Upload ที่ Origin / Rotate Out (ตอนรับฝาก)</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig16.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>สาขาห้าง / ต่างจังหวัด</p>
<ul><li>Upload เฉพาะที่ Origin ทุกกรณี (ฝาก / ส่ง / ไม่ Rotate)</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig17.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เมื่อเลือกประเภทแล้ว ให้พนักงานกดถ่ายภาพกระเป๋า (กรณีใช้ผ่านมือถือ / mobile phone) หรือลากรูปจากใน</li></ul>
<p>อัลบั๊มเครื่อง (กรณีใช้ผ่าน Desktop)</p>
<ul><li>การถ่ายภาพให้ถ่ายมากกว่า 1 รูป และต้องมีรูปที่เห็น Tag กระเป๋าชัดเจน</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig18.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>24. สามารถตรวจสอบรูปว่าอัพโหลดเรียบร้อยแล้วหรือไม่ผ่านทาง Order Image โดยกดที่ Origin หรือ Rotate</strong></p>
<p>Out</p>
<figure><img src="/sop/booking-photo-rotate/fig19.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/booking-photo-rotate/fig20.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>กรณีฝากมากกว่า 3 - 5 วันขึ้นไปให้กด Tab : Rotation Out ด้านบน ตามลูกศร (สำหรับการแจ้ง MS เพื่อส่ง</li></ul>
<p>กระเป๋าไปคลัง)</p>
<figure><img src="/sop/booking-photo-rotate/fig21.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เมื่อดำเนินการเรียบร้อย จะขึ้นข้อความ Rotation Request Success</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig22.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>จัดเตรียมกระเป๋าที่แจ้ง Rotate Out แต่ละวันแยกไว้ตามเวลาที่กำหนด เพื่อรอขนส่ง (MS) มารับไปจัดเก็บที่</li></ul>
<p>คลัง การรับกระเป๋าที่กลับมาจาก MS (Rotate In)</p>
<ul><li>เมื่อรับกระเป๋ากลับมา ให้ตรวจเช็ค และถ่ายรูป ให้เห็น Tag กระเป๋า และถ่าย 1-2 มุม กรณีมีความเสียหายจะได้</li></ul>
<p>สามารถตรวจสอบได้</p>
<ul><li>สำหรับสาขาที่มี Porter สามารถให้ Porter ที่รับกระเป๋าถ่ายรูป และส่งให้ Guest Service ดำเนินการต่อ หรือ</li></ul>
<p>Porter สามารถ Serch order ผ่านมือถือ และอัพโหลดรูปได้เอง</p>
<ul><li>Login เข้า Postels และ Search Order Number ที่ต้องการ</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig23.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>อัพโหลดรูป ที่ Drop down : Rotate In</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig24.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>กดถ่ายภาพกระเป๋า (กรณีใช้ผ่านมือถือ / mobile phone) หรือลากรูปจากในอัลบั๊มเครื่อง (กรณีใช้ผ่าน</li></ul>
<p>Desktop)</p>
<figure><img src="/sop/booking-photo-rotate/fig25.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>ตรวจสอบว่า Upload รูปเรียบร้อยแล้วที่ Rotate In</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig26.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>จากนั้นกดที่ Tab : Rotate In ด้านบนตามลูกศร เพื่อยืนยันการรับกระเป๋ากลับเข้าสาขา จาก MS</li></ul>
<figure><img src="/sop/booking-photo-rotate/fig27.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/booking-photo-rotate/fig28.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เมื่อดำเนินการเรียบร้อย จะขึ้นข้อความ Rotation Request Success</li></ul>
<p>การอัพโหลดรูปภาพผ่านมือถือด้วย Postels</p>
<figure><img src="/sop/booking-photo-rotate/fig29.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เปิดผ่านมือถือ https://postels.airportels.asia/admin/login</p>
<figure><img src="/sop/booking-photo-rotate/fig30.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>Login เข้า Postels ด้วยรหัสสาขา</p>
<figure><img src="/sop/booking-photo-rotate/fig31.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เลือก Dropdown และเลือกประเภทที่ต้องการ เช่น Origin &amp; Rotate Out สำหรับอัพรูปเพื่อส่งไปคลัง หรือ Rotate In เมื่อรับกระเป๋ากลับเข้ามา</p>
<figure><img src="/sop/booking-photo-rotate/fig32.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เลือก Origin &amp; Rotate Out เพื่อถ่ายรูป สำหรับการ Rotate Out - ส่งกระเป๋าไปคลัง</p>
<figure><img src="/sop/booking-photo-rotate/fig33.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เลือก Origiin Rotate Out เพื่อถ่ายรูป สำหรับการ Rotate In - ส่งกระเป๋ากลับเข้าสาขา</p>
<figure><img src="/sop/booking-photo-rotate/fig34.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เลือก Tab Rotation Out สำหรับแจ้งส่งกระเป๋าเข้า</li></ul>
<p>คลัง</p>
<ul><li>เลือก Tab Rotae In สำหรับแจ้งคลังให้นำกระเป๋า</li></ul>
<p>ส่งคืนสาขา</p>
<figure><img src="/sop/booking-photo-rotate/fig35.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เมื่อดำเนินการเรียบร้อย ระบบขึ้น Rotation Request Successfully หมายเหตุ : กรณีมีการเปลี่ยนแปลง order หรือวันรับกระเป๋า จะมีการแจ้งเตือนไปยัง Lark ของสาขาที่เกี่ยวข้อง ตัวอย่างการแจ้งเตือนกรณีมีการเปลี่ยนแปลง Order</p>
<figure><img src="/sop/booking-photo-rotate/fig36.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>สามารถเช็ค รายการ และ สถานะกระเป๋าที่ Rotate ผ่าน ไฟลล์ Lark : AI Luggage Rotation Center (NEW)</p>
<figure><img src="/sop/booking-photo-rotate/fig37.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://postels.airportels.asia/admin/order/browse/intx2403236" target="_blank" rel="noopener">1. เข้าระบบ Postels Welcome Back! Create an Account!</a></li><li><a href="https://postels.airportels.asia/admin/login" target="_blank" rel="noopener">เว็บไซต์ AIRPORTELs</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/base/QFH0brg1vaOY3us9Czqlf04JgQe?from=from_copylink" target="_blank" rel="noopener">สามารถเช็ค รายการ และ สถานะกระเป๋าที่ Rotate ผ่าน ไฟลล์ Lark</a></li></ul>', array['booking','rotate','warehouse','photo','delivery'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: same-day-delivery =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('same-day-delivery', 'บริการขนส่งสัมภาระภายในวันเดียวกัน (Same Day Delivery)', 'SOP-OPS 018/2025 — มาตรฐานการให้บริการ Same Day Delivery (กรุงเทพฯ เชียงใหม่ ภูเก็ต) เงื่อนไขการให้บริการ รายการสิ่งของต้องห้าม เงื่อนไขความรับผิดชอบ และสคริปต์สื่อสารกับลูกค้า',
  (select id from sop.categories where slug = 'delivery'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 018/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 พฤศจิกายน 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>เพื่อกำหนดแนวทางและขั้นตอนการให้บริการขนส่งสัมภาระภายในวันเดียวกัน (Same Day Delivery) ให้เป็นไปตามมาตรฐานของบริษัท AIRPORTELS INTERNATIONAL จำกัด โดยมุ่งเน้นความถูกต้อง ปลอดภัย และความพึงพอใจของลูกค้า To define the operational standard for Same Day Delivery Service under AIRPORTELS INTERNATIONAL ensuring accuracy, safety, and customer satisfaction.</p>
<h3>📌 ขอบเขตการใช้งาน / Scope</h3>
<p>ใช้สำหรับพนักงานหน้าสาขา (Branch Staff) ที่ให้บริการลูกค้าในพื้นที่ กรุงเทพฯ, เชียงใหม่ และภูเก็ต เฉพาะกรณีบริการจัดส่งสัมภาระภายในวันเดียวกัน (Same Day Delivery) Applicable to all front-line branch staff handling Same Day Delivery services in Bangkok, Chiang Mai, and Phuket branches only.</p>
<h3>เงื่อนไขการให้บริการ (Service Conditions)</h3>
<ul><li>บริการเฉพาะพื้นที่ให้บริการที่กำหนด</li><li>กระเป๋าจะถูกจัดส่งตามรอบเวลา (Delivery Schedule) ของแต่ละสาขา</li><li>ลูกค้าต้องยินยอมให้ตรวจสอบสัมภาระกรณีพบสิ่งต้องห้าม</li><li>บริษัทมีสิทธิ์ปฏิเสธการจัดส่งในกรณีที่สัมภาระไม่เป็นไปตามเงื่อนไข</li><li>Available only in designated service areas</li><li>Delivery will follow the daily schedule</li><li>Customer must consent to bag inspection for prohibited items</li><li>Company reserves the right to refuse service for non-compliant items</li></ul>
<p>🔒 รายการสิ่งของต้องห้าม (Prohibited Items) ห้ามจัดส่งสิ่งของดังต่อไปนี้ : Prohibit Items 💡หมายเหตุ: ของเหลว (Liquid) สามารถรับได้เฉพาะกรณี</p>
<ul><li>ไม่เป็นสเปรย์</li><li>บรรจุภัณฑ์ไม่เกิน 100 ml.</li><li>มีฉลากระบุชัดเจนและอยู่ในบรรจุภัณฑ์เดิม ภายใต้เงื่อนไข ไม่เกิน 100 ml.</li></ul>
<p>📘 สิ่งของที่แตกหักง่าย และเปราะบาง : หากลูกค้ายืนยันต้องการนำส่งให้แจ้งเงื่อนไขให้ชัดเจนทุกครั้ง</p>
<ul><li>AIRPORTELs are not responsible for fragile, valuable, liquid, electronic, or prohibited items.</li><li>AIRPORTELs จะไม่รับผิดชอบต่อสิ่งของที่เปราะบาง มีค่า เป็นของเหลว เป็นอุปกรณ์อิเล็กทรอนิกส์ หรือสิ่งของ</li></ul>
<p>ต้องห้าม</p>
<h3>ขั้นตอนการปฏิบัติงาน (Operational Procedure)</h3>
<p>หมายเหตุเพิ่มเติม (Additional Notes)</p>
<ul><li>หากลูกค้าถามว่า “ทำไมของบางอย่างโหลดขึ้นเครื่องได้ แต่ส่งกับเราไม่ได้”</li></ul>
<p>พนักงานสามารถอธิบายได้ว่า = “เพราะลูกค้าตรวจของเองตอนเช็กอินและนำขึ้นเครื่องด้วยตนเอง แต่บริการขนส่งเป็นการฝากให้บริษัทดำเนินการแทน ซึ่งมีกฎควบคุมตามมาตรฐานคาร์โก้ SAME DAY DELIVERY – SCRIPT SHEET (TH–EN)</p>
<h3>⚖️ เงื่อนไขความรับผิดชอบ (Responsibility Condition)</h3>
<p>🎯 Tips สำหรับพนักงาน</p>
<ul><li>ใช้คำพูดที่สุภาพ และทวนคำลูกค้าก่อนดำเนินการ</li><li>พูดช้า ชัด ยิ้มในน้ำเสียง (Smile through your voice)</li><li>หากไม่แน่ใจ ให้ขออนุญาตเช็กข้อมูลก่อนตอบเสมอ เช่น</li><li>“ขออนุญาตเช็กข้อมูลให้ก่อนนะคะ รอสักครู่ค่ะ”</li></ul>
<p>“Let me double-check that information for you, just a moment please.”</p>
<ul><li>พนักงานควรแจ้งเงื่อนไขนี้ทุกครั้งก่อนรับฝาก ให้ลูกค้าทราบอย่างชัดเจนว่าบริษัทไม่รับผิดชอบในกรณีที่สิ่งของ</li></ul>
<p>อยู่ในประเภทดังกล่าว</p>
<ul><li>“เพราะกระเป๋าผ่านการขนส่งหลายจุดค่ะ อาจเกิดแรงกระแทกระหว่างทางได้”</li></ul>
<p>“The luggage may go through multiple handling points, which could cause impact or vibration.”</p>
<ul><li>หากลูกค้ายืนยันจะส่ง ให้แจ้งเงื่อนไขความรับผิดชัดเจนอีกครั้ง และเขียนข้อความลงบนพัสดุ หรือ Luggage</li></ul>
<p>“Fragile – Handle with Care”</p>
<ul><li>หากลูกค้าสงสัย ให้แสดงเอกสารเงื่อนไขการให้บริการ (Service Terms) เพื่อประกอบคำอธิบาย</li></ul>
<h3>ข้อกำหนดและเงื่อนไขการใช้บริการ</h3>
<p>Luggage Delivery &amp; Storage in Thailand</p>
<h3>ภาพและสคริปต์จากเอกสารต้นฉบับ</h3><figure><img src="/sop/same-day-delivery/p2.jpg" alt="เงื่อนไขและรายการสิ่งของต้องห้าม (Prohibited Items)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>เงื่อนไขและรายการสิ่งของต้องห้าม (Prohibited Items)</figcaption></figure><figure><img src="/sop/same-day-delivery/p3.jpg" alt="ขั้นตอนการปฏิบัติงาน" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>ขั้นตอนการปฏิบัติงาน</figcaption></figure><figure><img src="/sop/same-day-delivery/p4.jpg" alt="เงื่อนไขความรับผิดชอบ / Script Sheet (TH–EN)" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>เงื่อนไขความรับผิดชอบ / Script Sheet (TH–EN)</figcaption></figure><figure><img src="/sop/same-day-delivery/p5.jpg" alt="Tips และสคริปต์สำหรับพนักงาน" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>Tips และสคริปต์สำหรับพนักงาน</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://share.google/hwblfzEndAJvbucDd" target="_blank" rel="noopener">ข้อกำหนดและเงื่อนไขการใช้บริการ</a></li><li><a href="https://www.airportels.asia/?_gl=1%2Akxwthw%2A_ga%2AOTM5ODkwNTQuMTc2MDY5NTcyMA..%2A_ga_H1D2K8LK0B%2AczE3NjE4ODQxODUkbzIkZzAkdDE3NjE4ODQxODUkajYwJGwwJGgxODcyOTk4MTQ5" target="_blank" rel="noopener">Luggage Delivery &amp; Storage in Thailand</a></li></ul>', array['delivery','same-day','prohibited-items'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: baggage-inspection-lock-report =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('baggage-inspection-lock-report', 'มาตรการจัดการกระเป๋าและสัมภาระ: การเปิดตรวจ การล็อก และการรายงานความผิดปกติ', 'SOP-OPS 0024/2026 — มาตรการปกป้องทรัพย์สินลูกค้า: ห้ามเปิด/รื้อค้นโดยไม่ได้รับอนุญาต ขั้นตอนการตรวจค้นสิ่งของต้องห้ามอย่างโปร่งใส การล็อกด้วย Cable Tie และการรายงานความผิดปกติของสัมภาระ',
  (select id from sop.categories where slug = 'counter-service'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0024/2026<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 26 พฤษภาคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<h3>เอกสารที่เกี่ยวข้อง :</h3>
<ul><li>SOP การจัดเก็บกระเป๋าให้ปลอดภัยในพื้นที่จัดเตรียม</li></ul>
<h3>วัตถุประสงค์ (Objective)</h3>
<ul><li>เพื่อกำหนดมาตรการปกป้องทรัพย์สินของลูกค้าและความเป็นส่วนตัว โดยห้ามพนักงานเปิดหรือรื้อค้นกระเป๋า</li></ul>
<p>สัมภาระโดยไม่ได้รับอนุญาต</p>
<ul><li>เพื่อกำหนดขั้นตอนการตรวจค้นสิ่งของต้องห้ามอย่างโปร่งใส มีหลักฐานบันทึก และคุ้มครองทั้งลูกค้าและ</li></ul>
<p>พนักงาน</p>
<ul><li>เพื่อป้องกันการสูญหายของทรัพย์สินระหว่างการฝากและขนส่งกระเป๋าสัมภาระ</li><li>เพื่อกำหนดแนวทางปฏิบัติเมื่อพบความผิดปกติของสัมภาระ ให้พนักงานทุกคนดำเนินการได้อย่างถูกต้องและ</li></ul>
<p>รวดเร็ว</p>
<h3>ขอบเขตการใช้งาน (Scope)</h3>
<h3>เอกสารฉบับนี้ใช้บังคับกับ:</h3>
<ul><li>ผู้มีหน้าที่: พนักงานทุกตำแหน่งในทุกสาขา ได้แก่</li><li>Guest Service Officer (GSO)</li><li>Branch Manager</li><li>Porter</li><li>ครอบคลุมทุกสาขาของ AIRPORTELs (สนามบิน และ ห้างสรรพสินค้า) ทั้ง 15 สาขาในประเทศไทย</li><li>บังคับใช้กับสัมภาระทุกประเภทที่อยู่ในความดูแลของสาขา ทั้งกรณีฝาก (Storage) และกรณีรับส่ง (Delivery)</li><li>ใช้ตลอดเวลาให้บริการ</li></ul>
<h3>นิยามและคำศัพท์ที่เกี่ยวข้อง</h3>
<h3>คำศัพท์ ความหมาย</h3>
<h3>สิ่งของต้องห้าม</h3>
<p>สิ่งของที่ไม่อนุญาตให้นำเข้าฝาก เช่น วัตถุระเบิด อาวุธ วัตถุไวไฟ สารเคมีอันตราย สัตว์มีชีวิต หรือ สิ่งของผิดกฎหมาย เป็นต้น ตามรายละเอียด Prohibit Items Cable Tie AIRPORTELs สายรัดพลาสติกที่สาขาจัดเตรียมไว้ เพื่อใช้ล็อกซิปกระเป๋าแทนกรณีที่ลูกค้าไม่ได้ใส่กุญแจหรือ TSA lock Porter พนักงานยกและขนสัมภาระประจำสาขา (มีเฉพาะสาขา BKK &amp; DMK) Branch Manger / Operation Co. หัวหน้าทีมประจำสาขา หรือ GSE ที่ได้รับมอบหมาย เป็นผู้รับเรื่องแจ้งความผิดปกติ Guest Service พนักงานให้บริการลูกค้า ประจำสาขา</p>
<h3>มาตรการและข้อปฏิบัติหลัก</h3>
<p><strong>1. หลักการสำคัญ</strong></p>
<p>ห้ามพนักงานเปิดกระเป๋าสัมภาระของลูกค้าโดยเด็ดขาด ยกเว้นกรณีมีความจำเป็นต้องตรวจค้นสิ่งของต้องห้าม และ ต้องปฏิบัติตามขั้นตอนที่กำหนดในเอกสารนี้เท่านั้น</p>
<p><strong>2. กรณีการตรวจค้นสิ่งของต้องห้าม</strong></p>
<p>แบ่งตามสถานการณ์ดังนี้: สถานการณ์ ผู้ดำเนินการ ขั้นตอน ลูกค้ามาด้วยตนเอง ลูกค้า ให้ลูกค้าเปิดกระเป๋าด้วยตนเองเท่านั้น โดยพนักงานตรวจสอบร่วมกับลูกค้า กระเป๋าถูกส่งมา / ลูกค้าไม่ได้มาด้วย ตนเอง</p>
<ul><li>Porter + GS (สาขาที่มี</li></ul>
<p>Porter)</p>
<ul><li>GS (สาขาที่ไม่มี Porter)</li></ul>
<p><strong>1. ตรวจต่อหน้ากล้อง CCTV</strong></p>
<p><strong>2. บันทึก VDO เป็นหลักฐานทุกครั้ง</strong></p>
<p><strong>3. พนักงาน 2 คนดำเนินการร่วมกัน (ถ้ามี)</strong></p>
<p><strong>3. ขั้นตอนรับฝากกระเป๋า — ตรวจสอบการล็อก</strong></p>
<p>พนักงานต้องปฏิบัติตามขั้นตอนต่อไปนี้ทุกครั้งที่รับฝากกระเป๋า:</p>
<p><strong>1. ตรวจสอบการล็อก: สอบถามลูกค้าว่า</strong></p>
<p>"กระเป๋าได้ล็อกเรียบร้อยแล้วหรือไม่?"</p>
<p><strong>2. กรณียังไม่ได้ล็อก: หากกระเป๋ายังไม่ได้ล็อก ให้ดำเนินการตามตัวเลือกใดตัวเลือกหนึ่ง:</strong></p>
<ul><li>แจ้งให้ลูกค้าทำการล็อกกระเป๋า สำหนับกระเป๋าลูกค้า ที่มีอุปกรณ์ล็อค หรือ ระบบ TSA Lock</li><li>ใช้ Cable Tie AIRPORTELs ล็อกซิปกระเป๋าให้ลูกค้า (แจ้งให้ลูกค้าทราบด้วยทุกครั้ง) หรือ ส่งมอบ Cable Tie</li></ul>
<p>ให้ลูกค้าทำการล๊อคด้วยตนเอง รูปแบบ Cable Tie AIRPORTELs</p>
<p><strong>4. กรณีพบความผิดปกติของสัมภาระ</strong></p>
<p>สัญญาณที่พนักงานต้องระวัง เช่น มีเสียงผิดปกติ ลักษณะภายนอกผิดปกติ หรือน้ำหนักผิดสัดส่วน</p>
<h3>ขั้นตอนเมื่อพบความผิดปกติ:</h3>
<ul><li>หยุดการดำเนินการทันที อย่าเคลื่อนย้ายหรือแตะต้องสัมภาระ</li><li>แจ้ง Team Lead ผ่านกลุ่ม Lark Group สาขาที่กำหนดโดยทันที</li><li>รอคำสั่งจาก Team Lead ก่อนดำเนินการต่อ</li><li>ในกรณีเร่งด่วน (เช่น มีกลิ่น มีควัน มีเสียงดัง)</li><li>ให้แจ้งเจ้าหน้าที่รักษาความปลอดภัยในพื้นที่ปฏิบัติงานทันที</li><li>แจ้งลูกค้าหยุดให้บริการ พร้อมแจ้งข้อมูลผ่าน Lark Group</li><li>พนักงานออกจากพื้นที่ทันที ตามมาตราการฯ ของสถานที่นั้นๆ</li></ul>
<p><strong>5. บทลงโทษกรณีฝ่าฝืน</strong></p>
<p>🛑หากตรวจพบพฤติกรรมผิดปกติในการรื้อค้นสัมภาระลูกค้าโดยไม่ได้รับอนุญาต บริษัทฯ จะดำเนินการตาม</p>
<h3>ขั้นตอนของฝ่ายทรัพยากรบุคคล (HR) ทันที</h3>
<p><strong>6. Flow การทำงาน</strong></p>
<p>6.1 Flow: รับฝากกระเป๋า (Storage Drop-off)</p>
<h3>ขั้นตอน ผู้ดำเนินการ การดำเนินการ หมายเหตุ</h3>
<p>1 GSO / Porter ทักทายลูกค้าและรับข้อมูลการจอง ตรวจสอบ Booking ID/ Order ID 2 GSO / Porter ตรวจสอบสภาพกระเป๋าภายนอกและถ่ายภาพก่อนรับ ฝาก บันทึกในระบบ 3 GSO / Porter สอบถามลูกค้า: "กระเป๋าล็อกเรียบร้อยแล้วหรือไม่?" บังคับทุกรายการ 4A GSO / Porter กรณีล็อกแล้ว: รับฝากกระเป๋าได้ทันที 4B GSO / ลูกค้า กรณียังไม่ล็อก: แนะนำให้ล็อกหรือใช้ Cable Tie AIRPORTELs ลูกค้าเลือกวิธีการ 5 GSO บันทึกข้อมูลในระบบ POS/POSTEL และออก Claim Tag 6 GSO / Porter จัดเก็บกระเป๋าในพื้นที่ที่กำหนด ห้ามวางในที่สาธารณะ 6.2 Flow: ตรวจค้นสิ่งของต้องห้าม — ลูกค้ามาด้วยตนเอง</p>
<h3>ขั้นตอน ผู้ดำเนินการ การดำเนินการ หมายเหตุ</h3>
<p>1 GS / Branch Manager แจ้งเหตุผลความจำเป็นในการตรวจค้นสิ่งของต้อง ห้ามแก่ลูกค้า สุภาพ ชัดเจน 2 ลูกค้า ลูกค้าเปิดกระเป๋าด้วยตนเอง — พนักงานไม่สัมผัส กระเป๋า หรือสิ่งของโดยไม่ได้รับอนุญาตจากลูกค้า ห้ามพนักงานเปิด เอง 3 GS / Branch Manager /Porter ตรวจสอบสิ่งของพร้อมลูกค้าอยู่ด้วย ต้องมีพยาน หรืออยู่ ในมุมกล้อง CCTV 6.3 Flow: ตรวจค้นสิ่งของต้องห้าม — กระเป๋าถูกส่ง/ลูกค้าไม่ได้มา</p>
<h3>ขั้นตอน ผู้ดำเนินการ การดำเนินการ หมายเหตุ</h3>
<p>1 GS/ Porter ติดต่อลูกค้า และแจ้งหตุผลความจำเป็นในการตรวจค้น 2 Porter + GS เคลื่อนย้ายกระเป๋าไปยังพื้นที่หน้ากล้อง CCTV สาขาที่มี Porter 3 Porter + GS เริ่มบันทึก VDO ด้วยโทรศัพท์ก่อนเปิดกระเป๋า ต้องบันทึกทุกครั้ง 4 Porter + GS เปิดกระเป๋าและตรวจสอบต่อหน้ากล้อง CCTV — พนักงาน 2 คนพร้อมกัน กรณีมีพนักงานมากกว่า 1 คน ให้เป็นพยานร่วมกัน 5 Porter + GS บันทึกสิ่งที่พบ และปิดกระเป๋าคืนสภาพเดิม 6 Team Lead เก็บรูปภาพ ก็บ VDO เป็นหลักฐาน อัปโหลดในรูปภาพใน Postel หรือ ในกลุ่ม Line / Lark ที่เกี่ยวข้อง 6.4 Flow: พบความผิดปกติของสัมภาระ</p>
<h3>ขั้นตอน ผู้ดำเนินการ การดำเนินการ หมายเหตุ</h3>
<p>1 GS / Porter สังเกตพบความผิดปกติ เช่น มีเสียง ลักษณะภายนอก ผิดปกติ น้ำหนักผิดสัดส่วน 2 GS / Porter หยุดการดำเนินการทันที อย่าแตะต้องหรือเคลื่อนย้าย สัมภาระ สำคัญมาก 3 GS / Porter แจ้ง Team Lead ผ่านกลุ่ม Lark สาขาที่กำหนดทันที ระบุรายละเอียดให้ ครบ 4 Team Lead รับเรื่องและประเมินสถานการณ์ 5A Team Lead กรณีปกติ: สั่งการตามขั้นตอน 5B Team Lead กรณีเร่งด่วน (กลิ่น/ควัน/เสียงดัง): แจ้งเจ้าหน้าที่ ความปลอดภัยและ/หรือตำรวจ ในพื้นที่ ไม่ต้องรอ</p>
<h3>ผู้รับผิดชอบ</h3>
<p>ตำแหน่ง หน้าที่รับผิดชอบ Branch Manager / GS / Porter ปฏิบัติตาม Flow ข้างต้นอย่างเคร่งครัด ห้ามเปิดกระเป๋าเองโดยไม่ได้รับอนุญาต แจ้งทีมผ่าน Lark เมื่อพบความผิดปกติ Branch Manager กำกับดูแลให้พนักงานในสาขาปฏิบัติตาม SOP นี้ รายงานต่อ Operations Manager กรณีเกิด เหตุ Team Lead (Operation Co. / Operation Manager) รับเรื่องแจ้งความผิดปกติ ประเมินสถานการณ์ อนุมัติการตรวจค้น ดูแลให้มีการบันทึก VDO และ รายงานผล Operations Manager เป็นผู้รับผิดชอบนโยบายนี้ อนุมัติการแก้ไข SOP และดำเนินการทางวินัยร่วมกับ HR กรณีฝ่าฝืน</p>
<h3>การทบทวนและปรับปรุง</h3>
<ul><li>ทบทวนเอกสารนี้ทุก 6 เดือน หรือเมื่อมีการเปลี่ยนแปลงนโยบายของบริษัท</li><li>Operations Manager เป็นผู้รับผิดชอบในการอนุมัติการแก้ไขทุกครั้ง</li><li>แจ้งพนักงานทุกคนผ่านระบบ Lark เมื่อมีการปรับปรุงเวอร์ชันใหม่</li></ul>
<p>AIRPORTELs | SOP: OP-LUG-001 | เวอร์ชัน 1.0 | Branch Operations</p>
<h3>แผนผังการทำงาน (Flow) จากเอกสารต้นฉบับ</h3><figure><img src="/sop/baggage-inspection-lock-report/p3.jpg" alt="การตรวจสอบการล็อก และรูปแบบ Cable Tie AIRPORTELs" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>การตรวจสอบการล็อก และรูปแบบ Cable Tie AIRPORTELs</figcaption></figure><figure><img src="/sop/baggage-inspection-lock-report/p5.jpg" alt="Flow: รับฝากกระเป๋า และตรวจค้นกรณีลูกค้ามาด้วยตนเอง" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>Flow: รับฝากกระเป๋า และตรวจค้นกรณีลูกค้ามาด้วยตนเอง</figcaption></figure><figure><img src="/sop/baggage-inspection-lock-report/p6.jpg" alt="Flow: ตรวจค้นกรณีกระเป๋าถูกส่ง และกรณีพบความผิดปกติ" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>Flow: ตรวจค้นกรณีกระเป๋าถูกส่ง และกรณีพบความผิดปกติ</figcaption></figure>', array['security','inspection','lock','incident','cable-tie'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: complaint-handling =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('complaint-handling', 'ขั้นตอนมาตรฐานการรับมือข้อร้องเรียน (Complaint Handling)', 'SOP-OPS 023/2026 — ขั้นตอนรับเรื่อง จัดการ และแก้ไขข้อร้องเรียนจากลูกค้าทุกช่องทาง (หน้าสาขา / CS Online) โครงสร้างการส่งต่อ (Escalation) Priority Matrix + SLA สคริปต์สื่อสาร และ RCA',
  (select id from sop.categories where slug = 'counter-service'),
  '<style>
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px}
.prose table.sop-tbl td{min-width:170px;max-width:340px;vertical-align:top;font-size:13.5px;line-height:1.55}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:130px;white-space:nowrap;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.sop-script{background:var(--surface-2);border-left:3px solid var(--brand-400);border-radius:6px;padding:8px 12px;margin:6px 0;font-size:13.5px}
.sop-script .en{color:var(--text-muted);font-style:italic}
</style>

<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS-023/2026 &nbsp;·&nbsp; <strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 พฤษภาคม 2569 &nbsp;·&nbsp; <strong>หน่วยงาน:</strong> Operations</p></blockquote>

<h3>🔹 วัตถุประสงค์ (Purpose)</h3>
<p>กำหนดขั้นตอนมาตรฐานในการ <strong>รับเรื่อง จัดการ และแก้ไข</strong> ข้อร้องเรียนจากลูกค้าของ AIRPORTELs ผ่านทุกช่องทาง เพื่อลดความเสียหาย รักษาภาพลักษณ์ และสร้างความพึงพอใจสูงสุด</p>
<p class="en" style="color:var(--color-muted,#6b7280)"><em>This SOP defines standard steps for receiving, managing, and resolving customer complaints across all channels.</em></p>

<h3>🔹 ขอบเขต (Scope)</h3>
<ul>
<li>ครอบคลุม 3 ช่องทาง: <strong>หน้าสาขา (Walk-in)</strong> · <strong>Customer Service Online</strong> (Email / Chat / Social Media)</li>
<li>ผู้รับผิดชอบ: Guest Service Staff / CS Staff / Branch Manager / CS Team Lead / Operation Co. / Operations Manager</li>
<li>ใช้กับทุกสาขาที่ให้บริการรับฝากและจัดส่งกระเป๋า</li>
</ul>

<h3>⏸️ คำจำกัดความ (Definitions)</h3>
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

<h3>⏸️ บทบาท / ความรับผิดชอบ (Roles &amp; Responsibilities)</h3>
<ul>
<li><strong>Guest Service / CS Staff:</strong> รับเรื่อง ฟัง บันทึก และแก้ไขเบื้องต้น | ส่งต่อเมื่อเกินขีดความสามารถ</li>
<li><strong>Branch Manager / Ops Coordinator:</strong> รับเรื่องระดับ 2 | ตัดสินใจแก้ปัญหาและชดเชยในขอบเขตที่กำหนด | รายงาน OP Manager (ผ่าน Lark Group แต่ละสาขา)</li>
<li><strong>CS Team Lead:</strong> ดูแล CS Online | ติดตาม SLA | รายงานสรุปรายสัปดาห์</li>
<li><strong>Operations Manager:</strong> อนุมัติการแก้ไขระดับสูง | อนุมัติค่าชดเชย | ดูแล RCA และมาตรการป้องกัน</li>
</ul>

<h3>⏸️ โครงสร้างการส่งต่อ (Escalation Matrix)</h3>
<div class="sop-scroll"><table class="sop-tbl">
<thead><tr><th>ช่องทาง / Channel</th><th>ระดับ 1 / Level 1</th><th>ระดับ 2 / Level 2</th><th>ระดับ 3 / Level 3</th></tr></thead>
<tbody>
<tr><td>หน้าสาขา / Branch</td><td>Guest Service Staff</td><td>Branch Manager / Ops Coordinator</td><td>Operations Manager</td></tr>
<tr><td>CS Online (Email / Chat / Social)</td><td>CS Staff</td><td>CS Team Lead</td><td>Operations Manager</td></tr>
</tbody></table></div>
<p><em>หมายเหตุ: Operations Manager = ผู้มีอำนาจตัดสินใจสูงสุดในทุกกรณี</em></p>

<h3>ช่องทางที่ 1 — หน้าสาขา (Walk-in Complaint)</h3>
<p><strong>⚙️ ขั้นตอนการรับมือ (Handling Procedure)</strong></p>
<ol>
<li><strong>รับเรื่องและฟังอย่างตั้งใจ (Receive &amp; Listen Actively)</strong> — ต้อนรับลูกค้า แนะนำตัว ฟังโดยไม่ขัดจังหวะ จดบันทึกปัญหาสำคัญ</li>
<li><strong>ยืนยันและสรุปปัญหา (Acknowledge &amp; Summarise)</strong> — ทวนสิ่งที่ลูกค้าแจ้งเพื่อยืนยันความเข้าใจที่ถูกต้อง</li>
<li><strong>ประเมินระดับความเร่งด่วน (Assess Urgency)</strong> — ปัญหาทั่วไป → Staff จัดการเอง | ซับซ้อน/อารมณ์สูง → ส่งต่อ Branch Manager</li>
<li><strong>เสนอทางแก้ไข (Propose Resolution)</strong> — นำเสนอแนวทางในขอบเขตอำนาจ Staff เช่น ขอโทษ ชดเชย จัดการสิ่งของ</li>
<li><strong>บันทึกเรื่องร้องเรียน (Log the Complaint)</strong> — แจ้งผ่านกลุ่ม Lark ที่กำหนดหลังจบการสนทนา โดยระบุ: Order No. / ชื่อลูกค้า / รายละเอียดเคส / การแก้ไขเบื้องต้นที่ทำไป / สิ่งที่ลูกค้าต้องการหรือต่อรอง / ข้อมูลอื่นที่จำเป็น</li>
<li><strong>ติดตามผล (Follow-up)</strong> — แก้ไขทันที → แจ้งลูกค้า | ต้องรอ → แจ้งระยะเวลาที่คาดหวัง</li>
</ol>

<h4>เงื่อนไขการส่งต่อ (Escalation Triggers)</h4>
<div class="sop-scroll"><table class="sop-tbl">
<thead><tr><th>เงื่อนไข / Trigger</th><th>ผู้รับผิดชอบ / Responsible</th></tr></thead>
<tbody>
<tr><td>ลูกค้าปฏิเสธคำขอโทษ / ต้องการค่าชดเชย</td><td>Branch Manager / Ops Coordinator</td></tr>
<tr><td>กระเป๋าสูญหาย / เสียหาย</td><td>Branch Manager → OP Manager</td></tr>
<tr><td>ลูกค้าขู่ร้องเรียนต่อสาธารณะ / กฎหมาย</td><td>OP Manager ทันที</td></tr>
</tbody></table></div>

<h4>สคริปต์การสื่อสาร (Communication Scripts)</h4>
<p><strong>การเปิดรับเรื่อง (Opening)</strong></p>
<div class="sop-script"><p>💬 “สวัสดีครับ/ค่ะ ขอโทษที่ทำให้คุณลำบากใจนะครับ (ค่ะ) ช่วยเล่าให้ฟังหน่อยได้ไหมครับว่าเกิดอะไรขึ้น … ผม/ดิฉัน [ชื่อ] จะดูแลเรื่องนี้เองนะครับ/ค่ะ”</p><p class="en">“Good [morning/afternoon]. I''m so sorry to hear about this. My name is [Name], and I''m here to help. Could you please walk me through what happened?”</p></div>
<p><strong>การขอโทษและเสนอทางออก (Apology &amp; Resolution)</strong></p>
<div class="sop-script"><p>💬 “ต้องขอโทษจริงๆ สำหรับความไม่สะดวกที่เกิดขึ้น เราจะ [ระบุแนวทาง] ให้เลยครับ/ค่ะ หากใช้เวลานานกว่านี้ ผม/ดิฉันจะแจ้งให้ทราบทันที”</p><p class="en">“Please accept our sincere apologies. We will [state action] for you right away. If this takes longer than expected, I will keep you updated.”</p></div>

<h3>ช่องทางที่ 2 — Customer Service Online (Email / Chat / Social Media)</h3>
<p><strong>ขั้นตอนการรับมือ (Handling Procedure)</strong></p>
<ol>
<li><strong>ติดตามและรับเรื่อง (Monitor &amp; Receive)</strong> — CS Staff ตรวจสอบ email, chat, social ตาม SLA ที่กำหนด</li>
<li><strong>ส่งข้อความยืนยันรับเรื่อง (Send Acknowledgement)</strong> — ตอบรับ ≤ 1 ชม. (Urgent) / ≤ 4 ชม. (Standard)</li>
<li><strong>จัดประเภทและกำหนด Priority</strong> — ใช้ Priority Matrix (P1/P2/P3)</li>
<li><strong>สืบค้นและประสานงาน (Investigate &amp; Coordinate)</strong> — ตรวจสอบ booking ประสานทีมหน้าสาขาหรือทีมที่เกี่ยวข้อง</li>
<li><strong>แก้ไขและแจ้งผล (Resolve &amp; Communicate)</strong> — แจ้งผลผ่านช่องทางเดิมที่ลูกค้าติดต่อมา</li>
<li><strong>ปิดเคสและบันทึก (Close &amp; Log)</strong> — บันทึกในระบบ Respond: วันปิด สาเหตุ และแนวทางแก้ไข</li>
</ol>

<h3>Priority Matrix &amp; SLA</h3>
<div class="sop-scroll"><table class="sop-tbl">
<thead><tr><th>Priority</th><th>ประเภทปัญหา / Issue Type</th><th>ยืนยัน / Ack.</th><th>แก้ไข / Resolve</th></tr></thead>
<tbody>
<tr><td>P1 Urgent</td><td>กระเป๋าสูญหาย, ความปลอดภัย, กฎหมาย (Lost luggage, safety, legal threat)</td><td>≤ 1 ชม.</td><td>≤ 4 ชม.</td></tr>
<tr><td>P2 High</td><td>กระเป๋าเสียหาย, booking ผิด, ชำระผิดพลาด (Damaged item, booking/payment error)</td><td>≤ 2 ชม.</td><td>≤ 24 ชม.</td></tr>
<tr><td>P3 Standard</td><td>ข้อร้องเรียนทั่วไป, นโยบาย, คืนเงิน (General complaint, policy, refund)</td><td>≤ 4 ชม.</td><td>≤ 48 ชม.</td></tr>
</tbody></table></div>

<h3>ตัวอย่างการตอบกลับ (Response Templates)</h3>
<p><strong>ข้อความยืนยันรับเรื่อง (Email / Chat)</strong></p>
<div class="sop-script"><p>📩 เรียนคุณ [ชื่อ] – ขอบคุณที่ติดต่อ AIRPORTELs ค่ะ/ครับ เราได้รับเรื่องร้องเรียนแล้ว และกำลังดำเนินการตรวจสอบ จะติดต่อกลับภายใน [X ชั่วโมง] — ด้วยความเคารพ, Customer Service Team</p><p class="en">Dear [Name], Thank you for contacting AIRPORTELs. We have received your complaint and are looking into the matter. We will get back to you within [X hours]. — Warm regards, AIRPORTELs Customer Service Team</p></div>
<p><strong>สคริปต์ทางโทรศัพท์ (Phone)</strong></p>
<div class="sop-script"><p>📞 “สวัสดีครับ/ค่ะ AIRPORTELs Customer Service ผม/ดิฉัน [ชื่อ] ยินดีช่วยเหลือครับ/ค่ะ” — หลังฟัง: “ขอบคุณที่แจ้งให้ทราบ ขออภัยในความไม่สะดวก ขอหมายเลขอ้างอิงได้ไหมครับ/ค่ะ”</p><p class="en">“Thank you for calling AIRPORTELs Customer Service. This is [Name], how may I help you today?” — After listening: “I sincerely apologise for the inconvenience. May I have your booking reference?”</p></div>

<h3>กรณีผิดปกติ (Exceptions &amp; Incident Handling)</h3>
<ul>
<li><strong>ลูกค้าขู่ / ใช้ความรุนแรง:</strong> แจ้ง รปภ. ทันที อย่าโต้เถียง (กรณีหน้าสาขา) และแจ้ง OP Team Lead</li>
<li><strong>กระเป๋าสูญหายมูลค่าสูง:</strong> ถ่ายภาพ บันทึกรายละเอียด แจ้ง Branch Manager → OP Team Lead ทันที ดำเนินการตามนโยบายชดเชย</li>
<li><strong>ลูกค้าจะโพสต์ Social Media เชิงลบ:</strong> แจ้ง Branch Manager / CS Team Lead → OP Manager ทันที เพื่อประสานตอบสนองเชิงรุก</li>
</ul>

<h3>การวิเคราะห์สาเหตุ (Root Cause Analysis – RCA)</h3>
<p>หลังปิดเคส P1 และ P2 ทุกเคส ต้องผ่านกระบวนการ RCA ดังนี้:</p>
<div class="sop-scroll"><table class="sop-tbl">
<thead><tr><th>ขั้นตอน RCA</th><th>ผู้รับผิดชอบ / Owner</th></tr></thead>
<tbody>
<tr><td>ระบุสาเหตุหลัก (5 Whys)</td><td>CS Team Lead / Branch Manager</td></tr>
<tr><td>เสนอมาตรการป้องกัน</td><td>CS Team Lead / Branch Manager</td></tr>
<tr><td>อนุมัติและสั่งการ</td><td>Operations Manager</td></tr>
<tr><td>ติดตามผลภายใน 14 วันทำการ</td><td>CS Team Lead</td></tr>
</tbody></table></div>

<h3>บันทึกและการควบคุม (Documentation &amp; Controls)</h3>
<p><strong>ข้อมูลที่ต้องบันทึกทุกเคส:</strong> วันที่-เวลา / ช่องทาง (Branch / Online / Google Review) / ชื่อลูกค้า + เลขการจอง / ประเภทปัญหา + Priority / การดำเนินการ / ผลลัพธ์ / ชื่อผู้ปิดเคส</p>
<p><strong>รายงานสรุป:</strong> รายสัปดาห์ — CS Team Lead → OP Manager (จำนวนเคส, SLA compliance, trends) · รายเดือน — OP Manager รายงาน pattern และมาตรการป้องกันต่อฝ่ายบริหาร</p>

<h3>ตัวชี้วัด (KPIs &amp; Audit)</h3>
<ul>
<li><strong>SLA Compliance:</strong> P1 ≥ 95% | P2 ≥ 90% | P3 ≥ 85% ภายในเวลามาตรฐาน</li>
<li><strong>Resolution Rate:</strong> แก้ไขได้ใน First Contact ≥ 70%</li>
<li><strong>Customer Satisfaction:</strong> CSAT หลังปิดเคส ≥ 4.0 / 5.0</li>
<li><strong>Audit:</strong> CS Team Lead ทบทวน Complaint Log รายสัปดาห์ | OP Manager รายเดือน</li>
</ul>

<h3>✔ Checklist — CS Team &amp; Branch Staff</h3>
<ul>
<li>☐ รับเรื่องลูกค้า → ฟัง → ยืนยันปัญหา → ประเมิน Priority</li>
<li>☐ ตอบรับภายใน SLA ที่กำหนด พร้อมเลขอ้างอิง</li>
<li>☐ แก้ไข หรือส่งต่อตาม Escalation Matrix ทันที</li>
<li>☐ บันทึก Complaint Log ทุกเคส (ห้ามข้าม)</li>
<li>☐ ปิดเคส → บันทึกผล → รายงาน Team Lead</li>
<li>☐ P1 / P2: ทำ RCA หลังปิดเคส ภายใน 3 วันทำการ</li>
</ul>

<h3>ประวัติการแก้ไข (Document Control)</h3>
<div class="sop-scroll"><table class="sop-tbl">
<thead><tr><th>Version</th><th>วันที่ / Date</th><th>แก้ไขโดย / Author</th><th>รายละเอียด / Notes</th></tr></thead>
<tbody><tr><td>1.0</td><td>10 May 2026</td><td>Operations Team</td><td>Initial release / เอกสารฉบับแรก</td></tr></tbody>
</table></div>
', array['complaint','customer-service','sla','escalation'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: abandoned-luggage-disposal =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('abandoned-luggage-disposal', 'การจัดการและการกำจัดสัมภาระที่ถูกทิ้ง (Abandoned Luggage Disposal)', 'SOP-OPS 021 — ขั้นตอนจัดการสัมภาระที่ลูกค้าไม่ติดต่อ/ไม่มารับ/ทอดทิ้ง ต่อจาก SOP-OPS:016 เส้นเวลาติดตาม 3 ครั้ง (Day 1–25) การกำหนดสถานะ Abandoned (Day 30) ช่องทางการกำจัด (บริจาค/ขายทอดตลาด/ทำลาย) และสคริปต์สื่อสาร',
  (select id from sop.categories where slug = 'delivery'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 021<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 พฤษภาคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<p>อ้างอิง / Reference:</p>
<ul><li>(TH)Terms and Conditions2026 / (EN)Terms and Conditions2026</li><li>SOP : การจัดการกรณีลูกค้ามารับสัมภาระล่าช้า – เกณฑ์และโครงสร้างส่วนลด</li></ul>
<h3>🔹 วัตถุประสงค์ / Purpose</h3>
<p>กำหนดขั้นตอนมาตรฐานการจัดการสัมภาระที่ลูกค้าไม่ติดต่อ ไม่มารับ หรือทอดทิ้ง ภายหลังจาก SOP-OPS:016 (Delayed Collection) ไม่สามารถติดต่อลูกค้าได้ เพื่อคุ้มครองสิทธิ์ของบริษัท ป้องกันพื้นที่จัดเก็บเต็ม และดำเนิน การทางกฎหมายอย่างถูกต้อง To define the standard procedure for handling luggage that is unclaimed, abandoned, or where the customer has failed to respond — following escalation from SOP-OPS:016. This protects company rights, prevents storage capacity issues, and ensures legally compliant disposal.</p>
<p>🔗 ความสัมพันธ์กับ SOP อื่น / SOP Relationship</p>
<ul><li>SOP-OPS:016 (Delayed Collection) → เมื่อลูกค้าไม่ติดต่อ/ไม่มารับ → ส่งต่อมายัง SOP-OPS:023 นี้</li></ul>
<p>SOP-OPS:016 handles delayed but contactable customers. If uncontactable → escalate here.</p>
<ul><li>SOP-OPS:021 (Lost &amp; Found) → ใช้เมื่อลูกค้ายังต้องการกระเป๋าและแจ้งสูญหาย ≠ SOP นี้</li></ul>
<p>SOP-OPS:021 handles active lost reports. This SOP handles unclaimed/abandoned cases.</p>
<ul><li>SOP-OPS:022 (Damage Claim) → ใช้หลังจากลูกค้ารับกระเป๋าแล้วและพบความเสียหาย</li></ul>
<p>SOP-OPS:022 applies after retrieval and damage is reported.</p>
<h3>🔹 ขอบเขตและคำจำกัดความ / Scope &amp; Definitions</h3>
<p>ครอบคลุม / Applies To ยกเว้น / Excludes ลูกค้าทุกประเภทที่ฝากสัมภาระกับ AIRPORTELs All customers storing luggage at any AIRPORTELs location กรณีที่ลูกค้าติดต่อกลับแล้ว → ส่งคืน SOP-OPS:016 If customer responds → revert to SOP-OPS:016 ทุกสาขาและช่องทาง (Walk-in, Call Center, Email, Line, Facebook) All branches and contact channels กรณีลูกค้าแจ้งสูญหาย → SOP-OPS:021 Active lost reports → SOP-OPS:021 Guest Service Staff, Branch Manager, CS Team, Operations Manager, Legal/BD กระเป๋าที่มีเจ้าของติดต่อภายในระยะเวลากำหนด Bags with owners who contact within stipulated period</p>
<h3>🔹 คำจำกัดความ / Key Definitions</h3>
<h3>คำศัพท์ / Term ความหมาย / Definition</h3>
<p>Delayed Collection ลูกค้ายังติดต่อได้แต่มารับล่าช้า → จัดการโดย SOP-OPS:016 Customer is contactable, but late to collect — handled by SOP-OPS:016 Unclaimed Luggage กระเป๋าที่ครบกำหนดและยังไม่มีการรับคืน แต่ยังอยู่ในช่วงติดตาม Luggage past due date, still in follow-up period Abandoned Bag กระเป๋าที่ลูกค้าไม่ติดต่อกลับหลัง 3 รอบ Follow-up ครบ Notice Period Luggage where customer has not responded after 3 follow-ups and notice period has elapsed Notice Period ระยะเวลาที่บริษัทแจ้งเตือนลูกค้าก่อนดำเนินการทิ้ง/จำหน่าย (30 วัน) 30-day formal notice period before disposal action Disposal การดำเนินการกับกระเป๋าที่ถูกทอดทิ้ง: บริจาค / ขายทอดตลาด / ทำลาย ตาม T&amp;C Action taken on abandoned bags: donate / auction / destroy per T&amp;C Ex-Gratia ส่วนลดพิเศษที่มอบให้ลูกค้า VIP/กรณีพิเศษ อนุมัติโดย BD/COO/CEO เท่านั้น Special goodwill discount for VIP/special cases, approved by BD/COO/CEO only 🔹 เส้นเวลาและเกณฑ์เวลา / Timeline &amp; Trigger Points 🧭 กำหนดเวลาหลัก / Key Timeline (นับจากวันครบกำหนดรับกระเป๋า) ทุก milestone อ้างอิงจาก T&amp;C ฉบับ 29 เมษายน 2569 และนโยบาย SOP-OPS:016 Day 0 TRIGGER สัมภาระครบกำหนดรับ</p>
<ul><li>กระเป๋าถึงวันครบกำหนดตาม Booking | Booking end date reached</li><li>ระบบแจ้งเตือนอัตโนมัติ / Lark notification ส่งถึง GS</li></ul>
<p>Day 1–7 FOLLOW-UP 1 ติดตามครั้งที่ 1 — GS / CS</p>
<ul><li>GS/CS โทรหรือส่งอีเมล/LINE แจ้งลูกค้า | Call/Email/LINE to inform customer</li><li>บันทึกการติดต่อใน CRM / Lark | Log contact attempt in CRM/Lark</li><li>หากลูกค้าตอบรับ → ส่งกลับ SOP-OPS:016 | If customer responds → revert to SOP-</li></ul>
<p>OPS:016 Day 15 FOLLOW-UP 2 ติดตามครั้งที่ 2 — CS</p>
<ul><li>ส่ง Formal Notice Email แจ้งค่าฝากค้างชำระ + กำหนดเวลา | Send formal email:</li></ul>
<p>outstanding fee + deadline</p>
<ul><li>แนบรายละเอียด: ขนาดสัมภาระ, วันฝาก, ยอดค้างชำระ, กำหนดรับ 30 วัน</li><li>หากลูกค้าตอบรับ → ส่งกลับ SOP-OPS:016</li></ul>
<p>Day 25 FOLLOW-UP 3 ติดตามครั้งที่ 3 — OP Manager</p>
<ul><li>OP Manager ส่ง Final Notice — แจ้ง 5 วันสุดท้าย | OP Manager sends final 5-day</li></ul>
<p>warning</p>
<ul><li>ระบุชัดเจน: หากไม่มารับ/ติดต่อ กระเป๋าจะถูก Disposal ตาม T&amp;C</li><li>ช่องทาง: Email + LINE + โทรศัพท์ (บันทึกทุกช่องทาง)</li></ul>
<p>Day 30 ABANDONED กำหนดสถานะ Abandoned</p>
<ul><li>หากยังไม่มีการติดต่อ → เปลี่ยนสถานะเป็น ''Abandoned'' | Status changed to</li></ul>
<p>''Abandoned'' in system</p>
<ul><li>OP Manager จัดทำ Abandonment Report + ขออนุมัติ BD/ CEO</li></ul>
<p>| OP Manager prepares Abandonment Report for CEO/BD approval Day 31+ DISPOSAL ดำเนินการ Disposal</p>
<ul><li>ดำเนินการตามช่องทาง Disposal (ดู Section Disposal Options)</li></ul>
<p>| Execute disposal per approved disposal channel</p>
<ul><li>บันทึกผลลัพธ์ รูปถ่าย และเอกสารครบ เก็บอย่างน้อย 1 ปี</li></ul>
<h3>🔹 ขั้นตอนการปฏิบัติสำหรับพนักงาน : Staff Procedure — Lost &amp; Found / Abandoned</h3>
<p>ลำดับที่ 1: ก่อนถึง Day 30 — ติดตามและป้องกัน Abandon / Pre-Abandonment Follow-Up 1 ตรวจสอบรายวัน — ระบบแจ้งเตือน / Daily Check — System Alert</p>
<ul><li>GS ตรวจสอบ Dashboard Lark / ระบบจัดการทุกเช้า | Check Lark Dashboard every morning</li><li>กรองรายการ: Overdue (เกินกำหนด) + No Contact (ยังไม่ได้ติดต่อ)</li><li>Priority: Long-term (≥6 เดือน) → OP Manager รับทราบด้วย</li></ul>
<p>2 Follow-Up ครั้งที่ 1 (Day 1–7) / First Contact Attempt</p>
<ul><li>โทรศัพท์ก่อน → ถ้าไม่รับ ส่ง SMS/LINE/Email ตาม Contact ที่มีในระบบ</li><li>ใช้ Script การติดต่อ (ดู Section Scripts หน้าถัดไป)</li><li>บันทึกใน CRM: วันเวลา, ช่องทาง, ผลการติดต่อ</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016 (Discount Structure)</li></ul>
<p>| Customer responds → revert to SOP-OPS:016</p>
<ul><li>ลูกค้าไม่ตอบ ❌ → รอ Day 15 Follow-Up 2 | No response → wait for Day 15</li></ul>
<p>3 Formal Notice Email (Day 15) / Second Contact — Formal Notice</p>
<ul><li>CS ส่ง Formal Notice Email (ดู Template Section)</li><li>เนื้อหาต้องระบุ: ยอดค้างชำระ | วันฝาก | ขนาดสัมภาระ | กำหนดรับ 30 วัน | ผลที่ตามมาถ้าไม่มารับ</li><li>บันทึก Email Sent Date ใน Lark + แนบสำเนา Email</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016</li></ul>
<p>| Customer responds → revert to SOP-OPS:016 4 Final Notice (Day 25) / Third Contact — Final Warning</p>
<ul><li>OP Manager ส่ง Final Notice (Email + LINE + โทร)</li><li>ระบุชัด: หากไม่มีการติดต่อหรือชำระภายใน 5 วัน กระเป๋าจะถูก Abandoned Disposal</li><li>บันทึกการส่ง Final Notice ทุกช่องทาง + screenshot</li><li>ลูกค้าตอบรับ ✅ → ส่งกลับ SOP-OPS:016 (ขออนุมัติ Operation Manager สำหรับ Long-term) |</li></ul>
<p>Customer responds → SOP-OPS:016 + OM approval ลำดับที่ 2: Day 30+ — จัดการ Abandoned Bag / Abandonment &amp; Disposal Process 5 เปลี่ยนสถานะ Abandoned (Day 30) / Mark as Abandoned</p>
<ul><li>OP Manager ยืนยันว่าครบ 3 Follow-ups + ครบ Notice Period</li><li>เปลี่ยนสถานะในระบบ Lark เป็น ''Abandoned''</li><li>จัดทำ Abandonment Report: ชื่อลูกค้า | Order ID | วันฝาก | ระยะเวลา | ยอดค้าง | ประวัติการติดต่อ</li><li>ถ่ายภาพสัมภาระก่อนดำเนินการ (บันทึกสภาพ)</li></ul>
<p>6 ขออนุมัติ Disposal / Request Disposal Approval</p>
<ul><li>OP Manager ส่ง Abandonment Report ให้ CEO/BD ผ่านกลุ่ม Business Gank! หรือ Lark</li><li>รอการอนุมัติก่อนดำเนินการ Disposal ทุกกรณี | Await approval before any disposal action</li><li>เนื้อหา Report: สรุปกรณี | ช่องทาง Disposal ที่แนะนำ | มูลค่าประมาณ | เหตุผล</li></ul>
<p>7 ดำเนินการ Disposal (หลังได้รับอนุมัติ) / Execute Disposal</p>
<ul><li>เลือก Disposal Channel ตามตารางด้านล่าง (ดู Section Disposal Options)</li><li>ถ่ายภาพ/วิดีโอขณะดำเนินการ Disposal</li><li>บันทึกผลลัพธ์ใน Disposal Record: วันที่ | ช่องทาง | มูลค่า (ถ้ามี) | ผู้อนุมัติ</li><li>เก็บเอกสารและภาพถ่ายอย่างน้อย 1 ปี | Retain records for minimum 1 year</li></ul>
<p>8 แจ้งลูกค้า (ถ้าติดต่อได้ภายหลัง) / Notify Customer Post-Disposal</p>
<ul><li>หากลูกค้าติดต่อมาหลัง Disposal แล้ว: แจ้งสถานะและให้ Disposal Record</li><li>ไม่มีภาระผูกพันทางการเงินแก่บริษัทหลัง Disposal ตาม T&amp;C | No financial obligation after disposal per</li></ul>
<p>T&amp;C</p>
<ul><li>หากลูกค้าโต้แย้ง: Escalate ถึง BD/CEO + Legal (ถ้าจำเป็น)</li></ul>
<h3>ช่องทาง Disposal และตารางอนุมัติ Disposal Options &amp; Approval Authority</h3>
<ul><li>ช่องทาง Disposal / Disposal Channels</li></ul>
<h3>ช่องทาง / Channel เงื่อนไข / Condition ผู้อนุมัติ /</h3>
<p>Approver หมายเหตุ / Notes 🎁 บริจาค / Donate สัมภาระสภาพดี ไม่มีมูลค่าตลาด สูง | ลูกค้าไม่ติดต่อครบ Notice Period Good condition, low market value, notice period elapsed OP Manager บันทึกองค์กรที่รับบริจาค + ภาพถ่าย Log receiving org + photo 🔨 ขายทอดตลาด / Auction สัมภาระมีมูลค่า (กระเป๋าแบรนด์, ถุงกอล์ฟ) | ยอด ค้างสูง High-value items, significant outstanding fee BD / CEO รายได้หักค่าฝากก่อน ส่วนที่เหลือ (ถ้า มี) เก็บไว้ 90 วัน Revenue offsets fees; remainder held 90 days 🗑️ ทำลาย / Destroy สัมภาระสภาพแย่ / เสื่อมสภาพ / มี ของต้องห้าม / ไม่สามารถบริจาค หรือขายได้ CLO + ถ่ายรูป บันทึกเหตุผล + ถ่ายวิดีโอขณะทำลาย Damaged, contains</p>
<h3>prohibited items, unsellable</h3>
<p>Document reason + video during destruction 📦 เก็บต่อ /Pending กรณี VIP / Corporate / กำลังอยู่ ในกระบวนการกฎหมาย VIP/Corporate or legal proceedings in progress CEO / BD / Legal กำหนดระยะเวลาเก็บต่อและเงื่อนไข ชัดเจน</p>
<h3>ตารางอนุมัติส่วนลด (เชื่อมต่อจาก SOP-OPS:016) /</h3>
<h3>Discount Approval Matrix - from SOP-OPS:016</h3>
<p>ส่วนลด /</p>
<h3>Discount Level</h3>
<p>ระยะเวลาฝาก ผู้อนุมัติ เงื่อนไข ≤ 25% ทุกช่วงเวลา Guest Service Exe. อนุมัติผ่านกลุ่ม Lark ได้ทันที &gt;25% ถึง 50% ≥ 6 เดือน (Long- term) Operation Manager ต้องมีเอกสาร + Approval Request Email + หลักฐาน | ขั้นต่ำชำระ 50% ของยอดเต็ม &gt;50% VIP / Ex-Gratia เท่านั้น BD / COO / CEO ไม่อนุมัติในกรณีทั่วไป | เฉพาะ VIP Corporate หรือกรณีพิเศษที่ CEO พิจารณา 📌 ตัวอย่างกรณี / Example Cases 📑Case 1: Long-term + ลูกค้ากลับมาก่อน Disposal</p>
<ul><li>ฝาก 7 เดือน | กระเป๋า Large | ยอดค้าง 22,000 THB (Very High)</li><li>Base Table = 15% → Duration ≥ 6 เดือน → Special Discount 25–50%</li><li>OP Manager อนุมัติ 50% → จ่าย 11,000 THB (ขั้นต่ำ 50% ตาม Rule) | → Approved 50%,</li></ul>
<p>pay 11,000 THB</p>
<ul><li>⚑ ต้องแนบเอกสาร + ส่ง Approval Request ก่อนยืนยันลูกค้า</li></ul>
<p>📑 Case 2: Long-term + ไม่ติดต่อ → Abandoned</p>
<ul><li>ฝาก 9 เดือน | กระเป๋า Medium | ยอดค้าง 6,000 THB | ไม่ตอบ 3 Follow-ups</li><li>Day 30 → Abandonment Report | CEO อนุมัติ Dispose → บริจาค (สภาพดี)</li><li>บันทึก: ภาพก่อน-หลัง + องค์กรที่รับบริจาค + วันที่ + ผู้ดำเนินการ</li></ul>
<p>📑 Case 3: ลูกค้าโทรมาหลัง Disposal แล้ว</p>
<ul><li>แจ้งสถานะ: กระเป๋าถูก Dispose ตาม T&amp;C (Notice Period ครบ)</li><li>มอบ Disposal Record ให้ลูกค้า</li><li>ไม่มีภาระผูกพันทางการเงินแก่บริษัท | หากโต้แย้ง → BD/Legal</li></ul>
<h3>เอกสารและ Scripts Required Documents &amp; Communication Scripts</h3>
<h3>📌 เอกสารที่ต้องใช้ / Required Documents</h3>
<h3>เอกสาร / Document ใช้ช่วง / When จัดทำโดย / By เก็บที่ / Stored In</h3>
<p>Contact Attempt Log Follow-up ทุก ครั้ง (Day 1–25) GS / CS CRM / Lark Formal Notice Email Day 15 CS Email Sent Folder + Lark Final Notice (Email + LINE) Day 25 OP Manager Email + LINE Screenshot + Lark Abandonment Report Day 30 OP Manager Lark Base + อีเมล CEO/BD Disposal Record + Photos หลัง Disposal OP Manager Lark Base + เก็บ 1 ปี</p>
<h3>Approval Request Email ส่วนลด &gt;25%</h3>
<p>หรือ Disposal CS / OP Manager Email Chain + Lark</p>
<h3>📌 Scripts การสื่อสาร / Communication Scripts</h3>
<p>1️⃣การรับเรื่องจากลูกค้า (เริ่มต้น) TH สวัสดีค่ะ/ครับ ขอบคุณที่ติดต่อ AIRPORTELs รบกวนขอชื่อ-นามสกุล และรหัสการจอง เพื่อให้ทีม งานตรวจสอบข้อมูลการฝากสัมภาระของคุณลูกค้าค่ะ EN Hello, thank you for contacting AIRPORTELs. May I have your full name and</p>
<h3>booking reference so our team can check your storage details?</h3>
<p>2️⃣กรณีลูกค้าแจ้งล่วงหน้า TH หากคุณลูกค้าแจ้งล่วงหน้าก่อนถึงวันรับจริง เราสามารถช่วยจัดการได้ค่ะ เช่น เสนอการส่งสัมภาระ ให้ หรือพิจารณาลดค่าฝากตามที่กำหนดได้เลยค่ะ EN If you inform us in advance, we can arrange solutions such as delivery or apply a</p>
<h3>discount on your storage fee per our policy.</h3>
<p>3️⃣ กรณีไม่แจ้ง แต่มีเหตุสุดวิสัย TH หากคุณลูกค้าไม่สามารถแจ้งล่วงหน้าได้ แต่มีเหตุสุดวิสัยพร้อมเอกสารยืนยัน เช่น ตั๋วเครื่องบินที่ เลื่อน/ยกเลิก หรือใบรับรองแพทย์ เราสามารถพิจารณาส่วนลดให้ได้ค่ะ รบกวนส่งเอกสารมาที่อีเมลหรือ LINE ของเราด้วยนะคะ EN If you couldn''t notify us due to force majeure and have supporting documents (flight cancellation, medical certificate), we can consider a discount. Please send documents via email or LINE.</p>
<p>4️⃣ แจ้งผลอนุมัติส่วนลด TH เรียนคุณลูกค้า ทางทีมงานได้พิจารณาแล้ว และอนุมัติส่วนลด [XX%] สำหรับค่าฝากสัมภาระในครั้ง นี้ค่ะ ขอบคุณที่ไว้วางใจใช้บริการ AIRPORTELs EN Dear Customer, we are pleased to inform you that your discount request has been approved at [XX%]. Thank you for choosing AIRPORTELs.</p>
<p>5️⃣ แจ้งสถานะ Abandoned (หลัง Disposal) TH เรียนคุณลูกค้า สัมภาระของท่านได้ผ่านกระบวนการแจ้งเตือนครบ 3 ครั้ง และครบระยะเวลา Notice Period 30 วันแล้ว ทางบริษัทจึงได้ดำเนินการตาม T&amp;C เรียบร้อยแล้ว หากต้องการเอกสารประกอบ กรุณาติดต่อทีมงานค่ะ EN Dear Customer, your luggage has completed the 3-notice follow-up process and the 30-day Notice Period. The disposal has been completed per our T&amp;C. Please contact us if you require documentation.</p>
<p>6️⃣ ชวนรีวิว Google TH หากคุณลูกค้าพึงพอใจกับการบริการ รบกวนช่วยรีวิว AIRPORTELs ทาง Google Review ด้วยนะ คะ ความเห็นของคุณลูกค้ามีคุณค่ามากสำหรับการพัฒนาบริการของเราค่ะ EN If you are satisfied with our service, we would appreciate a Google Review. Your feedback helps us improve.</p>
<p>คู่มือลูกค้า — ของหายและกระเป๋าถูกทิ้ง Customer Guide — Lost &amp; Found / Abandoned Bag ส่วนนี้จัดทำขึ้นสำหรับแจกหรือส่งอีเมลให้ลูกค้าโดยตรง สามารถพิมพ์หรือแชร์ได้เลย</p>
<p><strong>1. กระเป๋าของฉันอยู่ที่ไหน? / Where is my luggage?</strong></p>
<p>หากคุณฝากกระเป๋าไว้กับ AIRPORTELs และไม่ได้มารับตามกำหนด กระเป๋าของคุณยังอยู่ที่สาขาที่ฝากไว้ AIRPORTELs จะพยายามติดต่อคุณ 3 ครั้ง ก่อนดำเนินการใดๆ If you stored luggage with AIRPORTELs and did not collect by the booking end date, your bag remains at the branch. AIRPORTELs will attempt to contact you 3 times before any action is taken.</p>
<ul><li>ติดตาม Order ของคุณที่: app.airportels.asia/tracking | Track your order at:</li></ul>
<p>app.airportels.asia/tracking</p>
<ul><li>หรือติดต่อ: center@airportels.asia | LINE Official | Or contact: center@airportels.asia</li></ul>
<p><strong>2. ขั้นตอนหลังเกินกำหนด / What happens after the due date?</strong></p>
<p>ช่วงเวลา / Period AIRPORTELs ทำอะไร? ลูกค้าต้องทำ? Day 1–7 GS/CS ติดต่อครั้งที่ 1 (โทร/Email/LINE) First contact attempt ตอบรับและยืนยันวันรับกระเป๋า Respond and confirm collection date Day 15 ส่ง Formal Notice Email พร้อมยอด ค้าง Formal notice email with outstanding fee ติดต่อกลับ + เตรียมเอกสาร (ถ้ามีเหตุสุดวิสัย) Contact us + prepare documents if force majeure Day 25 ส่ง Final Notice (5 วันสุดท้าย) Final 5-day warning ติดต่อกลับทันที ก่อนสิ้นสุดกำหนด Contact us immediately before deadline Day 30 กระเป๋าถูกกำหนดสถานะ Abandoned Bag marked as Abandoned หากยังต้องการกระเป๋า ติดต่อทันทีก่อน Disposal Contact immediately if you still want your bag Day 31+ ดำเนินการ Disposal ตาม T&amp;C ขอ Disposal Record ได้ที่ ops@airportels.com Disposal executed per T&amp;C Request Disposal Record at ops@airportels.com</p>
<p><strong>3. ขอส่วนลดค่าฝากได้หรือไม่? / Can I request a discount on storage fees?</strong></p>
<p>กรณี / Case ส่วนลดที่ได้รับ เอกสารที่ต้องแสดง แจ้งล่วงหน้าก่อนวันรับ ตามตาราง Base Table ไม่ต้องมีเอกสารพิเศษ ไม่แจ้ง มีเหตุสุดวิสัย พิจารณาตามกรณี ตั๋วสายการบิน / ใบรับรองแพทย์ / หนังสือราชการ Long-term ≥ 6 เดือน 25–50% (ขั้นต่ำจ่าย 50%) ประวัติการฝาก + เหตุผล + อนุมัติ OP Manager VIP / Corporate พิจารณาเป็นกรณี Email ฝ่ายการตลาด/BD | Customer profile ไม่ตรงเงื่อนไข ไม่มีส่วนลด ต้องชำระเต็มจำนวน</p>
<p><strong>4. ติดต่อ AIRPORTELs / Contact Us</strong></p>
<ul><li>Official notifications from: center@airportels.asia</li><li>Website: www.airportels.asia | T&amp;C: www.airportels.asia/terms-conditions/</li><li>Hours: ตามเวลาทำการของสาขา | Branch operating hours apply</li></ul>
<h3>✔ Checklist สำหรับลูกค้า (กรณีเกินกำหนดรับ)</h3>
<p>☐ ติดต่อ AIRPORTELs ทันทีที่ทราบว่าไม่สามารถมารับได้ตามกำหนด ☐ เตรียมเอกสารหลักฐาน (ถ้ามีเหตุสุดวิสัย): ตั๋วสายการบิน / ใบรับรองแพทย์ / เอกสารราชการ ☐ ยืนยันวันที่จะมารับกระเป๋า หรือขอให้จัดส่งถึงที่ ☐ หากได้รับ Formal Notice Email → ตอบกลับทันทีอย่าเพิกเฉย ☐ หากต้องการข้อมูล Disposal Record → ติดต่อ Customer Service</p>
<h3>ประวัติการแก้ไข / Document Control</h3>
<p>Version วันที่ / Date แก้ไขโดย / Author รายละเอียด / Notes 1.0 10 May 2026 Operations Team Initial release / เอกสารฉบับแรก</p>

<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="mailto:ops@airportels.com" target="_blank" rel="noopener">ขอ  Disposal Record ได้ที่ ops@airportels.com</a></li></ul>', array['abandoned','disposal','storage','lost-found'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== NEW: lost-found-claim =====
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values ('lost-found-claim', 'การจัดการของหาย & เคลมความเสียหาย (Lost & Found / Damage Claim)', 'SOP-OPS 021 — ขั้นตอนรับแจ้ง สอบสวน และจัดการกรณีลูกค้าแจ้งของหาย/เสียหายระหว่างใช้บริการ เงื่อนไขการเคลมตาม T&C (แจ้งภายใน 72 ชม.) วงเงินชดเชย และแผนผังขั้นตอนการเคลม',
  (select id from sop.categories where slug = 'counter-service'),
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 021<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 พฤษภาคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote>
<p>อ้างอิง / Reference:</p>
<ul><li>(TH)Terms and Conditions2025 / (EN)Terms and Conditions2025</li><li>SOP: เคลมความเสียหาย</li></ul>
<h3>🔹 วัตถุประสงค์ / Purpose</h3>
<p>กำหนดขั้นตอนมาตรฐานในการรับแจ้ง สอบสวน และจัดการกรณีที่ลูกค้าแจ้งว่ากระเป๋าหรือทรัพย์สินสูญหายระหว่าง ใช้บริการ AIRPORTELs เพื่อให้การดำเนินการถูกต้องตาม T&amp;C โปร่งใส และตรวจสอบย้อนกลับได้ To standardize receiving, investigating, and resolving lost item reports during AIRPORTELs service in accordance with official T&amp;C</p>
<h3>🔹 ขอบเขต / Scope</h3>
<ul><li>ครอบคลุมทุกสาขาที่มีบริการรับฝากและจัดส่งกระเป๋า — Applies to all branches with storage and</li></ul>
<h3>delivery services.</h3>
<ul><li>ขอบเขตสำหรับพนักงานหน้าสาขาทุกคน | Applies to all Guest Service Staff, CS Agents, and Branch</li></ul>
<p>Managers.</p>
<ul><li>อ้างอิง T&amp;C เรื่องสิทธิ์เคลมและค่าชดเชย | All claim decisions reference the official T&amp;C .</li></ul>
<h3>⚠️ เงื่อนไขการเคลมความเสียหาย : Key T&amp;C References (Last update: 29/04/2026)</h3>
<ul><li>ลูกค้าต้องแจ้งเคลมความเสียหายภายใน 3 วัน หรือ 72 ชั่วโมง นับตั้งแต่ได้รับกระเป๋าคืน หรือนับตั้งแต่สถานะ</li></ul>
<p>การจัดส่งในระบบแสดงว่า “ส่งสำเร็จ” หากพ้นระยะเวลาดังกล่าว บริษัทฯ ขอสงวนสิทธิ์ไม่รับผิดชอบต่อความ เสียหายหรือสูญหายใดๆ ทั้งสิ้น</p>
<ul><li>หากปลายทางไม่มีผู้รับกระเป๋า ณ เวลาที่จัดส่ง บริษัทฯ ขอสงวนสิทธิ์ไม่รับผิดชอบต่อความเสียหายหรือสูญหาย</li></ul>
<p>ใดๆ ที่อาจเกิดขึ้น ทั้งนี้ พนักงานจะรอเพียง 15 นาทีตามเงื่อนไขการจัดส่ง หากไม่มีผู้รับ คำสั่งซื้อจะถือเป็น “ไม่ แสดงตน” และจะไม่มีการคืนเงิน</p>
<ul><li>หากเป็นสิ่งของ หรือรายการต้องห้าม ที่ทางบริษัทฯ ไม่รับฝากหรือส่ง ขอสงวนสิทธิ์ไม่รับเคลม และไม่รับผิดชอบ</li></ul>
<p>ใดๆ ทั้งสิ้น</p>
<ul><li>ค่าชดเชยสูงสุด: 5,000 THB (กระเป๋า) | 50,000 THB (ถุงกอล์ฟ) | 10,000 THB (Nationwide 5 วัน) ต่อ</li></ul>
<p>ออร์เดอร์</p>
<ul><li>บริษัทรับพิจารณาเฉพาะหลักฐานที่ออกจากช่องทางของบริษัทโดยตรง ได้แก่</li><li>อีเมลจาก center@airportels.asia</li><li>ใบเสร็จที่พิมพ์จากระบบบริษัท</li><li>ข้อมูลบนเว็บไซต์และระบบจัดการของบริษัท</li><li>เอกสารที่ได้รับจากเจ้าหน้าที่หรือพาร์ทเนอร์ที่ได้รับอนุญาต</li></ul>
<h3>🔹 บทบาทและความรับผิดชอบ / Roles</h3>
<p>ตำแหน่ง / Role หน้าที่ / Responsibility CS Agent / Guest Service Staff รับแจ้ง บันทึกเคส รวบรวมหลักฐาน ประสานงานสาขา สื่อสารกับลูกค้า Receive, log, collect evidence, coordinate branch, communicate. OP Coordinator / OP Manager กำกับการสอบสวน อนุมัติค่าชดเชย ตรวจสอบ CCTV รายงานผิดปกติ Supervise investigation, approve compensation, review CCTV.</p>
<p>Operations /BD / CLO MS ปิดเคสระดับสูง ประสานหน่วยงานราชการ ทบทวนนโยบายรายไตรมาส Handle escalations, liaise with authorities, quarterly review.</p>
<h3>🔹 ประเภทของสูญหาย / Lost Item Categories</h3>
<h3>ประเภท / Category สิทธิ์เคลม การดำเนินการ / Action</h3>
<p>กระเป๋าหายทั้งใบ ระหว่างขนส่ง โดย AIRPORTELs / Make Send or Partner Whole luggage lost during transport ✅ มีสิทธิ์ถ้ายืนยันได้ และดำเนินการตาม กระบวนการ ลูกค้าแจ้งเคลมตามขั้นตอน → ตรวจสอบรายละเอียด → ยืนยัน → ชดเชยตามตาราง (ต้องแสดงใบเสร็จ / หลักฐานครบถ้วน) ของหายภายในกระเป๋า Missing item inside luggage ❌ ไม่ครอบคลุม บันทึกเท่านั้น อ้างอิงT&amp;C Section: Liabilities ของแต่งกระเป๋า (พวงกุญแจ, ป้าย, หมอน) Attachments/accessories ❌ ไม่ครอบคลุม T&amp;C ระบุชัด: ไม่รับประกัน แนะนำถอดออกก่อนใช้บริการ ของต้องห้าม / Prohibited items ❌ ไม่ครอบคลุม ไม่ดำเนินการเคลม อ้างอิง T&amp;C Prohibited Items Section</p>
<h3>ขั้นตอนการปฏิบัติ Lost &amp; Found Process Steps</h3>
<p>1. GS &amp; CS รับแจ้งและบันทึกข้อมูลเบื้องต้น / Receive the Report</p>
<ul><li>รับทราบรายงานลูกค้าภายในวันทำการเดียวกัน | Acknowledge same business day</li><li>รวบรวม: ชื่อ-นามสกุล | Order ID | เบอร์ติดต่อ | คำอธิบายของที่หาย | วัน-เวลา-สาขาที่ใช้บริการ</li></ul>
<p>2. ตรวจสอบออร์เดอร์และตัวตน / Verify Order &amp; Identity</p>
<ul><li>ยืนยันการจองผ่านระบบจัดการของ AIRPORTELs | Confirm via AIRPORTELs management system</li><li>ตรวจสอบรายละเอียดความเสียหาย รูปถ่าย หรือ VDO หลักฐาน</li></ul>
<p>3. ส่ง Claim From ให้ลูกค้าแจ้งรายละเอียด / Log the Case</p>
<ul><li>ลูกค้ากรอกแบบฟอร์ม เพื่อทำการขอเคลม Order ID | วันที่รับแจ้ง | คำอธิบายของที่หาย | ประเภทบริการ | มูลค่า</li></ul>
<p>ความเสียหาย | รายละเอียดการคืนเงิน 4. สอบสวนและค้นหา / Investigate</p>
<ul><li>ประสานงานสาขา/คนขับที่เกี่ยวข้อง ตรวจสอบ CCTV หรือบันทึกส่งมอบ</li><li>ยืนยันว่าของอยู่ในความดูแลของ AIRPORTELs ขณะสูญหาย</li><li>เป้าหมาย: ภายใน 3 วันทำการ / Target: within 3 business days</li></ul>
<p>5. แจ้งผลลัพธ์ / Communicate Outcome</p>
<ul><li>ยืนยันเป็นลายลักษณ์อักษรทางอีเมลทุกกรณี</li><li>หากพบ: แจ้งทันที ส่งมอบคืนที่สาขา หรือจัดส่งให้ | หากไม่พบ + มีสิทธิ์: ไปขั้นตอนที่ 6</li><li>หากไม่มีสิทธิ์: อธิบายเป็นลายลักษณ์อักษรโดยอ้างอิง T&amp;C ชัดเจน</li></ul>
<p>6. ดำเนินการชดเชย (กรณีมีสิทธิ์) / Process Compensation — if eligible</p>
<ul><li>ขอหลักฐานการซื้อ / มูลค่าเดิมจากลูกค้า</li><li>วงเงิน: 5,000 THB (กระเป๋า) | 50,000 THB (ถุงกอล์ฟ) | 10,000 THB (Nationwide 5 วัน) ต่อออร์เดอร์</li><li>คืนเงินภายใน 7–14 วันทำการ ผ่าน Wireless Transfer เท่านั้น (T&amp;C)</li><li>ขออนุมัติ Operations Manager ก่อนยืนยันกับลูกค้า</li></ul>
<p>7. ปิดเคสและบันทึก / Close &amp; Document</p>
<ul><li>อัปเดตบันทึกเคส แนบหลักฐานทั้งหมด เก็บอย่างน้อย 90 วัน</li><li>กรณีสงสัยคดีอาญา: Escalate Operations Manager รายงานถึงผู้บริหาร ประสานกับเจ้าหน้าที่เพื่อดำเนิน</li></ul>
<p>การตามขั้นตอนที่เกี่ยวข้อง 🚫 กรณีที่ไม่ดำเนินการเคลม / Do NOT Process If:</p>
<ul><li>สูญหายก่อนส่งมอบ / หลังปิดธุรกรรม / บุคคลอื่นแสดง valid references รับไปแล้ว</li><li>ของต้องห้าม / ของยกเว้น / ของในกระเป๋า / ของแต่งกระเป๋า</li><li>เหตุสุดวิสัย (ภัยธรรมชาติ, คำสั่งราชการ, จราจรระงับ) — T&amp;C Uncontrollable Events</li></ul>
<h3>🔹สรุป Flow Claim — AIRPORTELs</h3>
<p>ผู้ที่เกี่ยวข้อง: Customer (ลูกค้า) · Guest Service (GS) · Operations (OP) · Customer Service (CS) ลำดับที่ 1 — รับเรื่องที่สาขา หรือ Online team (Customer → GS or CS)</p>
<p><strong>1. ลูกค้ามาที่เคาน์เตอร์ → GS ตรวจสอบ</strong></p>
<ul><li>กรณีลูกค้าแจ้งผ่านช่องทาง Online → CS ตรวจสอบ</li></ul>
<p><strong>2. GS เปิดคืนกระเป๋า → ลูกค้ารับกระเป๋าคืน</strong></p>
<p><strong>3. ตรวจสอบว่ากระเป๋ามีความเสียหายหรือไม่</strong></p>
<ul><li>NO → คืนกระเป๋าให้ลูกค้า (จบ)</li><li>YES → แจ้งความเสียหายกับพนักงาน</li></ul>
<p>ลำดับที่ 2 — ตรวจสอบและส่งแบบฟอร์ม (GS → CS)</p>
<p><strong>4. GS / CS ตรวจสอบความเสียหายของกระเป๋า</strong></p>
<p><strong>5. ประเมินจาก (Policy)</strong></p>
<ul><li>NO (ไม่ผ่าน) → แจ้งเงื่อนไขให้ลูกค้า</li><li>YES → ส่ง Email ให้ลูกค้ากรอกแบบฟอร์มผ่าน Respond</li></ul>
<p><strong>6. ลูกค้ากรอกแบบฟอร์มพร้อมส่งหลักฐาน → OP รับผลผ่านฟอร์ม</strong></p>
<p>ลำดับที่ 3 — พิจารณาและอนุมัติ (OP)</p>
<p><strong>7. OP ตรวจสอบข้อมูล ครบ/ไม่ครบ</strong></p>
<ul><li>NO → ส่งให้ CS ขอข้อมูลเพิ่ม → CS Respond กลับ → นำส่งให้ OP ใหม่</li><li>YES → พิจารณากรณี</li></ul>
<p><strong>8. ตรวจสอบว่ากระเป๋าเสียหายจากการขนส่งหรือไม่</strong></p>
<ul><li>NO → ตรวจสอบจากกล้องวงจรปิด หรือหลักฐานอื่นๆ</li><li>YES → ทำเอกสารเคลมให้ลูกค้า</li></ul>
<p>ลำดับที่ 4 — อนุมัติและจ่ายเงิน (OP → CEO → CS)</p>
<p><strong>9. ตรวจสอบความผิดพลาด — จาก AI หรือพนักงาน</strong></p>
<ul><li>NO (จาก MS) → บันทึกความเสียหายส่งเคลมกลับไปที่ MS</li><li>YES (AI) → แจกแจงความเสียหายพร้อมแนบเอกสาร ส่งทีม HR, ACC</li></ul>
<p><strong>10. ส่งเอกสารให้ CS → ลูกค้าผ่าน Respond พร้อมยอดรับ</strong></p>
<p><strong>11. ส่งเอกสารให้ Operation Manager → เซ็นอนุมัติ → Status ใน Lark เป็น Approver</strong></p>
<p><strong>12. ส่งเอกสารให้ CEO ผ่านกลุ่ม Business Gank! → เพื่อยืนยันกับลูกค้า</strong></p>
<p><strong>13. นำเข้าข้อมูลใน CS → ดำเนินการเคลม → CS ส่งหลักฐานการโอนให้ลูกค้า</strong></p>
<p><strong>14. เปลี่ยน Status ใน Lark เป็น In Paid</strong></p>
<p><strong>15. กรอกฟอร์มเคลมกรณีความเสียหายเกิดจากการขนส่ง MS → แนบหลักฐานการโอนเงินให้ลูกค้า</strong></p>
<p>→ END</p>
<h3>เอกสาร และแบบฟอร์ม ประกอบการ Claim</h3>
<ul><li>Flow Claim and Refund</li><li>Claim and Refund</li><li>Claim with MS</li></ul>
<h3>ประวัติการแก้ไข / Document Control</h3>
<p>Version วันที่ / Date แก้ไขโดย / Author รายละเอียด / Notes 1.0 10 May 2026 Operations Team Initial release / เอกสารฉบับแรก</p>
<h3>แผนผังขั้นตอนการเคลม (Flow Chart) จากเอกสารต้นฉบับ</h3><figure><img src="/sop/lost-found-claim/p5.jpg" alt="แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 1" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 1</figcaption></figure><figure><img src="/sop/lost-found-claim/p6.jpg" alt="แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 2" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 2</figcaption></figure><figure><img src="/sop/lost-found-claim/p7.jpg" alt="แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 3" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>แผนผังขั้นตอนการเคลม (Flow Chart) — ส่วนที่ 3</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="mailto:center@airportels.asia" target="_blank" rel="noopener">อีเมลจาก center@airportels.asia</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/docx/YpQGdONFSoSPM7xT14ulfCe7gqc?from=from_copylink" target="_blank" rel="noopener">เปิดลิงก์ (Open link)</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/base/AjqWbJszaaLk1hspwmClmhizg2f?from=from_copylink" target="_blank" rel="noopener">เปิดลิงก์ (Open link)</a></li><li><a href="https://forms.gle/B5dXQkTH73CDtBJJA" target="_blank" rel="noopener">Claim with MS</a></li></ul>', array['lost-found','claim','compensation','damage'], 'published', false)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary,
  category_id = excluded.category_id, content_html = excluded.content_html,
  tags = excluded.tags, status = excluded.status;

-- ===== ILLUSTRATED: dmk-airport-service (2 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 020/2026<br><strong>วันที่บังคับใช้:</strong> 1 มกราคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><p>เวอร์ชัน / Version: ปรับปรุงครั้งที่ 1</p>
<h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>เพื่อกำหนดขั้นตอนการรับและส่งมอบกระเป๋าเดินทาง ณ ท่าอากาศยานดอนเมือง ให้เป็นไปตามข้อกำหนดด้านความ ปลอดภัยของการท่าฯ (ทอท.) และใช้เป็นแนวปฏิบัติจริงสำหรับพนักงานหน้าสาขา To establish operational procedures for luggage acceptance and release at Don Mueang Airport in compliance with AOT security regulations.</p>
<h3>📌ขอบเขตการใช้งาน / Scope</h3>
<p>ใช้สำหรับพนักงาน AIRPORTELs ประจำสาขาดอนเมือง (DMK) ทุกตำแหน่งที่เกี่ยวข้องกับการรับ ฝาก ส่งมอบ และ ตรวจสอบกระเป๋า Applicable to all AIRPORTELs staff involved in luggage acceptance, storage, delivery, and X-ray screening at DMK.</p>
<h3>คำจำกัดความ (Definitions)</h3>
<ul><li>พนักงานหน้าสาขา (Guest Service &amp; Porter ): พนักงานที่ให้บริการลูกค้า ณ จุดบริการ</li><li>ผู้รับมอบฉันทะ: บุคคลที่ได้รับมอบอำนาจเป็นลายลักษณ์อักษรจากเจ้าของกระเป๋า</li><li>ทอท. (AOT): บริษัท ท่าอากาศยานไทย จำกัด (มหาชน)</li></ul>
<h3>บทบาทและความรับผิดชอบ (Roles &amp; Responsibilities)</h3>
<p>พนักงานหน้าสาขาทุกตำแหน่ง (Guest Service &amp; Porter)</p>
<ul><li>ตรวจสอบการจองและเอกสารลูกค้า</li><li>ชี้แจงเงื่อนไขการให้บริการและข้อกำหนดด้านความปลอดภัย</li><li>ปฏิบัติตามขั้นตอน SOP อย่างเคร่งครัด</li><li>หยุดกระบวนการและรายงานเมื่อพบความเสี่ยง</li></ul>
<p>หัวหน้าสาขา (ฺBranch Manager) / ผู้ควบคุมงาน (Operation Team)</p>
<ul><li>กำกับดูแลการปฏิบัติงานให้เป็นไปตาม SOP</li><li>ประสานงานกับเจ้าหน้าที่ ทอท. ในกรณีผิดปกติ</li></ul>
<h3>ขั้นตอนการปฏิบัติงาน (Operational Procedures)</h3>
<h3>ขั้นตอนการรับฝากกระเป๋า (Luggage Acceptance)</h3>
<p><strong>1. รับลูกค้าและตรวจสอบการจองในระบบ</strong></p>
<p><strong>2. ขอเอกสารประจำตัว ID Card / Passport เพื่อบันทึกข้อมูลลงในระบบ POS</strong></p>
<p><strong>3. ตรวขสอบกระเป่า หรือสัมภาระ ร่วมกับผู้ใช้บริการ ทั้งภายนอก และภายใน</strong></p>
<p><strong>4. ชี้แจงข้อกำหนดด้านความปลอดภัยของ ทอท. และแจ้งว่ากระเป๋าทุกใบต้องผ่านการตรวจ X-ray</strong></p>
<p><strong>5. ขอความยินยอมจากลูกค้าเพื่อดำเนินการตรวจ X-ray</strong></p>
<p><strong>6. หากไม่ยินยอม ให้ปฏิเสธการให้บริการทันที</strong></p>
<p><strong>7. นำกระเป๋าเข้าตรวจด้วยเครื่อง X-ray โดยผู้ได้รับอนุญาต</strong></p>
<p><strong>8. จัดประเภทผล X-ray</strong></p>
<ul><li>Clear: ดำเนินการรับกระเป๋าเข้าระบบ</li><li>Prohibited Item: แยกสิ่งของออก และส่งมอบคืนให้ผู้ใช้บริการ</li><li>Suspicious Item: หยุดกระบวนการ ห้ามเปิดกระเป๋า และประสาน ทอท. ตรวจสอบทันที่เบอร์โทร 02-535</li></ul>
<p>1616</p>
<p><strong>9. ติด Tag / Label และบันทึกข้อมูลกระเป๋าในระบบ</strong></p>
<h3>ขั้นตอนการส่งมอบกระเป๋า (Luggage Release )</h3>
<p><strong>1. ผู้มารับกระเป๋าแสดงเอกสารรับกระเป๋า</strong></p>
<p><strong>2. ตรวจสอบว่าผู้รับเป็นเจ้าของกระเป๋าหรือผู้รับมอบฉันทะ</strong></p>
<p><strong>3. ตรวจสอบเอกสารประจำตัว / หนังสือมอบฉันทะ (ถ้ามี)</strong></p>
<p><strong>4. ตรวจสอบ Tag / Label ให้ตรงกับข้อมูลในระบบ</strong></p>
<p><strong>5. ส่งมอบกระเป๋าให้ผู้รับ</strong></p>
<p><strong>6. บันทึกการส่งมอบในระบบ</strong></p>
<p>ข้อห้ามและข้อควรระวัง (Prohibitions &amp; Precautions)</p>
<ul><li>ห้ามรับกระเป๋าที่ไม่ผ่านการตรวจ X-ray</li><li>ห้ามเปิดกระเป๋าด้วยตนเองในทุกกรณี</li><li>ห้ามรับกระเป๋าที่พบสิ่งของต้องห้ามตามข้อกำหนดสนามบิน</li><li>ต้องปฏิบัติตามคำสั่งของเจ้าหน้าที่ ทอท. อย่างเคร่งครัด</li></ul>
<h3>เอกสารที่เกี่ยวข้อง (Related Documents)</h3>
<ul><li>SOP การให้บริการรับฝากกระเป๋า ณ ท่าอากาศยานดอนเมือง</li><li>SOP: การให้ผู้อื่นมารับกระเป๋าแทน / Authorized Person Pickup</li></ul>
<p>รายการสิ่งของต้องห้าม (Prohibited Items) ห้ามจัดส่งสิ่งของดังต่อไปนี้ : Prohibit Items</p>
<figure><img src="/sop/dmk-airport-service/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>💡หมายเหตุ: ของเหลว (Liquid) สามารถรับได้เฉพาะกรณี</p>
<ul><li>ไม่เป็นสเปรย์</li><li>บรรจุภัณฑ์ไม่เกิน 100 ml.</li><li>มีฉลากระบุชัดเจนและอยู่ในบรรจุภัณฑ์เดิม ภายใต้เงื่อนไข ไม่เกิน 100 ml.</li></ul>
<p>📘 สิ่งของที่แตกหักง่าย และเปราะบาง : หากลูกค้ายืนยันต้องการนำส่งให้แจ้งเงื่อนไขให้ชัดเจนทุกครั้ง</p>
<ul><li>AIRPORTELs are not responsible for fragile, valuable, liquid, electronic, or prohibited items.</li><li>AIRPORTELs จะไม่รับผิดชอบต่อสิ่งของที่เปราะบาง มีค่า เป็นของเหลว เป็นอุปกรณ์อิเล็กทรอนิกส์ หรือสิ่งของ</li></ul>
<p>ต้องห้าม</p>
<h3>ข้อกำหนดด้านความปลอดภัย (ทอท.) | AOT Security Requirements</h3>
<ul><li>กระเป๋าทุกใบต้องผ่านการตรวจด้วยเครื่อง X-ray ก่อนรับเข้าระบบ</li></ul>
<p>All luggage must undergo X-ray screening prior to acceptance.</p>
<ul><li>ผู้ใช้งานเครื่อง X-ray ต้องผ่านการอบรมและได้รับอนุญาตจาก ทอท.</li></ul>
<p>X-ray operators must be certified and authorized by AOT.</p>
<ul><li>กรณีพบสิ่งของต้องห้ามหรือสิ่งน่าสงสัย ต้องหยุดกระบวนการและประสานเจ้าหน้าที่ ทอท. ทันที ที่เบอร์โทร 02-</li></ul>
<p>535 1616 Any prohibited or suspicious items must be reported to AOT immediately.</p>
<figure><img src="/sop/dmk-airport-service/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>การบริการรับฝากกระเป๋า ณ ท่า อากาศยานดอนเมือง.pdf 12.63MB</p>' where slug = 'dmk-airport-service';

-- ===== ILLUSTRATED: pos-order-receiving (12 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 011/2025<br><strong>เวอร์ชัน:</strong> 2.0<br><strong>วันที่บังคับใช้:</strong> 9 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><p>แก้ไขครั้งที่ 1 / Revised Date: 20 สิงหาคม 2568 : Dev. อัพเดตการเลือก Service Type การจอง MS</p>
<h3>📌วัตถุประสงค์ (Purpose)</h3>
<p>เพื่อกำหนดขั้นตอนที่เป็นมาตรฐานในการรับออเดอร์จากลูกค้า ทั้งการฝากกระเป๋าและการส่งกระเป๋า ผ่านระบบ POS และระบบหลังบ้าน เพื่อให้มั่นใจว่าทุกขั้นตอนถูกต้อง ครบถ้วน รวดเร็ว และสามารถตรวจสอบย้อนหลังได้</p>
<h3>📌ขอบเขต (Scope)</h3>
<p>SOP นี้ครอบคลุมขั้นตอนการรับออเดอร์ของลูกค้าผ่านระบบ POS :</p>
<ul><li>ที่หน้าสาขาทุกแห่งของบริษัท</li><li>สำหรับบริการฝากและบริการส่งกระเป๋าเดินทาง หรือสัมภาระ</li><li>ตั้งแต่การกรอกข้อมูลลูกค้าใน POS จนถึงการจองเลข MS (ในกรณีบริการส่ง)</li></ul>
<h3>ขั้นตอนการปฏิบัติงาน (Work Instructions)</h3>
<p><strong>1. การรับออเดอร์ผ่านระบบ POS</strong></p>
<h3>ขั้นตอนที่ 1: เตรียมข้อมูลลูกค้า</h3>
<ul><li>ขอ Passport หรือ บัตรประชาชน จากลูกค้า</li><li>เข้าระบบ POS</li></ul>
<figure><img src="/sop/pos-order-receiving/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>ใส่ Passport ID หรือ เลขบัตรประชาชน</li><li>กด Search</li></ul>
<h3>ขั้นตอนที่ 2: กรอกข้อมูลลูกค้าให้ครบถ้วน</h3>
<ul><li>เลือกคำนำหน้าชื่อ ให้ถูกต้อง</li><li>กรอก ชื่อ-นามสกุล</li><li>ตรวจสอบว่า เลขที่บัตรประชาชน / Passport ID แสดงถูกต้อง (ระบบจะแสดงข้อมูลตามที่ระบุไว้ในขั้นตอนที่ 1)</li><li>กรอก สัญชาติ (ใช้ตัวย่อตาม Passport)</li><li>กด Continue</li></ul>
<figure><img src="/sop/pos-order-receiving/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<h3>ขั้นตอนที่ 3: สร้างคำสั่งซื้อ</h3>
<ul><li>กด New Order</li><li>เลือกประเภทบริการที่ลูกค้าต้องการ:</li><li>บริการฝากกระเป๋า (Deposit Order)</li><li>บริการส่งกระเป๋า (Delivery Order)</li></ul>
<figure><img src="/sop/pos-order-receiving/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/pos-order-receiving/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>2. รายละเอียดตามประเภทบริการ</strong></p>
<p>A. บริการฝากกระเป๋า</p>
<ul><li>กรอก จำนวนกระเป๋า</li><li>ใส่ลำดับ Tag ของกระเป๋า (อิงตามสาขา)</li><li>เลือก วันที่และเวลา ที่ลูกค้าจะมารับ</li><li>สแกน QR Code ให้ลูกค้ากรอก Email และเบอร์โทรศัพท์</li><li>เมื่อระบุข้อมูลครบแล้ว กด Continue</li></ul>
<figure><img src="/sop/pos-order-receiving/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/pos-order-receiving/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>คิดเงิน (หากต้องการคิดทันที):</p>
<ul><li>กด Service</li><li>ใส่จำนวนเงิน แล้วกด ADD</li><li>กด Confirm เพื่อสิ้นสุดรายการ</li></ul>
<p>B. บริการส่งกระเป๋า</p>
<ul><li>เลือก ปลายทางจัดส่ง</li><li>เลือก วันที่และเวลา ที่ลูกค้าจะมารับ</li><li>สแกน QR Code ให้ลูกค้ากรอก Email และเบอร์โทรศัพท์</li><li>กด Continue</li><li>กด Service เพื่อคิดเงิน</li><li>ใส่จำนวนเงิน แล้วกด ADD</li></ul>
<figure><img src="/sop/pos-order-receiving/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>กด Continue เพื่อสิ้นสุดรายการ</li></ul>
<figure><img src="/sop/pos-order-receiving/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. การจองเลข MS (สำหรับบริการส่งเท่านั้น)</strong></p>
<ul><li>เข้าระบบหลังบ้าน Airportles</li><li>ค้นหาออเดอร์</li><li>กด Create Logistic Order</li></ul>
<figure><img src="/sop/pos-order-receiving/fig9.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>เลือก Service Type</li></ul>
<p>พนักงานที่กดจอง ออเดอร์เข้าฝั่ง MS จะต้องเลือก Service Type ที่ต้องการ โดยระบบจะปรับ Tracking prefix ฝั่ง MS ให้เป็นไปตามที่พนักงานระบุไป (จำเป็นต้องระบุ)</p>
<ul><li>หากมีรายละเอียดเพิ่มเติม : ให้ระบุใน Note เพื่อแจ้งรายละเอียดไปฝั่ง MS ได้ เช่น "ส่งด่วนนะคะ" , "สีแดง</li></ul>
<p>3ใบ" เป็นต้น (หากไม่มีข้อมูลสามารถปล่อยว่างได้)</p>
<figure><img src="/sop/pos-order-receiving/fig10.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>ตรวจสอบ ที่อยู่ต้นทาง - ปลายทาง</li><li>เลือกวันจัดส่ง และรอบเวลา 12:00 - 14:00</li><li>เลือก จังหวัด / อำเภอ / รหัสไปรษณีย์ ให้ตรงกับที่อยู่ปลายทาง</li><li>กด Create</li></ul>
<figure><img src="/sop/pos-order-receiving/fig11.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<ul><li>สิ้นสุดการทำรายการ</li></ul>
<figure><img src="/sop/pos-order-receiving/fig12.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>หมายเหตุ:</p>
<ul><li>หากพบที่อยู่ไม่ถูกต้อง ต้องแก้ไขก่อนจองเลข MS</li><li>เน้นย้ำ!! หากจองเลข MS แล้วต้องการแก้ไขที่อยู่ ให้แจ้งยกเลิกกับ Planner ทุกครั้ง แล้วทำการจองใหม่</li></ul>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://postels.airportels.asia/admin/order/browse" target="_blank" rel="noopener">เข้าระบบหลังบ้าน Airportles</a></li></ul>' where slug = 'pos-order-receiving';

-- ===== ILLUSTRATED: authorized-person-pickup (3 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 012/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>เพื่อกำหนดแนวทางปฏิบัติที่ชัดเจนในการให้ผู้อื่นมารับกระเป๋าแทนเจ้าของอย่างปลอดภัย ลดความเสี่ยงจาก ความผิดพลาด การสูญหาย หรือการแอบอ้าง To provide clear procedures for allowing an authorized person to collect luggage on behalf of the owner, ensuring safety and minimizing risks of loss, errors, or impersonation.</p>
<h3>📌ขอบเขตการใช้งาน / Scope</h3>
<p>ใช้กับกรณีที่ลูกค้าไม่สามารถมารับกระเป๋าด้วยตนเอง และมอบหมายให้ผู้อื่นมารับแทน Applicable when the customer cannot pick up the luggage themselves and authorizes another person to do so.</p>
<h3>เอกสารและหลักฐานที่ต้องตรวจสอบ / Required Documents</h3>
<p>1.1 เอกสารของผู้รับมอบอำนาจ / Documents of the Authorized Person</p>
<ul><li>บัตรประชาชน / หนังสือเดินทาง / ใบขับขี่ (ฉบับจริง)</li></ul>
<p>National ID / Passport / Driver’s License (original copy)</p>
<ul><li>สำเนาบัตรประชาชน พร้อมลายเซ็นรับรองสำเนาถูกต้อง</li></ul>
<p>Copy of National ID with certified signature 1.2 เอกสารของผู้มอบอำนาจ / Documents of the Owner</p>
<ul><li>สำเนาบัตรประชาชน / หนังสือเดินทาง พร้อมลายเซ็นรับรองสำเนาถูกต้อง</li></ul>
<p>Copy of National ID / Passport with certified signature 1.3 หนังสือมอบอำนาจ / Authorization Letter</p>
<ul><li>รายละเอียดที่ต้องระบุ เช่น ชื่อ-นามสกุล, เลขบัตรประชาชนของทั้งสองฝ่าย, วัตถุประสงค์, รายละเอียดกระเป๋า,</li></ul>
<p>วันเวลา, ลายเซ็น, พยาน (ถ้ามี) Must include: Full names, ID numbers of both parties, purpose, bag details, date/time, signatures, witnesses (if possible) 1.4 เอกสารยืนยันการจัดฝาก Receive slip หรือ การส่ง / Delivery Confirmation</p>
<ul><li>ใบเสร็จ, หมายเลข Tracking, จุดรับ-ส่ง, หลักฐานการชำระเงิน</li></ul>
<p>Receipt, tracking number, pickup-drop point, proof of payment 1.5 รูปถ่าย / Photos</p>
<ul><li>รูปถ่ายกระเป๋า และเจ้าของคู่กับกระเป๋า (ถ้ามี)</li></ul>
<p>Clear photo of the luggage and owner with the luggage (if available)</p>
<h3>ขั้นตอนการปฏิบัติ / Procedure</h3>
<p><strong>1. ลูกค้าแจ้งความประสงค์ให้ผู้อื่นมารับกระเป๋าแทน พร้อมส่งเอกสารล่วงหน้า</strong></p>
<ul><li>Customer informs intention to authorize another person and sends documents in</li></ul>
<p>advance.</p>
<p><strong>2. เจ้าหน้าที่ตรวจสอบเอกสาร หากไม่ครบให้แจ้งลูกค้า</strong></p>
<ul><li>Staff verifies documents. If incomplete, notify the customer.</li></ul>
<p><strong>3. บันทึกข้อมูลผู้รับมอบอำนาจในระบบหรือแบบฟอร์มควบคุม</strong></p>
<ul><li>Record authorized person''s information in the system or control form.</li></ul>
<p><strong>4. ตรวจสอบตัวจริงผู้รับมอบอำนาจในวันรับกระเป๋า</strong></p>
<ul><li>Verify identity of the authorized person on pickup day.</li></ul>
<p><strong>5. ถ่ายรูปผู้รับมอบอำนาจกับกระเป๋าไว้เป็นหลักฐาน</strong></p>
<ul><li>Take a photo of the authorized person with the luggage for records.</li></ul>
<p><strong>6. ให้เซ็นรับกระเป๋า และแนบสำเนาบัตรประชาชนที่รับรองแล้ว</strong></p>
<ul><li>Obtain signature and attach a certified copy of the authorized person''s ID.</li></ul>
<p><strong>7. เจ้าหน้าที่ตรวจสอบสภาพกระเป๋าต่อหน้าผู้รับ</strong></p>
<ul><li>Staff inspects luggage condition in front of the authorized person.</li></ul>
<p><strong>8. ข้อควรระวังเพิ่มเติม / Additional Precautions</strong></p>
<ul><li>แจ้งลูกค้าให้ตรวจสอบนโยบายบริษัทล่วงหน้า</li><li>Inform customer to check company policy in advance.</li><li>ห้ามส่งมอบหากตรวจสอบตัวตนไม่ได้</li><li>Do not release luggage if identity cannot be verified.</li><li>หากสงสัยต้องแจ้งหัวหน้าสาขา</li><li>Report to branch manager if suspicious.</li><li>ถ่ายสำเนาและจัดเก็บเอกสารไว้อย่างน้อย 3 เดือน</li><li>Keep copies of documents for at least 3 months.</li></ul>
<p>หมายเหตุ / Remarks บริษัทขอสงวนสิทธิ์ในการปฏิเสธการส่งมอบกระเป๋าหากเอกสารไม่ครบถ้วน หรือไม่สามารถยืนยันตัวตนได้ The company reserves the right to deny luggage release if documents are incomplete or identity cannot be verified. กรณีเอกสารไม่ครบ / Missing Document Scenario</p>
<p><strong>1. ตรวจสอบเอกสารตัวจริง / Verify Original Documents</strong></p>
<ul><li>ขอให้ผู้รับแสดงเอกสารตัวจริง เช่น บัตรประชาชน หรือหนังสือเดินทาง</li><li>Request to present original documents (e.g., National ID, Passport)</li><li>ถ่ายรูปเอกสารตัวจริงต่อหน้าเจ้าของ</li><li>Take a photo of the original document in the presence of the person</li><li>ขออนุญาตจัดเก็บรูปถ่ายไว้ในระบบหรือแบบฟอร์มควบคุม</li><li>Store the photo in the system or record form with consent</li></ul>
<p><strong>2. โทรยืนยันกับเจ้าของกระเป๋า / Call the Luggage Owner for Verification</strong></p>
<ul><li>โทรติดต่อเจ้าของกระเป๋าตามเบอร์ในระบบ เพื่อยืนยันตัวตนของผู้รับแทน</li><li>Call the owner using contact info in the system to confirm the identity of the</li></ul>
<p>authorized person</p>
<ul><li>ให้เจ้าของยืนยันข้อมูล เช่น ชื่อ เลขบัตร หรือความสัมพันธ์</li><li>Have the owner confirm the name, ID number, or relationship</li><li>ควรมีพยาน (เจ้าหน้าที่) รับฟังการยืนยัน</li><li>A staff member should witness the confirmation call</li></ul>
<p><strong>3. บันทึกแบบฟอร์มยินยอม / Fill Consent Form for Exceptional Case</strong></p>
<ul><li>ให้ผู้รับเซ็นแบบฟอร์ม ''ยินยอมรับกระเป๋าโดยไม่มีสำเนาเอกสาร''</li><li>Let the receiver sign a consent form for collecting luggage without document copies</li><li>แบบฟอร์มต้องระบุข้อมูลผู้รับ เหตุผล ลายเซ็น วันเวลา ภาพถ่ายเอกสาร</li><li>Form must include personal info, reason, signature, timestamp, and document photo</li></ul>
<p><strong>4. แจ้งหัวหน้าสาขา / Notify Branch Manager</strong></p>
<ul><li>ต้องได้รับอนุมัติจากหัวหน้าสาขาหรือ Supervisor ก่อนส่งมอบ</li><li>Approval from the branch manager or supervisor is required before releasing luggage</li></ul>
<p>❌ ห้ามดำเนินการ หาก / DO NOT proceed if:</p>
<ul><li>ไม่สามารถยืนยันตัวตนจากเจ้าของกระเป๋า /Cannot verify with the owner</li><li>ไม่มีเอกสารตัวจริงใด ๆ / No original documents presented</li><li>มีพฤติกรรมหรือลักษณะน่าสงสัย / Suspicious behavior or inconsistency in information</li></ul>
<figure><img src="/sop/authorized-person-pickup/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ใบมอบฉันทะ.pdf</p>
<figure><img src="/sop/authorized-person-pickup/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>หนังสือมอบฉันทะ - Letter of Authorization.pdf</p>
<figure><img src="/sop/authorized-person-pickup/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = 'authorized-person-pickup';

-- ===== ILLUSTRATED: open-close-counter (8 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 003<br><strong>เวอร์ชัน:</strong> 2.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><p>วันที่มีการแก้ไข และปรับปรุง / Updated Date : 23 มกราคม 2569</p>
<h3>📌 วัตถุประสงค์ (Purpose)</h3>
<p>เพื่อกำหนดแนวทางปฏิบัติงานที่เป็นมาตรฐานในการ เปิดและปิดเคาน์เตอร์บริการ ทั้งในสาขาห้างสรรพสินค้าและ สนามบิน โดยมีจุดประสงค์เพื่อให้:</p>
<ul><li>พนักงานสามารถปฏิบัติงานได้อย่างถูกต้อง เป็นขั้นตอน และปลอดภัย</li><li>สร้างความพร้อมในการให้บริการลูกค้าอย่างมีประสิทธิภาพ</li><li>ป้องกันการสูญหายหรือความเสียหายของทรัพย์สินและอุปกรณ์</li><li>สนับสนุนการตรวจสอบคุณภาพงานและความถูกต้องของข้อมูลรายวัน เช่น Check-in, Check-out และยอด</li></ul>
<p>ขาย</p>
<h3>📌 ขอบเขต (Scope)</h3>
<p>แนวปฏิบัตินี้ครอบคลุมการดำเนินงานเฉพาะช่วง ก่อนเริ่มงาน (เปิดเคาน์เตอร์) และ หลังสิ้นสุดการให้บริการ (ปิด เคาน์เตอร์) ของพนักงาน ณ จุดให้บริการ สาขาในห้างสรรพสินค้า / ศูนย์การค้า และ สาขาในสนามบิน ภายใต้ แบรนด์ AIRPORTELs โดยรวมถึง:</p>
<ul><li>การเข้างานและออกงานผ่านแอปพลิเคชัน EMPEO</li><li>การตรวจสอบและจัดเตรียมอุปกรณ์ประจำจุดบริการ</li><li>การทำความสะอาดและจัดระเบียบพื้นที่ให้บริการ</li><li>การจัดทำและส่งรายงานยอดขายประจำวัน</li><li>การฝากเงินและการจัดการกระเป๋าหรือทรัพย์สินของลูกค้า</li><li>การจัดการกรณีสัมภาระตกค้าง / รอลูกค้าเข้ามารับ หลังเวลาการให้บริการ</li></ul>
<p>🏬 สำหรับเคาน์เตอร์ในห้างสรรพสินค้า / ศูนย์การค้า (Shopping Mall )</p>
<h3>🟢 ขั้นตอนการเปิดเคาน์เตอร์</h3>
<p><strong>1. สแกนหน้าเข้างาน ผ่านแอปพลิเคชัน EMPEO</strong></p>
<p><strong>2. ตรวจสอบความเรียบร้อยของเคาน์เตอร์</strong></p>
<ul><li>ปลดล็อคประตู และเปิดผ้าคลุมเคาน์เตอร์</li><li>ตรวจดูวัตถุต้องสงสัยหรือความผิดปกติภายใน และบริเวณรอบเคาน์เตอร์</li></ul>
<p><strong>3. ทำความสะอาดเคาน์เตอร์</strong></p>
<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ (จอมอนิเตอร์ / Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบ</li></ul>
<p>สกปรก)</p>
<ul><li>กวาด และถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li></ul>
<p><strong>4. เปิดอุปกรณ์ให้พร้อมใช้งาน</strong></p>
<ul><li>คอมพิวเตอร์</li><li>เครื่องพิมพ์</li><li>เครื่อง EDC</li><li>ป้ายไฟ</li><li>จอ LED</li><li>Tablet</li><li>ระบบปรับอากาศ (แอร์)</li><li>ระบบ CCTV : ตรวจสอบว่ากล้องถูกเปิด หรือไม่ดับระหว่างวัน</li></ul>
<p><strong>5. จัดวาง Tent Card และอุปกรณ์ประชาสัมพันธ์ให้ถูกต้อง ครบถ้วนตามที่กำหนด</strong></p>
<p><strong>6. ตรวจเช็คสัมภาระ และกระเป๋าลูกค้าคงค้างให้ถูกต้องครบถ้วน</strong></p>
<ul><li>จัดระเบียบตามลำดับการส่งคืนเพื่อให้สะดวกในการให้บริการระหว่างวัน</li></ul>
<p><strong>7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-in ผ่าน Lark OPEN Counter Checklist</strong></p>
<p><strong>8. เช็คสต๊อคสินค้าและของใช้ทุกวันอาทิตย์ UPDATE STOCK</strong></p>
<p><strong>9. ตรวจสอบ Stock KKDAY (สำหรับสาขา T21- Asok / CTW - Hugthai)</strong></p>
<ul><li>Update Report ใน Google Sheet สำหรับแต่ละสาขา</li></ul>
<figure><img src="/sop/open-close-counter/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>10. เตรียมความพร้อมให้บริการลูกค้า</strong></p>
<ul><li>ตรวจสอบการแต่งกาย และการแต่งหน้า แขวนบัตรพนักงานให้เรียบร้อย พร้อมให้บริการ</li></ul>
<p>หมายเหตุ : เพื่อให้พนักงานพร้อมให้บริการตามเวลาเปิดบริการ ควรมาถึงพื้นที่เพื่อเช็คอินก่อนเวลาทำการ 15 นาที</p>
<h3>🔴 ขั้นตอนการปิดเคาน์เตอร์</h3>
<p><strong>1. ตรวจสอบสัมภาระตกค้าง</strong></p>
<p>กรณีมีสัมภาระตกค้าง สำหรับสาขาที่ปิดบริการทุกวัน (สาขาห้าง ฯ และ สนามบินภูเก็ตทั้ง 2 สาขา , สาขาสนามบิน เชียงใหม่) ให้ดำเนินการดังนี้ อย่างเคร่งครัด</p>
<ul><li>หากมีกระเป๋าที่ลูกค้ายังไม่มารับ ให้แจ้ง CS เพื่อติดต่อลูกค้า</li><li>ให้แจ้งในกลุ่ม Lark สาขา กรณีประสานงาน CS และ ติดต่อลูกค้าแล้ว แต่ยังไม่มารับ (กรณีไม่มีการตอบกลับ</li></ul>
<p>ข้อความภายใน 15 นาที ให้โทรศัพท์หา OP Team Lead เพื่อประสานงานส่วนที่เกี่ยวข้อง)</p>
<ul><li>ห้ามพนักงานออกจากพื้นที่ก่อนได้รับการยืนยันจาก OP Team Lead เพื่อป้องกันความเสียหาย กรณีลูกค้า</li></ul>
<p>มีไฟล์ทบิน และจำเป็นต้องรับกระเป๋าภายในคืนนั้น</p>
<p><strong>2. นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</strong></p>
<figure><img src="/sop/open-close-counter/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. ปิดอุปกรณ์ต่าง ๆ</strong></p>
<ul><li>คอมพิวเตอร์</li><li>เครื่องพิมพ์</li><li>เครื่อง EDC</li><li>ป้ายไฟ</li><li>จอ LED</li><li>Tablet</li><li>ระบบปรับอากาศ (แอร์)</li></ul>
<p><strong>4. ทำความสะอาดเคาน์เตอร์</strong></p>
<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ (จอมอนิเตอร์ / Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบ</li></ul>
<p>สกปรก)</p>
<ul><li>กวาด และถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li><li>ทิ้งขยะ</li></ul>
<p><strong>5. เก็บ Tent Card และอุปกรณ์ประชาสัมพันธ์</strong></p>
<ul><li>ตรวจสอบหากมีชำรุดเสียหาย ให้แจ้งหัวหน้าสาขา เพื่อประสานงานนำชิ้นใหม่ไปเปลี่ยน</li></ul>
<p><strong>6. ตรวจสอบอุปกรณ์ต่างๆหากมีชำรุดเสียหายให้แจ้งซ่อม</strong></p>
<ul><li>ช่องทางการแจ้งซ่อม AIMS Help Center</li></ul>
<p><strong>7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-out ผ่าน Lark CLOSE Counter Checklist</strong></p>
<p><strong>8. ตรวจสอบและล็อคเคาน์เตอร์</strong></p>
<ul><li>คลุมผ้าคลุม และล็อคตู้ ประตูให้เรียบร้อย</li></ul>
<p><strong>9. สแกนหน้าออกงาน ผ่านแอปพลิเคชั่น EMPEO</strong></p>
<p><strong>10. ฝากเงินสดเข้าบัญชีบริษัท และแนบหลักฐานการโอนใน Lark</strong></p>
<figure><img src="/sop/open-close-counter/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>✈️ สำหรับเคาน์เตอร์ในสนามบิน (AIRPORT)</p>
<h3>🟢 ขั้นตอนการเปิดเคาน์เตอร์</h3>
<p><strong>1. สแกนหน้าเข้างาน ผ่านแอปพลิเคชั่น EMPEO</strong></p>
<p><strong>2. ตรวจสอบความเรียบร้อยของเคาน์เตอร์</strong></p>
<ul><li>ตรวจดูวัตถุต้องสงสัยหรือความผิดปกติภายใน และบริเวณรอบเคาน์เตอร์</li></ul>
<p><strong>3. ทำความสะอาดเคาน์เตอร์บริการตามรอบที่กำหนด (เช้า , เย็น และระหว่างวัน)</strong></p>
<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ (จอมอนิเตอร์ / Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบ</li></ul>
<p>สกปรก)</p>
<ul><li>กวาด และถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li></ul>
<p><strong>4. ถ่ายรูปเคาน์เตอร์ สำหรับ Check- in ผ่าน Lark OPEN Counter Checklist</strong></p>
<p><strong>5. ตรวจสอบ Stock KKDAY ทั้ง 3 กะ ที่เข้างาน (สำหรับสนามบินสุวรรณภูมิ และดอนเมือง) และส่งรายงานตาม</strong></p>
<p>ช่องทางดังนี้</p>
<ul><li>Lark กลุ่ม</li></ul>
<figure><img src="/sop/open-close-counter/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/open-close-counter/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/open-close-counter/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>6. เตรียมพร้อมให้บริการลูกค้า</strong></p>
<ul><li>ตรวจสอบการแต่งกาย และการแต่งหน้า แขวนบัตรพนักงาให้เรียบร้อย พร้อมให้บริการ</li></ul>
<p>หมายเหตุ : เพื่อให้พนักงานพร้อมให้บริการตามเวลาเปิดบริการ ควรมาถึงพื้นที่เพื่อเช็คอิน และรับมอบงาน เพื่อส่งต่อ รอบ ก่อนเวลาทำการ 15 นาที</p>
<h3>🔴 ขั้นตอนการปิดเคาน์เตอร์</h3>
<p><strong>1. ตรวจสอบสัมภาระตกค้าง</strong></p>
<ul><li>กรณีมีสัมภาระตกค้าง สำหรับสาขาที่ปิดบริการทุกวัน (สาขาห้าง ฯ และ สนามบินภูเก็ตทั้ง 2 สาขา , สาขา</li></ul>
<p>สนามบินเชียงใหม่) ให้ดำเนินการดังนี้ อย่างเคร่งครัด</p>
<ul><li>มีกระเป๋าที่ลูกค้ายังไม่มารับ ให้แจ้ง CS เพื่อติดต่อลูกค้า (กรณีนอกเวลางาน CS ให้แจ้งในกลุ่ม Lark สาขา</li></ul>
<p>เพื่อประสานงาน)</p>
<ul><li>ให้แจ้งในกลุ่ม Lark สาขา กรณีประสานงาน CS และ ติดต่อลูกค้าแล้ว แต่ยังไม่มารับ (กรณีไม่มีการตอบกลับ</li></ul>
<p>ข้อความภายใน 15 นาที ให้โทรศัพท์หา OP Team Lead เพื่อประสานงานส่วนที่เกี่ยวข้อง)</p>
<ul><li>ห้ามพนักงานออกจากพื้นที่ก่อนได้รับการยืนยันจาก OP Team Lead เพื่อป้องกันความเสียหาย กรณีลูกค้า</li></ul>
<p>มีไฟล์ทบิน และจำเป็นต้องรับกระเป๋าภายในคืนนั้น</p>
<ul><li>สำหรับสาขาที่เปิดบริการ 24 ชม. หากมีการเปลี่ยนกะพนักงาน ให้ส่งต่อข้อมูลงาน และข้อมูลลูกค้ากันให้</li></ul>
<p>เรียบร้อย กรณีเกิดปัญหา จะได้ตรวจสอบ และแก้ไขปัญหาได้ทันท่วงที</p>
<p><strong>2. นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</strong></p>
<figure><img src="/sop/open-close-counter/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. ทำความสะอาดเคาน์เตอร์</strong></p>
<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ (จอมอนิเตอร์ / Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบ</li></ul>
<p>สกปรก)</p>
<ul><li>กวาด และถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li><li>ทิ้งขยะ</li></ul>
<p><strong>4. ตรวจสอบอุปกรณ์ต่างๆหากมีชำรุดเสียหายให้แจ้งซ่อม</strong></p>
<ul><li>ช่องทางการแจ้งซ่อม AIMS Help Center</li></ul>
<p><strong>5. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-out ผ่าน Lark CLOSE Counter Checklist</strong></p>
<p><strong>6. สแกนหน้าออกงาน ผ่านแอปพลิเคชั่น EMPEO</strong></p>
<p><strong>7. ฝากเงินสดเข้าบัญชีบริษัท และแนบหลักฐานการโอนใน Lark Daily Sales Report</strong></p>
<figure><img src="/sop/open-close-counter/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgdvb7YjwI4wYLyl1EglMMtb" target="_blank" rel="noopener">7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-in ผ่าน Lark OPEN Counter Checklist</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgoiPdpbc2c8p7CnKE5JFiqo" target="_blank" rel="noopener">8. เช็คสต๊อคสินค้าและของใช้ทุกวันอาทิตย์  UPDATE STOCK</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlg66DrQmhPvml9oPAUtJEijf" target="_blank" rel="noopener">2. นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/docx/RqegdFpV7o6g6mxNaHdlhJY9gbd" target="_blank" rel="noopener">ช่องทางการแจ้งซ่อม</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgQRdC8dnKvx5BDfsaFe3nIf" target="_blank" rel="noopener">7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-out ผ่าน Lark   CLOSE Counter Checklist</a></li></ul>' where slug = 'open-close-counter';

-- ===== ILLUSTRATED: yoowifi-service (7 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 013/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 4 สิงหาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>📌 วัตถุประสงค์ / Purpose</h3>
<p>เพื่อให้พนักงานหน้าสาขา AIRPORTELs ให้บริการลูกค้า YOOWIFI ได้อย่างมีมาตรฐาน ถูกต้อง และป้องกันความ ผิดพลาดในการส่งมอบอุปกรณ์</p>
<h3>📌 ขอบเขตการใช้งาน / Scope</h3>
<p>ใช้สำหรับพนักงาน Guest Service ประจำสาขาของ AIRPORTELs ที่ให้บริการรับ–ส่งอุปกรณ์ YOOWIFI แก่ ลูกค้า ณ จุดให้บริการสนามบินหรือจุดให้บริการอื่นที่ได้รับมอบหมาย</p>
<ul><li>กรณีที่ลูกค้า: ทำการจองอุปกรณ์ YOOWIFI ล่วงหน้า และมารับอุปกรณ์ที่จุดให้บริการ /ส่งคืนอุปกรณ์หลังใช้</li></ul>
<p>งานเสร็จสิ้น</p>
<ul><li>ขั้นการให้บริการครอบคลุม ตั้งแต่ขั้นตอนการแจ้งข้อมูลลูกค้า จนถึงการรับ - ส่งคืนอุปกรณ์</li></ul>
<h3>🔁 ขั้นตอนการปฏิบัติ / Procedure</h3>
<p><strong>1. รับแจ้งข้อมูลลูกค้า</strong></p>
<ul><li>ผู้แจ้ง: ทีม YOOWIFI / คุณเมจิ</li><li>ช่องทาง: LINE กลุ่ม</li><li>รายละเอียดการแจ้ง ดังนี้</li><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Passport no.</li><li>Booking no.</li><li>จำนวนเครื่อง (Quantity)</li><li>จุดรับ - คืนเครื่อง (Pick-up point)</li><li>วันที่-เวลารับเครื่อง (Pick-up &amp; Return Date)</li><li>IMEA no. &amp; Password (ถ้ามี)</li><li>รายละเอียดอื่นๆ (ถ้ามี)</li><li>แนบลิ้งค์ Google Sheet สำหรับตรวจสอบข้อมูล (รวมกับใน LINE Group) : เพื่อป้องกันข้อมูลตกหล่น หรือ</li></ul>
<p>แจ้งลำดับการอัพเดตข้อมูล https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxcFAv PWY/edit?gid=0#gid=0</p>
<figure><img src="/sop/yoowifi-service/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/yoowifi-service/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง : การแจ้งข้อมูลใน Line Group</p>
<p><strong>2. พนักงาน Guest Service ตรวจสอบข้อมูลใน Google Sheet</strong></p>
<ul><li>เข้าลิงก์เอกสาร Google Sheet ที่แจ้งในไลน์</li><li>ตรวจสอบข้อมูลลูกค้า ได้แก่:</li><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Passport no.</li><li>Booking no.</li><li>จำนวนเครื่อง (Quantity)</li><li>IMEI no. ให้ตรงกับเครื่องที่จะเตรียม</li></ul>
<p><strong>3. เตรียมอุปกรณ์ให้พร้อมสำหรับให้บริการ</strong></p>
<ul><li>ชาร์จแบตเตอรี่อุปกรณ์ให้เต็ม</li><li>ตรวจสอบความเรียบร้อย และความครบถ้วนของอุปกรณ์:</li><li>ตัวเครื่อง WiFi</li><li>สายชาร์จ</li><li>ซองใส่</li><li>เขียน หรือพิมพ์ข้อมูลติดหน้าเครื่อง ให้มีรายละเอียด ดังนี้</li><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Booking no.</li><li>Passport no.</li><li>พาสเวิร์ด WiFi (ถ้ามี)</li></ul>
<figure><img src="/sop/yoowifi-service/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง: การจัดเตรียมอุปกรณ์ และปริีนท์ ข้อมูลลูกค้า</p>
<p><strong>4. ส่งมอบอุปกรณ์ให้ลูกค้า</strong></p>
<ul><li>ขั้นตอนการยืนยันตัวตน:</li><li>a. ขอให้ลูกค้าแสดง Booking No. หรือหน้าจอการจอง (Reservation Confirmation)</li></ul>
<figure><img src="/sop/yoowifi-service/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง: ข้อมูลการจองจากลูกค้า แสดงแก่เจ้าหน้าที่ Guest Service เมื่อมารับเครื่อง</p>
<ul><li>b. ถ้าลูกค้าไม่มี Booking No. ให้สอบถามชื่อ-นามสกุลเพื่อค้นหาข้อมูลใน Google sheet</li></ul>
<p>https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxc FAvPWY/edit?gid=0#gid=0</p>
<ul><li>c. ตรวจสอบพาสปอร์ตลูกค้า</li><li>d. ข้อมูลลูกค้าที่มารับเครื่องฯต้องตรงกับชื่อที่แสดงใน LINE Group/Booking no. /Google sheet ที่ทาง</li></ul>
<p>คุณเมจิ แจ้ง</p>
<ul><li>e. เมื่อยืนยันข้อมูลถูกต้อง ตรงกันแล้ว ให้ถ่ายรูปเพื่อแจ้งใน LINE Group :</li><li>ตัวเครื่อง WiFi ที่จะส่งมอบ (ให้เห็น IMEI no. ชัดเจน)</li><li>หน้าพาสปอร์ตของลูกค้า (เฉพาะหน้าแสดงชื่อ-รูปถ่าย)</li><li>ส่งภาพทั้งหมดเข้าใน LINE Group เพื่อยืนยันการส่งมอบ</li></ul>
<figure><img src="/sop/yoowifi-service/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง: การถ่ายรูป และแจ้งข้อมูลใน LINE Group</p>
<ul><li>f. กรณีลูกค้าไม่ได้มารับด้วยตนเอง หรือให้ผู้อื่นมารับแทน จะมีการแจ้งข้อมูลล่วงหน้าจากคุณเมจิ ใน LINE</li></ul>
<p>Group ดังนี้</p>
<figure><img src="/sop/yoowifi-service/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง: การแจ้งข้อมูลกรณีให็ผู้อื่นมารับแทนใน LINE Group</p>
<ul><li>g. กรณีลูกค้าให้ผู้อื่นมารับแทน และไม่มีการแจ้งล่วงหน้าจากคุณเมจิ : ให้สอบถามเข้าไปใน LINE Group เพื่อ</li></ul>
<p>ตรวจสอบก่อน ทำการจัดเตรียมอุปกรณ์ และส่งมอบ โดยแจ้งลูกค้าดังนี้</p>
<ul><li>แจ้งให้ลูกค้ารอสักครู่ เพื่อตรวจสอบข้อมูล</li><li>แจ้งระยะเวลาจัดเตรียมอุปกรณ์ (กรณีมีอุปกรณ์อยู่ที่สาขา และข้อมูลตกหล่นจากทางคุณเมจิ)</li><li>ส่งมอบอุปกรณ์ตามขั้นตอนการส่งมอบ และแจ้งข้อมูลลูกค้า พร้อมรูปภาพใน LINE Group</li></ul>
<p><strong>5. การรับคืนอุปกรณ์ (หากลูกค้ามาคืนที่สาขา)</strong></p>
<ul><li>ตรวจสอบสภาพเครื่องภายนอก และความครบถ้วนของอุปกรณ์</li><li>ถ่ายภาพตัวเครื่อง WiFi ที่จะรับคืน(ให้เห็น IMEI no. ชัดเจน)</li><li>หน้าพาสปอร์ตของลูกค้า (เฉพาะหน้าแสดงชื่อ-รูปถ่าย)</li><li>ส่งภาพทั้งหมดเข้าใน LINE Group เพื่อยืนยันการรับคืน เพื่อแจ้งการคืนทันที</li></ul>
<figure><img src="/sop/yoowifi-service/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่าง: การถ่ายรูป และแจ้งข้อมูลใน LINE Group ✅ Checklist สำหรับพนักงาน (ส่งมอบเครื่อง)</p>
<ul><li>ตรวจสอบข้อมูลใน LINE Group และ Google Sheet</li><li>เตรียมเครื่องครบ / แบตเต็ม</li><li>ลูกค้าแสดง Booking No. หรือหน้าการจอง</li><li>ตรวจสอบพาสปอร์ตให้ข้อมูลถูกต้อง ตรงกับที่คุณเมจิ แจ้ง</li><li>ถ่ายภาพเครื่อง + พาสปอร์ต</li><li>ส่งภาพยืนยันใน LINE กลุ่ม</li></ul>
<p>⚠️ ข้อควรระวัง</p>
<ul><li>ห้าม ส่งมอบอุปกรณ์หากไม่สามารถยืนยันตัวตนลูกค้าได้ (ข้อมูลในพาสปอร์ตไม่ตรงกับที่แจ้ง)</li><li>ห้ามลืม ถ่ายภาพทุกครั้งที่มีการมอบหรือรับคืนอุปกรณ์</li><li>ตรวจสอบพาสเวิร์ด (ถ้ามี)และอุปกรณ์ทุกชิ้นก่อนมอบให้ลูกค้า</li></ul>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxcFAvPWY/edit?gid=0#gid=0" target="_blank" rel="noopener">https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxcFAv</a></li></ul>' where slug = 'yoowifi-service';

-- ===== ILLUSTRATED: edc-machine (18 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0017/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 3 ตุลาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดขั้นตอนการใช้งานเครื่อง EDC สำหรับการรับชำระเงินด้วยบัตรเครดิต, Thai QR Payment, Alipay, WeChat และการพิมพ์รายงานสรุปยอดประจำวัน ให้เป็นมาตรฐานเดียวกันในทุกสาขา ลดความผิดพลาดและเพิ่ม ประสิทธิภาพในการให้บริการลูกค้า</p>
<h3>ขอบเขต (Scope)</h3>
<p>คู่มือการปฏิบัติงานนี้ครอบคลุมถึง</p>
<ul><li>พนักงานสาขาที่มีหน้าที่รับชำระเงิน</li><li>การรับชำระเงินผ่านเครื่อง EDC ทุกประเภท (Credit Card / QR / e-Wallet / e-payment)</li><li>การจัดการสลิป การยกเลิกรายการ และการสรุปยอดประจำวัน</li></ul>
<h3>ขั้นตอนการปฏิบัติ (Procedure)</h3>
<p><strong>1. การเตรียมเครื่อง EDC</strong></p>
<ul><li>ตรวจสอบว่าเครื่อง EDC ชาร์จไฟเพียงพอ หรือเชื่อมต่อกับแหล่งจ่ายไฟ</li><li>ตรวจสอบสัญญาณ GPRS/Wi-Fi ให้พร้อมใช้งาน</li></ul>
<p>💳 NOTE: กรณีเครือง EDCไม่จับสัญญาณGPRS,เครืองEDCทํารายการไม่ได้ , เครืองค้าง , หน้าจอค้าง , ให้ทําการ Restart เครือง EDC</p>
<p><strong>2. การใส่ม้วนสลิป</strong></p>
<ul><li>เปิดฝาช่องใส่ม้วนกระดาษ</li><li>ใส่ม้วนสลิปโดยให้ด้านกระดาษออกทางด้านบน</li><li>ปิดฝาเครื่อง และดึงกระดาษออกมาเล็กน้อยเพื่อทดสอบ</li></ul>
<figure><img src="/sop/edc-machine/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ดึงฝาครอบม้วนสลิปขึ้น เพื่อนำแกน กระดาษสลิปของเดิมออก</p>
<figure><img src="/sop/edc-machine/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ใส่ม้วนกระดาษสลิปใหม่ลงไป พร้อมดึงปลายกระดาษ ออกมาเล็กน้อย แล้วจึงปิดฝาครอบให้สนิทตามเดิม</p>
<p><strong>3. การรับชำระเงินด้วย QR Payment / Alipay / WeChat</strong></p>
<ul><li>กดปุ่มเลือกโหมด QR Payment</li><li>ใส่จำนวนเงินที่ต้องการรับ</li><li>ให้ลูกค้าสแกน QR จากหน้าจอเครื่อง</li><li>รอการยืนยัน → หากสำเร็จ เครื่องจะพิมพ์สลิปอัตโนมัติ</li></ul>
<p>💳NOTE: หากยอดเงินไม่เข้าหรือลูกค้ายังไม่ทํายืนยันการโอนสลิปจะไม่ออกจากตัวเครืองหากต้องการ สแกนจ่ายใหม่ให้กดยกเลิกและกดชําระด้วย QR ใหม</p>
<figure><img src="/sop/edc-machine/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>1. กด OK ที่เครื่อง EDC</strong></p>
<figure><img src="/sop/edc-machine/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>2. หน้าจอแสดงให้เลือกประเภทที่ ต้องการ</p>
<figure><img src="/sop/edc-machine/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. กดจำนวนเงินที่ต้องการชำระ</strong></p>
<figure><img src="/sop/edc-machine/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>4. เครื่อง EDC จะขึ้น QR</strong></p>
<p>ให้ลูกค้าสแกน</p>
<figure><img src="/sop/edc-machine/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>5. เมื่อลูกค้าโอนยอดสำเร็จ แล้ว กดยืนยันจะมีใบเสร็จออกมา จากตัวเครื่อง</p>
<figure><img src="/sop/edc-machine/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>6. ฉีกสลิปให้ลูกค้า</strong></p>
<figure><img src="/sop/edc-machine/fig9.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>7. พนักงานเก็บสลิปไว้เป็นหลักฐาน</strong></p>
<figure><img src="/sop/edc-machine/fig10.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>8. ตัวอย่างหน้าจอสลิปการโอนจากลูกค้า</strong></p>
<p><strong>4. การรับชำระเงินด้วยบัตรเครดิต</strong></p>
<ul><li>ใส่จำนวนเงินที่ต้องการรับ</li><li>เสียบ/รูด/แตะบัตรเครดิต ตามที่ระบบรองรับ</li><li>หากต้องใส่รหัส PIN → ให้ลูกค้ากรอกด้วยตนเอง</li><li>เครื่องพิมพ์สลิปออกมา → ตรวจสอบความถูกต้อง</li><li>คืนบัตรและมอบสลิปให้ลูกค้า</li></ul>
<p><strong>1. หน้าจอเครื่องปกติ</strong></p>
<p>2. ใส่จำนวนที่ลูกค้าต้องการชำระ ในรูปแบบทศนิยม 2 หลักแล้ว กด OK</p>
<p><strong>3. สอด รูด หรือแตะบัตร</strong></p>
<p><strong>4. ตรวจสอบหมายเลขบัตร</strong></p>
<p>และยอดเงิน 5. เครื่องจะพิมพ์ Sales Slip สำหรับร้านค้า</p>
<p><strong>6. เครื่องจะพิมพ์ Sales Slip</strong></p>
<p>สำหรับผู้ถือบัตร ฉีกให้ผู้ถือบัตรเซ็นต์รับรอง และร้าน ค้าเก็บไว้เป็นหลักฐาน ส่งมอบให้ผู้ถือบัตรเก็บไว้เป็นหลัก ฐาน</p>
<p><strong>5. การยกเลิกรายการ (Void Transaction)</strong></p>
<ul><li>กดเลือกเมนู ยกเลิกรายการ (Void)</li><li>ใส่หมายเลขอ้างอิงของรายการที่ต้องการยกเลิก</li><li>ยืนยันการทำรายการ → เครื่องพิมพ์สลิปยกเลิก</li></ul>
<p>💳NOTE : ห้ามคืนเงินสด (เงินทอน) ให้แก่ลูกค้าโดนเด็ดขาด กรณีกดยอดชำระผิด ให้ทำการยกเลิกราย (Void)ผ่านเครื่อง EDC และทำรายการใหม่ ให้ถูกต้อง พร้อมส่งสลิป ทั้งที่ VIOD และ สลิปตัวจริง (ที่ถูก ต้อง แม็กให้ลูกค้า) และพนักงานถ่ายภาพสลิปแนบใน Sales Report ท้ายตารางหลังหมายเหตุ</p>
<p><strong>1. กด F2 เลือก VOID</strong></p>
<p><strong>2. กรอกรหัสผ่าน 1111</strong></p>
<p>กด OK 3. กรอกหมายเลข TRACE # กด OK</p>
<p><strong>4. กด OK ยืนยัน</strong></p>
<p><strong>5. กำลังทำรายการ</strong></p>
<p><strong>6. รายการอนุมัติ</strong></p>
<p><strong>7. พิมพ์สลิปให้ลูกค้า</strong></p>
<p>กด OK</p>
<p><strong>8. เครื่องพิมพ์สลิป</strong></p>
<p><strong>6. การสรุปยอดประจำวัน (Settlement)</strong></p>
<ul><li>กดเลือกเมนู สรุปยอด (Settlement)</li><li>รอเครื่องประมวลผล</li><li>เครื่องพิมพ์สรุปยอดออกมา</li><li>ตรวจสอบยอดรวม และเก็บสลิปสรุปไว้เป็นหลักฐาน</li><li>ฉีกสลิปที่ออกมาแต่ละรายการ เช็คยอดเงินว่าครบแล้วจึงนำมาเย็บเข้ากับสลิปรวมทั้งหมด</li></ul>
<figure><img src="/sop/edc-machine/fig11.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/edc-machine/fig12.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. กรอกรหัสผ่าน 1111 กด OK</strong></p>
<p><strong>1. กด F1 เลือก "โอนยอดเงิน"</strong></p>
<figure><img src="/sop/edc-machine/fig13.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>2. กด 2 เลือก โอนยอดทั้งหมด</strong></p>
<figure><img src="/sop/edc-machine/fig14.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>4. กด OK ยืนยัน</strong></p>
<figure><img src="/sop/edc-machine/fig15.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>5. กำลังทำรายการ</strong></p>
<figure><img src="/sop/edc-machine/fig16.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>6. ทำรายการโอนยอดสำเร็จ</strong></p>
<p><strong>7. วิธีการ พิมพ์ซ้ำ สรุปยอด</strong></p>
<ul><li>การพิมพ์รายงานย้อนหลัง</li><li>กดเลือกเมนู พิมพ์ซ้ำ / รายงาน</li><li>เลือกประเภทที่ต้องการ (เช่น สรุปยอดย้อนหลัง)</li><li>เครื่องจะพิมพ์เอกสารออกมา</li></ul>
<p>1. กด F4 เลือก “REPRINT” 2. กด 3 เลือก “โอน ยอดล่าสุด”</p>
<p><strong>3. เลือกรายการ</strong></p>
<p>4. เครื่องพิมพ์สลิป “โอนยอดล่าสุด” การแก้ไขปัญหาพื้นฐาน (Troubleshooting)</p>
<ul><li>เครื่องไม่มีสัญญาณ / ค้าง → Restart เครื่อง</li><li>สลิปไม่ออก → ตรวจสอบม้วนกระดาษ</li><li>QR ไม่ขึ้นยอด → กด “ยกเลิก” และทำรายการใหม่</li></ul>
<p>วิธีการ ตรวจสอบรายการจาก e-Slip ของผู้ชำระ</p>
<figure><img src="/sop/edc-machine/fig17.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>Response/Error Code ที่พบบ่อย และแนวทางแก้ไข</p>
<figure><img src="/sop/edc-machine/fig18.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = 'edc-machine';

-- ===== ILLUSTRATED: online-credit-card-payment (8 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 007/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดขั้นตอนที่เป็นมาตรฐานในการเรียกเก็บเงินจากลูกค้าผ่านบัตรเครดิตแบบออนไลน์ โดยใช้ระบบหลังบ้าน ของ AIRPORTELs เพื่อให้การรับชำระเป็นไปอย่างถูกต้อง ตรวจสอบได้ และลดข้อผิดพลาด To standardize the steps for requesting online credit card payments via AIRPORTELs'' back- office system, ensuring accuracy and traceability.</p>
<h3>ขอบเขต (Scope)</h3>
<p>ใช้สำหรับพนักงานที่ปฏิบัติงานในสาขา หรือตำแหน่งที่เกี่ยวข้องกับการเรียกเก็บเงินจากลูกค้าในกรณีต้องชำระผ่าน ช่องทางออนไลน์ Applicable to branch staff or related roles responsible for collecting customer payments via online channels.</p>
<h3>ขั้นตอนการดำเนินงาน (Procedure)</h3>
<ul><li>สำหรับใช้รับชำระผ่านระบบ Online กรณีเครื่อง EDC หน้าสาขามีปัญหา ไม่สามารถใช้งานได้</li><li>🔗 ลิงก์เข้าสู่ระบบหลังบ้าน:</li></ul>
<p>https://postels.airportels.asia/admin/order/browse</p>
<figure><img src="/sop/online-credit-card-payment/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>วิธีการดำเนินการตามตัวอย่างดังนี้</p>
<p><strong>1. ค้นหาออเดอร์ที่หลังบ้าน Airportles</strong></p>
<p><strong>2. กด Request Payment</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. ใส่จำนวนเงิน และกด Generate Link</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>4. ลิงค์ช่องทางการจ่ายเงินจะขึ้น</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>5. Copy link เพื่อไปสร้าง QR Code</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/online-credit-card-payment/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>6. หลังจากนั้นให้ลูกค้าสแกนจ่ายเครดิตการ์ดแบบ Online</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>7. เสร็จเรียบร้อย หลังจากนั้นหลังบ้านจะขึ้นประวัติการชำระอัตโนมัติ</strong></p>
<figure><img src="/sop/online-credit-card-payment/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>หมายเหตุ : หากยังไม่ขึ้นประวัติการชำระ ให้รีบติดต่อหัวหน้าทันที</p>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://postels.airportels.asia/admin/order/browse" target="_blank" rel="noopener">เว็บไซต์ AIRPORTELs</a></li></ul>' where slug = 'online-credit-card-payment';

-- ===== ILLUSTRATED: cashless-payment-policy (6 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 002<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 16 มิถุนายน 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><ul><li>รับชำระเงินสดที่ต่ำกว่า หรือเท่ากับ 100 บาท สำหรับทุกสาขา</li><li>รับชำระเงินสดที่ยอดต่ำกว่า หรือเท่ากับ 150 บาท ขึ้นไป สำหรับสาขาสนามบินภูเก็ต (International &amp;</li></ul>
<p>Domestic)</p>
<h3>🔹 วัตถุประสงค์ / Purpose</h3>
<p>To ensure clear communication and consistent service when enforcing the cashless payment policy. เพื่อให้พนักงานสามารถสื่อสารกับลูกค้าได้อย่างถูกต้องและมีมาตรฐานเดียวกันในการให้บริการช่วงเปลี่ยนผ่านไปสู่ ระบบไร้เงินสด</p>
<h3>🔹 ขอบเขต / Scope</h3>
<p>Applicable at all AIRPORTELs counters for all services including luggage storage and delivery. ใช้สำหรับเคาน์เตอร์บริการของ AIRPORTELs ทุกสาขา ทั้งบริการรับฝากและจัดส่งกระเป๋า</p>
<h3>🔹 ขั้นตอนการปฏิบัติงาน /Procedures</h3>
<figure><img src="/sop/cashless-payment-policy/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>🔹 หมายเหตุเพิ่มเติม / Additional Notes</p>
<ul><li>Display the “We''re Going Cashless” poster clearly at the counter.</li></ul>
<p>ติดโปสเตอร์ “We''re Going Cashless” ให้เห็นชัดเจนหน้าสาขา</p>
<ul><li>Staff must not request cash for amounts ≥100 THB.</li></ul>
<p>ห้ามเรียกรับเงินสดหากยอดเท่ากับหรือมากกว่า 100 บาท</p>
<ul><li>If customer insists on paying cash, politely explain the policy.</li></ul>
<p>หากลูกค้าต้องการจ่ายเงินสด ให้ชี้แจงด้วยความสุภาพว่าเป็นนโยบายใหม่ของบริษัท 🔹 การจัดการกรณีพิเศษ / Emergency or Exception Handling</p>
<figure><img src="/sop/cashless-payment-policy/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>🔶 แนวทางการดำเนินการแบบเป็นขั้นตอน</p>
<h3>(Step-by-Step Handling Process)</h3>
<figure><img src="/sop/cashless-payment-policy/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>🗨️ Script สำหรับพนักงานบริการลูกค้า (2 ภาษา) 🎯 กรณีทั่วไปที่ลูกค้าปฏิเสธ Cashless: ไทย: “ต้องขออภัยค่ะ ตอนนี้ทางบริษัทเราดำเนินการเปลี่ยนเป็นระบบชำระเงินแบบไร้เงินสด สำหรับยอด 150 บาทขึ้น ไปค่ะ ท่านสามารถชำระผ่านบัตรเครดิต เดบิต หรือ QR พร้อมเพย์ได้เลยค่ะ ไม่มีค่าธรรมเนียมเพิ่มเติมนะคะ 😊 หาก คุณไม่สะดวกตรงไหน ทางเรายินดีช่วยแนะนำวิธีที่สะดวกที่สุดค่ะ” English: “I’m sorry, but for payments of 150 THB or more, we now accept only cashless methods. You can pay by credit card, debit card, or QR code, and there’s no extra fee. If you need help, I’d be happy to assist you with the process 😊.” 🌏 กรณีลูกค้าต่างชาติอยากใช้เงินสดที่แลกมาให้หมด: ไทย: “เข้าใจเลยค่ะว่าลูกค้าอยากใช้เงินสดที่แลกมาให้หมดนะคะ 😊 อย่างไรก็ตาม เนื่องจากนโยบายใหม่ของบริษัท สำหรับยอด 100 บาทขึ้นไป จะรับเฉพาะช่องทางไร้เงินสดค่ะ เราสามารถแนะนำวิธีที่ง่าย เช่น สแกน QR ด้วยมือถือ หรือใช้บัตรเครดิตได้เลยค่ะ หากต้องการเราช่วยแนะนำได้นะคะ” English: “I totally understand that you’d like to use up your Thai currency 😊 However, due to our new policy, we only accept cashless payment for amounts over 100 THB. We can help you pay via QR code or card. Please tell us if you need any help! .”</p>
<p><strong>1. กำหนดมาตรการรองรับ – กรณีไม่สามารถชำระแบบ Cashless ได้</strong></p>
<p>(เช่น ระบบล่ม / เครื่องรูดบัตรเสีย / ลูกค้าไม่มีอุปกรณ์ / ไม่มีแอปธนาคารไทย ฯลฯ) ✅ แนวทางสำรอง</p>
<figure><img src="/sop/cashless-payment-policy/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>🟨 2. มาตรการกรณีลูกค้าปฏิเสธชำระแบบ Cashless (Cashless Policy Exception Guideline)</p>
<figure><img src="/sop/cashless-payment-policy/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>🟨 3. นโยบาย (Policy Summary) ชื่อ: Cashless Enforcement &amp; Exception Policy ใช้บังคับ: พนักงานทุกคนที่หน้าสาขา 🔸 หลักเกณฑ์:</p>
<ul><li>ยอดชำระ 100 บาทขึ้นไป ต้องใช้ช่องทางไร้เงินสดเท่านั้น</li><li>ไม่สามารถขอรับเงินสดได้ ยกเว้นในกรณี:</li><li>ระบบล่ม</li><li>ลูกค้าไม่มีช่องทางอื่น และได้รับอนุมัติจากหัวหน้า</li><li>กรณีลูกค้าต่างชาติที่ไม่สามารถดำเนินการผ่านระบบไทยได้จริง</li></ul>
<p>🟨 4. แบบฟอร์มบันทึกเคสกรณียกเว้น (Exception Handling Form) ใช้บันทึกทุกครั้งที่ต้อง “อนุโลม” การรับเงินสดในระบบ Cashless ในช่อง Remark "หมายเหตุ" ใน Sales Report ตามตัวอย่าง และต้องแจ้งผู้จัดการสาขา (สำหรับสาขาที่มีผู้จัดการ) หรือ Guest Service Excutive (นิว) / Guest Service Assistant (มายด์ หรือ เน) ทุกครั้ง</p>
<figure><img src="/sop/cashless-payment-policy/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>SOP ที่เกี่ยวข้อง : SOP: ขั้นตอนการชำระเงินด้วยบัตรเครดิตแบบออนไลน์</p>' where slug = 'cashless-payment-policy';

-- ===== ILLUSTRATED: inventory-stock-update (4 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 006/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อควบคุมและติดตามปริมาณสต๊อกของใช้ประจำสาขาให้มีความถูกต้อง ป้องกันของขาด และสนับสนุนการวางแผน จัดส่งสินค้าได้อย่างมีประสิทธิภาพ</p>
<h3>ขอบเขต (Scope)</h3>
<p>SOP นี้สำหรับพนักงานตำแหน่ง Guest Service / Branch Manager / Porter ทุกคนที่ปฏิบัติงานหน้าสาขา และ ครอบคลุมขั้นตอนการการดำเนินการดังนี้:</p>
<ul><li>ตรวจเช็กสต๊อกประจำสัปดาห์</li><li>การอัปเดตข้อมูลลงในระบบ</li><li>การจัดเตรียมและจัดส่งของเข้าแต่ละสาขา</li><li>การรับของและกดรับในระบบโดยพนักงานสาขา</li><li>การจัดส่งน้ำดื่มประจำเดือน</li></ul>
<h3>ขั้นตอนการดำเนินงาน (Step by Step Process)</h3>
<p><strong>1. การอัปเดตสต๊อกประจำสัปดาห์</strong></p>
<figure><img src="/sop/inventory-stock-update/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>2. การเบิกและจัดส่งของให้สาขา</strong></p>
<figure><img src="/sop/inventory-stock-update/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>3. การรับของเข้าสต๊อกโดยพนักงานสาขา</strong></p>
<figure><img src="/sop/inventory-stock-update/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p><strong>4. การจัดส่งน้ำดื่มประจำเดือน</strong></p>
<figure><img src="/sop/inventory-stock-update/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>หมายเหตุเพิ่มเติม</p>
<ul><li>หากพบปัญหาในการใช้งานระบบ หรือยอดคำนวณไม่ถูกต้อง ต้องแจ้งมายด์ทันที ห้าม Update Stock แบบผิด</li></ul>
<p>มาเด็ดขาด</p>
<ul><li>พนักงานต้องเช็คจำนวนของจริงทุกครั้งก่อน Update Stock และอัพเดทให้ตรงเวลาตามรอบ เพื่อไม่ให้การจัด</li></ul>
<p>ส่งล่าช้า</p>
<ul><li>หากได้รับของแล้ว พนักงานต้องกดรับของทันที ห้าม Update Stock ก่อนกดรับของเด็ดขาด เพราะจะทำให้</li></ul>
<p>ยอดติดลบ</p>
<ul><li>หากได้รับจำนวนของที่ส่งไปไม่ถูกต้อง ขาด/เกิน ให้ใส่จำนวนจริงที่ได้รับ เช่น ส่งทิชชู่ไปให้ 5 ม้วน แต่ได้รับจริง 4</li></ul>
<p>ม้วน ให้ใส่จำนวนที่ได้รับ 4 ม้วน</p>
<ul><li>หากได้รับของแต่เกิดการชำรุด ให้ใส่จำนวนทั้งหมดที่ได้รับ เช่น ส่งทิชชู่ไปให้ 5 ม้วน แต่เปียกฝน 1 ม้วน ใช้ได้จริง</li></ul>
<p>4 ม้วน ให้ใส่จำนวนที่ได้รับ 5 ม้วน และโน้ตบอกว่า เปียกฝน 1 ม้วน ใช้ได้จริง 4 ม้วน</p>' where slug = 'inventory-stock-update';

-- ===== ILLUSTRATED: luggage-delivery-google-sheet (1 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> WI-OPS : 001/2026<br><strong>เวอร์ชัน:</strong> 01<br><strong>วันที่บังคับใช้:</strong> 19 มกราคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดขั้นตอนมาตรฐานในการปฏิบัติงานของพนักงานหน้าสาขา (Guest Service: GS) และ Customer Service (CS) ในการบันทึกข้อมูลการให้บริการขนส่งกระเป๋า และประสานงานกับทีมขนส่ง (MS) อย่างถูกต้อง ครบ ถ้วน และเป็นมาตรฐานเดียวกันทุกสาขา</p>
<h3>ขอบเขต (Scope)</h3>
<p>ครอบคลุมพนักงาน Guest Service (GS) ทุกสาขา และทีม Customer Service (CS) ที่เกี่ยวข้องกับการบันทึกออ เดอร์บริการขนส่งกระเป๋า ผ่าน Google Sheet: Luggage Delivery Record เพื่อประสานงานกับทีมขนส่ง (MS) ไฟลล์ที่ใช้บันทึกข้อมูล</p>
<ul><li>https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0f</li></ul>
<p>XJE/edit?gid=0#gid=0 การเลือกแท็บบันทึกข้อมูลใน Google Sheet พนักงานต้องเลือกแท็บให้ตรงกับประเภทบริการเท่านั้น</p>
<figure><img src="/sop/luggage-delivery-google-sheet/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>แท็บ Intown</p>
<ul><li>ใช้บันทึกข้อมูลบริการส่ง</li><li>BKK intown</li><li>CNX intown</li><li>HKT intown</li><li>Pattaya (ลงทั้งเส้นทาง Bangkok-Pattaya และ Pattaya-Bangkok)</li></ul>
<p>คอลัมน์ ข้อมูล ตัวอย่าง A ใส่วันที่รับออเดอร์ B เลือกสถานะการจอง (Booking Status) C ใส่วันที่ส่ง (Delivery Date) D ใส่ชื่อลูกค้า (Customer Name) E เลือก service ให้ตรงกับบริการ (Service type) F ใส่จำนวนกระเป๋า (#Bags) G ใส่เลขออเดอร์พาร์ทเนอร์ของลูกค้า (Order no.) H ใส่เลขออเดอร์ของลูกค้า (AI Order No.) I เลือกประเภทการจัดส่ง (Delivery Type) J ใส่ต้นทาง (From) K เลือกเวลารอบรถรับกระเป๋า (Pick up time) L ใส่ปลายทาง (To) M เลือกประเภทกระเป๋า (Luggage Type) N เลือกช่องทางการจอง (Channel) O เลือกเวลาที่จะถึงปลายทาง (ETA) P ใส่เวลาที่ลูกค้ามารับจริง (Pickup Time) Q ใส่เที่ยวบิน (Flight No.) R เลือกสถานะการจัดส่ง (Delivery Status) S ใส่เลข MS ที่จองไว้ (MS order เท่านั้น) T ใส่ Promotion (Promotion) U ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note) แท็บ On Demand</p>
<ul><li>ใช้บันทึกเฉพาะออเดอร์ที่ส่งแบบไม่ตรงตามตารางเวลา</li></ul>
<p>คอลัมน์ ข้อมูล ตัวอย่าง A เลือกสถานะการจอง B ใส่วันที่ส่ง (Delivery Date) C ใส่ชื่อลูกค้า (Customer Name) D ใส่จำนวนกระเป๋า (#Bags) E ใส่เลขออเดอร์ของลูกค้า (Order No.) F เลือกประเภทการจัดส่ง (Delivery Type) G ใส่ต้นทาง (From) H ใส่เวลาลูกค้ามาดรอปกระเป๋า (Drop time) I ใส่ปลายทาง (To) J เลือกเวลาที่จะถึงปลายทาง (ETA) K เลือกประเภทกระเป๋า (Luggage Type) L เลือกช่องทางการจอง (Channel) M ใส่เวลาที่ลูกค้ามารับจริง (Pickup Time) N เลือกสถานะการจัดส่ง (Delivery Status) O ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note) แท็บ Sameday</p>
<ul><li>ใช้บันทึกทุกออเดอร์ที่มีการส่งด้วย Cargo (ส่งข้ามจังหวัดทั้ง sameday และ nextday) ทั้งกระเป๋าเดินทาง/ถุง</li></ul>
<p>กอล์ฟ</p>
<ul><li>ลงควบคู่กับแท็บ Intown</li></ul>
<p>คอลัมน์ ข้อมูล ตัวอย่าง A เลือกเส้นทางการส่ง (Route) B เลือกสถานะการจอง (Booking Status) C ใส่เลข MS ที่จองไว้ (MS order) D ใส่ราคาที่เก็บจากลูกค้า (Price) E ใส่เลขออเดอร์ของลูกค้า (Order ID) F ใส่วันที่ลูกค้ามาดรอปกระเป๋า (Drop Date) G ใส่วันที่ส่งกระเป๋า (Delivery Date) H ใส่ชื่อลูกค้า (Customer Name) I ใส่เบอร์โทรศัพท์ของลูกค้า (Phone No.) J ใส่จำนวนกระเป๋า (#Bags) K ใส่น้ำหนักกระเป๋า (Weight) L เลือกประเภทการจัดส่ง (Delivery Type) M ใส่วันที่คาดการณ์ว่าลูกค้าจะได้รับกระเป๋า ETA (Date) N ใส่ต้นทาง (From) O ใส่ที่อยู่ของต้นทาง (Address) P เลือกจังหวัดของต้นทาง (Province) Q ใส่เวลาที่ลูกค้ามาดรอปกระเป๋า (Drop time) R ใส่ปลายทาง อาจจะเป็นชื่อลูกค้าหรือเคาน์เตอร์ (To) S ใส่ที่อยู่ของปลายทาง (Address) T เลือกจังหวัดของปลายทาง (Province) U เลือกประเภทกระเป๋า (Luggage Type) V เลือกช่องทางการจอง (Channel) W ใส่เบอร์โทรผู้ร้บ (Call confirm) X ใส่ชื่อผู้รับ (Name of hotel staff) Y เลือกสถานะการจัดส่ง (Delivery Status) Z ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note) แท็บ Next day</p>
<ul><li>ใช้บันทึกทุกออเดอร์ที่เป็นการส่งแบบ Within 5 days (ส่งด้วย KEX)</li><li>ลงควบคู่กับแท็บ Intown</li></ul>
<p>คอลัม น์ ข้อมูล ตัวอย่าง A ใส่ลำดับออเดอร์ B เลือกสถานะการจอง (Booking Status) C ใส่เลข MS ที่จองไว้ (MS order) D เลือกสถานะการจองหลังจากจอง KEX เสร็จ (Book Shipsmile) E ใส่ราคาหลังจากจอง KEX เสร็จ (Price sm) F ใส่ราคาที่เก็บจากลูกค้า (Price) G ใส่วันที่ลูกค้ามาดรอปกระเป๋า (Drop Date) H ใส่วันที่ส่งกระเป๋า (Delivery Date) I ใส่ชื่อลูกค้า (Customer Name) J ใส่เบอร์โทรศัพท์ของลูกค้า (Phone No.) K ใส่จำนวนกระเป๋า (#Bags) L เลือกประเภทการจัดส่ง (Delivery Type) M ใส่วันที่คาดการณ์ว่าลูกค้าจะได้รับกระเป๋า ETA (Date) N ใส่ต้นทาง (From) O ใส่ที่อยู่ของต้นทาง (Address) P ใส่จังหวัดของต้นทาง (Province) Q ใส่เวลาที่ลูกค้ามาดรอปกระเป๋า (Drop time) R ใส่ปลายทาง อาจจะเป็นชื่อลูกค้าหรือเคาน์เตอร์ (To) S ใส่ที่อยู่ของปลายทาง (Address) T ใส่จังหวัดของปลายทาง (Province) U ใส่วันที่ลูกค้าได้รับกระเป๋า (Arrived Date) V ใส่น้ำหนักกระเป๋าลูกค้า (Weight) W ใส่ขนาดกระเป๋ากว้าง * ยาว * สูง X เลือกประเภทกระเป๋า (Luggage Type) Y เลือกช่องทางการจอง (Channel) Z ใส่เบอร์โทรผู้ร้บ (Call confirm) AA ใส่ชื่อผู้รับ (Name of hotel staff) AB ใส่ DHL Tracking ปัจจุบันไม่ได้ใช้แล้ว AC ใส่ Orange Tracking AD ใส่ Ninja Tracking ปัจจุบันไม่ได้ใช้แล้ว AE เลือกสถานะการจัดส่ง (Delivery Status) AF ใส่เลขออเดอร์ โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note)</p>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0fXJE/edit?gid=0#gid=0" target="_blank" rel="noopener">https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0f</a></li></ul>' where slug = 'luggage-delivery-google-sheet';

-- ===== ILLUSTRATED: emergency-airport (4 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS-EMS:004/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>📌 วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดแนวทางการปฏิบัติงานสำหรับพนักงานประจำจุดบริการ AIRPORTELs ในพื้นที่สนามบิน ให้สามารถตอบ สนองต่อเหตุฉุกเฉินได้อย่างมีประสิทธิภาพ โดยมีเป้าหมายหลัก ดังนี้:</p>
<ul><li>รักษาความปลอดภัยของพนักงานและลูกค้าเป็นลำดับแรก</li><li>ลดความเสี่ยงและความเสียหายต่อทรัพย์สินของลูกค้าและบริษัทในระหว่างเกิดเหตุ</li><li>ตอบสนองต่อเหตุฉุกเฉินอย่างมีประสิทธิภาพ รวดเร็ว และเป็นระบบ</li><li>ปฏิบัติงานตามมาตรฐานความปลอดภัยของสนามบินทั้งในระดับท้องถิ่นและสากล</li><li>เสริมสร้างความเชื่อมั่นในบริการ และภาพลักษณ์ด้านความปลอดภัยของบริษัท</li></ul>
<h3>📌 ขอบเขต (Scope):</h3>
<p>ใช้สำหรับพนักงานที่ปฏิบัติงานประจำเคาน์เตอร์หรือจุดบริการ AIRPORTELs ในเขตสนามบินทุกแห่ง เมื่อเกิด สถานการณ์ฉุกเฉินที่อาจกระทบต่อความปลอดภัยของบุคคลและทรัพย์สิน การปฏิบัติงานเมื่อเกิดเหตุฉุกเฉิน 💣กรณีที่ 1: พบวัตถุต้องสงสัย / วัตถุอันตราย</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>หยุดการให้บริการทันที</li><li>ห้ามเคลื่อนย้ายวัตถุต้องสงสัย</li><li>แจ้งลูกค้าให้ถอยห่างโดยไม่สร้างความตื่นตระหนก</li><li>แจ้งหน่วยงานที่เกี่ยวข้อง</li><li>โทรแจ้งหน่วยรักษาความปลอดภัยสนามบินทันที</li><li>รายงานหัวหน้า/ผู้จัดการสาขา</li><li>กันพื้นที่</li><li>ห้ามบุคคลอื่นเข้าใกล้วัตถุต้องสงสัย</li><li>หากมีป้ายหรือแถบกั้นความปลอดภัย ใช้ทันที</li><li>ตรวจสอบทรัพย์สิน</li><li>ตรวจสอบกระเป๋าหรือทรัพย์สินของลูกค้าที่ยังอยู่ภายในพื้นที่</li><li>จดบันทึกรายละเอียดของทรัพย์สินที่ยังไม่สามารถเคลื่อนย้ายได้</li><li>อพยพพนักงานและลูกค้า</li><li>ปฏิบัติตามคำแนะนำของเจ้าหน้าที่สนามบินหรือเจ้าหน้าที่รักษาความปลอดภัย</li><li>เดินทางไปยังจุดรวมพลที่กำหนดไว้</li><li>รอคำสั่งเพิ่มเติม</li><li>ห้ามกลับเข้าพื้นที่จนกว่าจะได้รับอนุญาตจากเจ้าหน้าที่</li></ul>
<p>🌍 กรณีที่ 2: แผ่นดินไหว</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>หลบอยู่ในที่ปลอดภัย</li><li>หาที่กำบัง เช่น ใต้โต๊ะที่แข็งแรง หรือยืนชิดเสา</li><li>ป้องกันศีรษะและคอด้วยมือหรือกระเป๋า</li><li>หลังการสั่นสะเทือนหยุด</li><li>ประเมินความเสียหายเบื้องต้น</li><li>หากพื้นที่ไม่ปลอดภัย เช่น มีเพดานหลุด หรือมีควัน ให้ อพยพทันที</li><li>อพยพพนักงานและลูกค้า</li><li>พาทุกคนไปยังจุดรวมพลนอกอาคาร (ตามที่สนามบินกำหนด)</li><li>ห้ามใช้ลิฟต์โดยเด็ดขาด</li><li>แจ้งหัวหน้างาน / ผู้จัดการ</li><li>รายงานสถานการณ์</li><li>แจ้งจำนวนทีมงานที่อพยพออกมา</li><li>ประสานกับสนามบิน</li><li>ปฏิบัติตามคำแนะนำของหน่วยงานความปลอดภัยสนามบิน</li><li>ตรวจสอบทรัพย์สิน</li><li>หลังได้รับอนุญาตให้กลับเข้าพื้นที่ ตรวจสอบทรัพย์สินของลูกค้าว่ายังอยู่ครบถ้วน</li><li>ตรวจสอบทรัพย์สิน และอุปกรณ์ของบริษัทฯ กรณีได้รับความเสียหายให้รายงานกลับสำนักงานใหญ่ เพื่อ</li></ul>
<p>จัดหาอุปกรณ์ทดแทนเร่งด่วน หรือ พิจารณาปิดให้บริการ 🌊กรณีที่ 3: เตือนภัยสึนามิ / น้ำท่วม</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>รับฟังประกาศเตือนภัย</li><li>ติดตามประกาศจากสนามบินและหน่วยงานทางการ</li><li>แจ้งลูกค้า</li><li>อธิบายสถานการณ์โดยสุภาพ</li><li>แนะนำให้ลูกค้าเก็บของมีค่าและเตรียมอพยพ</li><li>กรณีเตรียมอพยพ</li><li>หยุดให้บริการ</li><li>เก็บทรัพย์สินลูกค้าในที่สูง หากมีเวลา</li><li>ล็อคพื้นที่เก็บสัมภาระ</li><li>กรณีต้องอพยพทันที</li><li>ปฏิบัติตามเส้นทางอพยพที่กำหนดโดยสนามบิน</li><li>เดินทางไปยังพื้นที่ปลอดภัยบนที่สูง</li><li>แจ้งผู้จัดการ</li><li>รายงานสถานการณ์และจำนวนผู้ที่อพยพ</li></ul>
<p>🧨กรณีที่ 4: เกิดเหตุก่อการร้าย / แจ้งเหตุวางระเบิด / มีคนใช้อาวุธในพื้นที่สนามบิน</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>หยุดให้บริการทันที</li><li>ปิดเคาน์เตอร์/ล็อกอุปกรณ์</li><li>หยุดรับลูกค้าและแจ้งให้ลูกค้าอยู่ในความสงบ</li><li>ประเมินสถานการณ์เบื้องต้น</li><li>หากได้ยินเสียงระเบิด หรือมีการแจ้งจากสนามบินว่าเกิดเหตุรุนแรง:</li><li>อย่าเข้าใกล้จุดเกิดเหตุ</li><li>ไม่ถ่ายภาพหรือเผยแพร่สถานการณ์ผ่านโซเชียลมีเดีย</li><li>หากเหตุการณ์ยังไม่เกิดแต่มี "การแจ้งเตือนล่วงหน้า" (เช่น มีการโทรขู่วางระเบิด):</li><li>ปฏิบัติตามคำสั่งเจ้าหน้าที่สนามบินทันที</li><li>แจ้งเหตุ</li><li>ติดต่อเจ้าหน้าที่รักษาความปลอดภัยสนามบินหรือเจ้าหน้าที่ตำรวจที่อยู่ใกล้ที่สุด (กรณีเป็นผู้พบเห็น</li></ul>
<p>เหตุการณ์) ◦ รายงานหัวหน้าสาขาหรือผู้จัดการทันทีผ่านช่องทางฉุกเฉิน</p>
<ul><li>อพยพอย่างปลอดภัย</li><li>อพยพตามเส้นทางที่สนามบินกำหนดเท่านั้น</li><li>ไม่ใช้ลิฟต์</li><li>หลีกเลี่ยงบริเวณที่มีผู้คนหนาแน่นหรือเสียงปืน/เสียงระเบิด</li><li>หากอยู่ใกล้บริเวณที่มีการยิงหรือเสียงระเบิด:</li><li>หมอบลงกับพื้น หากหลบได้ให้เข้าไปในพื้นที่ปิด / ห้องนิรภัย</li><li>ปิดโทรศัพท์มือถือหรือลดเสียงเพื่อหลีกเลี่ยงการตรวจพบ</li><li>รวบรวมพนักงานและลูกค้า</li><li>หากปลอดภัย ให้รวมกลุ่มและเคลื่อนย้ายไปยัง จุดรวมพลที่ปลอดภัย ตามที่สนามบินกำหนด</li><li>ตรวจสอบจำนวนลูกค้าและพนักงานในความดูแล พร้อมรายงานให้หัวหน้าทราบ</li><li>รอคำสั่งจากเจ้าหน้าที่</li><li>ห้ามกลับเข้าพื้นที่บริการจนกว่าจะได้รับอนุญาตอย่างเป็นทางการ</li><li>เตรียมพร้อมให้ข้อมูล หากเจ้าหน้าที่ต้องการสอบถาม</li><li>บันทึกเหตุการณ์</li><li>บันทึกรายละเอียดเหตุการณ์ทันทีที่ปลอดภัย:</li><li>วัน/เวลา</li><li>ลักษณะเหตุการณ์</li><li>การปฏิบัติของพนักงาน</li><li>รายชื่อพนักงาน/ลูกค้าที่อยู่ในเหตุการณ์</li></ul>
<p>แนวปฏิบัติสำคัญเพิ่มเติมสำหรับทุกกรณีฉุกเฉิน:</p>
<ul><li>หลีกเลี่ยงการตัดสินใจโดยลำพัง หากมีหัวหน้าอยู่ ให้รอรับคำสั่ง (เว้นแต่สถานการณ์ต้องรีบอพยพ)</li><li>ความปลอดภัยของ ชีวิต มาก่อน ทรัพย์สิน</li><li>พนักงานควรได้รับการฝึกซ้อมตาม แผนฉุกเฉินสนามบิน อย่างสม่ำเสมอ</li></ul>
<p>หมายเหตุสำคัญ:</p>
<ul><li>ทุกเหตุการณ์ต้องมีการจดบันทึกเหตุการณ์ทันทีที่ปลอดภัย หรือรายงานผ่านกลุ่มงาน Lark ขั้นตอนดังนี้</li><li>วัน/เวลา</li><li>รายละเอียดเหตุการณ์</li><li>การแจ้งเหตุ</li><li>การตอบสนอง</li><li>รายการทรัพย์สินที่เสียหาย (ถ้ามี)</li><li>รายงานเหตุการณ์ให้หัวหน้าหน่วยงาน / ผู้จัดการภายใน 1 ชั่วโมงหลังสถานการณ์คลี่คลาย</li></ul>
<figure><img src="/sop/emergency-airport/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-airport/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-airport/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-airport/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = 'emergency-airport';

-- ===== ILLUSTRATED: emergency-mall (4 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS-EMS:005/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>📌 วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดแนวทางปฏิบัติงานที่ชัดเจนให้กับพนักงานประจำจุดบริการ ภายในศูนย์การค้า ในกรณีที่เกิดเหตุฉุกเฉิน เช่น การพบวัตถุต้องสงสัย เหตุก่อการร้าย หรือภัยพิบัติทางธรรมชาติ โดยมีเป้าหมายเพื่อ:</p>
<ul><li>รักษาความปลอดภัยของพนักงานและลูกค้าเป็นลำดับแรก</li><li>ลดความเสี่ยงต่อการสูญเสียหรือความเสียหายต่อทรัพย์สินของลูกค้าและบริษัท</li><li>ตอบสนองต่อเหตุฉุกเฉินอย่างมีประสิทธิภาพ รวดเร็ว และเป็นระบบ</li><li>สร้างความมั่นใจให้กับลูกค้าในการใช้บริการ</li><li>ปฏิบัติสอดคล้องกับนโยบายความปลอดภัยของศูนย์การค้าและหน่วยงานที่เกี่ยวข้อง</li></ul>
<h3>📌 ขอบเขต (Scope):</h3>
<p>เอกสารนี้ใช้สำหรับพนักงานประจำเคาน์เตอร์หรือจุดบริการ AIRPORTELs ภายในศูนย์การค้าทุกแห่ง เพื่อให้สามารถ ตอบสนองต่อสถานการณ์ฉุกเฉินได้อย่างมีประสิทธิภาพ ปลอดภัย และลดความเสียหายต่อชีวิตและทรัพย์สิน การปฏิบัติงานเมื่อเกิดเหตุฉุกเฉิน 💣 กรณีที่ 1: พบวัตถุต้องสงสัย / วัตถุอันตราย</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>หยุดการให้บริการทันที</li><li>ห้ามเคลื่อนย้ายวัตถุต้องสงสัย</li><li>แจ้งลูกค้าให้ถอยห่างโดยไม่สร้างความตื่นตระหนก</li><li>แจ้งหน่วยงานที่เกี่ยวข้อง</li><li>โทรแจ้งหน่วยรักษาความปลอดภัยสนามบินทันที</li><li>รายงานหัวหน้า/ผู้จัดการสาขา</li><li>กันพื้นที่</li><li>ห้ามบุคคลอื่นเข้าใกล้วัตถุต้องสงสัย</li><li>หากมีป้ายหรือแถบกั้นความปลอดภัย ใช้ทันที</li><li>ตรวจสอบทรัพย์สิน</li><li>ตรวจสอบกระเป๋าหรือทรัพย์สินของลูกค้าที่ยังอยู่ภายในพื้นที่</li><li>จดบันทึกรายละเอียดของทรัพย์สินที่ยังไม่สามารถเคลื่อนย้ายได้</li><li>อพยพพนักงานและลูกค้า</li><li>ปฏิบัติตามคำแนะนำของเจ้าหน้าที่สนามบินหรือเจ้าหน้าที่รักษาความปลอดภัย</li><li>เดินทางไปยังจุดรวมพลที่กำหนดไว้</li><li>รอคำสั่งเพิ่มเติม</li><li>ห้ามกลับเข้าพื้นที่จนกว่าจะได้รับอนุญาตจากเจ้าหน้าที่</li></ul>
<p>🚨 กรณีที่ 2: เหตุก่อการร้าย / ใช้อาวุธ / ขู่วางระเบิด</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>การพบเห็นเหตุการณ์ แจ้งเจ้าหน้าที่รักษาความปลอดภัยทันที</li><li>ผ่านเบอร์ภายในของศูนย์ หรือวิทยุสื่อสาร</li><li>หลีกเลี่ยงการเผชิญหน้า</li><li>อย่าเข้าใกล้ผู้ต้องสงสัยหรือพื้นที่ที่มีอาวุธ</li><li>หยุดให้บริการทันที</li><li>ล็อคพื้นที่บริการหากปลอดภัยและทำได้ทัน</li><li>อพยพอย่างสงบ</li><li>ตามเส้นทางที่ปลอดภัยที่สุด ไม่อยู่รวมกันเป็นกลุ่มใหญ่</li><li>ห้ามใช้ลิฟต์</li><li>หมอบ/หลบในที่กำบัง หากได้ยินเสียงปืนหรือระเบิด</li><li>ปิดเสียงโทรศัพท์</li><li>อย่าเคลื่อนไหวหากอยู่ในพื้นที่เสี่ยง</li><li>รายงานหัวหน้าสาขา หรือ ผู้จัดการ</li><li>แจ้งสถานการณ์และพิกัดของตนเอง</li><li>รอคำสั่งจากเจ้าหน้าที่ความมั่นคง/ศูนย์การค้า</li></ul>
<p>🌍 กรณีที่ 3: แผ่นดินไหว</p>
<h3>ขั้นตอนการปฏิบัติ:</h3>
<ul><li>หลบอยู่ในที่ปลอดภัย</li><li>หมอบลงใต้โต๊ะ หรือยืนใกล้เสาแข็งแรง</li><li>ป้องกันศีรษะด้วยมือหรือกระเป๋า</li><li>หลังการสั่นสะเทือนหยุด</li><li>ประเมินความเสียหายเบื้องต้น</li><li>หากพื้นที่ไม่ปลอดภัย เช่น มีเพดานหลุด หรือมีควัน ให้ อพยพทันที</li><li>อพยพพนักงานและลูกค้า</li><li>ใช้บันได ไม่ใช้ลิฟต์</li><li>ไปยังจุดรวมพลตามแผนของศูนย์การค้า</li><li>แจ้งหัวหน้างาน / ผู้จัดการ</li><li>รายงานสถานการณ์</li><li>แจ้งจำนวนทีมงานที่อพยพออกมา</li><li>ตรวจสอบทรัพย์สิน</li><li>หลังได้รับอนุญาตให้กลับเข้าพื้นที่ ตรวจสอบทรัพย์สินของลูกค้าว่ายังอยู่ครบถ้วน</li><li>ตรวจสอบทรัพย์สิน และอุปกรณ์ของบริษัทฯ กรณีได้รับความเสียหายให้รายงานกลับสำนักงานใหญ่ เพื่อ</li></ul>
<p>จัดหาอุปกรณ์ทดแทนเร่งด่วน หรือ พิจารณาปิดให้บริการ แนวปฏิบัติสำคัญเพิ่มเติมสำหรับทุกกรณีฉุกเฉิน:</p>
<ul><li>หลีกเลี่ยงการตัดสินใจโดยลำพัง หากมีหัวหน้าอยู่ ให้รอรับคำสั่ง (เว้นแต่สถานการณ์ต้องรีบอพยพ)</li><li>ความปลอดภัยของ ชีวิต มาก่อน ทรัพย์สิน</li><li>พนักงานควรได้รับการฝึกซ้อมแผนฉุกเฉินตามนโยบายศูนย์การค้าอย่างน้อยปีละ 1 ครั้ง</li></ul>
<p>หมายเหตุสำคัญ :</p>
<ul><li>ทุกเหตุการณ์ต้องมีการจดบันทึกเหตุการณ์ทันทีที่ปลอดภัย หรือรายงานผ่านกลุ่มงาน Lark ตามขั้นตอนดังนี้</li><li>วัน/เวลา</li><li>รายละเอียดเหตุการณ์</li><li>การแจ้งเหตุ</li><li>การตอบสนอง</li><li>รายการทรัพย์สินที่เสียหาย (ถ้ามี)</li><li>รายงานเหตุการณ์ให้หัวหน้าหน่วยงาน / ผู้จัดการภายใน 1 ชั่วโมงหลังสถานการณ์คลี่คลาย</li></ul>
<figure><img src="/sop/emergency-mall/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-mall/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-mall/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/emergency-mall/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = 'emergency-mall';

-- ===== ILLUSTRATED: respond-io-guide (45 figures) =====
update sop.documents set content_html = '<blockquote><p>※ หน้าที่มีข้อมูลรหัสเข้าระบบถูกซ่อนไว้เพื่อความปลอดภัย — โปรดดูจากระบบต้นทางโดยตรง</p></blockquote><figure><img src="/sop/respond-io-guide/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig9.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig10.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig11.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig12.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig13.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig14.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig15.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig16.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig17.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig18.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig19.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig20.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig21.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig22.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig23.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig24.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig25.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig26.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig27.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig28.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig29.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig30.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig31.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig32.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig33.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig34.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig35.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig36.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig37.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig38.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig39.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig40.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig41.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig42.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig43.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig44.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/respond-io-guide/fig45.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = 'respond-io-guide';

-- ===== ILLUSTRATED: 3cx-guide (2 figures) =====
update sop.documents set content_html = '<figure><img src="/sop/3cx-guide/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/3cx-guide/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>' where slug = '3cx-guide';

-- ===== ILLUSTRATED: dress-code-guest-service (8 figures) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 001/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>วัตถุประสงค์ (Objective)</h3>
<p>เพื่อกำหนดมาตรฐานการแต่งกายสำหรับพนักงาน Guest Service ทั้งชายและหญิง ให้ดูเรียบร้อย เหมาะสม และ เป็นมืออาชีพ สร้างความประทับใจแก่ลูกค้า To establish a dress code standard for both male and female Guest Service staff to ensure a neat, appropriate, and professional appearance that creates a positive impression for customers.</p>
<h3>ขอบเขต (Scope)</h3>
<p>พนักงานตำแหน่ง Guest Service / Branch Manager / Porter ทุกคนที่ปฏิบัติงานหน้าสาขา หรือให้บริการลูกค้า โดยตรง All Service staff working at branches or in direct customer service roles.</p>
<p><strong>1. ข้อกำหนดทั่วไป (General Requirements)</strong></p>
<p>รายการ Item พนักงานชาย Male Staff พนักงานหญิง Female Staff เสื้อ / Shirt เสื้อยูนิฟอร์มบริษัท รีดเรียบ ไม่ยับ เสื้อยูนิฟอร์มบริษัท รีดเรียบ ไม่ยับ กางเกง / Pants กางเกงขายาวสีดำหรือสีตามบริษัท กำหนด ไม่รัดรูป กระโปรง/กางเกงขายาว ทรงสุภาพ ความยาวคลุมเข่า รองเท้า / Shoes รองเท้าหุ้มส้น/ ผ้าใบ สะอาด รองเท้าหุ้มส้น ส้นเตี้ยหรือปานกลาง /ผ้าใบสะอาด ทรงผม / Hair ตัดผมสุภาพ ไม่ย้อมสีฉูดฉาด ไม่ไว้ หนวด/ เครา รวบผมเรียบร้อย สีธรรมชาติ ไม่มีเครื่องประดับเกิน จำเป็น เล็บ / Nails สั้น สะอาด ไม่ทาเล็บ สะอาด สีธรรมชาติ ไม่มีเล็บปลอม หรืออุปกรณ์ที่มี อุปสรรคต่อการทำงาน เครื่องประดับ / Accessories ใส่นาฬิิกาได้ ไม่ควรสวมแหวน/สร้อยที่ โดดเด่น เครื่องประดับเรียบง่าย เช่น ต่างหูเล็ก นาฬิิกา กลิ่นตัว / Body Odor ใช้น้ำหอมอ่อนๆ ไม่มีกลิ่นตัวรบกวนลูกค้า ใช้น้ำหอมเบาๆ ไม่ฉุนจนเกินไป หน้ากากอนามัย / Mask สีสุภาพ ไม่มีลวดลาย (ถ้ามีการกำหนดใช้) สีสุภาพ ไม่มีลวดลาย (ถ้ามีการกำหนดใช้) การแต่งหน้า / Make up สามารถทาแป้ง / ลิปมัน ได้ตามความ เหมาะสม สีสันสุภาพ ไม่จัดจ้านจนเกินไป และ ไม่หน้าสด</p>
<p><strong>2. ข้อห้าม (Prohibited)</strong></p>
<ul><li>ห้ามสวมใส่เสื้อผ้าที่ไม่ใช่ยูนิฟอร์มขณะปฏิบัติงาน / Do not wear non-uniform clothing during work</li><li>กรณีฉุกเฉิน อนุโลมให้ใส่เสื้อโปโล คอปกสีดำล้วน หรือ สีกรมท่า ในการปฏิบัติงานได้ โดยต้องแจ้งหัวหน้า</li></ul>
<p>สาขา หรือผู้ดูแลให้ทราบทุกครั้ง</p>
<ul><li>ห้ามแต่งหน้า/ทำผม/ทาเล็บในลักษณะที่ไม่สุภาพ /No inappropriate makeup/hair/nail styles</li><li>ห้ามสวมรองเท้าแตะ หรือรองเท้าเปิดส้น / No sandals or open-heel shoes</li><li>ห้ามใส่เครื่องประดับแฟชั่นที่เด่นชัดหรือมีเสียงดังรบกวน / No flashy or noisy fashion accessories</li></ul>
<p><strong>3. การแขวนบัตรพนักงาน (Staff ID Badge Wearing Guideline)</strong></p>
<ul><li>พนักงานทุกคนต้องสวมบัตรพนักงานในตำแหน่งที่เห็นได้ชัดขณะปฏิบัติงาน</li></ul>
<p>All staff must wear ID badges visibly while on duty</p>
<ul><li>ต้องแขวนไว้บริเวณหน้าอกด้านซ้ายหรือกลางลำตัว ด้วยสายคล้องที่บริษัทจัดให้</li></ul>
<p>Badge must be hung on the left chest or center using company-provided lanyards</p>
<ul><li>บัตรต้องสะอาดไม่ชำรุดและไม่ปิดบังข้อมูลสำคัญเช่นรูปถ่ายชื่อหรือรหัสพนักงาน</li><li>บัตรต้อสอด ไม่ชำรุด แลไม่ปิดบัข้อมูลสำ ญ เช่น รูปถ่ย ชื่อ รือรสนั น The badge must be clean, undamaged, and display key information (photo, name, ID)</li><li>ห้ามแก้ไข ดัดแปลง หรือประดับตกแต่งบัตรพนักงานด้วยวัสดุอื่น</li></ul>
<p>Do not modify, decorate, or cover any part of the badge</p>
<ul><li>หากบัตรหาย ต้องแจ้งหัวหน้าแผนกทันทีและดำเนินการขอออกบัตรใหม่</li></ul>
<p>Lost badges must be reported immediately and reissued through proper channels</p>
<p><strong>4. การตรวจสอบและติดตามผล (Monitoring &amp; Compliance)</strong></p>
<p>หัวหน้าสาขาและทีมตรวจมาตรฐานจะเป็นผู้ตรวจสอบความเรียบร้อยในการแต่งกายของพนักงานทุกวัน หากพบการ แต่งกายไม่เหมาะสม จะดำเนินการตามขั้นตอนการตักเตือน Branch Supervisors and Standard Audit Teams are responsible for daily monitoring. Non- compliance will be addressed according to the disciplinary procedure.</p>
<p>ตัวอย่างการแต่งกายพนักงาน ชาย - หญิง และการสวมบัตรพนักงาน</p>
<figure><img src="/sop/dress-code-guest-service/fig1.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/dress-code-guest-service/fig2.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/dress-code-guest-service/fig3.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/dress-code-guest-service/fig4.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>การแต่งหน้า และทรงผม</p>
<figure><img src="/sop/dress-code-guest-service/fig5.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<figure><img src="/sop/dress-code-guest-service/fig6.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>ตัวอย่างเสื้อโปโล คอปกสีดำ และ สีกรมท่า ที่อนุโลมให้ใส่ได้ กรณีฉุกเฉิน</p>
<figure><img src="/sop/dress-code-guest-service/fig7.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เสื้อโปโล คอปกสีดำ</p>
<figure><img src="/sop/dress-code-guest-service/fig8.jpg" alt="ภาพประกอบขั้นตอน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px" /></figure>
<p>เสื้อโปโล คอปกสีกรมท่า</p>' where slug = 'dress-code-guest-service';

notify pgrst, 'reload schema';
commit;
