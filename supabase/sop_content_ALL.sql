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
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0025/2026<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 07 กรกฏาคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>ขั้นตอนการจอง (ภาพจากเอกสารต้นฉบับ)</h3><figure><img src="/sop/ntw-5day-booking/p1.jpg" alt="หน้า 1" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p2.jpg" alt="หน้า 2" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p3.jpg" alt="หน้า 3" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p4.jpg" alt="หน้า 4" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p5.jpg" alt="หน้า 5" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p6.jpg" alt="หน้า 6" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p7.jpg" alt="หน้า 7" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p8.jpg" alt="หน้า 8" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p9.jpg" alt="หน้า 9" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p10.jpg" alt="หน้า 10" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p11.jpg" alt="หน้า 11" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 11</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p12.jpg" alt="หน้า 12" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 12</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p13.jpg" alt="หน้า 13" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 13</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p14.jpg" alt="หน้า 14" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 14</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p15.jpg" alt="หน้า 15" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 15</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p16.jpg" alt="หน้า 16" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 16</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p17.jpg" alt="หน้า 17" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 17</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p18.jpg" alt="หน้า 18" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 18</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p19.jpg" alt="หน้า 19" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 19</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p20.jpg" alt="หน้า 20" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 20</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p21.jpg" alt="หน้า 21" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 21</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p22.jpg" alt="หน้า 22" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 22</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p23.jpg" alt="หน้า 23" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 23</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p24.jpg" alt="หน้า 24" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 24</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p25.jpg" alt="หน้า 25" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 25</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p26.jpg" alt="หน้า 26" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 26</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p27.jpg" alt="หน้า 27" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 27</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p28.jpg" alt="หน้า 28" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 28</figcaption></figure><figure><img src="/sop/ntw-5day-booking/p29.jpg" alt="หน้า 29" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 29</figcaption></figure>
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
  '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 019/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 3 ธันวาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>ขั้นตอนการทำงาน (ภาพจากเอกสารต้นฉบับ)</h3><figure><img src="/sop/booking-photo-rotate/p1.jpg" alt="หน้า 1" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p2.jpg" alt="หน้า 2" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p3.jpg" alt="หน้า 3" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p4.jpg" alt="หน้า 4" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p5.jpg" alt="หน้า 5" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p6.jpg" alt="หน้า 6" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p7.jpg" alt="หน้า 7" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p8.jpg" alt="หน้า 8" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p9.jpg" alt="หน้า 9" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p10.jpg" alt="หน้า 10" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p11.jpg" alt="หน้า 11" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 11</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p12.jpg" alt="หน้า 12" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 12</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p13.jpg" alt="หน้า 13" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 13</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p14.jpg" alt="หน้า 14" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 14</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p15.jpg" alt="หน้า 15" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 15</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p16.jpg" alt="หน้า 16" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 16</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p17.jpg" alt="หน้า 17" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 17</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p18.jpg" alt="หน้า 18" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 18</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p19.jpg" alt="หน้า 19" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 19</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p20.jpg" alt="หน้า 20" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 20</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p21.jpg" alt="หน้า 21" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 21</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p22.jpg" alt="หน้า 22" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 22</figcaption></figure><figure><img src="/sop/booking-photo-rotate/p23.jpg" alt="หน้า 23" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 23</figcaption></figure>
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

-- ===== IMAGES: dmk-airport-service (5 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 020/2026<br><strong>วันที่บังคับใช้:</strong> 1 มกราคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/dmk-airport-service/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/dmk-airport-service/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/dmk-airport-service/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/dmk-airport-service/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/dmk-airport-service/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>' where slug = 'dmk-airport-service';

-- ===== IMAGES: pos-order-receiving (8 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 011/2025<br><strong>เวอร์ชัน:</strong> 2.0<br><strong>วันที่บังคับใช้:</strong> 9 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/pos-order-receiving/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/pos-order-receiving/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://postels.airportels.asia/admin/order/browse" target="_blank" rel="noopener">เข้าระบบหลังบ้าน Airportles</a></li></ul>' where slug = 'pos-order-receiving';

-- ===== IMAGES: authorized-person-pickup (7 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 012/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 10 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/authorized-person-pickup/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/authorized-person-pickup/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>' where slug = 'authorized-person-pickup';

-- ===== IMAGES: open-close-counter (8 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 003<br><strong>เวอร์ชัน:</strong> 2.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/open-close-counter/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/open-close-counter/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/open-close-counter/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/open-close-counter/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/open-close-counter/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/open-close-counter/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/open-close-counter/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/open-close-counter/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgdvb7YjwI4wYLyl1EglMMtb" target="_blank" rel="noopener">7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-in ผ่าน Lark OPEN Counter Checklist</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgoiPdpbc2c8p7CnKE5JFiqo" target="_blank" rel="noopener">8. เช็คสต๊อคสินค้าและของใช้ทุกวันอาทิตย์  UPDATE STOCK</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlg66DrQmhPvml9oPAUtJEijf" target="_blank" rel="noopener">2. นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/docx/RqegdFpV7o6g6mxNaHdlhJY9gbd" target="_blank" rel="noopener">ช่องทางการแจ้งซ่อม</a></li><li><a href="https://ssglsj0spi27.sg.larksuite.com/share/base/form/shrlgQRdC8dnKvx5BDfsaFe3nIf" target="_blank" rel="noopener">7. ถ่ายรูปเคาน์เตอร์ สำหรับ Check-out ผ่าน Lark   CLOSE Counter Checklist</a></li></ul>' where slug = 'open-close-counter';

-- ===== IMAGES: yoowifi-service (10 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 013/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 4 สิงหาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/yoowifi-service/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p9.jpg" alt="หน้า 9" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure>
<figure><img src="/sop/yoowifi-service/p10.jpg" alt="หน้า 10" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxcFAvPWY/edit?gid=0#gid=0" target="_blank" rel="noopener">https://docs.google.com/spreadsheets/d/1OFprB9ESYGEukB2dd_TaCu5E8uDCT0q8P4cxcFAv</a></li></ul>' where slug = 'yoowifi-service';

-- ===== IMAGES: edc-machine (11 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 0017/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 3 ตุลาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/edc-machine/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/edc-machine/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/edc-machine/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/edc-machine/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/edc-machine/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/edc-machine/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/edc-machine/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/edc-machine/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<figure><img src="/sop/edc-machine/p9.jpg" alt="หน้า 9" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure>
<figure><img src="/sop/edc-machine/p10.jpg" alt="หน้า 10" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure>
<figure><img src="/sop/edc-machine/p11.jpg" alt="หน้า 11" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 11</figcaption></figure>' where slug = 'edc-machine';

-- ===== IMAGES: online-credit-card-payment (5 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 007/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/online-credit-card-payment/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/online-credit-card-payment/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/online-credit-card-payment/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/online-credit-card-payment/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/online-credit-card-payment/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://postels.airportels.asia/admin/order/browse" target="_blank" rel="noopener">เว็บไซต์ AIRPORTELs</a></li></ul>' where slug = 'online-credit-card-payment';

-- ===== IMAGES: cashless-payment-policy (5 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS: 002<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 16 มิถุนายน 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/cashless-payment-policy/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/cashless-payment-policy/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/cashless-payment-policy/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/cashless-payment-policy/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/cashless-payment-policy/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>' where slug = 'cashless-payment-policy';

-- ===== IMAGES: inventory-stock-update (3 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 006/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/inventory-stock-update/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/inventory-stock-update/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/inventory-stock-update/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>' where slug = 'inventory-stock-update';

-- ===== IMAGES: luggage-delivery-google-sheet (25 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> WI-OPS : 001/2026<br><strong>เวอร์ชัน:</strong> 01<br><strong>วันที่บังคับใช้:</strong> 19 มกราคม 2569<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/luggage-delivery-google-sheet/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p9.jpg" alt="หน้า 9" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p10.jpg" alt="หน้า 10" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p11.jpg" alt="หน้า 11" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 11</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p12.jpg" alt="หน้า 12" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 12</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p13.jpg" alt="หน้า 13" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 13</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p14.jpg" alt="หน้า 14" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 14</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p15.jpg" alt="หน้า 15" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 15</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p16.jpg" alt="หน้า 16" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 16</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p17.jpg" alt="หน้า 17" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 17</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p18.jpg" alt="หน้า 18" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 18</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p19.jpg" alt="หน้า 19" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 19</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p20.jpg" alt="หน้า 20" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 20</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p21.jpg" alt="หน้า 21" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 21</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p22.jpg" alt="หน้า 22" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 22</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p23.jpg" alt="หน้า 23" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 23</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p24.jpg" alt="หน้า 24" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 24</figcaption></figure>
<figure><img src="/sop/luggage-delivery-google-sheet/p25.jpg" alt="หน้า 25" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 25</figcaption></figure>
<h3>🔗 ลิงก์ที่เกี่ยวข้อง (Links)</h3>
<ul><li><a href="https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0fXJE/edit?gid=0#gid=0" target="_blank" rel="noopener">https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0f</a></li></ul>' where slug = 'luggage-delivery-google-sheet';

-- ===== IMAGES: emergency-airport (7 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS-EMS:004/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/emergency-airport/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/emergency-airport/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/emergency-airport/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/emergency-airport/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/emergency-airport/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/emergency-airport/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/emergency-airport/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>' where slug = 'emergency-airport';

-- ===== IMAGES: emergency-mall (6 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS-EMS:005/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/emergency-mall/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/emergency-mall/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/emergency-mall/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/emergency-mall/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/emergency-mall/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/emergency-mall/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>' where slug = 'emergency-mall';

-- ===== IMAGES: respond-io-guide (30 pages) =====
update sop.documents set content_html = '<blockquote><p>※ หน้าที่มีข้อมูลรหัสเข้าระบบถูกซ่อนไว้ในภาพเพื่อความปลอดภัย — โปรดดูจากระบบต้นทางโดยตรง</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/respond-io-guide/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p6.jpg" alt="หน้า 6" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 6</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p7.jpg" alt="หน้า 7" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 7</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p8.jpg" alt="หน้า 8" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 8</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p9.jpg" alt="หน้า 9" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 9</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p10.jpg" alt="หน้า 10" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 10</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p11.jpg" alt="หน้า 11" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 11</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p12.jpg" alt="หน้า 12" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 12</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p13.jpg" alt="หน้า 13" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 13</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p14.jpg" alt="หน้า 14" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 14</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p15.jpg" alt="หน้า 15" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 15</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p16.jpg" alt="หน้า 16" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 16</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p17.jpg" alt="หน้า 17" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 17</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p18.jpg" alt="หน้า 18" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 18</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p19.jpg" alt="หน้า 19" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 19</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p20.jpg" alt="หน้า 20" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 20</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p21.jpg" alt="หน้า 21" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 21</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p22.jpg" alt="หน้า 22" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 22</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p23.jpg" alt="หน้า 23" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 23</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p25.jpg" alt="หน้า 25" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 25</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p26.jpg" alt="หน้า 26" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 26</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p27.jpg" alt="หน้า 27" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 27</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p28.jpg" alt="หน้า 28" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 28</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p29.jpg" alt="หน้า 29" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 29</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p30.jpg" alt="หน้า 30" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 30</figcaption></figure>
<figure><img src="/sop/respond-io-guide/p31.jpg" alt="หน้า 31" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 31</figcaption></figure>' where slug = 'respond-io-guide';

-- ===== IMAGES: 3cx-guide (3 pages) =====
update sop.documents set content_html = '<h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/3cx-guide/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/3cx-guide/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/3cx-guide/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>' where slug = '3cx-guide';

-- ===== IMAGES: dress-code-guest-service (5 pages) =====
update sop.documents set content_html = '<blockquote><p><strong>รหัสเอกสาร:</strong> SOP-OPS : 001/2025<br><strong>เวอร์ชัน:</strong> 1.0<br><strong>วันที่บังคับใช้:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน:</strong> Operations</p></blockquote><h3>เอกสารต้นฉบับ</h3>
<figure><img src="/sop/dress-code-guest-service/p1.jpg" alt="หน้า 1" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 1</figcaption></figure>
<figure><img src="/sop/dress-code-guest-service/p2.jpg" alt="หน้า 2" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 2</figcaption></figure>
<figure><img src="/sop/dress-code-guest-service/p3.jpg" alt="หน้า 3" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 3</figcaption></figure>
<figure><img src="/sop/dress-code-guest-service/p4.jpg" alt="หน้า 4" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 4</figcaption></figure>
<figure><img src="/sop/dress-code-guest-service/p5.jpg" alt="หน้า 5" loading="lazy" style="max-width:100%;border:1px solid #e5e7eb;border-radius:8px" /><figcaption>หน้า 5</figcaption></figure>' where slug = 'dress-code-guest-service';

notify pgrst, 'reload schema';
commit;
