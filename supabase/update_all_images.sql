-- ============================================================
-- Insert original figures into ALL SOP documents (internal use, as-is).
-- Run in Supabase SQL Editor of the Scheduling project (schema sop).
-- Re-runnable. Images are served from /docs/<slug>/ by the app.
-- ============================================================

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2><ul><li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 020/2026</li><li><strong>เวอร์ชัน / Version:</strong> ปรับปรุงครั้งที่ 1</li><li><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 มกราคม 2569</li><li><strong>หน่วยงาน / Department:</strong> Operations</li></ul><h2>วัตถุประสงค์ / Purpose</h2><p>เพื่อกำหนดขั้นตอนการรับและส่งมอบกระเป๋าเดินทาง ณ ท่าอากาศยานดอนเมือง ให้เป็นไปตามข้อกำหนดด้านความปลอดภัยของการท่าฯ (ทอท.) และใช้เป็นแนวปฏิบัติจริงสำหรับพนักงานหน้าสาขา</p><p><em>To establish operational procedures for luggage acceptance and release at Don Mueang Airport in compliance with AOT security regulations.</em></p><h2>ขอบเขตการใช้งาน / Scope</h2><p>ใช้สำหรับพนักงาน AIRPORTELs (DMK) ทุกตำแหน่งที่เกี่ยวข้องกับการรับ ฝาก ส่งมอบ และตรวจสอบกระเป๋า ประจำสาขาดอนเมือง</p><p><em>Applicable to all AIRPORTELs staff involved in luggage acceptance, storage, delivery, and X-ray screening at DMK.</em></p><h2>คำจำกัดความ (Definitions)</h2><ul><li><strong>พนักงานหน้าสาขา (Guest Service &amp; Porter):</strong> พนักงานที่ให้บริการลูกค้า ณ จุดบริการ</li><li><strong>ผู้รับมอบฉันทะ:</strong> บุคคลที่ได้รับมอบอำนาจเป็นลายลักษณ์อักษรจากเจ้าของกระเป๋า</li><li><strong>ทอท. (AOT):</strong> บริษัท ท่าอากาศยานไทย จำกัด (มหาชน)</li></ul><h2>บทบาทและความรับผิดชอบ (Roles &amp; Responsibilities)</h2><h3>พนักงานหน้าสาขาทุกตำแหน่ง (Guest Service &amp; Porter)</h3><ul><li>ตรวจสอบการจองและเอกสารลูกค้า</li><li>ชี้แจงเงื่อนไขการให้บริการและข้อกำหนดด้านความปลอดภัย</li><li>ปฏิบัติตามขั้นตอน SOP อย่างเคร่งครัด</li><li>หยุดกระบวนการและรายงานเมื่อพบความเสี่ยง</li></ul><h3>หัวหน้าสาขา (Branch Manager) / ผู้ควบคุมงาน (Operation Team)</h3><ul><li>กำกับดูแลการปฏิบัติงานให้เป็นไปตาม SOP</li><li>ประสานงานกับเจ้าหน้าที่ ทอท. ในกรณีผิดปกติ</li></ul><h2>ขั้นตอนการปฏิบัติงาน (Operational Procedures)</h2><h3>ขั้นตอนการรับฝากกระเป๋า (Luggage Acceptance)</h3><ol><li>รับลูกค้าและตรวจสอบการจองในระบบ</li><li>ขอเอกสารประจำตัว (ID Card / Passport) เพื่อบันทึกข้อมูลลงในระบบ POS</li><li>ตรวจสอบกระเป๋าหรือสัมภาระร่วมกับผู้ใช้บริการ ทั้งภายนอกและภายใน</li><li>ชี้แจงข้อกำหนดด้านความปลอดภัยของ ทอท. และแจ้งว่ากระเป๋าทุกใบต้องผ่านการตรวจ X-ray</li><li>ขอความยินยอมจากลูกค้าเพื่อดำเนินการตรวจ X-ray</li><li>หากไม่ยินยอม ให้ปฏิเสธการให้บริการทันที</li><li>นำกระเป๋าเข้าตรวจด้วยเครื่อง X-ray โดยผู้ได้รับอนุญาต</li><li>จัดประเภทผล X-ray<ul><li><strong>Clear:</strong> ดำเนินการรับกระเป๋าเข้าระบบ</li><li><strong>Prohibited Item:</strong> แยกสิ่งของออก และส่งมอบคืนให้ผู้ใช้บริการ</li><li><strong>Suspicious Item:</strong> หยุดกระบวนการ ห้ามเปิดกระเป๋า และประสาน ทอท. ตรวจสอบทันทีที่เบอร์โทร 02-535 1616</li></ul></li><li>ติด Tag / Label และบันทึกข้อมูลกระเป๋าในระบบ</li></ol><h3>ขั้นตอนการส่งมอบกระเป๋า (Luggage Release)</h3><ol><li>ผู้มารับกระเป๋าแสดงเอกสารรับกระเป๋า</li><li>ตรวจสอบว่าผู้รับเป็นเจ้าของกระเป๋าหรือผู้รับมอบฉันทะ</li><li>ตรวจสอบเอกสารประจำตัว / หนังสือมอบฉันทะ (ถ้ามี)</li><li>ตรวจสอบ Tag / Label ให้ตรงกับข้อมูลในระบบ</li><li>ส่งมอบกระเป๋าให้ผู้รับ</li><li>บันทึกการส่งมอบในระบบ</li></ol><h2>ข้อห้ามและข้อควรระวัง (Prohibitions &amp; Precautions)</h2><blockquote><ul><li>ห้ามรับกระเป๋าที่ไม่ผ่านการตรวจ X-ray</li><li>ห้ามเปิดกระเป๋าด้วยตนเองในทุกกรณี</li><li>ห้ามรับกระเป๋าที่พบสิ่งของต้องห้ามตามข้อกำหนดสนามบิน</li><li>ต้องปฏิบัติตามคำสั่งของเจ้าหน้าที่ ทอท. อย่างเคร่งครัด</li></ul></blockquote><h2>รายการสิ่งของต้องห้าม (Prohibited Items)</h2><p>ห้ามจัดส่งสิ่งของต้องห้าม (Prohibited Items)</p><blockquote><p><strong>หมายเหตุ:</strong> ของเหลว (Liquid) สามารถรับได้เฉพาะกรณี</p><ul><li>ไม่เป็นสเปรย์</li><li>บรรจุภัณฑ์ไม่เกิน 100 ml.</li><li>มีฉลากระบุชัดเจนและอยู่ในบรรจุภัณฑ์เดิม ภายใต้เงื่อนไขไม่เกิน 100 ml.</li></ul></blockquote><blockquote><p>สิ่งของที่แตกหักง่ายและเปราะบาง หากลูกค้ายืนยันต้องการนำส่ง ให้แจ้งเงื่อนไขให้ชัดเจนทุกครั้ง</p></blockquote><p>AIRPORTELs จะไม่รับผิดชอบต่อสิ่งของที่เปราะบาง มีค่า เป็นของเหลว เป็นอุปกรณ์อิเล็กทรอนิกส์ หรือสิ่งของต้องห้าม</p><p><em>AIRPORTELs are not responsible for fragile, valuable, liquid, electronic, or prohibited items.</em></p><h2>ข้อกำหนดด้านความปลอดภัย (ทอท.) | AOT Security Requirements</h2><ul><li>กระเป๋าทุกใบต้องผ่านการตรวจด้วยเครื่อง X-ray ก่อนรับเข้าระบบ<br><em>All luggage must undergo X-ray screening prior to acceptance.</em></li><li>ผู้ใช้งานเครื่อง X-ray ต้องผ่านการอบรมและได้รับอนุญาตจาก ทอท.<br><em>X-ray operators must be certified and authorized by AOT.</em></li><li>กรณีพบสิ่งของต้องห้ามหรือสิ่งน่าสงสัย ต้องหยุดกระบวนการและประสานเจ้าหน้าที่ ทอท. ทันที ที่เบอร์โทร 02-535 1616<br><em>Any prohibited or suspicious items must be reported to AOT immediately.</em></li></ul><h2>เอกสารที่เกี่ยวข้อง (Related Documents)</h2><ul><li>SOP: การให้บริการรับฝากกระเป๋า ณ ท่าอากาศยานดอนเมือง</li><li>SOP: การให้ผู้อื่นมารับกระเป๋าแทน / Authorized Person Pickup</li></ul><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/dmk-airport-service/fig-2.jpg" alt="" /><img src="/docs/dmk-airport-service/fig-3.jpg" alt="" />', cover_image = '/docs/dmk-airport-service/fig-1.jpg' where slug = 'dmk-airport-service';

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2><ul><li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 011/2025</li><li><strong>เวอร์ชัน / Version:</strong> 2.0 (Revised 1)</li><li><strong>วันที่บังคับใช้ / Effective Date:</strong> 9 กรกฏาคม 2568</li><li><strong>แก้ไขครั้งที่ 1 / Revised Date:</strong> 20 สิงหาคม 2568 : Dev. อัพเดตการเลือก Service Type การจอง MS</li><li><strong>หน่วยงาน / Department:</strong> Operations</li></ul><h2>วัตถุประสงค์ (Purpose)</h2><p>เพื่อกำหนดขั้นตอนที่เป็นมาตรฐานในการรับออเดอร์จากลูกค้า ทั้งการฝากกระเป๋าและการส่งกระเป๋า ผ่านระบบ POS และระบบหลังบ้าน เพื่อให้มั่นใจว่าทุกขั้นตอนถูกต้อง ครบถ้วน รวดเร็ว และสามารถตรวจสอบย้อนหลังได้</p><h2>ขอบเขต (Scope)</h2><p>SOP นี้ครอบคลุมขั้นตอนการรับออเดอร์ของลูกค้าผ่านระบบ POS:</p><ul><li>ที่หน้าสาขาทุกแห่งของบริษัท</li><li>สำหรับบริการฝากและบริการส่งกระเป๋าเดินทางหรือสัมภาระ</li><li>ตั้งแต่การกรอกข้อมูลลูกค้าใน POS จนถึงการจองเลข MS (ในกรณีบริการส่ง)</li></ul><h2>ขั้นตอนการปฏิบัติงาน (Work Instructions)</h2><h3>1. การรับออเดอร์ผ่านระบบ POS</h3><h3>ขั้นตอนที่ 1: เตรียมข้อมูลลูกค้า</h3><ol><li>ขอ Passport หรือบัตรประชาชนจากลูกค้า</li><li>เข้าระบบ POS</li><li>ใส่ Passport ID หรือเลขบัตรประชาชน</li><li>กด Search</li></ol><h3>ขั้นตอนที่ 2: กรอกข้อมูลลูกค้าให้ครบถ้วน</h3><ol><li>เลือกคำนำหน้าชื่อให้ถูกต้อง</li><li>กรอกชื่อ-นามสกุล</li><li>ตรวจสอบว่าเลขที่บัตรประชาชน / Passport ID แสดงถูกต้อง (ระบบจะแสดงข้อมูลตามที่ระบุไว้ในขั้นตอนที่ 1)</li><li>กรอกสัญชาติ (ใช้ตัวย่อตาม Passport)</li><li>กด Continue</li></ol><h3>ขั้นตอนที่ 3: สร้างคำสั่งซื้อ</h3><ol><li>กด New Order</li><li>เลือกประเภทบริการที่ลูกค้าต้องการ:<ul><li>บริการฝากกระเป๋า (Deposit Order)</li><li>บริการส่งกระเป๋า (Delivery Order)</li></ul></li></ol><h3>2. รายละเอียดตามประเภทบริการ</h3><h3>A. บริการฝากกระเป๋า</h3><ol><li>กรอกจำนวนกระเป๋า</li><li>ใส่ลำดับ Tag ของกระเป๋า (อิงตามสาขา)</li><li>เลือกวันที่และเวลาที่ลูกค้าจะมารับ</li><li>สแกน QR Code ให้ลูกค้ากรอก Email และเบอร์โทรศัพท์</li><li>เมื่อระบุข้อมูลครบแล้ว กด Continue</li></ol><p><strong>คิดเงิน (หากต้องการคิดทันที):</strong></p><ol><li>กด Service</li><li>ใส่จำนวนเงิน แล้วกด ADD</li><li>กด Confirm เพื่อสิ้นสุดรายการ</li></ol><h3>B. บริการส่งกระเป๋า</h3><ol><li>เลือกปลายทางจัดส่ง</li><li>เลือกวันที่และเวลาที่ลูกค้าจะมารับ</li><li>สแกน QR Code ให้ลูกค้ากรอก Email และเบอร์โทรศัพท์</li><li>กด Continue</li><li>กด Service เพื่อคิดเงิน</li><li>ใส่จำนวนเงิน แล้วกด ADD</li><li>กด Continue เพื่อสิ้นสุดรายการ</li></ol><h3>3. การจองเลข MS (สำหรับบริการส่งเท่านั้น)</h3><ol><li>เข้าระบบหลังบ้าน Airportels</li><li>ค้นหาออเดอร์</li><li>กด Create Logistic Order</li><li>เลือก Service Type<blockquote><p>พนักงานที่กดจองออเดอร์เข้าฝั่ง MS จะต้องเลือก Service Type ที่ต้องการ โดยระบบจะปรับ Tracking prefix ฝั่ง MS ให้เป็นไปตามที่พนักงานระบุไป (จำเป็นต้องระบุ)</p><p><strong>Note:</strong> หากมีรายละเอียดเพิ่มเติม ให้ระบุใน Note เพื่อแจ้งรายละเอียดไปฝั่ง MS ได้ เช่น "ส่งด่วนนะคะ", "สีแดง 3 ใบ" เป็นต้น หากไม่มีข้อมูลสามารถปล่อยว่างได้</p></blockquote></li><li>ตรวจสอบที่อยู่ต้นทาง-ปลายทาง</li><li>เลือกวันจัดส่ง และรอบเวลา 12:00 - 14:00</li><li>เลือกจังหวัด / อำเภอ / รหัสไปรษณีย์ ให้ตรงกับที่อยู่ปลายทาง</li><li>กด Create</li><li>สิ้นสุดการทำรายการ</li></ol><blockquote><p><strong>หมายเหตุ:</strong></p><ul><li>หากพบที่อยู่ไม่ถูกต้อง ต้องแก้ไขก่อนจองเลข MS</li><li><strong>เน้นย้ำ!!</strong> หากจองเลข MS แล้วต้องการแก้ไขที่อยู่ ให้แจ้งยกเลิกกับ Planner ทุกครั้ง แล้วทำการจองใหม่</li></ul></blockquote><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/pos-order-receiving/fig-2.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-3.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-4.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-5.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-6.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-7.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-8.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-9.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-10.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-11.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-12.jpg" alt="" /><img src="/docs/pos-order-receiving/fig-13.jpg" alt="" />', cover_image = '/docs/pos-order-receiving/fig-1.jpg' where slug = 'pos-order-receiving';

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2><ul><li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 012/2025</li><li><strong>เวอร์ชัน / Version:</strong> 1.0</li><li><strong>วันที่บังคับใช้ / Effective Date:</strong> 10 กรกฏาคม 2568</li><li><strong>หน่วยงาน / Department:</strong> Operations</li></ul><h2>วัตถุประสงค์ / Purpose</h2><p>เพื่อกำหนดแนวทางปฏิบัติที่ชัดเจนในการให้ผู้อื่นมารับกระเป๋าแทนเจ้าของอย่างปลอดภัย ลดความเสี่ยงจากความผิดพลาด การสูญหาย หรือการแอบอ้าง</p><p><em>To provide clear procedures for allowing an authorized person to collect luggage on behalf of the owner, ensuring safety and minimizing risks of loss, errors, or impersonation.</em></p><h2>ขอบเขตการใช้งาน / Scope</h2><p>ใช้กับกรณีที่ลูกค้าไม่สามารถมารับกระเป๋าด้วยตนเอง และมอบหมายให้ผู้อื่นมารับแทน</p><p><em>Applicable when the customer cannot pick up the luggage themselves and authorizes another person to do so.</em></p><h2>เอกสารและหลักฐานที่ต้องตรวจสอบ / Required Documents</h2><h3>1.1 เอกสารของผู้รับมอบอำนาจ / Documents of the Authorized Person</h3><ul><li>บัตรประชาชน / หนังสือเดินทาง / ใบขับขี่ (ฉบับจริง)<br><em>National ID / Passport / Driver''s License (original copy)</em></li><li>สำเนาบัตรประชาชน พร้อมลายเซ็นรับรองสำเนาถูกต้อง<br><em>Copy of National ID with certified signature</em></li></ul><h3>1.2 เอกสารของผู้มอบอำนาจ / Documents of the Owner</h3><ul><li>สำเนาบัตรประชาชน / หนังสือเดินทาง พร้อมลายเซ็นรับรองสำเนาถูกต้อง<br><em>Copy of National ID / Passport with certified signature</em></li></ul><h3>1.3 หนังสือมอบอำนาจ / Authorization Letter</h3><ul><li>รายละเอียดที่ต้องระบุ เช่น ชื่อ-นามสกุล, เลขบัตรประชาชนของทั้งสองฝ่าย, วัตถุประสงค์, รายละเอียดกระเป๋า, วันเวลา, ลายเซ็น, พยาน (ถ้ามี)<br><em>Must include: Full names, ID numbers of both parties, purpose, bag details, date/time, signatures, witnesses (if possible)</em></li></ul><h3>1.4 เอกสารยืนยันการจัดฝาก (Receive slip) หรือการส่ง / Delivery Confirmation</h3><ul><li>ใบเสร็จ, หมายเลข Tracking, จุดรับ-ส่ง, หลักฐานการชำระเงิน<br><em>Receipt, tracking number, pickup-drop point, proof of payment</em></li></ul><h3>1.5 รูปถ่าย / Photos</h3><ul><li>รูปถ่ายกระเป๋า และเจ้าของคู่กับกระเป๋า (ถ้ามี)<br><em>Clear photo of the luggage and owner with the luggage (if available)</em></li></ul><h2>ขั้นตอนการปฏิบัติ / Procedure</h2><ol><li>ลูกค้าแจ้งความประสงค์ให้ผู้อื่นมารับกระเป๋าแทน พร้อมส่งเอกสารล่วงหน้า<br><em>Customer informs intention to authorize another person and sends documents in advance.</em></li><li>เจ้าหน้าที่ตรวจสอบเอกสาร หากไม่ครบให้แจ้งลูกค้า<br><em>Staff verifies documents. If incomplete, notify the customer.</em></li><li>บันทึกข้อมูลผู้รับมอบอำนาจในระบบหรือแบบฟอร์มควบคุม<br><em>Record authorized person''s information in the system or control form.</em></li><li>ตรวจสอบตัวจริงผู้รับมอบอำนาจในวันรับกระเป๋า<br><em>Verify identity of the authorized person on pickup day.</em></li><li>ถ่ายรูปผู้รับมอบอำนาจกับกระเป๋าไว้เป็นหลักฐาน<br><em>Take a photo of the authorized person with the luggage for records.</em></li><li>ให้เซ็นรับกระเป๋า และแนบสำเนาบัตรประชาชนที่รับรองแล้ว<br><em>Obtain signature and attach a certified copy of the authorized person''s ID.</em></li><li>เจ้าหน้าที่ตรวจสอบสภาพกระเป๋าต่อหน้าผู้รับ<br><em>Staff inspects luggage condition in front of the authorized person.</em></li></ol><h2>ข้อควรระวังเพิ่มเติม / Additional Precautions</h2><blockquote><ul><li>แจ้งลูกค้าให้ตรวจสอบนโยบายบริษัทล่วงหน้า<br><em>Inform customer to check company policy in advance.</em></li><li>ห้ามส่งมอบหากตรวจสอบตัวตนไม่ได้<br><em>Do not release luggage if identity cannot be verified.</em></li><li>หากสงสัยต้องแจ้งหัวหน้าสาขา<br><em>Report to branch manager if suspicious.</em></li><li>ถ่ายสำเนาและจัดเก็บเอกสารไว้อย่างน้อย 3 เดือน<br><em>Keep copies of documents for at least 3 months.</em></li></ul></blockquote><h2>หมายเหตุ / Remarks</h2><blockquote><p>บริษัทขอสงวนสิทธิ์ในการปฏิเสธการส่งมอบกระเป๋าหากเอกสารไม่ครบถ้วน หรือไม่สามารถยืนยันตัวตนได้</p><p><em>The company reserves the right to deny luggage release if documents are incomplete or identity cannot be verified.</em></p></blockquote><h2>กรณีเอกสารไม่ครบ / Missing Document Scenario</h2><ol><li><strong>ตรวจสอบเอกสารตัวจริง / Verify Original Documents</strong><ul><li>ขอให้ผู้รับแสดงเอกสารตัวจริง เช่น บัตรประชาชน หรือหนังสือเดินทาง (Request to present original documents e.g., National ID, Passport)</li><li>ถ่ายรูปเอกสารตัวจริงต่อหน้าเจ้าของ (Take a photo of the original document in the presence of the person)</li><li>ขออนุญาตจัดเก็บรูปถ่ายไว้ในระบบหรือแบบฟอร์มควบคุม (Store the photo in the system or record form with consent)</li></ul></li><li><strong>โทรยืนยันกับเจ้าของกระเป๋า / Call the Luggage Owner for Verification</strong><ul><li>โทรติดต่อเจ้าของกระเป๋าตามเบอร์ในระบบ เพื่อยืนยันตัวตนของผู้รับแทน (Call the owner using contact info in the system to confirm the identity of the authorized person)</li><li>ให้เจ้าของยืนยันข้อมูล เช่น ชื่อ เลขบัตร หรือความสัมพันธ์ (Have the owner confirm the name, ID number, or relationship)</li><li>ควรมีพยาน (เจ้าหน้าที่) รับฟังการยืนยัน (A staff member should witness the confirmation call)</li></ul></li><li><strong>บันทึกแบบฟอร์มยินยอม / Fill Consent Form for Exceptional Case</strong><ul><li>ให้ผู้รับเซ็นแบบฟอร์ม ''ยินยอมรับกระเป๋าโดยไม่มีสำเนาเอกสาร'' (Let the receiver sign a consent form for collecting luggage without document copies)</li><li>แบบฟอร์มต้องระบุข้อมูลผู้รับ เหตุผล ลายเซ็น วันเวลา ภาพถ่ายเอกสาร (Form must include personal info, reason, signature, timestamp, and document photo)</li></ul></li><li><strong>แจ้งหัวหน้าสาขา / Notify Branch Manager</strong><ul><li>ต้องได้รับอนุมัติจากหัวหน้าสาขาหรือ Supervisor ก่อนส่งมอบ (Approval from the branch manager or supervisor is required before releasing luggage)</li></ul></li></ol><h2>ห้ามดำเนินการ หาก / DO NOT proceed if:</h2><blockquote><ul><li>ไม่สามารถยืนยันตัวตนจากเจ้าของกระเป๋า / Cannot verify with the owner</li><li>ไม่มีเอกสารตัวจริงใด ๆ / No original documents presented</li><li>มีพฤติกรรมหรือลักษณะน่าสงสัย / Suspicious behavior or inconsistency in information</li></ul></blockquote><h2>เอกสารที่เกี่ยวข้อง</h2><ul><li>ใบมอบฉันทะ</li><li>หนังสือมอบฉันทะ - Letter of Authorization</li></ul><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/authorized-person-pickup/fig-2.jpg" alt="" /><img src="/docs/authorized-person-pickup/fig-3.jpg" alt="" /><img src="/docs/authorized-person-pickup/fig-4.jpg" alt="" />', cover_image = '/docs/authorized-person-pickup/fig-1.jpg' where slug = 'authorized-person-pickup';

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2><ul><li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS: 003</li><li><strong>เวอร์ชัน / Version:</strong> 2.0</li><li><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568</li><li><strong>วันที่มีการแก้ไขและปรับปรุง / Updated Date:</strong> 23 มกราคม 2569</li><li><strong>หน่วยงาน / Department:</strong> Operations</li></ul><h2>วัตถุประสงค์ (Purpose)</h2><p>เพื่อกำหนดแนวทางปฏิบัติงานที่เป็นมาตรฐานในการเปิดและปิดเคาน์เตอร์บริการ ทั้งในสาขาห้างสรรพสินค้าและสนามบิน โดยมีจุดประสงค์เพื่อให้:</p><ul><li>พนักงานสามารถปฏิบัติงานได้อย่างถูกต้อง เป็นขั้นตอน และปลอดภัย</li><li>สร้างความพร้อมในการให้บริการลูกค้าอย่างมีประสิทธิภาพ</li><li>ป้องกันการสูญหายหรือความเสียหายของทรัพย์สินและอุปกรณ์</li><li>สนับสนุนการตรวจสอบคุณภาพงานและความถูกต้องของข้อมูลรายวัน เช่น Check-in, Check-out และยอดขาย</li></ul><h2>ขอบเขต (Scope)</h2><p>แนวปฏิบัตินี้ครอบคลุมการดำเนินงานเฉพาะช่วงก่อนเริ่มงาน (เปิดเคาน์เตอร์) และหลังสิ้นสุดการให้บริการ (ปิดเคาน์เตอร์) ของพนักงาน ณ จุดให้บริการ สาขาในห้างสรรพสินค้า/ศูนย์การค้า และสาขาในสนามบิน ภายใต้แบรนด์ AIRPORTELs โดยรวมถึง:</p><ul><li>การเข้างานและออกงานผ่านแอปพลิเคชัน EMPEO</li><li>การตรวจสอบและจัดเตรียมอุปกรณ์ประจำจุดบริการ</li><li>การทำความสะอาดและจัดระเบียบพื้นที่ให้บริการ</li><li>การจัดทำและส่งรายงานยอดขายประจำวัน</li><li>การฝากเงินและการจัดการกระเป๋าหรือทรัพย์สินของลูกค้า</li><li>การจัดการกรณีสัมภาระตกค้าง/รอลูกค้าเข้ามารับ หลังเวลาการให้บริการ</li></ul><h2>สำหรับเคาน์เตอร์ในห้างสรรพสินค้า / ศูนย์การค้า (Shopping Mall)</h2><h3>ขั้นตอนการเปิดเคาน์เตอร์</h3><ol><li>สแกนหน้าเข้างานผ่านแอปพลิเคชัน EMPEO</li><li>ตรวจสอบความเรียบร้อยของเคาน์เตอร์<ul><li>ปลดล็อคประตู และเปิดผ้าคลุมเคาน์เตอร์</li><li>ตรวจดูวัตถุต้องสงสัยหรือความผิดปกติภายในและบริเวณรอบเคาน์เตอร์</li></ul></li><li>ทำความสะอาดเคาน์เตอร์<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ จอมอนิเตอร์/Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบสกปรก</li><li>กวาดและถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li></ul></li><li>เปิดอุปกรณ์ให้พร้อมใช้งาน<ul><li>คอมพิวเตอร์</li><li>เครื่องพิมพ์</li><li>เครื่อง EDC</li><li>ป้ายไฟ</li><li>จอ LED</li><li>Tablet</li><li>ระบบปรับอากาศ (แอร์)</li><li>ระบบ CCTV: ตรวจสอบว่ากล้องถูกเปิด หรือไม่ดับระหว่างวัน</li></ul></li><li>จัดวาง Tent Card และอุปกรณ์ประชาสัมพันธ์ให้ถูกต้อง ครบถ้วนตามที่กำหนด</li><li>ตรวจเช็คสัมภาระและกระเป๋าลูกค้าคงค้างให้ถูกต้องครบถ้วน<ul><li>จัดระเบียบตามลำดับการส่งคืนเพื่อให้สะดวกในการให้บริการระหว่างวัน</li></ul></li><li>ถ่ายรูปเคาน์เตอร์สำหรับ Check-in ผ่าน Lark OPEN Counter Checklist</li><li>เช็คสต๊อคสินค้าและของใช้ทุกวันอาทิตย์ (UPDATE STOCK)</li><li>ตรวจสอบ Stock KKDAY (สำหรับสาขา T21-Asok / CTW-Hugthai)<ul><li>Update Report ใน Google Sheet สำหรับแต่ละสาขา</li></ul></li><li>เตรียมความพร้อมให้บริการลูกค้า<ul><li>ตรวจสอบการแต่งกาย และการแต่งหน้า แขวนบัตรพนักงานให้เรียบร้อย พร้อมให้บริการ</li></ul></li></ol><blockquote><p><strong>หมายเหตุ:</strong> เพื่อให้พนักงานพร้อมให้บริการตามเวลาเปิดบริการ ควรมาถึงพื้นที่เพื่อเช็คอินก่อนเวลาทำการ 15 นาที</p></blockquote><h3>ขั้นตอนการปิดเคาน์เตอร์</h3><ol><li>ตรวจสอบสัมภาระตกค้าง<blockquote><p>กรณีมีสัมภาระตกค้าง สำหรับสาขาที่ปิดบริการทุกวัน (สาขาห้างฯ และสนามบินภูเก็ตทั้ง 2 สาขา, สาขาสนามบินเชียงใหม่) ให้ดำเนินการดังนี้อย่างเคร่งครัด</p><ul><li>หากมีกระเป๋าที่ลูกค้ายังไม่มารับ ให้แจ้ง CS เพื่อติดต่อลูกค้า</li><li>ให้แจ้งในกลุ่ม Lark สาขา (กรณีประสานงานและติดต่อลูกค้าแล้ว แต่ยังไม่มารับ กรณีไม่มีการตอบกลับข้อความภายใน 15 นาที ให้โทรศัพท์หา OP Team Lead เพื่อประสานงานส่วนที่เกี่ยวข้อง)</li><li>ห้ามพนักงานออกจากพื้นที่ก่อนได้รับการยืนยันจาก OP Team Lead เพื่อป้องกันความเสียหาย กรณีลูกค้ามีไฟล์ทบินและจำเป็นต้องรับกระเป๋าภายในคืนนั้น</li></ul></blockquote></li><li>นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</li><li>ปิดอุปกรณ์ต่าง ๆ<ul><li>คอมพิวเตอร์</li><li>เครื่องพิมพ์</li><li>เครื่อง EDC</li><li>ป้ายไฟ</li><li>จอ LED</li><li>Tablet</li><li>ระบบปรับอากาศ (แอร์)</li></ul></li><li>ทำความสะอาดเคาน์เตอร์<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ จอมอนิเตอร์/Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบสกปรก</li><li>กวาดและถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li><li>ทิ้งขยะ</li></ul></li><li>เก็บ Tent Card และอุปกรณ์ประชาสัมพันธ์<ul><li>ตรวจสอบหากมีชำรุดเสียหาย ให้แจ้งหัวหน้าสาขา เพื่อประสานงานนำชิ้นใหม่ไปเปลี่ยน</li></ul></li><li>ตรวจสอบอุปกรณ์ต่าง ๆ หากมีชำรุดเสียหายให้แจ้งซ่อม<ul><li>ช่องทางการแจ้งซ่อม AIMS Help Center</li></ul></li><li>ถ่ายรูปเคาน์เตอร์สำหรับ Check-out ผ่าน Lark CLOSE Counter Checklist</li><li>ตรวจสอบและล็อคเคาน์เตอร์<ul><li>คลุมผ้าคลุม และล็อคตู้ ประตูให้เรียบร้อย</li></ul></li><li>สแกนหน้าออกงานผ่านแอปพลิเคชัน EMPEO</li><li>ฝากเงินสดเข้าบัญชีบริษัท และแนบหลักฐานการโอนใน Lark</li></ol><h2>สำหรับเคาน์เตอร์ในสนามบิน (AIRPORT)</h2><h3>ขั้นตอนการเปิดเคาน์เตอร์</h3><ol><li>สแกนหน้าเข้างานผ่านแอปพลิเคชัน EMPEO</li><li>ตรวจสอบความเรียบร้อยของเคาน์เตอร์<ul><li>ตรวจดูวัตถุต้องสงสัยหรือความผิดปกติภายในและบริเวณรอบเคาน์เตอร์</li></ul></li><li>ทำความสะอาดเคาน์เตอร์บริการตามรอบที่กำหนด (เช้า, เย็น และระหว่างวัน)<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ จอมอนิเตอร์/Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบสกปรก</li><li>กวาดและถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li></ul></li><li>ถ่ายรูปเคาน์เตอร์สำหรับ Check-in ผ่าน Lark OPEN Counter Checklist</li><li>ตรวจสอบ Stock KKDAY ทั้ง 3 กะที่เข้างาน (สำหรับสนามบินสุวรรณภูมิและดอนเมือง) และส่งรายงานตามช่องทางดังนี้<ul><li>Lark กลุ่ม</li></ul></li><li>เตรียมพร้อมให้บริการลูกค้า<ul><li>ตรวจสอบการแต่งกาย และการแต่งหน้า แขวนบัตรพนักงานให้เรียบร้อย พร้อมให้บริการ</li></ul></li></ol><blockquote><p><strong>หมายเหตุ:</strong> เพื่อให้พนักงานพร้อมให้บริการตามเวลาเปิดบริการ ควรมาถึงพื้นที่เพื่อเช็คอินและรับมอบงาน เพื่อส่งต่อรอบ ก่อนเวลาทำการ 15 นาที</p></blockquote><h3>ขั้นตอนการปิดเคาน์เตอร์</h3><ol><li>ตรวจสอบสัมภาระตกค้าง<blockquote><ul><li>กรณีมีสัมภาระตกค้าง สำหรับสาขาที่ปิดบริการทุกวัน (สาขาห้างฯ และสนามบินภูเก็ตทั้ง 2 สาขา, สาขาสนามบินเชียงใหม่) ให้ดำเนินการดังนี้อย่างเคร่งครัด</li><li>มีกระเป๋าที่ลูกค้ายังไม่มารับ ให้แจ้ง CS เพื่อติดต่อลูกค้า (กรณีนอกเวลางาน ให้แจ้งในกลุ่ม Lark CS สาขา เพื่อประสานงาน)</li><li>ให้แจ้งในกลุ่ม Lark CS สาขา (กรณีประสานงานและติดต่อลูกค้าแล้ว แต่ยังไม่มารับ กรณีไม่มีการตอบกลับข้อความภายใน 15 นาที ให้โทรศัพท์หา OP Team Lead เพื่อประสานงานส่วนที่เกี่ยวข้อง)</li><li>ห้ามพนักงานออกจากพื้นที่ก่อนได้รับการยืนยันจาก OP Team Lead เพื่อป้องกันความเสียหาย กรณีลูกค้ามีไฟล์ทบินและจำเป็นต้องรับกระเป๋าภายในคืนนั้น</li></ul></blockquote></li><li>สำหรับสาขาที่เปิดบริการ 24 ชม. หากมีการเปลี่ยนกะพนักงาน ให้ส่งต่อข้อมูลงานและข้อมูลลูกค้ากันให้เรียบร้อย กรณีเกิดปัญหาจะได้ตรวจสอบและแก้ไขปัญหาได้ทันท่วงที</li><li>นับเงินและส่ง Sales Report ผ่าน Lark Daily Sales Report</li><li>ทำความสะอาดเคาน์เตอร์<ul><li>เช็ดทำความสะอาดเคาน์เตอร์บริการ จอมอนิเตอร์/Tablet และพื้นที่โดยรอบไม่ให้มีฝุ่น ขยะ หรือคราบสกปรก</li><li>กวาดและถูพื้นโดยอุปกรณ์ทำความสะอาดที่จัดเตรียมให้</li><li>ทิ้งขยะ</li></ul></li><li>ตรวจสอบอุปกรณ์ต่าง ๆ หากมีชำรุดเสียหายให้แจ้งซ่อม<ul><li>ช่องทางการแจ้งซ่อม AIMS Help Center</li></ul></li><li>ถ่ายรูปเคาน์เตอร์สำหรับ Check-out ผ่าน Lark CLOSE Counter Checklist</li><li>สแกนหน้าออกงานผ่านแอปพลิเคชัน EMPEO</li><li>ฝากเงินสดเข้าบัญชีบริษัท และแนบหลักฐานการโอนใน Lark Daily Sales Report</li></ol><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/open-close-counter/fig-2.jpg" alt="" /><img src="/docs/open-close-counter/fig-3.jpg" alt="" /><img src="/docs/open-close-counter/fig-4.jpg" alt="" /><img src="/docs/open-close-counter/fig-5.jpg" alt="" /><img src="/docs/open-close-counter/fig-6.jpg" alt="" /><img src="/docs/open-close-counter/fig-7.jpg" alt="" />', cover_image = '/docs/open-close-counter/fig-1.jpg' where slug = 'open-close-counter';

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2><ul><li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 013/2025</li><li><strong>เวอร์ชัน / Version:</strong> 1.0</li><li><strong>วันที่บังคับใช้ / Effective Date:</strong> 4 สิงหาคม 2568</li><li><strong>หน่วยงาน / Department:</strong> Operations</li></ul><h2>วัตถุประสงค์ / Purpose</h2><p>เพื่อให้พนักงานหน้าสาขา AIRPORTELs ให้บริการลูกค้า YOOWIFI ได้อย่างมีมาตรฐาน ถูกต้อง และป้องกันความผิดพลาดในการส่งมอบอุปกรณ์</p><h2>ขอบเขตการใช้งาน / Scope</h2><p>ใช้สำหรับพนักงาน Guest Service ประจำสาขาของ AIRPORTELs ที่ให้บริการรับ-ส่งอุปกรณ์ YOOWIFI แก่ลูกค้า ณ จุดให้บริการสนามบินหรือจุดให้บริการอื่นที่ได้รับมอบหมาย</p><ul><li>กรณีที่ลูกค้าทำการจองอุปกรณ์ YOOWIFI ล่วงหน้า และมารับอุปกรณ์ที่จุดให้บริการ / ส่งคืนอุปกรณ์หลังใช้งานเสร็จสิ้น</li><li>ขั้นการให้บริการครอบคลุมตั้งแต่ขั้นตอนการแจ้งข้อมูลลูกค้า จนถึงการรับ-ส่งคืนอุปกรณ์</li></ul><h2>ขั้นตอนการปฏิบัติ / Procedure</h2><h3>1. รับแจ้งข้อมูลลูกค้า</h3><ul><li><strong>ผู้แจ้ง:</strong> ทีม YOOWIFI / คุณเมจิ</li><li><strong>ช่องทาง:</strong> กลุ่ม LINE</li><li>รายละเอียดการแจ้ง ดังนี้:<ul><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Passport no.</li><li>Booking no.</li><li>จำนวนเครื่อง (Quantity)</li><li>จุดรับ-คืนเครื่อง (Pick-up point)</li><li>วันที่-เวลารับเครื่อง (Pick-up &amp; Return Date)</li><li>IMEI no. &amp; Password (ถ้ามี)</li><li>รายละเอียดอื่น ๆ (ถ้ามี)</li></ul></li><li>แนบลิงก์ Google Sheet สำหรับตรวจสอบข้อมูล (รวมกับใน LINE Group) เพื่อป้องกันข้อมูลตกหล่น หรือแจ้งลำดับการอัพเดตข้อมูล</li></ul><img src="/docs/yoowifi-service/fig-2.jpg" alt="" /><p><em>ตัวอย่างการแจ้งข้อมูลใน LINE Group</em></p><h3>2. พนักงาน Guest Service ตรวจสอบข้อมูลใน Google Sheet</h3><ul><li>เข้าลิงก์เอกสาร Google Sheet ที่แจ้งในไลน์</li><li>ตรวจสอบข้อมูลลูกค้า ได้แก่:<ul><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Passport no.</li><li>Booking no.</li><li>จำนวนเครื่อง (Quantity)</li><li>IMEI no. ให้ตรงกับเครื่องที่จะเตรียม</li></ul></li></ul><h3>3. เตรียมอุปกรณ์ให้พร้อมสำหรับให้บริการ</h3><ul><li>ชาร์จแบตเตอรี่อุปกรณ์ให้เต็ม</li><li>ตรวจสอบความเรียบร้อย และความครบถ้วนของอุปกรณ์:<ul><li>ตัวเครื่อง WiFi</li><li>สายชาร์จ</li><li>ซองใส่</li></ul></li><li>เขียนหรือพิมพ์ข้อมูลติดหน้าเครื่อง ให้มีรายละเอียดดังนี้:<ul><li>ชื่อ-นามสกุลลูกค้า (Name)</li><li>Booking no.</li><li>Passport no.</li><li>พาสเวิร์ด WiFi (ถ้ามี)</li></ul></li></ul><img src="/docs/yoowifi-service/fig-3.jpg" alt="" /><p><em>ตัวอย่างการจัดเตรียมอุปกรณ์ และปริ้นท์ข้อมูลลูกค้า</em></p><h3>4. ส่งมอบอุปกรณ์ให้ลูกค้า</h3><p><strong>ขั้นตอนการยืนยันตัวตน:</strong></p><ol><li>ขอให้ลูกค้าแสดง Booking No. หรือหน้าจอการจอง (Reservation Confirmation)<img src="/docs/yoowifi-service/fig-4.jpg" alt="" /><p><em>ตัวอย่างข้อมูลการจองจากลูกค้า แสดงแก่เจ้าหน้าที่ Guest Service เมื่อมารับเครื่อง</em></p></li><li>ถ้าลูกค้าไม่มี Booking No. ให้สอบถามชื่อ-นามสกุลเพื่อค้นหาข้อมูลใน Google Sheet</li><li>ตรวจสอบพาสปอร์ตลูกค้า</li><li>ข้อมูลลูกค้าที่มารับเครื่องฯ ต้องตรงกับชื่อที่แสดงใน LINE Group / Booking no. / Google Sheet ที่ทางคุณเมจิแจ้ง</li><li>เมื่อยืนยันข้อมูลถูกต้อง ตรงกันแล้ว ให้ถ่ายรูปเพื่อแจ้งใน LINE Group:<ul><li>ตัวเครื่อง WiFi ที่จะส่งมอบ (ให้เห็น IMEI no. ชัดเจน)</li><li>หน้าพาสปอร์ตของลูกค้า (เฉพาะหน้าแสดงชื่อ-รูปถ่าย)</li><li>ส่งภาพทั้งหมดเข้าใน LINE Group เพื่อยืนยันการส่งมอบ</li></ul><img src="/docs/yoowifi-service/fig-5.jpg" alt="" /><p><em>ตัวอย่างการถ่ายรูปและแจ้งข้อมูลใน LINE Group</em></p></li><li>กรณีลูกค้าไม่ได้มารับด้วยตนเอง หรือให้ผู้อื่นมารับแทน จะมีการแจ้งข้อมูลล่วงหน้าจากคุณเมจิใน LINE Group<img src="/docs/yoowifi-service/fig-6.jpg" alt="" /><p><em>ตัวอย่างการแจ้งข้อมูลกรณีให้ผู้อื่นมารับแทนใน LINE Group</em></p></li><li>กรณีลูกค้าให้ผู้อื่นมารับแทน และไม่มีการแจ้งล่วงหน้าจากคุณเมจิ ให้สอบถามเข้าไปใน LINE Group เพื่อตรวจสอบก่อนทำการจัดเตรียมอุปกรณ์และส่งมอบ โดยแจ้งลูกค้าดังนี้:<ul><li>แจ้งให้ลูกค้ารอสักครู่ เพื่อตรวจสอบข้อมูล</li><li>แจ้งระยะเวลาจัดเตรียมอุปกรณ์ (กรณีมีอุปกรณ์อยู่ที่สาขา และข้อมูลตกหล่นจากทางคุณเมจิ)</li><li>ส่งมอบอุปกรณ์ตามขั้นตอนการส่งมอบ และแจ้งข้อมูลลูกค้าพร้อมรูปภาพใน LINE Group</li></ul></li></ol><h3>5. การรับคืนอุปกรณ์ (หากลูกค้ามาคืนที่สาขา)</h3><ul><li>ตรวจสอบสภาพเครื่องภายนอกและความครบถ้วนของอุปกรณ์:<ul><li>ถ่ายภาพตัวเครื่อง WiFi ที่จะรับคืน (ให้เห็น IMEI no. ชัดเจน)</li><li>หน้าพาสปอร์ตของลูกค้า (เฉพาะหน้าแสดงชื่อ-รูปถ่าย)</li></ul></li><li>ส่งภาพทั้งหมดเข้าใน LINE Group เพื่อยืนยันการรับคืน เพื่อแจ้งการคืนทันที</li></ul><img src="/docs/yoowifi-service/fig-7.jpg" alt="" /><p><em>ตัวอย่างการถ่ายรูปและแจ้งข้อมูลใน LINE Group</em></p><h2>Checklist สำหรับพนักงาน (ส่งมอบเครื่อง)</h2><ul><li>ตรวจสอบข้อมูลใน LINE Group และ Google Sheet</li><li>เตรียมเครื่องครบ / แบตเต็ม</li><li>ลูกค้าแสดง Booking No. หรือหน้าการจอง</li><li>ตรวจสอบพาสปอร์ตให้ข้อมูลถูกต้อง ตรงกับที่คุณเมจิแจ้ง</li><li>ถ่ายภาพเครื่อง + พาสปอร์ต</li><li>ส่งภาพยืนยันใน LINE กลุ่ม</li></ul><h2>ข้อควรระวัง</h2><blockquote><ul><li><strong>ห้าม</strong> ส่งมอบอุปกรณ์หากไม่สามารถยืนยันตัวตนลูกค้าได้ (ข้อมูลในพาสปอร์ตไม่ตรงกับที่แจ้ง)</li><li><strong>ห้ามลืม</strong> ถ่ายภาพทุกครั้งที่มีการมอบหรือรับคืนอุปกรณ์</li><li>ตรวจสอบพาสเวิร์ด (ถ้ามี) และอุปกรณ์ทุกชิ้นก่อนมอบให้ลูกค้า</li></ul></blockquote>', cover_image = '/docs/yoowifi-service/fig-1.jpg' where slug = 'yoowifi-service';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 0017/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 3 ตุลาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p><h2>วัตถุประสงค์ (Objective)</h2><p>เพื่อกำหนดขั้นตอนการใช้งานเครื่อง EDC สำหรับการรับชำระเงินด้วยบัตรเครดิต, Thai QR Payment, Alipay, WeChat และการพิมพ์รายงานสรุปยอดประจำวัน ให้เป็นมาตรฐานเดียวกันในทุกสาขา ลดความผิดพลาดและเพิ่มประสิทธิภาพในการให้บริการลูกค้า</p><h2>ขอบเขต (Scope)</h2><p>คู่มือการปฏิบัติงานนี้ครอบคลุมถึง</p><ul><li>พนักงานสาขาที่มีหน้าที่รับชำระเงิน</li><li>การรับชำระเงินผ่านเครื่อง EDC ทุกประเภท (Credit Card / QR / e-Wallet / e-payment)</li><li>การจัดการสลิป การยกเลิกรายการ และการสรุปยอดประจำวัน</li></ul><h2>ขั้นตอนการปฏิบัติ (Procedure)</h2><h3>1. การเตรียมเครื่อง EDC</h3><ul><li>ตรวจสอบว่าเครื่อง EDC ชาร์จไฟเพียงพอ หรือเชื่อมต่อกับแหล่งจ่ายไฟ</li><li>ตรวจสอบสัญญาณ GPRS/Wi-Fi ให้พร้อมใช้งาน</li></ul><blockquote><p>NOTE: กรณีเครื่อง EDC ไม่จับสัญญาณ GPRS, เครื่อง EDC ทำรายการไม่ได้, เครื่องค้าง, หน้าจอค้าง ให้ทำการ Restart เครื่อง EDC</p></blockquote><h3>2. การใส่ม้วนสลิป</h3><ul><li>เปิดฝาช่องใส่ม้วนกระดาษ</li><li>ใส่ม้วนสลิปโดยให้ด้านกระดาษออกทางด้านบน</li><li>ปิดฝาเครื่อง และดึงกระดาษออกมาเล็กน้อยเพื่อทดสอบ</li></ul><p>ดึงฝาครอบม้วนสลิปขึ้น เพื่อนำแกนกระดาษสลิปของเดิมออก จากนั้นใส่ม้วนกระดาษสลิปใหม่ลงไป พร้อมดึงปลายกระดาษออกมาเล็กน้อย แล้วจึงปิดฝาครอบให้สนิทตามเดิม</p><img src="/docs/edc-machine/fig-2.jpg" alt="" /><p><em>ขั้นตอนการเปลี่ยน/ใส่ม้วนกระดาษสลิปลงในเครื่อง EDC</em></p><h3>3. การรับชำระเงินด้วย QR Payment / Alipay / WeChat</h3><ul><li>กดปุ่มเลือกโหมด QR Payment</li><li>ใส่จำนวนเงินที่ต้องการรับ</li><li>ให้ลูกค้าสแกน QR จากหน้าจอเครื่อง</li><li>รอการยืนยัน หากสำเร็จ เครื่องจะพิมพ์สลิปอัตโนมัติ</li></ul><blockquote><p>NOTE: หากยอดเงินไม่เข้าหรือลูกค้ายังไม่ทำการยืนยันการโอน สลิปจะไม่ออกจากตัวเครื่อง หากต้องการสแกนจ่ายใหม่ให้กดยกเลิกและกดชำระด้วย QR ใหม่</p></blockquote><p>ขั้นตอนโดยละเอียด:</p><ol><li>กด OK ที่เครื่อง EDC</li><li>หน้าจอแสดงให้เลือกประเภทที่ต้องการ</li><li>กดจำนวนเงินที่ต้องการชำระ</li><li>เครื่อง EDC จะขึ้น QR ให้ลูกค้าสแกน</li><li>เมื่อลูกค้าโอนยอดสำเร็จแล้ว กดยืนยันจะมีใบเสร็จออกมาจากตัวเครื่อง</li><li>ฉีกสลิปให้ลูกค้า</li><li>พนักงานเก็บสลิปไว้เป็นหลักฐาน</li></ol><img src="/docs/edc-machine/fig-3.jpg" alt="" /><p><em>ลำดับหน้าจอเครื่อง EDC การรับชำระด้วย QR และตัวอย่างหน้าจอสลิปการโอนจากลูกค้า</em></p><h3>4. การรับชำระเงินด้วยบัตรเครดิต</h3><ul><li>ใส่จำนวนเงินที่ต้องการรับ</li><li>เสียบ / รูด / แตะบัตรเครดิต ตามที่ระบบรองรับ</li><li>หากต้องใส่รหัส PIN ให้ลูกค้ากรอกด้วยตนเอง</li><li>เครื่องพิมพ์สลิปออกมา ตรวจสอบความถูกต้อง</li><li>คืนบัตรและมอบสลิปให้ลูกค้า</li></ul><p>ขั้นตอนโดยละเอียด:</p><ol><li>หน้าจอเครื่องปกติ</li><li>ใส่จำนวนที่ลูกค้าต้องการชำระในรูปแบบทศนิยม 2 หลัก แล้วกด OK</li><li>สอด รูด หรือแตะบัตร</li><li>ตรวจสอบหมายเลขบัตรและยอดเงิน</li><li>เครื่องจะพิมพ์ Sales Slip สำหรับร้านค้า ฉีกให้ผู้ถือบัตรเซ็นรับรอง และร้านค้าเก็บไว้เป็นหลักฐาน</li><li>เครื่องจะพิมพ์ Sales Slip สำหรับผู้ถือบัตร ส่งมอบให้ผู้ถือบัตรเก็บไว้เป็นหลักฐาน</li></ol><img src="/docs/edc-machine/fig-4.jpg" alt="" /><p><em>ลำดับหน้าจอเครื่อง EDC การรับชำระด้วยบัตรเครดิตและตัวอย่าง Sales Slip</em></p><h3>5. การยกเลิกรายการ (Void Transaction)</h3><ul><li>กดเลือกเมนู ยกเลิกรายการ (Void)</li><li>ใส่หมายเลขอ้างอิงของรายการที่ต้องการยกเลิก</li><li>ยืนยันการทำรายการ เครื่องพิมพ์สลิปยกเลิก</li></ul><blockquote><p>NOTE: ห้ามคืนเงินสด (เงินทอน) ให้แก่ลูกค้าโดยเด็ดขาด กรณีกดยอดชำระผิด ให้ทำการยกเลิกรายการ (Void) ผ่านเครื่อง EDC และทำรายการใหม่ให้ถูกต้อง พร้อมส่งสลิปทั้งที่ VOID และสลิปตัวจริงที่ถูกต้อง แม็กให้ลูกค้า และพนักงานถ่ายภาพสลิปแนบใน Sales Report ท้ายตารางหลังหมายเหตุ</p></blockquote><p>ขั้นตอนโดยละเอียด:</p><ol><li>กด F2 เลือก VOID</li><li>กรอกรหัสผ่าน 1111 กด OK</li><li>กรอกหมายเลข TRACE # กด OK</li><li>กด OK ยืนยัน</li><li>กำลังทำรายการ</li><li>รายการอนุมัติ</li><li>พิมพ์สลิปให้ลูกค้า กด OK</li><li>เครื่องพิมพ์สลิป</li></ol><img src="/docs/edc-machine/fig-5.jpg" alt="" /><p><em>ลำดับหน้าจอการยกเลิกรายการ (Void) บนเครื่อง EDC</em></p><h3>6. การสรุปยอดประจำวัน (Settlement)</h3><ul><li>กดเลือกเมนู สรุปยอด (Settlement)</li><li>รอเครื่องประมวลผล</li><li>เครื่องพิมพ์สรุปยอดออกมา</li><li>ตรวจสอบยอดรวม และเก็บสลิปสรุปไว้เป็นหลักฐาน</li><li>ฉีกสลิปที่ออกมาแต่ละรายการ เช็คยอดเงินว่าครบแล้วจึงนำมาเย็บเข้ากับสลิปรวมทั้งหมด</li></ul><p>ขั้นตอนโดยละเอียด:</p><ol><li>กด F1 เลือก "โอนยอดเงิน"</li><li>กด 2 เลือก โอนยอดทั้งหมด</li><li>กรอกรหัสผ่าน 1111 กด OK</li><li>กด OK ยืนยัน</li><li>กำลังทำรายการ</li><li>ทำรายการโอนยอดสำเร็จ</li></ol><img src="/docs/edc-machine/fig-6.jpg" alt="" /><p><em>ลำดับหน้าจอการสรุปยอดประจำวัน (Settlement) บนเครื่อง EDC</em></p><h3>7. วิธีการพิมพ์ซ้ำสรุปยอด (การพิมพ์รายงานย้อนหลัง)</h3><ul><li>กดเลือกเมนู พิมพ์ซ้ำ / รายงาน</li><li>เลือกประเภทที่ต้องการ เช่น สรุปยอดย้อนหลัง</li><li>เครื่องจะพิมพ์เอกสารออกมา</li></ul><p>ขั้นตอนโดยละเอียด:</p><ol><li>กด F4 เลือก "REPRINT"</li><li>กด 3 เลือก "โอนยอดล่าสุด"</li><li>เลือกรายการ</li><li>เครื่องพิมพ์สลิป "โอนยอดล่าสุด"</li></ol><img src="/docs/edc-machine/fig-7.jpg" alt="" /><p><em>ลำดับหน้าจอการพิมพ์รายงานย้อนหลัง (REPRINT) บนเครื่อง EDC</em></p><h2>การแก้ไขปัญหาพื้นฐาน (Troubleshooting)</h2><ul><li>เครื่องไม่มีสัญญาณ / ค้าง → Restart เครื่อง</li><li>สลิปไม่ออก → ตรวจสอบม้วนกระดาษ</li><li>QR ไม่ขึ้นยอด → กด "ยกเลิก" และทำรายการใหม่</li></ul><p>ดูเพิ่มเติม: วิธีการตรวจสอบรายการจาก e-Slip ของผู้ชำระ และ Response/Error Code ที่พบบ่อยพร้อมแนวทางแก้ไข</p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/edc-machine/fig-8.jpg" alt="" /><img src="/docs/edc-machine/fig-9.jpg" alt="" /><img src="/docs/edc-machine/fig-10.jpg" alt="" /><img src="/docs/edc-machine/fig-11.jpg" alt="" /><img src="/docs/edc-machine/fig-12.jpg" alt="" /><img src="/docs/edc-machine/fig-13.jpg" alt="" /><img src="/docs/edc-machine/fig-14.jpg" alt="" /><img src="/docs/edc-machine/fig-15.jpg" alt="" /><img src="/docs/edc-machine/fig-16.jpg" alt="" /><img src="/docs/edc-machine/fig-17.jpg" alt="" /><img src="/docs/edc-machine/fig-18.jpg" alt="" /><img src="/docs/edc-machine/fig-19.jpg" alt="" /><img src="/docs/edc-machine/fig-20.jpg" alt="" /><img src="/docs/edc-machine/fig-21.jpg" alt="" /><img src="/docs/edc-machine/fig-22.jpg" alt="" /><img src="/docs/edc-machine/fig-23.jpg" alt="" /><img src="/docs/edc-machine/fig-24.jpg" alt="" /><img src="/docs/edc-machine/fig-25.jpg" alt="" /><img src="/docs/edc-machine/fig-26.jpg" alt="" /><img src="/docs/edc-machine/fig-27.jpg" alt="" /><img src="/docs/edc-machine/fig-28.jpg" alt="" /><img src="/docs/edc-machine/fig-29.jpg" alt="" /><img src="/docs/edc-machine/fig-30.jpg" alt="" /><img src="/docs/edc-machine/fig-31.jpg" alt="" /><img src="/docs/edc-machine/fig-32.jpg" alt="" /><img src="/docs/edc-machine/fig-33.jpg" alt="" /><img src="/docs/edc-machine/fig-34.jpg" alt="" />', cover_image = '/docs/edc-machine/fig-1.jpg' where slug = 'edc-machine';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 007/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p><h2>วัตถุประสงค์ (Objective)</h2><p>เพื่อกำหนดขั้นตอนที่เป็นมาตรฐานในการเรียกเก็บเงินจากลูกค้าผ่านบัตรเครดิตแบบออนไลน์ โดยใช้ระบบหลังบ้านของ AIRPORTELs เพื่อให้การรับชำระเป็นไปอย่างถูกต้อง ตรวจสอบได้ และลดข้อผิดพลาด</p><p><em>To standardize the steps for requesting online credit card payments via AIRPORTELs'' back-office system, ensuring accuracy and traceability.</em></p><h2>ขอบเขต (Scope)</h2><p>ใช้สำหรับพนักงานที่ปฏิบัติงานในสาขา หรือตำแหน่งที่เกี่ยวข้องกับการเรียกเก็บเงินจากลูกค้าในกรณีต้องชำระผ่านช่องทางออนไลน์</p><p><em>Applicable to branch staff or related roles responsible for collecting customer payments via online channels.</em></p><h2>ขั้นตอนการดำเนินงาน (Procedure)</h2><ul><li>สำหรับใช้รับชำระผ่านระบบ Online EDC</li><li>ลิงก์เข้าสู่ระบบหลังบ้าน กรณีเครื่องหน้าสาขามีปัญหาไม่สามารถใช้งานได้: <a href="https://postels.airportels.asia/admin/order/browse">https://postels.airportels.asia/admin/order/browse</a></li></ul><p>วิธีการดำเนินการตามตัวอย่างดังนี้</p><ol><li>ค้นหาออเดอร์ที่หลังบ้าน AIRPORTELs</li><li>กด Request Payment</li><li>ใส่จำนวนเงิน และกด Generate Link</li><li>ลิงก์ช่องทางการจ่ายเงินจะขึ้น</li><li>Copy link เพื่อไปสร้าง QR Code</li><li>หลังจากนั้นให้ลูกค้าสแกนจ่ายเครดิตการ์ดแบบ Online</li><li>เสร็จเรียบร้อย หลังจากนั้นหลังบ้านจะขึ้นประวัติการชำระอัตโนมัติ</li></ol><blockquote><p>หมายเหตุ: หากยังไม่ขึ้นประวัติการชำระ ให้รีบติดต่อหัวหน้าทันที</p></blockquote><img src="/docs/online-credit-card-payment/fig-2.jpg" alt="" /><p><em>ตัวอย่างหน้าจอระบบหลังบ้าน AIRPORTELs การกด Request Payment, Generate Link และสร้าง QR Code</em></p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/online-credit-card-payment/fig-3.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-4.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-5.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-6.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-7.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-8.jpg" alt="" /><img src="/docs/online-credit-card-payment/fig-9.jpg" alt="" />', cover_image = '/docs/online-credit-card-payment/fig-1.jpg' where slug = 'online-credit-card-payment';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS: 002<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 16 มิถุนายน 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p><h2>เกณฑ์การรับชำระเงินสด</h2><ul><li>รับชำระเงินสดที่ยอดต่ำกว่าหรือเท่ากับ 100 บาท สำหรับทุกสาขา</li><li>รับชำระเงินสดที่ยอดต่ำกว่าหรือเท่ากับ 150 บาท สำหรับสาขาสนามบินภูเก็ต (International &amp; Domestic)</li></ul><h2>วัตถุประสงค์ (Purpose)</h2><p>เพื่อให้พนักงานสามารถสื่อสารกับลูกค้าได้อย่างถูกต้องและมีมาตรฐานเดียวกันในการให้บริการช่วงเปลี่ยนผ่านไปสู่ระบบไร้เงินสด</p><p><em>To ensure clear communication and consistent service when enforcing the cashless payment policy.</em></p><h2>ขอบเขต (Scope)</h2><p>ใช้สำหรับเคาน์เตอร์บริการของ AIRPORTELs ทุกสาขา ทั้งบริการรับฝากและจัดส่งกระเป๋า</p><p><em>Applicable at all AIRPORTELs counters for all services including luggage storage and delivery.</em></p><h2>หมายเหตุเพิ่มเติม (Additional Notes)</h2><ul><li>ติดโปสเตอร์ "We''re Going Cashless" ให้เห็นชัดเจนหน้าสาขา<br><em>Display the "We''re Going Cashless" poster clearly at the counter.</em></li><li>ห้ามเรียกรับเงินสดหากยอดเท่ากับหรือมากกว่า 100 บาท<br><em>Staff must not request cash for amounts ≥100 THB.</em></li><li>หากลูกค้าต้องการจ่ายเงินสด ให้ชี้แจงด้วยความสุภาพว่าเป็นนโยบายใหม่ของบริษัท<br><em>If customer insists on paying cash, politely explain the policy.</em></li></ul><h2>การจัดการกรณีพิเศษ / แนวทางการดำเนินการแบบเป็นขั้นตอน (Step-by-Step Handling Process)</h2><h3>Script สำหรับพนักงานบริการลูกค้า (2 ภาษา)</h3><h3>กรณีทั่วไปที่ลูกค้าปฏิเสธ Cashless</h3><p><strong>ไทย:</strong></p><blockquote><p>"ต้องขออภัยค่ะ ตอนนี้ทางบริษัทเราดำเนินการเปลี่ยนเป็นระบบชำระเงินแบบไร้เงินสด สำหรับยอด 150 บาทขึ้นไปค่ะ ท่านสามารถชำระผ่านบัตรเครดิต เดบิต หรือ พร้อมเพย์ QR ได้เลยค่ะ ไม่มีค่าธรรมเนียมเพิ่มเติมนะคะ หากคุณไม่สะดวกตรงไหน ทางเรายินดีช่วยแนะนำวิธีที่สะดวกที่สุดค่ะ"</p></blockquote><p><strong>English:</strong></p><blockquote><p>"I''m sorry, but for payments of 150 THB or more, we now accept only cashless methods. You can pay by credit card, debit card, or QR code, and there''s no extra fee. If you need help, I''d be happy to assist you with the process."</p></blockquote><h3>กรณีลูกค้าต่างชาติอยากใช้เงินสดที่แลกมาให้หมด</h3><p><strong>ไทย:</strong></p><blockquote><p>"เข้าใจเลยค่ะว่าลูกค้าอยากใช้เงินสดที่แลกมาให้หมดนะคะ อย่างไรก็ตาม เนื่องจากนโยบายใหม่ของบริษัท สำหรับยอด 100 บาทขึ้นไป จะรับเฉพาะช่องทางไร้เงินสดค่ะ เราสามารถแนะนำวิธีที่ง่าย เช่น สแกน QR ด้วยมือถือ หรือใช้บัตรเครดิตได้เลยค่ะ หากต้องการเราช่วยแนะนำได้นะคะ"</p></blockquote><p><strong>English:</strong></p><blockquote><p>"I totally understand that you''d like to use up your Thai currency. However, due to our new policy, we only accept cashless payment for amounts over 100 THB. We can help you pay via QR code or card. Please tell us if you need any help!"</p></blockquote><h3>1. กำหนดมาตรการรองรับ – กรณีไม่สามารถชำระแบบ Cashless ได้</h3><p>เช่น ระบบล่ม / เครื่องรูดบัตรเสีย / ลูกค้าไม่มีอุปกรณ์ / ไม่มีแอปธนาคารไทย ฯลฯ ให้มีแนวทางสำรองรองรับ</p><h3>2. มาตรการกรณีลูกค้าปฏิเสธชำระแบบ Cashless (Cashless Policy Exception Guideline)</h3><p>ดำเนินการตามสคริปต์สื่อสารข้างต้น</p><h3>3. นโยบาย (Policy Summary)</h3><p><strong>ชื่อ:</strong> Cashless Enforcement &amp; Exception Policy<br><strong>ใช้บังคับ:</strong> พนักงานทุกคนที่หน้าสาขา</p><p><strong>หลักเกณฑ์:</strong></p><ul><li>ยอดชำระ 100 บาทขึ้นไป ต้องใช้ช่องทางไร้เงินสดเท่านั้น</li><li>ไม่สามารถขอรับเงินสดได้ ยกเว้นในกรณี:<ul><li>ระบบล่ม</li><li>ลูกค้าไม่มีช่องทางอื่น และได้รับอนุมัติจากหัวหน้า</li><li>กรณีลูกค้าต่างชาติที่ไม่สามารถดำเนินการผ่านระบบไทยได้จริง</li></ul></li></ul><h3>4. แบบฟอร์มบันทึกเคสกรณียกเว้น (Exception Handling Form)</h3><p>ใช้บันทึกทุกครั้งที่ต้อง "อนุโลม" การรับเงินสดในระบบ Cashless ในช่อง Remark "หมายเหตุ" ใน Sales Report ตามตัวอย่าง และต้องแจ้งผู้จัดการสาขา (สำหรับสาขาที่มีผู้จัดการ) หรือ Guest Service Executive (นิว) / Guest Service Assistant (มายด์ หรือ เน) ทุกครั้ง</p><img src="/docs/cashless-payment-policy/fig-2.jpg" alt="" /><p><em>ตัวอย่างการบันทึกกรณียกเว้นในช่อง Remark "หมายเหตุ" ใน Sales Report</em></p><h2>SOP ที่เกี่ยวข้อง</h2><ul><li>ขั้นตอนการชำระเงินด้วยบัตรเครดิตแบบออนไลน์</li></ul><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/cashless-payment-policy/fig-3.jpg" alt="" /><img src="/docs/cashless-payment-policy/fig-4.jpg" alt="" /><img src="/docs/cashless-payment-policy/fig-5.jpg" alt="" /><img src="/docs/cashless-payment-policy/fig-6.jpg" alt="" /><img src="/docs/cashless-payment-policy/fig-7.jpg" alt="" />', cover_image = '/docs/cashless-payment-policy/fig-1.jpg' where slug = 'cashless-payment-policy';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 006/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p><h2>วัตถุประสงค์ (Objective)</h2><p>เพื่อควบคุมและติดตามปริมาณสต๊อกของใช้ประจำสาขาให้มีความถูกต้อง ป้องกันของขาด และสนับสนุนการวางแผนจัดส่งสินค้าได้อย่างมีประสิทธิภาพ</p><h2>ขอบเขต (Scope)</h2><p>SOP นี้สำหรับพนักงานตำแหน่ง Guest Service / Branch Manager / Porter ทุกคนที่ปฏิบัติงานหน้าสาขา และครอบคลุมขั้นตอนการดำเนินการดังนี้:</p><ul><li>ตรวจเช็กสต๊อกประจำสัปดาห์</li><li>การอัปเดตข้อมูลลงในระบบ</li><li>การจัดเตรียมและจัดส่งของเข้าแต่ละสาขา</li><li>การรับของและกดรับในระบบโดยพนักงานสาขา</li><li>การจัดส่งน้ำดื่มประจำเดือน</li></ul><h2>ขั้นตอนการดำเนินงาน (Step by Step Process)</h2><ol><li>การอัปเดตสต๊อกประจำสัปดาห์</li><li>การเบิกและจัดส่งของให้สาขา</li><li>การรับของเข้าสต๊อกโดยพนักงานสาขา</li><li>การจัดส่งน้ำดื่มประจำเดือน</li></ol><img src="/docs/inventory-stock-update/fig-2.jpg" alt="" /><p><em>ขั้นตอนการปฏิบัติงานแต่ละหัวข้อ (การอัปเดตสต๊อกประจำสัปดาห์, การเบิกและจัดส่งของ, การรับของเข้าสต๊อก และการจัดส่งน้ำดื่มประจำเดือน) แสดงเป็นภาพหน้าจอระบบประกอบ</em></p><h2>หมายเหตุเพิ่มเติม</h2><ul><li>หากพบปัญหาในการใช้งานระบบ หรือยอดคำนวณไม่ถูกต้อง ต้องแจ้งมายด์ทันที <strong>ห้าม Update Stock แบบผิดมาเด็ดขาด</strong></li><li>พนักงานต้องเช็คจำนวนของจริงทุกครั้งก่อน Update Stock และอัพเดทให้ตรงเวลาตามรอบ เพื่อไม่ให้การจัดส่งล่าช้า</li><li>หากได้รับของแล้ว พนักงานต้องกดรับของทันที <strong>ห้าม Update Stock ก่อนกดรับของเด็ดขาด</strong> เพราะจะทำให้ยอดติดลบ</li><li>หากได้รับจำนวนของที่ส่งไปไม่ถูกต้อง (ขาด/เกิน) ให้ใส่จำนวนจริงที่ได้รับ เช่น ส่งทิชชู่ไปให้ 5 ม้วน แต่ได้รับจริง 4 ม้วน ให้ใส่จำนวนที่ได้รับ 4 ม้วน</li><li>หากได้รับของแต่เกิดการชำรุด ให้ใส่จำนวนทั้งหมดที่ได้รับ เช่น ส่งทิชชู่ไปให้ 5 ม้วน แต่เปียกฝน 1 ม้วน ใช้ได้จริง 4 ม้วน ให้ใส่จำนวนที่ได้รับ 5 ม้วน และโน้ตบอกว่า เปียกฝน 1 ม้วน ใช้ได้จริง 4 ม้วน</li></ul><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/inventory-stock-update/fig-3.jpg" alt="" /><img src="/docs/inventory-stock-update/fig-4.jpg" alt="" /><img src="/docs/inventory-stock-update/fig-5.jpg" alt="" />', cover_image = '/docs/inventory-stock-update/fig-1.jpg' where slug = 'inventory-stock-update';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 0016/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 ตุลาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p>
<h2>วัตถุประสงค์ (Objective)</h2>
<p>เพื่อกำหนดมาตรฐานการดำเนินการเมื่อลูกค้าไม่สามารถมารับสัมภาระตามกำหนดเวลา โดยมีแนวทางการพิจารณาส่วนลดที่เป็นธรรม สร้างความพึงพอใจให้ลูกค้า ป้องกันการทิ้งสัมภาระ และคงไว้ซึ่งรายได้ของบริษัท</p>
<h2>ขอบเขต (Scope)</h2>
<ul>
<li>ใช้กับการให้บริการลูกค้าทุกประเภทที่ฝากสัมภาระกับ AIRPORTELs ทั้งสาขาหน้าร้าน และช่องทางออนไลน์ (Call Center, Email, Line, Facebook)</li>
<li>ครอบคลุมพนักงานทุกตำแหน่งที่เกี่ยวข้อง ได้แก่ Guest Service Staff, Branch Manager และ Customer Service Team</li>
<li>ใช้กับทุกกรณีของ <strong>การรับกระเป๋าล่าช้า (Delayed Collection)</strong> ยกเว้น กรณี ลูกค้าไม่ติดต่อ/ไม่มารับเลย ซึ่งต้องเข้าสู่ขั้นตอน Lost &amp; Found / Disposal ตามนโยบายบริษัท</li>
</ul>
<h2>เกณฑ์พิจารณาและนโยบายส่วนลด (Discount Policy)</h2>
<h3>Criteria (เกณฑ์พิจารณา)</h3>
<ol>
<li><strong>Size Factor</strong> : Small / Medium / Large / Oversize or Special</li>
<li><strong>Fee Factor</strong> : Low / Medium / High / Very High</li>
<li><strong>Duration Factor</strong> (ระยะเวลาฝาก)
<ul>
<li>Short-term: ≤ 3 เดือน → ใช้โครงสร้าง Base Table ปกติ</li>
<li>Mid-term: 3–6 เดือน → ใช้ Base Table + ส่วนลดเพิ่มเล็กน้อย (+5–10%)</li>
<li>Long-term: ≥ 6 เดือน → เข้าสู่เงื่อนไขพิเศษ (25–50%)</li>
</ul>
</li>
</ol>
<h2>Discount Structure (ตามยอดเงิน + ขนาด)</h2>
<table>
<thead>
<tr><th>Size \ Fee</th><th>&lt; 5,000</th><th>5,000–10,000</th><th>10,001–20,000</th><th>&gt;20,000</th></tr>
</thead>
<tbody>
<tr><td><strong>Small</strong></td><td>10%</td><td>15%</td><td>20%</td><td>25%</td></tr>
<tr><td><strong>Medium</strong></td><td>5%</td><td>10%</td><td>15%</td><td>20%</td></tr>
<tr><td><strong>Large</strong></td><td>0%</td><td>5%</td><td>10%</td><td>15%</td></tr>
<tr><td><strong>Oversize / Special</strong></td><td>0%</td><td>0–5%</td><td>5%</td><td>10%</td></tr>
</tbody>
</table>
<h3>Duration Adjustment</h3>
<ul>
<li><strong>≤ 3 เดือน</strong> → ใช้ส่วนลดตามตาราง เท่านั้น</li>
<li><strong>3–6 เดือน</strong> → เพิ่มส่วนลดได้ +5–10% จากตารางส่วนลด (รวมแล้วไม่เกิน 30%)</li>
<li><strong>≥ 6 เดือน</strong> → ใช้ Special Duration Discount:
<ul>
<li>ส่วนลดรวมอยู่ในช่วง <strong>25–50%</strong> (ขึ้นกับขนาด/ยอด/เหตุผลลูกค้า)</li>
<li>แต่ต้องจ่ายขั้นต่ำ <strong>50% ของยอดเต็ม</strong></li>
</ul>
</li>
</ul>
<h3>Approval Authority</h3>
<ul>
<li>ส่วนลดรวม ≤25% → Guest Service Exe. อนุมัติได้</li>
<li>ส่วนลดรวม &gt;25% ถึง 50% (กรณี ≥ 6 เดือน) → ต้องขออนุมัติจาก Operation Manager</li>
<li>ส่วนลดรวม &gt;50% → ไม่อนุมัติ ยกเว้นกรณี VIP (BD / COO / CEO approval)</li>
</ul>
<h2>Example Cases</h2>
<h3>Case 1</h3>
<p>ลูกค้า ฝาก 7 เดือน / กระเป๋า Large / ยอดค้าง 22,000 บาท (Very High)</p>
<ul>
<li>Base Table = 15%</li>
<li>Duration ≥ 6 เดือน → ปรับเป็น Special Duration Discount 25–50%</li>
<li>หาก Operation Manager อนุมัติ → ลดได้สูงสุด 50% (เหลือจ่าย 11,000 บาท)</li>
</ul>
<h3>Case 2</h3>
<p>ลูกค้า ฝาก 8 เดือน / กระเป๋า Small / ยอดค้าง 6,000 บาท (Medium)</p>
<ul>
<li>Base Table = 15%</li>
<li>Duration ≥ 6 เดือน → ปรับใหม่เป็น 25–50%</li>
<li>อนุมัติ 30% → จ่าย 4,200 บาท (ขั้นต่ำต้องจ่าย 3,000 บาท ตาม rule 50%)</li>
</ul>
<h2>เงื่อนไขและเอกสารประกอบการพิจารณาส่วนลด (Conditions &amp; Required Documents)</h2>
<h3>General Conditions (เงื่อนไขทั่วไป)</h3>
<ol>
<li>ลูกค้าต้อง <strong>ติดต่อกลับมา</strong> และแสดงความประสงค์จะชำระหรือรับกระเป๋า (ไม่ใช่ abandon case)</li>
<li>ลูกค้าต้องชำระ <strong>ขั้นต่ำ 50% ของยอดค้างชำระเต็ม</strong></li>
<li>ส่วนลด ≤25% → อนุมัติได้โดย Guest Service Exe.</li>
<li>ส่วนลด 26–50% → ต้องมี <strong>เอกสารหลักฐาน + ส่งรายงานขออนุมัติ</strong> Operation Manager</li>
<li>ส่วนลด &gt;50% → อนุมัติได้เฉพาะกรณี <strong>VIP / Ex-gratia</strong> โดย BD หรือ CEO เท่านั้น</li>
</ol>
<h3>Specific Conditions by Case (กรณีและหลักฐานประกอบ)</h3>
<table>
<thead>
<tr><th>Case</th><th>เงื่อนไขการพิจารณา</th><th>เอกสาร/หลักฐานประกอบ</th></tr>
</thead>
<tbody>
<tr><td>แจ้งล่วงหน้า</td><td>ลูกค้าแจ้งก่อนถึงวันรับจริง</td><td>- Email/ข้อความจากลูกค้า<br>- Chat log หรือ CRM note</td></tr>
<tr><td>ไม่แจ้ง แต่มีเหตุสุดวิสัย</td><td>มีเหตุผลชัดเจนและมีหลักฐาน เช่น เที่ยวบิน/สุขภาพ/เอกสารทางราชการ</td><td>- เอกสารจากสายการบิน (Flight)<br>- ใบรับรองแพทย์<br>- หนังสือราชการ/เอกสารยืนยันอื่น</td></tr>
<tr><td>ไม่แจ้ง และไม่มีเหตุผลสมควร</td><td>ลูกค้าไม่ติดต่อ/ไม่มีเอกสารยืนยัน</td><td>- บันทึกในระบบว่าได้ follow up</td></tr>
<tr><td>Special Case (VIP / Corporate)</td><td>กรณีรักษาลูกค้าระยะยาว, สัญญา corporate, retention, หรือ case พิเศษ</td><td>- Email จากฝ่ายการตลาด/BD<br>- Customer profile ระบุ VIP/Corporate</td></tr>
<tr><td>Long-term storage ≥ 6 เดือน</td><td>ลูกค้าฝากยาวผิดปกติ และต้องการส่วนลดพิเศษ (25–50%)</td><td>- สัญญาฝาก/ระบบ transaction<br>- บันทึกการติดต่อกับลูกค้า</td></tr>
</tbody>
</table>
<h2>Process &amp; Documentation Flow (ขั้นตอนและการบันทึก)</h2>
<h3>Guest Service Staff / Branch Manager</h3>
<ul>
<li>ตรวจสอบข้อมูลลูกค้า (Size, Fee, Duration)</li>
<li>ขอเอกสาร/หลักฐานจากลูกค้า (ถ้ามี)</li>
<li>บันทึกใน Sales report หรือ Incident report</li>
</ul>
<h3>GS Team Lead</h3>
<ul>
<li>ตรวจสอบความถูกต้องของเอกสาร</li>
<li>อนุมัติทันทีถ้า Discount ≤25%</li>
<li>ถ้าเกิน 25% → forward <strong>Approval Request</strong> ไปยัง Operation Manager</li>
</ul>
<h3>Operation Manager</h3>
<ul>
<li>ตรวจสอบหลักฐาน, เหตุผลธุรกิจ (retention/VIP/long-term)</li>
<li>อนุมัติหรือปรับลด % ส่วนลดตาม policy (25–50%)</li>
<li>บันทึกการอนุมัติใน Sales Report หรือ อาจจัดทำเอกสาร Approve หรือระบบ Approve Lark</li>
</ul>
<h2>Criteria: ขนาดสัมภาระ (Size Factor)</h2>
<table>
<thead>
<tr><th>ประเภท</th><th>เกณฑ์ที่วัด (Criteria)</th><th>ตัวอย่างสัมภาระ (Examples)</th></tr>
</thead>
<tbody>
<tr><td><strong>Small</strong></td><td>≤ 20 นิ้ว (carry-on) หรือ น้ำหนัก ≤ 10 กก.</td><td>- กระเป๋าล้อลากเล็ก (cabin size)<br>- Backpack ใบกลาง<br>- กระเป๋า tote/duffle เล็ก / Shopping bag</td></tr>
<tr><td><strong>Medium</strong></td><td>21–26 นิ้ว หรือ น้ำหนัก ~ 10–20 กก.</td><td>- กระเป๋าล้อลาก 24 นิ้ว<br>- Duffle bag ขนาดใหญ่<br>- กล่องพัสดุขนาดกลาง</td></tr>
<tr><td><strong>Large</strong></td><td>27–32 นิ้ว หรือ น้ำหนัก ~ 20–32 กก.</td><td>- กระเป๋าล้อลาก 29–30 นิ้ว<br>- กล่องเดินทางใหญ่</td></tr>
<tr><td><strong>Oversize / special</strong></td><td>&gt; 32 นิ้ว หรือเกินมาตรฐานรูปทรง <strong>หรือ</strong> เป็นสิ่งของพิเศษ</td><td>- กระเป๋ากอล์ฟ<br>- จักรยาน (ใส่กล่อง)<br>- อุปกรณ์ดนตรี<br>- กล่องใหญ่พิเศษ/ลังไม้</td></tr>
</tbody>
</table>
<h2>ขั้นตอนดำเนินการ (Walk-in vs Call Center/Online)</h2>
<h3>กรณีลูกค้า Walk-in</h3>
<ol>
<li><strong>รับคำร้องขอ:</strong> พนักงานเคาน์เตอร์สอบถามข้อมูล → เลขฝาก, วันที่ฝาก, ระยะเวลา, เหตุผลที่มารับช้า</li>
<li><strong>ตรวจสอบข้อมูลระบบ:</strong>
<ul>
<li>ขนาดสัมภาระ (Size Factor)</li>
<li>ยอดค้างชำระ (Fee Factor)</li>
<li>ระยะเวลาฝาก (Duration Factor)</li>
<li>สถานะการติดต่อก่อนหน้า (มี follow-up หรือไม่)</li>
</ul>
</li>
<li><strong>ขอหลักฐาน (ถ้ามี):</strong> เช่น เอกสารสายการบิน, ใบรับรองแพทย์, เอกสารราชการ อื่นๆ (ถ้ามี)</li>
<li><strong>คำนวณค่าฝาก + ส่วนลดตามโครงสร้าง</strong>
<ul>
<li>ถ้าส่วนลด ≤25% → ประสานงานแจ้ง Guest Service Exe. อนุมัติผ่านกลุ่ม Lark ได้</li>
<li>ถ้าเกิน 25% → ประสานงานแจ้ง Case + ส่งต่อขออนุมัติไปยัง Operation Manager ผ่านกลุ่ม Lark</li>
</ul>
</li>
<li><strong>แจ้งลูกค้า:</strong> สรุปยอดสุทธิที่ต้องจ่าย + เงื่อนไข (เช่น ต้องจ่ายขั้นต่ำ 50%)</li>
<li><strong>ดำเนินการรับชำระ/คืนสัมภาระ</strong></li>
<li><strong>บันทึกใน Sales report /ระบบ:</strong> ระบุ case type + ส่วนลดที่อนุมัติ + แนบเอกสาร</li>
</ol>
<h3>กรณีลูกค้าติดต่อผ่าน Call Center / Online (โทร, อีเมล, LINE, FB)</h3>
<ol>
<li><strong>รับเรื่อง:</strong> CS บันทึกข้อมูลการติดต่อ → เลขฝาก, วันที่ฝาก, เหตุผล</li>
<li><strong>ตรวจสอบข้อมูลในระบบ:</strong> ขนาดสัมภาระ / ยอดค้าง / ระยะเวลาฝาก</li>
<li><strong>ขอให้ลูกค้าส่งหลักฐาน (ถ้าต้องใช้):</strong> ผ่าน Email / Line Official → attach file</li>
<li><strong>คำนวณค่าฝาก + ส่วนลดเบื้องต้น</strong> ตามเกณฑ์</li>
<li><strong>ดำเนินการอนุมัติ</strong>
<ul>
<li>≤25% → CS แจ้ง Guest Service Exe. อนุมัติและ confirm ลูกค้าได้เลย</li>
<li>&gt;25% → CS ต้องทำ "Approval Request Email" ส่ง Operation Manager พร้อมแนบหลักฐาน</li>
</ul>
</li>
<li><strong>แจ้งลูกค้า:</strong>
<ul>
<li>ถ้าอนุมัติ → ส่งสรุปยอดสุทธิ + ช่องทางการชำระเงิน (โอน/QR/ชำระที่สาขา)</li>
<li>ถ้ายังรออนุมัติ → แจ้งลูกค้าว่าจะได้รับการยืนยันภายใน [xx] ชั่วโมง</li>
</ul>
</li>
<li><strong>หลังลูกค้าชำระแล้ว</strong> → Update ข้อมูลในระบบ + แจ้งสาขาให้เตรียมกระเป๋าเพื่อรับหรือส่งกลับ</li>
</ol>
<h2>Script (TH/EN – Updated)</h2>
<h3>1. การรับเรื่องจากลูกค้า</h3>
<blockquote>
<p><strong>TH</strong> "สวัสดีค่ะ/ครับ ขอบคุณที่ติดต่อ AIRPORTELs รบกวนขอชื่อ-นามสกุล และรหัสการจอง เพื่อให้ทีมงานตรวจสอบข้อมูลการฝากสัมภาระของคุณลูกค้าค่ะ"</p>
<p><strong>EN</strong> "Hello, thank you for contacting AIRPORTELs. May I have your full name and booking reference so that we can check your storage details?"</p>
</blockquote>
<h3>2. กรณีลูกค้าแจ้งล่วงหน้า</h3>
<blockquote>
<p><strong>TH</strong> "หากคุณลูกค้าแจ้งล่วงหน้าก่อนถึงวันรับจริง เราสามารถช่วยจัดการได้ค่ะ เช่น เสนอการส่งสัมภาระให้ หรือพิจารณาลดค่าฝากตามที่กำหนดได้เลยค่ะ"</p>
<p><strong>EN</strong> "If you inform us in advance before the scheduled pick-up date, we can arrange solutions such as delivery service or apply a discount on your storage fee."</p>
</blockquote>
<h3>3. กรณีไม่แจ้ง แต่มีเหตุสุดวิสัย</h3>
<blockquote>
<p><strong>TH</strong> "หากคุณลูกค้าไม่สามารถแจ้งล่วงหน้าได้ แต่มีเหตุสุดวิสัยพร้อมเอกสารยืนยัน เช่น ตั๋วเครื่องบินที่เลื่อน/ยกเลิก หรือใบรับรองแพทย์ เราสามารถลดให้ได้ xx% ค่ะ เนื่องจากค่าฝากแบบรายเดือนเป็นราคาเหมารวมอยู่แล้ว"</p>
<p><strong>EN</strong> "If you were unable to notify us in advance but have a valid reason with supporting documents (e.g., flight delay/cancellation, medical certificate), we can offer a xx% discount, since monthly storage is already based on a flat rate."</p>
</blockquote>
<h3>4. การแจ้งลูกค้าให้อดทนรอผลการอนุมัติ</h3>
<blockquote>
<p><strong>TH</strong> "ขอบคุณสำหรับข้อมูลและเอกสารค่ะ ตอนนี้ทีมงานกำลังตรวจสอบและจะรีบแจ้งผลการพิจารณาให้คุณลูกค้าทราบโดยเร็วที่สุดค่ะ"</p>
<p><strong>EN</strong> "Thank you for providing the information and documents. Our team is reviewing your case, and we will update you with the decision as soon as possible."</p>
</blockquote>
<h3>5. การแจ้งผลอนุมัติส่วนลด</h3>
<blockquote>
<p><strong>TH</strong> "เรียนคุณลูกค้า ทางทีมงานได้พิจารณาแล้ว และอนุมัติส่วนลด [XX%] สำหรับค่าฝากสัมภาระในครั้งนี้ค่ะ ขอบคุณที่ไว้วางใจใช้บริการ AIRPORTELs และหวังว่าจะได้ให้บริการอีกในอนาคตนะคะ"</p>
<p><strong>EN</strong> "Dear Customer, we are pleased to inform you that your discount request has been approved at [XX%] for this storage. Thank you for choosing AIRPORTELs, and we look forward to serving you again."</p>
</blockquote>
<h3>6. การชวนลูกค้ารีวิว (Google Review)</h3>
<blockquote>
<p><strong>TH</strong> "หากคุณลูกค้าพึงพอใจกับการบริการ รบกวนช่วยรีวิว AIRPORTELs ทาง Google Review ได้ไหมคะ ความเห็นของคุณลูกค้ามีคุณค่ามากสำหรับการพัฒนาบริการของเรา"</p>
<p><strong>EN</strong> "If you are satisfied with our service, we would greatly appreciate it if you could leave us a review on Google. Your feedback means a lot to us"</p>
<p><strong>TH</strong> "ทางเราขอพิจารณาส่วนลดพิเศษจากราคา xx,xxx บาท เหลือเพียง x,xxx บาทค่ะ และหากคุณลูกค้าได้รับความพึงพอใจจากการให้บริการของพนักงานและสาขา รบกวนช่วยรีวิวใน Google Map เพื่อเป็นกำลังใจให้ทีมงานด้วยนะคะ"</p>
<p><strong>EN</strong> "We are pleased to offer you a special discount from xx,xxx THB to only x,xxx THB. If you are satisfied with our staff and service, we would greatly appreciate it if you could leave us a 5-star review on Google Maps to support our team. Thank you very much."</p>
</blockquote><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/delayed-pickup-discount/fig-2.jpg" alt="" /><img src="/docs/delayed-pickup-discount/fig-3.jpg" alt="" /><img src="/docs/delayed-pickup-discount/fig-4.jpg" alt="" />', cover_image = '/docs/delayed-pickup-discount/fig-1.jpg' where slug = 'delayed-pickup-discount';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> WI-OPS : 001/2026<br><strong>เวอร์ชัน / Version:</strong> 01<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 19 มกราคม 2569<br><strong>หน่วยงาน / Department:</strong> Operations</p>
<h2>วัตถุประสงค์ (Objective)</h2>
<p>เพื่อกำหนดขั้นตอนมาตรฐานในการปฏิบัติงานของพนักงานหน้าสาขา (Guest Service: GS) และ Customer Service (CS) ในการบันทึกข้อมูลการให้บริการขนส่งกระเป๋า และประสานงานกับทีมขนส่ง (MS) อย่างถูกต้อง ครบถ้วน และเป็นมาตรฐานเดียวกันทุกสาขา</p>
<h2>ขอบเขต (Scope)</h2>
<p>ครอบคลุมพนักงาน Guest Service (GS) ทุกสาขา และทีม Customer Service (CS) ที่เกี่ยวข้องกับการบันทึกออเดอร์บริการขนส่งกระเป๋า ผ่าน Google Sheet: <strong>Luggage Delivery Record</strong> เพื่อประสานงานกับทีมขนส่ง (MS)</p>
<h2>ไฟล์ที่ใช้บันทึกข้อมูล</h2>
<p>Google Sheet: <a href="https://docs.google.com/spreadsheets/d/1VsXsby13SyumPxKGZovgp571M7oPQC7ib7NSoD0fXJE/edit?gid=0#gid=0">Luggage Delivery Record 2025</a></p>
<h2>การเลือกแท็บบันทึกข้อมูลใน Google Sheet</h2>
<p>พนักงานต้องเลือกแท็บให้ตรงกับประเภทบริการเท่านั้น</p>
<table>
<thead>
<tr><th>ประเภทบริการ</th><th>การบันทึกข้อมูล</th><th>แท็บ</th></tr>
</thead>
<tbody>
<tr><td>BKK intown / CNX intown / HKT intown / Pattaya (ลงทั้งเส้นทาง Bangkok-Pattaya และ Pattaya-Bangkok)</td><td>บันทึกข้อมูลเฉพาะบริการส่ง</td><td>Intown</td></tr>
<tr><td>On Demand</td><td>ลงเฉพาะออเดอร์ที่ส่งแบบไม่ตรงตามตารางเวลา (ส่งนอกตารางเวลา)</td><td>On Demand</td></tr>
<tr><td>NTW Sameday / Nextday</td><td>ใช้บันทึกทุกออเดอร์ที่มีการส่งด้วย Cargo (ส่งข้ามจังหวัดทั้ง sameday และ nextday) ทั้งกระเป๋าเดินทาง/ถุงกอล์ฟ</td><td>Sameday (ลงควบคู่กับ Intown)</td></tr>
<tr><td>NTW Within 5 days</td><td>ลงทุกออเดอร์ที่เป็นการส่งแบบ 5 days (ส่งด้วย KEX)</td><td>Next day (ลงควบคู่กับ Intown)</td></tr>
</tbody>
</table>
<h2>แท็บ Intown</h2>
<p>ใช้บันทึกข้อมูลบริการส่ง: BKK intown, CNX intown, HKT intown, Pattaya (ลงทั้งเส้นทาง Bangkok-Pattaya และ Pattaya-Bangkok)</p>
<table>
<thead>
<tr><th>คอลัมน์</th><th>ข้อมูล</th></tr>
</thead>
<tbody>
<tr><td>A</td><td>ใส่วันที่รับออเดอร์</td></tr>
<tr><td>B</td><td>เลือกสถานะการจอง (Booking Status)</td></tr>
<tr><td>C</td><td>ใส่วันที่ส่ง (Delivery Date)</td></tr>
<tr><td>D</td><td>ใส่ชื่อลูกค้า (Customer Name)</td></tr>
<tr><td>E</td><td>เลือก service ให้ตรงกับบริการ (Service type)</td></tr>
<tr><td>F</td><td>ใส่จำนวนกระเป๋า (#Bags)</td></tr>
<tr><td>G</td><td>ใส่เลขออเดอร์พาร์ทเนอร์ของลูกค้า (Order no.)</td></tr>
<tr><td>H</td><td>ใส่เลขออเดอร์ของลูกค้า (AI Order No.)</td></tr>
<tr><td>I</td><td>เลือกประเภทการจัดส่ง (Delivery Type)</td></tr>
<tr><td>J</td><td>ใส่ต้นทาง (From)</td></tr>
<tr><td>K</td><td>เลือกเวลารอบรถรับกระเป๋า (Pick up time)</td></tr>
<tr><td>L</td><td>ใส่ปลายทาง (To)</td></tr>
<tr><td>M</td><td>เลือกประเภทกระเป๋า (Luggage Type)</td></tr>
<tr><td>N</td><td>เลือกช่องทางการจอง (Channel)</td></tr>
<tr><td>O</td><td>เลือกเวลาที่จะถึงปลายทาง (ETA)</td></tr>
<tr><td>P</td><td>ใส่เวลาที่ลูกค้ามารับจริง (Pickup Time)</td></tr>
<tr><td>Q</td><td>ใส่เที่ยวบิน (Flight No.)</td></tr>
<tr><td>R</td><td>เลือกสถานะการจัดส่ง (Delivery Status)</td></tr>
<tr><td>S</td><td>ใส่เลข MS ที่จองไว้ (MS order เท่านั้น)</td></tr>
<tr><td>T</td><td>ใส่ Promotion (Promotion)</td></tr>
<tr><td>U</td><td>ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note)</td></tr>
</tbody>
</table>
<img src="/docs/luggage-delivery-google-sheet/fig-2.jpg" alt="" /><p><em>ตัวอย่างค่าในแต่ละคอลัมน์ เช่น dropdown สถานะการจอง (CANCEL / Book MS), Service type (BKK/CNX/HKT In-town, Pattaya), Delivery Type (H2A, H2H, H2M, A2H, A2M, A2A, M2A, M2M, M2H), Delivery Status (Arrived, Delayed, Picked Up, Missing, Retrieved, CANCEL, NO SHOW)</em></p>
<h2>แท็บ On Demand</h2>
<p>ใช้บันทึกเฉพาะออเดอร์ที่ส่งแบบไม่ตรงตามตารางเวลา</p>
<table>
<thead>
<tr><th>คอลัมน์</th><th>ข้อมูล</th></tr>
</thead>
<tbody>
<tr><td>A</td><td>เลือกสถานะการจอง</td></tr>
<tr><td>B</td><td>ใส่วันที่ส่ง (Delivery Date)</td></tr>
<tr><td>C</td><td>ใส่ชื่อลูกค้า (Customer Name)</td></tr>
<tr><td>D</td><td>ใส่จำนวนกระเป๋า (#Bags)</td></tr>
<tr><td>E</td><td>ใส่เลขออเดอร์ของลูกค้า (Order No.)</td></tr>
<tr><td>F</td><td>เลือกประเภทการจัดส่ง (Delivery Type)</td></tr>
<tr><td>G</td><td>ใส่ต้นทาง (From)</td></tr>
<tr><td>H</td><td>ใส่เวลาลูกค้ามาดรอปกระเป๋า (Drop time)</td></tr>
<tr><td>I</td><td>ใส่ปลายทาง (To)</td></tr>
<tr><td>J</td><td>เลือกเวลาที่จะถึงปลายทาง (ETA)</td></tr>
<tr><td>K</td><td>เลือกประเภทกระเป๋า (Luggage Type)</td></tr>
<tr><td>L</td><td>เลือกช่องทางการจอง (Channel)</td></tr>
<tr><td>M</td><td>ใส่เวลาที่ลูกค้ามารับจริง (Pickup Time)</td></tr>
<tr><td>N</td><td>เลือกสถานะการจัดส่ง (Delivery Status)</td></tr>
<tr><td>O</td><td>ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note)</td></tr>
</tbody>
</table>
<h2>แท็บ Sameday</h2>
<ul>
<li><strong>ใช้บันทึกทุกออเดอร์ที่มีการส่งด้วย Cargo</strong> (ส่งข้ามจังหวัดทั้ง sameday และ nextday) ทั้งกระเป๋าเดินทาง/ถุงกอล์ฟ</li>
<li>ลงควบคู่กับแท็บ Intown</li>
</ul>
<table>
<thead>
<tr><th>คอลัมน์</th><th>ข้อมูล</th></tr>
</thead>
<tbody>
<tr><td>A</td><td>เลือกเส้นทางการส่ง (Route)</td></tr>
<tr><td>B</td><td>เลือกสถานะการจอง (Booking Status)</td></tr>
<tr><td>C</td><td>ใส่เลข MS ที่จองไว้ (MS order)</td></tr>
<tr><td>D</td><td>ใส่ราคาที่เก็บจากลูกค้า (Price)</td></tr>
<tr><td>E</td><td>ใส่เลขออเดอร์ของลูกค้า (Order ID)</td></tr>
<tr><td>F</td><td>ใส่วันที่ลูกค้ามาดรอปกระเป๋า (Drop Date)</td></tr>
<tr><td>G</td><td>ใส่วันที่ส่งกระเป๋า (Delivery Date)</td></tr>
<tr><td>H</td><td>ใส่ชื่อลูกค้า (Customer Name)</td></tr>
<tr><td>I</td><td>ใส่เบอร์โทรศัพท์ของลูกค้า (Phone No.)</td></tr>
<tr><td>J</td><td>ใส่จำนวนกระเป๋า (#Bags)</td></tr>
<tr><td>K</td><td>ใส่น้ำหนักกระเป๋า (Weight)</td></tr>
<tr><td>L</td><td>เลือกประเภทการจัดส่ง (Delivery Type)</td></tr>
<tr><td>M</td><td>ใส่วันที่คาดการณ์ว่าลูกค้าจะได้รับกระเป๋า ETA (Date)</td></tr>
<tr><td>N</td><td>ใส่ต้นทาง (From)</td></tr>
<tr><td>O</td><td>ใส่ที่อยู่ของต้นทาง (Address)</td></tr>
<tr><td>P</td><td>เลือกจังหวัดของต้นทาง (Province)</td></tr>
<tr><td>Q</td><td>ใส่เวลาที่ลูกค้ามาดรอปกระเป๋า (Drop time)</td></tr>
<tr><td>R</td><td>ใส่ปลายทาง อาจจะเป็นชื่อลูกค้าหรือเคาน์เตอร์ (To)</td></tr>
<tr><td>S</td><td>ใส่ที่อยู่ของปลายทาง (Address)</td></tr>
<tr><td>T</td><td>เลือกจังหวัดของปลายทาง (Province)</td></tr>
<tr><td>U</td><td>เลือกประเภทกระเป๋า (Luggage Type)</td></tr>
<tr><td>V</td><td>เลือกช่องทางการจอง (Channel)</td></tr>
<tr><td>W</td><td>ใส่เบอร์โทรผู้รับ (Call confirm)</td></tr>
<tr><td>X</td><td>ใส่ชื่อผู้รับ (Name of hotel staff)</td></tr>
<tr><td>Y</td><td>เลือกสถานะการจัดส่ง (Delivery Status)</td></tr>
<tr><td>Z</td><td>ใส่โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note)</td></tr>
</tbody>
</table>
<img src="/docs/luggage-delivery-google-sheet/fig-3.jpg" alt="" /><p><em>dropdown เส้นทางการส่ง (Route) เช่น BKK-CNX, CNX-BKK, BKK-HKT, HKT-BKK, CNX-HKT, HKT-CNX, BKK-Khonkaen, BKK-Chiang Rai, BKK-Hatyai, BKK-Krabi, BKK-Samui และเส้นทางย้อนกลับ</em></p>
<h2>แท็บ Next day</h2>
<ul>
<li>ใช้บันทึก<strong>ทุกออเดอร์ที่เป็นการส่งแบบ Within 5 days (ส่งด้วย KEX)</strong></li>
<li>ลงควบคู่กับแท็บ Intown</li>
</ul>
<table>
<thead>
<tr><th>คอลัมน์</th><th>ข้อมูล</th></tr>
</thead>
<tbody>
<tr><td>A</td><td>ใส่ลำดับออเดอร์</td></tr>
<tr><td>B</td><td>เลือกสถานะการจอง (Booking Status)</td></tr>
<tr><td>C</td><td>ใส่เลข MS ที่จองไว้ (MS order)</td></tr>
<tr><td>D</td><td>เลือกสถานะการจองหลังจากจอง KEX เสร็จ (Book Shipsmile)</td></tr>
<tr><td>E</td><td>ใส่ราคาหลังจากจอง KEX เสร็จ (Price sm)</td></tr>
<tr><td>F</td><td>ใส่ราคาที่เก็บจากลูกค้า (Price)</td></tr>
<tr><td>G</td><td>ใส่วันที่ลูกค้ามาดรอปกระเป๋า (Drop Date)</td></tr>
<tr><td>H</td><td>ใส่วันที่ส่งกระเป๋า (Delivery Date)</td></tr>
<tr><td>I</td><td>ใส่ชื่อลูกค้า (Customer Name)</td></tr>
<tr><td>J</td><td>ใส่เบอร์โทรศัพท์ของลูกค้า (Phone No.)</td></tr>
<tr><td>K</td><td>ใส่จำนวนกระเป๋า (#Bags)</td></tr>
<tr><td>L</td><td>เลือกประเภทการจัดส่ง (Delivery Type)</td></tr>
<tr><td>M</td><td>ใส่วันที่คาดการณ์ว่าลูกค้าจะได้รับกระเป๋า ETA (Date)</td></tr>
<tr><td>N</td><td>ใส่ต้นทาง (From)</td></tr>
<tr><td>O</td><td>ใส่ที่อยู่ของต้นทาง (Address)</td></tr>
<tr><td>P</td><td>ใส่จังหวัดของต้นทาง (Province)</td></tr>
<tr><td>Q</td><td>ใส่เวลาที่ลูกค้ามาดรอปกระเป๋า (Drop time)</td></tr>
<tr><td>R</td><td>ใส่ปลายทาง อาจจะเป็นชื่อลูกค้าหรือเคาน์เตอร์ (To)</td></tr>
<tr><td>S</td><td>ใส่ที่อยู่ของปลายทาง (Address)</td></tr>
<tr><td>T</td><td>ใส่จังหวัดของปลายทาง (Province)</td></tr>
<tr><td>U</td><td>ใส่วันที่ลูกค้าได้รับกระเป๋า (Arrived Date)</td></tr>
<tr><td>V</td><td>ใส่น้ำหนักกระเป๋าลูกค้า (Weight)</td></tr>
<tr><td>W</td><td>ใส่ขนาดกระเป๋า กว้าง * ยาว * สูง</td></tr>
<tr><td>X</td><td>เลือกประเภทกระเป๋า (Luggage Type)</td></tr>
<tr><td>Y</td><td>เลือกช่องทางการจอง (Channel)</td></tr>
<tr><td>Z</td><td>ใส่เบอร์โทรผู้รับ (Call confirm)</td></tr>
<tr><td>AA</td><td>ใส่ชื่อผู้รับ (Name of hotel staff)</td></tr>
<tr><td>AB</td><td>ใส่ DHL Tracking (ปัจจุบันไม่ได้ใช้แล้ว)</td></tr>
<tr><td>AC</td><td>ใส่ Orange Tracking</td></tr>
<tr><td>AD</td><td>ใส่ Ninja Tracking (ปัจจุบันไม่ได้ใช้แล้ว)</td></tr>
<tr><td>AE</td><td>เลือกสถานะการจัดส่ง (Delivery Status)</td></tr>
<tr><td>AF</td><td>ใส่เลขออเดอร์ โน้ตจำนวนกระเป๋า ชื่อลูกค้า และโน้ตอื่นๆที่ต้องการแจ้งทาง MS เพิ่ม (Note)</td></tr>
</tbody>
</table>
<blockquote>
<p>ช่องทางการจอง (Channel) ที่ใช้ได้ ได้แก่ Online, Walk-In, KLOOK, KKDAY, TRAVELOKA, GOODLUGG, Dream CT และ VELTRA</p>
</blockquote><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/luggage-delivery-google-sheet/fig-4.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-5.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-6.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-7.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-8.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-9.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-10.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-11.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-12.jpg" alt="" /><img src="/docs/luggage-delivery-google-sheet/fig-13.jpg" alt="" />', cover_image = '/docs/luggage-delivery-google-sheet/fig-1.jpg' where slug = 'luggage-delivery-google-sheet';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS-EMS:004/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p>
<h2>วัตถุประสงค์ (Objective)</h2>
<p>เพื่อกำหนดแนวทางการปฏิบัติงานสำหรับพนักงานประจำจุดบริการ AIRPORTELs <strong>ในพื้นที่สนามบิน</strong> ให้สามารถตอบสนองต่อเหตุฉุกเฉินได้อย่างมีประสิทธิภาพ โดยมีเป้าหมายหลัก ดังนี้:</p>
<ul>
<li>รักษาความปลอดภัยของพนักงานและลูกค้าเป็นลำดับแรก</li>
<li>ลดความเสี่ยงและความเสียหายต่อทรัพย์สินของลูกค้าและบริษัทในระหว่างเกิดเหตุ</li>
<li>ตอบสนองต่อเหตุฉุกเฉินอย่างมีประสิทธิภาพ รวดเร็ว และเป็นระบบ</li>
<li>ปฏิบัติงานตามมาตรฐานความปลอดภัยของสนามบินทั้งในระดับท้องถิ่นและสากล</li>
<li>เสริมสร้างความเชื่อมั่นในบริการ และภาพลักษณ์ด้านความปลอดภัยของบริษัท</li>
</ul>
<h2>ขอบเขต (Scope)</h2>
<p>ใช้สำหรับพนักงานที่ปฏิบัติงานประจำเคาน์เตอร์หรือจุดบริการ AIRPORTELs ในเขตสนามบินทุกแห่ง เมื่อเกิดสถานการณ์ฉุกเฉินที่อาจกระทบต่อความปลอดภัยของบุคคลและทรัพย์สิน</p>
<h2>การปฏิบัติงานเมื่อเกิดเหตุฉุกเฉิน</h2>
<h3>กรณีที่ 1: พบวัตถุต้องสงสัย / วัตถุอันตราย</h3>
<ul>
<li><strong>หยุดการให้บริการทันที</strong>
<ul>
<li>ห้ามเคลื่อนย้ายวัตถุต้องสงสัย</li>
<li>แจ้งลูกค้าให้ถอยห่างโดยไม่สร้างความตื่นตระหนก</li>
</ul>
</li>
<li><strong>แจ้งหน่วยงานที่เกี่ยวข้อง</strong>
<ul>
<li>โทรแจ้งหน่วยรักษาความปลอดภัยสนามบินทันที</li>
<li>รายงานหัวหน้า/ผู้จัดการสาขา</li>
</ul>
</li>
<li><strong>กันพื้นที่</strong>
<ul>
<li>ห้ามบุคคลอื่นเข้าใกล้วัตถุต้องสงสัย</li>
<li>หากมีป้ายหรือแถบกั้นความปลอดภัย ใช้ทันที</li>
</ul>
</li>
<li><strong>ตรวจสอบทรัพย์สิน</strong>
<ul>
<li>ตรวจสอบกระเป๋าหรือทรัพย์สินของลูกค้าที่ยังอยู่ภายในพื้นที่</li>
<li>จดบันทึกรายละเอียดของทรัพย์สินที่ยังไม่สามารถเคลื่อนย้ายได้</li>
</ul>
</li>
<li><strong>อพยพพนักงานและลูกค้า</strong>
<ul>
<li>ปฏิบัติตามคำแนะนำของเจ้าหน้าที่สนามบินหรือเจ้าหน้าที่รักษาความปลอดภัย</li>
<li>เดินทางไปยังจุดรวมพลที่กำหนดไว้</li>
</ul>
</li>
<li><strong>รอคำสั่งเพิ่มเติม</strong>
<ul>
<li>ห้ามกลับเข้าพื้นที่จนกว่าจะได้รับอนุญาตจากเจ้าหน้าที่</li>
</ul>
</li>
</ul>
<h3>กรณีที่ 2: แผ่นดินไหว</h3>
<ul>
<li><strong>หลบอยู่ในที่ปลอดภัย</strong>
<ul>
<li>หาที่กำบัง เช่น ใต้โต๊ะที่แข็งแรง หรือยืนชิดเสา</li>
<li>ป้องกันศีรษะและคอด้วยมือหรือกระเป๋า</li>
</ul>
</li>
<li><strong>หลังการสั่นสะเทือนหยุด</strong>
<ul>
<li>ประเมินความเสียหายเบื้องต้น</li>
<li>หากพื้นที่ไม่ปลอดภัย เช่น มีเพดานหลุด หรือมีควัน ให้ อพยพทันที</li>
</ul>
</li>
<li><strong>อพยพพนักงานและลูกค้า</strong>
<ul>
<li>พาทุกคนไปยังจุดรวมพลนอกอาคาร (ตามที่สนามบินกำหนด)</li>
<li>ห้ามใช้ลิฟต์โดยเด็ดขาด</li>
</ul>
</li>
<li><strong>แจ้งหัวหน้างาน / ผู้จัดการ</strong>
<ul>
<li>รายงานสถานการณ์</li>
<li>แจ้งจำนวนทีมงานที่อพยพออกมา</li>
</ul>
</li>
<li><strong>ประสานกับสนามบิน</strong>
<ul>
<li>ปฏิบัติตามคำแนะนำของหน่วยงานความปลอดภัยสนามบิน</li>
</ul>
</li>
<li><strong>ตรวจสอบทรัพย์สิน</strong>
<ul>
<li>หลังได้รับอนุญาตให้กลับเข้าพื้นที่ ตรวจสอบทรัพย์สินของลูกค้าว่ายังอยู่ครบถ้วน</li>
<li>ตรวจสอบทรัพย์สิน และอุปกรณ์ของบริษัทฯ กรณีได้รับความเสียหายให้รายงานกลับสำนักงานใหญ่ เพื่อจัดหาอุปกรณ์ทดแทนเร่งด่วน หรือ พิจารณาปิดให้บริการ</li>
</ul>
</li>
</ul>
<h3>กรณีที่ 3: เตือนภัยสึนามิ / น้ำท่วม</h3>
<ul>
<li><strong>รับฟังประกาศเตือนภัย</strong>
<ul>
<li>ติดตามประกาศจากสนามบินและหน่วยงานทางการ</li>
</ul>
</li>
<li><strong>แจ้งลูกค้า</strong>
<ul>
<li>อธิบายสถานการณ์โดยสุภาพ</li>
<li>แนะนำให้ลูกค้าเก็บของมีค่าและเตรียมอพยพ</li>
</ul>
</li>
<li><strong>กรณีเตรียมอพยพ</strong>
<ul>
<li>หยุดให้บริการ</li>
<li>เก็บทรัพย์สินลูกค้าในที่สูง หากมีเวลา</li>
<li>ล็อคพื้นที่เก็บสัมภาระ</li>
</ul>
</li>
<li><strong>กรณีต้องอพยพทันที</strong>
<ul>
<li>ปฏิบัติตามเส้นทางอพยพที่กำหนดโดยสนามบิน</li>
<li>เดินทางไปยังพื้นที่ปลอดภัยบนที่สูง</li>
</ul>
</li>
<li><strong>แจ้งผู้จัดการ</strong>
<ul>
<li>รายงานสถานการณ์และจำนวนผู้ที่อพยพ</li>
</ul>
</li>
</ul>
<h3>กรณีที่ 4: เกิดเหตุก่อการร้าย / แจ้งเหตุวางระเบิด / มีคนใช้อาวุธในพื้นที่สนามบิน</h3>
<ul>
<li><strong>หยุดให้บริการทันที</strong>
<ul>
<li>ปิดเคาน์เตอร์/ล็อกอุปกรณ์</li>
<li>หยุดรับลูกค้าและแจ้งให้ลูกค้าอยู่ในความสงบ</li>
</ul>
</li>
<li><strong>ประเมินสถานการณ์เบื้องต้น</strong>
<ul>
<li>หากได้ยินเสียงระเบิด หรือมีการแจ้งจากสนามบินว่าเกิดเหตุรุนแรง:
<ul>
<li>อย่าเข้าใกล้จุดเกิดเหตุ</li>
<li>ไม่ถ่ายภาพหรือเผยแพร่สถานการณ์ผ่านโซเชียลมีเดีย</li>
</ul>
</li>
<li>หากเหตุการณ์ยังไม่เกิดแต่มี "การแจ้งเตือนล่วงหน้า" (เช่น มีการโทรขู่วางระเบิด): ปฏิบัติตามคำสั่งเจ้าหน้าที่สนามบินทันที</li>
</ul>
</li>
<li><strong>แจ้งเหตุ</strong>
<ul>
<li>ติดต่อเจ้าหน้าที่รักษาความปลอดภัยสนามบินหรือเจ้าหน้าที่ตำรวจที่อยู่ใกล้ที่สุด (กรณีเป็นผู้พบเห็นเหตุการณ์)</li>
<li>รายงานหัวหน้าสาขาหรือผู้จัดการทันทีผ่านช่องทางฉุกเฉิน</li>
</ul>
</li>
<li><strong>อพยพอย่างปลอดภัย</strong>
<ul>
<li>อพยพตามเส้นทางที่สนามบินกำหนดเท่านั้น</li>
<li>ไม่ใช้ลิฟต์</li>
<li>หลีกเลี่ยงบริเวณที่มีผู้คนหนาแน่นหรือเสียงปืน/เสียงระเบิด</li>
<li>หากอยู่ใกล้บริเวณที่มีการยิงหรือเสียงระเบิด: <strong>หมอบลงกับพื้น</strong> หากหลบได้ให้เข้าไปในพื้นที่ปิด / ห้องนิรภัย และปิดโทรศัพท์มือถือหรือลดเสียงเพื่อหลีกเลี่ยงการตรวจพบ</li>
</ul>
</li>
<li><strong>รวบรวมพนักงานและลูกค้า</strong>
<ul>
<li>หากปลอดภัย ให้รวมกลุ่มและเคลื่อนย้ายไปยัง จุดรวมพลที่ปลอดภัย ตามที่สนามบินกำหนด</li>
<li>ตรวจสอบจำนวนลูกค้าและพนักงานในความดูแล พร้อมรายงานให้หัวหน้าทราบ</li>
</ul>
</li>
<li><strong>รอคำสั่งจากเจ้าหน้าที่</strong>
<ul>
<li>ห้ามกลับเข้าพื้นที่บริการจนกว่าจะได้รับอนุญาตอย่างเป็นทางการ</li>
<li>เตรียมพร้อมให้ข้อมูล หากเจ้าหน้าที่ต้องการสอบถาม</li>
</ul>
</li>
<li><strong>บันทึกเหตุการณ์</strong> บันทึกรายละเอียดเหตุการณ์ทันทีที่ปลอดภัย:
<ul>
<li>วัน/เวลา</li>
<li>ลักษณะเหตุการณ์</li>
<li>การปฏิบัติของพนักงาน</li>
<li>รายชื่อพนักงาน/ลูกค้าที่อยู่ในเหตุการณ์</li>
</ul>
</li>
</ul>
<h2>แนวปฏิบัติสำคัญเพิ่มเติมสำหรับทุกกรณีฉุกเฉิน</h2>
<ul>
<li>หลีกเลี่ยงการตัดสินใจโดยลำพัง หากมีหัวหน้าอยู่ ให้รอรับคำสั่ง (เว้นแต่สถานการณ์ต้องรีบอพยพ)</li>
<li>ความปลอดภัยของ <strong>ชีวิต</strong> มาก่อน <strong>ทรัพย์สิน</strong></li>
<li>พนักงานควรได้รับการฝึกซ้อมตาม <strong>แผนฉุกเฉินสนามบิน</strong> อย่างสม่ำเสมอ</li>
</ul>
<blockquote>
<p><strong>หมายเหตุสำคัญ:</strong></p>
<p>ทุกเหตุการณ์ต้องมีการจดบันทึกเหตุการณ์ทันทีที่ปลอดภัย หรือรายงานผ่านกลุ่มงาน Lark ตามขั้นตอนดังนี้ วัน/เวลา, รายละเอียดเหตุการณ์, การแจ้งเหตุ, การตอบสนอง, รายการทรัพย์สินที่เสียหาย (ถ้ามี)</p>
<p>รายงานเหตุการณ์ให้หัวหน้าหน่วยงาน / ผู้จัดการภายใน 1 ชั่วโมงหลังสถานการณ์คลี่คลาย</p>
</blockquote>
<img src="/docs/emergency-airport/fig-2.jpg" alt="" /><p><em>อินโฟกราฟิกสรุปขั้นตอนการปฏิบัติทั้ง 4 กรณี (เหตุก่อการร้าย/วางระเบิด, พบวัตถุต้องสงสัย, แผ่นดินไหว, เตือนภัยสึนามิ/น้ำท่วม)</em></p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/emergency-airport/fig-3.jpg" alt="" /><img src="/docs/emergency-airport/fig-4.jpg" alt="" /><img src="/docs/emergency-airport/fig-5.jpg" alt="" />', cover_image = '/docs/emergency-airport/fig-1.jpg' where slug = 'emergency-airport';

update sop.documents set content_html = '<p><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS-EMS:005/2025<br><strong>เวอร์ชัน / Version:</strong> 1.0<br><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568<br><strong>หน่วยงาน / Department:</strong> Operations</p>
<h2>วัตถุประสงค์ (Objective)</h2>
<p>เพื่อกำหนดแนวทางปฏิบัติงานที่ชัดเจนให้กับพนักงานประจำจุดบริการ <strong>ภายในศูนย์การค้า</strong> ในกรณีที่เกิดเหตุฉุกเฉิน เช่น การพบวัตถุต้องสงสัย เหตุก่อการร้าย หรือภัยพิบัติทางธรรมชาติ โดยมีเป้าหมายเพื่อ:</p>
<ul>
<li>รักษาความปลอดภัยของพนักงานและลูกค้าเป็นลำดับแรก</li>
<li>ลดความเสี่ยงต่อการสูญเสียหรือความเสียหายต่อทรัพย์สินของลูกค้าและบริษัท</li>
<li>ตอบสนองต่อเหตุฉุกเฉินอย่างมีประสิทธิภาพ รวดเร็ว และเป็นระบบ</li>
<li>สร้างความมั่นใจให้กับลูกค้าในการใช้บริการ</li>
<li>ปฏิบัติสอดคล้องกับนโยบายความปลอดภัยของศูนย์การค้าและหน่วยงานที่เกี่ยวข้อง</li>
</ul>
<h2>ขอบเขต (Scope)</h2>
<p>เอกสารนี้ใช้สำหรับพนักงานประจำเคาน์เตอร์หรือจุดบริการ AIRPORTELs ภายในศูนย์การค้าทุกแห่ง เพื่อให้สามารถตอบสนองต่อสถานการณ์ฉุกเฉินได้อย่างมีประสิทธิภาพ ปลอดภัย และลดความเสียหายต่อชีวิตและทรัพย์สิน</p>
<h2>การปฏิบัติงานเมื่อเกิดเหตุฉุกเฉิน</h2>
<h3>กรณีที่ 1: พบวัตถุต้องสงสัย / วัตถุอันตราย</h3>
<ul>
<li><strong>หยุดการให้บริการทันที</strong>
<ul>
<li>ห้ามเคลื่อนย้ายวัตถุต้องสงสัย</li>
<li>แจ้งลูกค้าให้ถอยห่างโดยไม่สร้างความตื่นตระหนก</li>
</ul>
</li>
<li><strong>แจ้งหน่วยงานที่เกี่ยวข้อง</strong>
<ul>
<li>โทรแจ้งหน่วยรักษาความปลอดภัยสนามบินทันที</li>
<li>รายงานหัวหน้า/ผู้จัดการสาขา</li>
</ul>
</li>
<li><strong>กันพื้นที่</strong>
<ul>
<li>ห้ามบุคคลอื่นเข้าใกล้วัตถุต้องสงสัย</li>
<li>หากมีป้ายหรือแถบกั้นความปลอดภัย ใช้ทันที</li>
</ul>
</li>
<li><strong>ตรวจสอบทรัพย์สิน</strong>
<ul>
<li>ตรวจสอบกระเป๋าหรือทรัพย์สินของลูกค้าที่ยังอยู่ภายในพื้นที่</li>
<li>จดบันทึกรายละเอียดของทรัพย์สินที่ยังไม่สามารถเคลื่อนย้ายได้</li>
</ul>
</li>
<li><strong>อพยพพนักงานและลูกค้า</strong>
<ul>
<li>ปฏิบัติตามคำแนะนำของเจ้าหน้าที่สนามบินหรือเจ้าหน้าที่รักษาความปลอดภัย</li>
<li>เดินทางไปยังจุดรวมพลที่กำหนดไว้</li>
</ul>
</li>
<li><strong>รอคำสั่งเพิ่มเติม</strong>
<ul>
<li>ห้ามกลับเข้าพื้นที่จนกว่าจะได้รับอนุญาตจากเจ้าหน้าที่</li>
</ul>
</li>
</ul>
<h3>กรณีที่ 2: เหตุก่อการร้าย / ใช้อาวุธ / ขู่วางระเบิด</h3>
<ul>
<li><strong>การพบเห็นเหตุการณ์ แจ้งเจ้าหน้าที่รักษาความปลอดภัยทันที</strong>
<ul>
<li>ผ่านเบอร์ภายในของศูนย์ หรือวิทยุสื่อสาร</li>
</ul>
</li>
<li><strong>หลีกเลี่ยงการเผชิญหน้า</strong>
<ul>
<li>อย่าเข้าใกล้ผู้ต้องสงสัยหรือพื้นที่ที่มีอาวุธ</li>
</ul>
</li>
<li><strong>หยุดให้บริการทันที</strong>
<ul>
<li>ล็อคพื้นที่บริการหากปลอดภัยและทำได้ทัน</li>
</ul>
</li>
<li><strong>อพยพอย่างสงบ</strong>
<ul>
<li>ตามเส้นทางที่ปลอดภัยที่สุด ไม่อยู่รวมกันเป็นกลุ่มใหญ่</li>
<li>ห้ามใช้ลิฟต์</li>
</ul>
</li>
<li><strong>หมอบ/หลบในที่กำบัง หากได้ยินเสียงปืนหรือระเบิด</strong>
<ul>
<li>ปิดเสียงโทรศัพท์</li>
<li>อย่าเคลื่อนไหวหากอยู่ในพื้นที่เสี่ยง</li>
</ul>
</li>
<li><strong>รายงานหัวหน้าสาขา หรือ ผู้จัดการ</strong>
<ul>
<li>แจ้งสถานการณ์และพิกัดของตนเอง</li>
</ul>
</li>
<li><strong>รอคำสั่งจากเจ้าหน้าที่ความมั่นคง/ศูนย์การค้า</strong></li>
</ul>
<h3>กรณีที่ 3: แผ่นดินไหว</h3>
<ul>
<li><strong>หลบอยู่ในที่ปลอดภัย</strong>
<ul>
<li>หมอบลงใต้โต๊ะ หรือยืนใกล้เสาแข็งแรง</li>
<li>ป้องกันศีรษะด้วยมือหรือกระเป๋า</li>
</ul>
</li>
<li><strong>หลังการสั่นสะเทือนหยุด</strong>
<ul>
<li>ประเมินความเสียหายเบื้องต้น</li>
<li>หากพื้นที่ไม่ปลอดภัย เช่น มีเพดานหลุด หรือมีควัน ให้ อพยพทันที</li>
</ul>
</li>
<li><strong>อพยพพนักงานและลูกค้า</strong>
<ul>
<li>ใช้บันได ไม่ใช้ลิฟต์</li>
<li>ไปยังจุดรวมพลตามแผนของศูนย์การค้า</li>
</ul>
</li>
<li><strong>แจ้งหัวหน้างาน / ผู้จัดการ</strong>
<ul>
<li>รายงานสถานการณ์</li>
<li>แจ้งจำนวนทีมงานที่อพยพออกมา</li>
</ul>
</li>
<li><strong>ตรวจสอบทรัพย์สิน</strong>
<ul>
<li>หลังได้รับอนุญาตให้กลับเข้าพื้นที่ ตรวจสอบทรัพย์สินของลูกค้าว่ายังอยู่ครบถ้วน</li>
<li>ตรวจสอบทรัพย์สิน และอุปกรณ์ของบริษัทฯ กรณีได้รับความเสียหายให้รายงานกลับสำนักงานใหญ่ เพื่อจัดหาอุปกรณ์ทดแทนเร่งด่วน หรือ พิจารณาปิดให้บริการ</li>
</ul>
</li>
</ul>
<h2>แนวปฏิบัติสำคัญเพิ่มเติมสำหรับทุกกรณีฉุกเฉิน</h2>
<ul>
<li>หลีกเลี่ยงการตัดสินใจโดยลำพัง หากมีหัวหน้าอยู่ ให้รอรับคำสั่ง (เว้นแต่สถานการณ์ต้องรีบอพยพ)</li>
<li>ความปลอดภัยของ <strong>ชีวิต</strong> มาก่อน <strong>ทรัพย์สิน</strong></li>
<li>พนักงานควรได้รับการฝึกซ้อม<strong>แผนฉุกเฉินตามนโยบายศูนย์การค้า</strong>อย่างน้อยปีละ 1 ครั้ง</li>
</ul>
<blockquote>
<p><strong>หมายเหตุสำคัญ:</strong></p>
<p>ทุกเหตุการณ์ต้องมีการจดบันทึกเหตุการณ์ทันทีที่ปลอดภัย หรือรายงานผ่านกลุ่มงาน Lark ตามขั้นตอนดังนี้ วัน/เวลา, รายละเอียดเหตุการณ์, การแจ้งเหตุ, การตอบสนอง, รายการทรัพย์สินที่เสียหาย (ถ้ามี)</p>
<p>รายงานเหตุการณ์ให้หัวหน้าหน่วยงาน / ผู้จัดการภายใน 1 ชั่วโมงหลังสถานการณ์คลี่คลาย</p>
</blockquote>
<img src="/docs/emergency-mall/fig-2.jpg" alt="" /><p><em>อินโฟกราฟิกสรุปขั้นตอนการปฏิบัติ (เหตุก่อการร้าย/ใช้อาวุธ/ขู่วางระเบิด, พบวัตถุต้องสงสัย, แผ่นดินไหว, เตือนภัยสึนามิ/น้ำท่วม)</em></p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/emergency-mall/fig-3.jpg" alt="" /><img src="/docs/emergency-mall/fig-4.jpg" alt="" /><img src="/docs/emergency-mall/fig-5.jpg" alt="" />', cover_image = '/docs/emergency-mall/fig-1.jpg' where slug = 'emergency-mall';

update sop.documents set content_html = '<h2>การใช้งานเบื้องต้น</h2>
<h3>วิธี Login เข้าระบบ</h3>
<p>สามารถค้นหา respond.io ผ่าน Google</p>
<ol>
<li>เข้าไปที่เว็บไซต์ respond.io</li>
<li>ใส่ username และ password ที่บริษัทได้สร้างให้</li>
<li>คลิก sign in เพื่อเข้าสู่ระบบ</li>
</ol>
<img src="/docs/respond-io-guide/fig-2.jpg" alt="" /><p><em>หน้าจอ Sign in ของ respond.io พร้อมช่องกรอกอีเมลและรหัสผ่าน</em></p>
<h3>วิธี Add new contact และส่งข้อความ</h3>
<ol>
<li>คลิกไปที่ไอคอน เพื่อ add new contact</li>
<li>ใส่ ชื่อ-นามสกุลลูกค้า และเพิ่ม Email address</li>
<li>คลิก Add เพื่อเป็นการสร้าง contact ใหม่</li>
</ol>
<img src="/docs/respond-io-guide/fig-3.jpg" alt="" /><p><em>ปุ่มไอคอน add new contact และหน้าต่าง New Contact สำหรับกรอกข้อมูลลูกค้า</em></p>
<ol start="4">
<li>พิมพ์ชื่อเรื่องได้ที่ Subject ก่อนส่งข้อความ</li>
<li>พิมพ์เนื้อหาที่ต้องการส่งลงไปที่ Message และกดส่งข้อความ</li>
<li>เมื่อกดส่งข้อความเรียบร้อยแล้ว คลิกไปที่ Close conversation เพื่อจบบทสนทนา</li>
</ol>
<img src="/docs/respond-io-guide/fig-4.jpg" alt="" /><p><em>หน้าจอการตอบข้อความ แสดงช่อง Subject, ช่อง Message และปุ่ม Close Conversation</em></p>
<h3>PATTERN ในการตอบข้อความลูกค้า</h3>
<p>สำหรับการตอบข้อความ จะมี Pattern พื้นฐาน ทั้งภาษาไทยและภาษาอังกฤษ อยู่ที่ Airportels CS (Respond.io) Sheet สำหรับตอบข้อความที่มีการถามเข้ามาบ่อยครั้ง เพื่อความรวดเร็ว และง่ายต่อการพูดคุย โดยที่</p>
<ol>
<li>จะเป็นหัวข้อสำหรับการส่งข้อความ</li>
<li>ข้อความรายละเอียดต่างๆ</li>
</ol>
<p>ถ้าเป็นคำถามนอกเหนือจากแพทเทิร์นที่ให้ไว้ สามารถตอบกลับได้ตามพื้นฐานความรู้เกี่ยวกับบริษัท</p>
<img src="/docs/respond-io-guide/fig-5.jpg" alt="" /><p><em>Google Sheet ชื่อ Airportels CS (Respond.io) แสดงคอลัมน์หัวข้อและข้อความรายละเอียดทั้งภาษาไทยและอังกฤษ</em></p>
<h3>Filter by</h3>
<p>คือระบบคัดกรองข้อความของลูกค้า ว่าเป็นข้อความใหม่ หรือข้อความเก่า</p>
<ol>
<li><strong>All status</strong> จะแสดงข้อความของลูกค้าทุกรูปแบบ ทั้งข้อความใหม่ หรือข้อความเก่า</li>
<li><strong>Open</strong> จะแสดงข้อความที่เข้ามาใหม่ หรือข้อความที่ยังไม่ได้มีการปิดแชท</li>
<li><strong>Closed</strong> จะแสดงข้อความที่ได้รับการตอบกลับ หรือได้รับการปิดแชทแล้ว</li>
</ol>
<h3>INBOX</h3>
<ol>
<li><strong>All</strong> คือข้อความทั้งหมด ที่มีการตอบกลับและยังไม่ได้รับการตอบกลับ</li>
<li><strong>Mine</strong> เมื่อลูกค้าตอบกลับ ข้อความที่เราได้มีการพูดคุยจะแสดงที่หน้านี้</li>
</ol>
<h3>Search</h3>
<p>ช่อง Search สามารถใช้ค้นหาได้ทั้ง Email หรือชื่อผู้ใช้งาน</p>
<h3>ช่องทางการติดต่อ AIRPORTELs</h3>
<ul>
<li>Email: center@airportels.asia</li>
<li>Facebook: AIRPORTELs</li>
<li>โทรศัพท์: 02 026 6927</li>
<li>เว็บไซต์: www.airportels.asia</li>
<li>LINE: @airportels</li>
<li>WhatsApp: +66864183484</li>
</ul>
<hr>
<h2>การส่งข้อความขอรูปภาพ ในกรณีส่งกระเป๋าเดินทาง</h2>
<ol>
<li>เข้าไปที่ Luggage Delivery Order</li>
<li>นำเลขที่ขึ้นต้นด้วย LUG หรือ INTX ไปค้นหาที่เว็บ Postels</li>
<li>เมื่อนำเลขไปค้นหาแล้ว ให้ดูที่ Customer Information นำ Email ไปสร้าง new account ใน respond.io</li>
</ol>
<img src="/docs/respond-io-guide/fig-6.jpg" alt="" /><p><em>Google Sheet Luggage Delivery Record และหน้า Customer Information บนเว็บ Postels แสดงช่อง Email ของลูกค้า</em></p>
<ol start="4">
<li>นำ Email ค้นหาที่ช่อง Search เพื่อค้นหาว่ามีการสร้าง Account ไว้หรือไม่ ถ้าไม่มี Account ให้ทำการสร้างก่อนส่งข้อความ ถ้ามีแล้วให้กดเข้าในแชทได้เลย</li>
<li>ให้เข้าไปที่หน้า Airportels CS (Respond.io) หาหัวข้อ "Please take a picture of your luggage when you drop your luggage." (หัวข้อการส่งรูป)</li>
<li>นำหัวข้อใส่ที่ Subject และใส่รายละเอียดด้านล่าง โดยรายละเอียดประกอบด้วย
<ul>
<li>Order ID</li>
<li>วันที่ที่ต้องการส่ง</li>
<li>สถานที่ส่ง</li>
<li>สถานที่รับ</li>
</ul>
หลังจากใส่รายละเอียดเรียบร้อยแล้วให้กดส่งข้อความ</li>
<li>หลังจากนั้นให้กดที่ Close conversation (ปุ่มเขียว) เพื่อเป็นการจบบทสนทนา</li>
</ol>
<img src="/docs/respond-io-guide/fig-7.jpg" alt="" /><p><em>ตัวอย่างข้อความ "Please take a picture of your luggage" ที่กรอกใน Subject และ Message พร้อมปุ่ม Close Conversation</em></p>
<hr>
<h2>วิธีการลง Order ลูกค้าที่จองผ่าน Airportels</h2>
<p>สำหรับลูกค้าที่จอง Storage และ Delivery ผ่านระบบ AIRPORTELs นั้น ข้อมูลของลูกค้าถูกส่งมาทาง respond.io โดยนำข้อมูลดังกล่าวมาใส่ใน Google Sheet เพื่อเก็บรวบรวม</p>
<h3>วิธีการลงข้อมูลลูกค้า</h3>
<ol>
<li>คลิกที่ show original email</li>
<li>ระบบจะแสดงข้อมูลลูกค้าทั้งหมด</li>
</ol>
<img src="/docs/respond-io-guide/fig-8.jpg" alt="" /><p><em>อีเมล "Thank you! Order is now complete" และปุ่ม Show original email พร้อมข้อมูลการจอง (Order No, Passport ID, Date)</em></p>
<p>ในระบบจะแสดงข้อมูลของลูกค้า ได้แก่</p>
<ul>
<li>Order No.</li>
<li>Passport ID</li>
<li>E-mail</li>
<li>วันที่ลูกค้าจองเข้ามาในระบบ</li>
<li>ชื่อลูกค้า</li>
<li>วันและเวลาที่ฝาก-รับ</li>
<li>ราคา</li>
<li>จำนวนกระเป๋า</li>
</ul>
<ol start="3">
<li>นำข้อมูลทั้งหมด ลงใน Google Sheet (AIRPORTELs partner''s orders) ในหน้า Airportels website</li>
</ol>
<img src="/docs/respond-io-guide/fig-9.jpg" alt="" /><p><em>Google Sheet AIRPORTELs partner''s orders แท็บ Airportels website</em></p>
<h3>Delivery Order</h3>
<ul>
<li><strong>INTX (In town)</strong> — ส่งภายในกรุงเทพ</li>
<li><strong>NTW (Nationwide)</strong> — ส่งไปต่างจังหวัด</li>
</ul>
<p>สำหรับ Delivery Order จะแตกต่างจาก Storage เพราะจะมีการลง Order ทั้ง 2 ชีท ได้แก่ AIRPORTELs partner''s orders ในหน้า Airportels Website ให้นำมาใส่ใน Luggage Delivery Record ให้ถูกต้อง และลงตามวันที่ลูกค้าต้องการจัดส่ง สำหรับเคส In-town ให้ดูเรื่องเวลาตัดรอบ ถ้านอกเหนือเวลาตัดรอบ ให้ลงในหน้า On Demand</p>
<ol>
<li>(AIRPORTELs partner''s orders) ในหน้า Airportels website</li>
<li>(Luggage Delivery Record) ในหน้า Intown-TPY</li>
</ol>
<p>ในส่วนของ Nationwide ให้ลงทั้งหมด 3 tab ได้แก่</p>
<ol>
<li>AIRPORTELs partner''s orders ในหน้า Airportels Website เพื่อจัดส่งเข้าคลัง</li>
<li>Luggage Delivery Record ในหน้า Intown-TPY และ NTW next day หรือ NTW same day
<ul>
<li>(Luggage Delivery Record) ในหน้า Next day</li>
<li>(Luggage Delivery Record) ในหน้า Same day</li>
</ul>
</li>
</ol>
<hr>
<h2>วิธีการลง Order ลูกค้าที่จองผ่าน Partner</h2>
<p>Partner ที่รองรับ ได้แก่</p>
<ul>
<li><strong>KKDAY</strong> — Storage / Delivery</li>
<li><strong>KLOOK</strong> — Storage / Delivery</li>
<li><strong>RADICAL (Radical Storage)</strong> — Storage</li>
</ul>
<h3>วิธีการลงข้อมูลลูกค้า</h3>
<ol>
<li>คลิกที่ show original email</li>
<li>ระบบจะแสดงข้อมูลลูกค้าทั้งหมด</li>
</ol>
<img src="/docs/respond-io-guide/fig-10.jpg" alt="" /><p><em>อีเมลแจ้ง Booking จาก KKDay พร้อม Booking ID และปุ่ม Show original email</em></p>
<h3>KKDAY — การเข้าระบบหลังบ้าน</h3>
<p>สำหรับ Order ที่จองผ่าน KKDAY ให้เข้าระบบหลังบ้านของทาง KKDAY [ scm.kkday.com ]</p>
<ul>
<li>Username: operator@airportels.asia</li>
<li>Password: (ขอรหัสผ่านจากหัวหน้างาน — ไม่เปิดเผยในคู่มือ)</li>
</ul>
<ol>
<li>เมื่อเข้าเว็บไซต์ กดที่ Log in</li>
<li>ใส่ทั้ง Username และ password หลังจากนั้นกดไปที่ Log in</li>
<li>กดไปที่ Order</li>
<li>นำเลข Order ใส่ไปที่ Booking No.</li>
<li>กดไปที่ Order detail</li>
<li>ระบบจะขึ้นข้อมูลลูกค้าทั้งหมด</li>
</ol>
<img src="/docs/respond-io-guide/fig-11.jpg" alt="" /><p><em>หน้า Login ของ kkday scm, เมนู Order, ช่องค้นหา Booking no. และหน้า Order detail แสดงข้อมูลผู้โดยสาร</em></p>
<img src="/docs/respond-io-guide/fig-12.jpg" alt="" /><p><em>ตัวอย่างอีเมลยืนยันคำสั่งซื้อจาก KLOOK (Klook Order Confirmed) และ Radical Storage (New order)</em></p>
<ol start="3">
<li>นำข้อมูลทั้งหมด ลงใน Google Sheet (AIRPORTELs partner''s orders) ในหน้า Partner Storage สำหรับลูกค้าจองบริการฝาก</li>
<li>นำข้อมูลทั้งหมด ลงใน Google Sheet (AIRPORTELs partner''s orders) ในหน้า Partner Delivery สำหรับลูกค้าจองบริการส่ง</li>
</ol>
<img src="/docs/respond-io-guide/fig-13.jpg" alt="" /><p><em>Google Sheet AIRPORTELs partner''s orders แท็บ Partner (Storage) และ Partner (Delivery)</em></p>
<h3>Delivery Order ของ Partner</h3>
<p>สำหรับ Delivery Order จะแตกต่างจาก Storage เพราะจะมีการลง Order ทั้ง 2 ชีท ได้แก่ AIRPORTELs partner''s orders ในหน้า Partner Delivery ให้นำมาใส่ใน Luggage Delivery Record ให้ถูกต้อง และลงตามวันที่ลูกค้าต้องการจัดส่ง สำหรับเคส In-town ให้ดูเรื่องเวลาตัดรอบ ถ้านอกเหนือเวลาตัดรอบ ให้ลงในหน้า On Demand</p>
<ol>
<li>(AIRPORTELs partner''s orders) ในหน้า Partner Delivery</li>
<li>(Luggage Delivery Record) ในหน้า Intown-TPY</li>
</ol>
<p>ในส่วนของ Nationwide ให้ลงทั้งหมด 3 tab ได้แก่</p>
<ol>
<li>AIRPORTELs partner''s orders ในหน้า Airportels Website เพื่อจัดส่งเข้าคลัง</li>
<li>Luggage Delivery Record ในหน้า Intown-TPY และ NTW next day หรือ NTW same day
<ul>
<li>(Luggage Delivery Record) ในหน้า Next day</li>
<li>(Luggage Delivery Record) ในหน้า Same day</li>
</ul>
</li>
</ol><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/respond-io-guide/fig-14.jpg" alt="" /><img src="/docs/respond-io-guide/fig-15.jpg" alt="" /><img src="/docs/respond-io-guide/fig-16.jpg" alt="" /><img src="/docs/respond-io-guide/fig-17.jpg" alt="" /><img src="/docs/respond-io-guide/fig-18.jpg" alt="" /><img src="/docs/respond-io-guide/fig-19.jpg" alt="" /><img src="/docs/respond-io-guide/fig-20.jpg" alt="" /><img src="/docs/respond-io-guide/fig-21.jpg" alt="" /><img src="/docs/respond-io-guide/fig-22.jpg" alt="" /><img src="/docs/respond-io-guide/fig-23.jpg" alt="" /><img src="/docs/respond-io-guide/fig-24.jpg" alt="" /><img src="/docs/respond-io-guide/fig-25.jpg" alt="" /><img src="/docs/respond-io-guide/fig-26.jpg" alt="" /><img src="/docs/respond-io-guide/fig-27.jpg" alt="" /><img src="/docs/respond-io-guide/fig-28.jpg" alt="" /><img src="/docs/respond-io-guide/fig-29.jpg" alt="" /><img src="/docs/respond-io-guide/fig-30.jpg" alt="" /><img src="/docs/respond-io-guide/fig-31.jpg" alt="" /><img src="/docs/respond-io-guide/fig-32.jpg" alt="" /><img src="/docs/respond-io-guide/fig-33.jpg" alt="" /><img src="/docs/respond-io-guide/fig-34.jpg" alt="" /><img src="/docs/respond-io-guide/fig-35.jpg" alt="" /><img src="/docs/respond-io-guide/fig-36.jpg" alt="" />', cover_image = '/docs/respond-io-guide/fig-1.jpg' where slug = 'respond-io-guide';

update sop.documents set content_html = '<h2>1. ติดตั้งและเข้าใช้งาน 3CX</h2>
<ol>
<li>ติดตั้งแอปพลิเคชัน "3CX" บนโทรศัพท์ของคุณ (ใช้งานผ่านอินเทอร์เน็ต / Work on internet)</li>
<li>สแกน QR code</li>
</ol>
<img src="/docs/3cx-guide/fig-1.jpg" alt="" /><p><em>ไอคอนแอป 3CX และหน้าจอ Keypad กับหน้าจอ Recents ของแอป 3CX บนมือถือ</em></p>
<h3>ความหมายของแท็บเมนู</h3>
<ul>
<li><strong>Team</strong> = Internal contacts (รายชื่อติดต่อภายใน)</li>
<li><strong>Contacts</strong> = Contacts (รวมเบอร์โทรศัพท์ในเครื่องของคุณ)</li>
<li><strong>Keypad</strong> (หมายเลข 1)</li>
<li><strong>Recents</strong> (หมายเลข 2)</li>
<li><strong>Chats</strong> = Internal chats (แชทภายใน)</li>
</ul>
<h2>2. วิธีปิดรับสายเข้าเมื่อไม่ได้ใช้งาน (How to turn off incoming calls when not in use)</h2>
<ol>
<li>กดที่ปุ่ม (หมายเลข 1)</li>
<li>เลือกสถานะของคุณ (แนะนำ = Do not disturb) (หมายเลข 2)</li>
<li>เมื่อถึงกะการทำงานของคุณ ต้องเลือกสถานะเป็น "Available"</li>
</ol>
<blockquote>สถานะที่เลือกได้ ได้แก่ Available, Away, Do not disturb, Lunch, Business Trip และ Set Status Temporarily</blockquote>
<img src="/docs/3cx-guide/fig-2.jpg" alt="" /><p><em>ปุ่มสถานะบนหน้าจอ 3CX และหน้าต่าง Status สำหรับเลือกสถานะการรับสาย</em></p>
<h2>3. การโอนสาย (Transfer the calls)</h2>
<ol>
<li>กดที่ปุ่ม (หมายเลข 1) — ปุ่ม Transfer</li>
<li>ที่หมายเลข 2 เลือกวิธีการโอน
<ul>
<li><strong>Transfer</strong> = โอนสายโดยตรง (Directly transfer)</li>
<li><strong>Att.transfer</strong> = แจ้งปลายทางก่อนโอนสาย (Notice destination before transfer)</li>
</ul>
</li>
<li>ควรเลือก Transfer จากนั้นเลือกหมายเลขปลายทาง</li>
</ol>
<img src="/docs/3cx-guide/fig-3.jpg" alt="" /><p><em>หน้าจอสายที่กำลังสนทนาพร้อมปุ่ม Transfer, หน้าต่างเลือกวิธี Transfer/Att.transfer และรายชื่อปลายทางที่จะโอนสาย</em></p>
<hr>
<p><em>AIRPORTELS INTERNATIONAL CO., Ltd. — 6 Pailin Park village, Soi Rattanathibet 28 Yak 2, Bang Kraso, Mueang Nonthaburi, Nonthaburi 11000 Tel. 02-0266927</em></p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/3cx-guide/fig-4.jpg" alt="" /><img src="/docs/3cx-guide/fig-5.jpg" alt="" /><img src="/docs/3cx-guide/fig-6.jpg" alt="" /><img src="/docs/3cx-guide/fig-7.jpg" alt="" />' where slug = '3cx-guide';

update sop.documents set content_html = '<h2>ข้อมูลเอกสาร</h2>
<ul>
<li><strong>รหัสเอกสาร / Document Code:</strong> SOP-OPS : 001/2025</li>
<li><strong>เวอร์ชัน / Version:</strong> 1.0</li>
<li><strong>วันที่บังคับใช้ / Effective Date:</strong> 1 กรกฏาคม 2568</li>
<li><strong>หน่วยงาน / Department:</strong> Operations</li>
</ul>
<h2>วัตถุประสงค์ (Objective)</h2>
<p>เพื่อกำหนดมาตรฐานการแต่งกายสำหรับพนักงาน Guest Service ทั้งชายและหญิง ให้ดูเรียบร้อย เหมาะสม และเป็นมืออาชีพ สร้างความประทับใจแก่ลูกค้า</p>
<p><em>To establish a dress code standard for both male and female Guest Service staff to ensure a neat, appropriate, and professional appearance that creates a positive impression for customers.</em></p>
<h2>ขอบเขต (Scope)</h2>
<p>พนักงานตำแหน่ง Guest Service / Branch Manager / Porter ทุกคนที่ปฏิบัติงานหน้าสาขา หรือให้บริการลูกค้าโดยตรง</p>
<p><em>All Service staff working at branches or in direct customer service roles.</em></p>
<h2>1. ข้อกำหนดทั่วไป (General Requirements)</h2>
<table>
<thead>
<tr><th>รายการ / Item</th><th>พนักงานชาย / Male Staff</th><th>พนักงานหญิง / Female Staff</th></tr>
</thead>
<tbody>
<tr><td>เสื้อ / Shirt</td><td>เสื้อยูนิฟอร์มบริษัท รีดเรียบ ไม่ยับ</td><td>เสื้อยูนิฟอร์มบริษัท รีดเรียบ ไม่ยับ</td></tr>
<tr><td>กางเกง / Pants</td><td>กางเกงขายาวสีดำ หรือสีตามบริษัทกำหนด ไม่รัดรูป</td><td>กระโปรง/กางเกงขายาว ทรงสุภาพ ความยาวคลุมเข่า</td></tr>
<tr><td>รองเท้า / Shoes</td><td>รองเท้าหุ้มส้น/ผ้าใบ สะอาด</td><td>รองเท้าหุ้มส้น ส้นเตี้ยหรือปานกลาง/ผ้าใบสะอาด</td></tr>
<tr><td>ทรงผม / Hair</td><td>ตัดผมสุภาพ ไม่ย้อมสีฉูดฉาด ไม่ไว้หนวด/เครา</td><td>รวบผมเรียบร้อย สีธรรมชาติ ไม่มีเครื่องประดับเกินจำเป็น</td></tr>
<tr><td>เล็บ / Nails</td><td>สั้น สะอาด ไม่ทาเล็บ</td><td>สะอาด สีธรรมชาติ ไม่มีเล็บปลอม หรืออุปกรณ์ที่มีอุปสรรคต่อการทำงาน</td></tr>
<tr><td>เครื่องประดับ / Accessories</td><td>ใส่นาฬิกาได้ ไม่ควรสวมแหวน/สร้อยที่โดดเด่น</td><td>เครื่องประดับเรียบง่าย เช่น ต่างหูเล็ก นาฬิกา</td></tr>
<tr><td>กลิ่นตัว / Body Odor</td><td>ใช้น้ำหอมอ่อนๆ ไม่มีกลิ่นตัวรบกวนลูกค้า</td><td>ใช้น้ำหอมเบาๆ ไม่ฉุนจนเกินไป</td></tr>
<tr><td>หน้ากากอนามัย / Mask</td><td>สีสุภาพ ไม่มีลวดลาย (ถ้ามีการกำหนดใช้)</td><td>สีสุภาพ ไม่มีลวดลาย (ถ้ามีการกำหนดใช้)</td></tr>
<tr><td>การแต่งหน้า / Make up</td><td>สามารถทาแป้ง/ลิปมัน ได้ตามความเหมาะสม</td><td>สีสันสุภาพ ไม่จัดจ้านจนเกินไป และไม่หน้าสด</td></tr>
</tbody>
</table>
<h2>2. ข้อห้าม (Prohibited)</h2>
<ul>
<li>ห้ามสวมใส่เสื้อผ้าที่ไม่ใช่ยูนิฟอร์มขณะปฏิบัติงาน / Do not wear non-uniform clothing during work
<ul>
<li>กรณีฉุกเฉิน อนุโลมให้ใส่เสื้อโปโล คอปกสีดำล้วน หรือสีกรมท่า ในการปฏิบัติงานได้ โดยต้องแจ้งหัวหน้าสาขา หรือผู้ดูแลให้ทราบทุกครั้ง</li>
</ul>
</li>
<li>ห้ามแต่งหน้า/ทำผม/ทาเล็บในลักษณะที่ไม่สุภาพ / No inappropriate makeup/hair/nail styles</li>
<li>ห้ามสวมรองเท้าแตะ หรือรองเท้าเปิดส้น / No sandals or open-heel shoes</li>
<li>ห้ามใส่เครื่องประดับแฟชั่นที่เด่นชัดหรือมีเสียงดังรบกวน / No flashy or noisy fashion accessories</li>
</ul>
<h2>3. การแขวนบัตรพนักงาน (Staff ID Badge Wearing Guideline)</h2>
<ul>
<li>พนักงานทุกคนต้องสวมบัตรพนักงานในตำแหน่งที่เห็นได้ชัดขณะปฏิบัติงาน / All staff must wear ID badges visibly while on duty</li>
<li>ต้องแขวนไว้บริเวณหน้าอกด้านซ้ายหรือกลางลำตัว ด้วยสายคล้องที่บริษัทจัดให้ / Badge must be hung on the left chest or center using company-provided lanyards</li>
<li>บัตรต้องสะอาด ไม่ชำรุด และไม่ปิดบังข้อมูลสำคัญ เช่น รูปถ่าย ชื่อ หรือรหัสพนักงาน / The badge must be clean, undamaged, and display key information (photo, name, ID)</li>
<li>ห้ามแก้ไข ดัดแปลง หรือประดับตกแต่งบัตรพนักงานด้วยวัสดุอื่น / Do not modify, decorate, or cover any part of the badge</li>
<li>หากบัตรหาย ต้องแจ้งหัวหน้าแผนกทันทีและดำเนินการขอออกบัตรใหม่ / Lost badges must be reported immediately and reissued through proper channels</li>
</ul>
<h2>4. การตรวจสอบและติดตามผล (Monitoring &amp; Compliance)</h2>
<p>หัวหน้าสาขาและทีมตรวจมาตรฐานจะเป็นผู้ตรวจสอบความเรียบร้อยในการแต่งกายของพนักงานทุกวัน หากพบการแต่งกายไม่เหมาะสม จะดำเนินการตามขั้นตอนการตักเตือน</p>
<p><em>Branch Supervisors and Standard Audit Teams are responsible for daily monitoring. Non-compliance will be addressed according to the disciplinary procedure.</em></p>
<h2>ตัวอย่างการแต่งกาย</h2>
<img src="/docs/dress-code-guest-service/fig-2.jpg" alt="" /><p><em>ตัวอย่างการแต่งกายพนักงานชาย-หญิง และการสวมบัตรพนักงาน</em></p>
<img src="/docs/dress-code-guest-service/fig-3.jpg" alt="" /><p><em>ตัวอย่างการแต่งหน้าและทรงผมของพนักงานชายและหญิง</em></p>
<img src="/docs/dress-code-guest-service/fig-4.jpg" alt="" /><p><em>ตัวอย่างเสื้อโปโล คอปกสีดำ และสีกรมท่า ที่อนุโลมให้ใส่ได้กรณีฉุกเฉิน</em></p><hr /><h3>ภาพประกอบจากคู่มือต้นฉบับ</h3><img src="/docs/dress-code-guest-service/fig-5.jpg" alt="" /><img src="/docs/dress-code-guest-service/fig-6.jpg" alt="" /><img src="/docs/dress-code-guest-service/fig-7.jpg" alt="" /><img src="/docs/dress-code-guest-service/fig-8.jpg" alt="" /><img src="/docs/dress-code-guest-service/fig-9.jpg" alt="" />', cover_image = '/docs/dress-code-guest-service/fig-1.jpg' where slug = 'dress-code-guest-service';

update sop.documents set content_html = '<h2>ข้อกำหนดและเงื่อนไขมาตรฐานการใช้บริการ</h2>
<h3>การยอมรับเงื่อนไขและข้อกำหนดของบริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด</h3>
<p>กรุณาอ่านเงื่อนไขและข้อกำหนดเหล่านี้อย่างละเอียดก่อนที่คุณจะเข้าถึงและใช้บริการของเรา บริการของเรามีให้บริการเฉพาะในเงื่อนไขที่ผู้เข้าร่วมบริการยอมรับเงื่อนไขและข้อกำหนดของเรา หากคุณไม่เห็นด้วยกับเงื่อนไขต่อไปนี้ กรุณาอย่าเข้าถึงหรือใช้บริการของเรา ขอให้ทราบว่าหากการจองหรือการเข้าร่วมใช้บริการของคุณทำโดยบุคคลที่สามและเป็นในนามของคุณ นั่นหมายความว่าคุณยอมรับและเคารพเงื่อนไขและข้อกำหนดเหล่านี้รวมถึงนโยบายความเป็นส่วนตัวของเรา</p>
<p>บริการของเรามีให้บริการเฉพาะสำหรับผู้ใช้ที่มีอายุ 18 ปีขึ้นไปและเป็นผู้ใหญ่ตามกฎหมายไทย ด้วยการใช้และเข้าถึงเว็บไซต์ แอปพลิเคชัน บริการของเรา คุณรับประกันว่าคุณมีอายุ 18 ปีขึ้นไป ยอมรับและเคารพเงื่อนไขและนโยบายของเรา และสามารถทำสัญญากับบริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด ได้อย่างอิสระ</p>
<h3>องค์กร</h3>
<p>บริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด เป็นองค์กรที่จดทะเบียนในราชอาณาจักรไทย ภายใต้เลขทะเบียน 0105565098687 และมีสำนักงานจดทะเบียนที่ 6 หมู่บ้านไพลินปาร์ค ซอยรัตนาธิเบศร์ 28 แยก 2 ตำบลบางกระสอ อำเภอเมืองนนทบุรี จังหวัดนนทบุรี 11000</p>
<h3>ราคาและการเรียกเก็บเงิน</h3>
<p>การกำหนดราคา การทำธุรกรรม หรือการกระทำใดๆ ที่เกี่ยวข้องกับเงินจะทำได้เฉพาะผ่านเว็บไซต์และ/หรืออีเมลหรือที่เคาน์เตอร์ของเรา (แผนกต้อนรับ) ในรายการต่อไปนี้ โปรดทราบว่าคำขอใดๆ สำหรับเงิน ผลประโยชน์ หรือการทำธุรกรรมใดๆ ที่ไม่ได้เกิดขึ้นที่สถานที่หรือช่องทางที่เราแต่งตั้งไม่ได้รับอนุญาตจากเรา</p>
<p>ราคาของบริการจะถูกเปิดเผยในรายการผ่านช่องทางของเรา เราอาจเปลี่ยนแปลงราคา แต่ราคาจะถูกตั้งไว้เมื่อมีการยืนยันการจอง และราคาที่ถูกแสดงทั้งหมดนั้นรวมภาษีมูลค่าเพิ่มแล้ว คำขอเพิ่มเติมใดๆ ที่ไม่ได้รวมอยู่ในการจองหรือการทำธุรกรรมเดียวกันจะถือเป็นคำสั่งซื้อใหม่ และราคาอาจแตกต่างกัน การทำธุรกรรมทั้งหมดสามารถชำระได้ด้วยบัตรเครดิต บัตรเดบิต และเงินสด โดยเป็นค่าเงินบาทไทย (฿) วิธีการชำระเงินมีดังนี้</p>
<h4>ออนไลน์</h4>
<ul>
<li>บัตรเครดิต/บัตรเดบิต (เฉพาะบัตรที่ออกโดย VISA, MASTER และ JCB)</li>
<li>Paypal</li>
<li>Alipay (เฉพาะผู้ใช้จากแผ่นดินใหญ่จีน)</li>
</ul>
<h4>ที่แผนกต้อนรับ AIRPORTELs (ประเทศไทย)</h4>
<ul>
<li>เงินสดเท่านั้นใน THB, เงินบาทไทย (฿)</li>
<li>บัตรเครดิต/บัตรเดบิต (เฉพาะบัตรที่ออกโดย VISA, MASTER, JCB และ UNION PAY)</li>
<li>Alipay (เฉพาะผู้ใช้จากแผ่นดินใหญ่จีน)</li>
<li>WeChat Pay (เฉพาะผู้ใช้จากแผ่นดินใหญ่จีน)</li>
<li>การโอนเงินไร้สาย</li>
<li>Paypal</li>
<li>Alipay (จีน)</li>
<li>PromptPay (ประเทศไทย)</li>
</ul>
<p>กระบวนการทั้งหมดของบริการ ตั้งแต่การจองจนถึงการเรียกเก็บเงินควรทำให้เสร็จสิ้นโดยใช้ชื่อและบุคคลเดียวกัน หนังสือเดินทางจริงหรือเอกสารรับรองการระบุตัวตนอื่นๆ ที่ได้รับการยอมรับ จะถูกขอให้แสดงเมื่อทำการทำธุรกรรม</p>
<p>ตาชั่งที่ใช้สำหรับการชั่งน้ำหนักและการคำนวณบิลได้รับการบำรุงรักษาและปฏิบัติตามมาตรฐาน ISO 9001 เมื่อคุณยอมรับที่จะใช้บริการ คุณยังตกลงกับผลลัพธ์ที่ได้โดยตาชั่งของเรา เราจะจัดทำใบแจ้งหนี้ที่ถูกต้องให้คุณตามน้ำหนักที่เราวัดได้ คุณจะต้องได้รับใบเสร็จการชำระเงินในรูปแบบแข็งหรืออ่อนหลังจากการทำธุรกรรมเสร็จสิ้นเสมอ</p>
<h3>ใบเสร็จรับเงิน</h3>
<p>รายละเอียดและข้อมูลเกี่ยวกับราคาของบริการจะถูกเปิดเผยในใบแจ้งหนี้เมื่อการเรียกเก็บเงินได้รับการยืนยัน และจะไม่มีการเรียกเก็บค่าธรรมเนียมเพิ่มเติม เรายินดีให้คำอธิบายหากมีคำสั่งใดๆ จากบริการของเราที่ไม่ชัดเจน บุคคลที่ใช้บริการควรเป็นบุคคลเดียวกับที่รับกระเป๋าหรือสัมภาระ ราคาที่ระบุในใบแจ้งหนี้ (ถ้ามี) และใบเสร็จรับเงินควรตรงกัน ใบเสร็จรับเงินจะถูกมอบให้เมื่อการทำธุรกรรมเสร็จสิ้นและคุณยอมรับเงื่อนไขและข้อกำหนดที่เรากำหนดไว้ การรับใบเสร็จรับเงินหมายความว่าคุณยอมรับว่าการให้บริการได้สิ้นสุดแล้ว</p>
<h3>ความรับผิดชอบของ AIRPORTELs</h3>
<p>เรามอบและให้บริการตามที่ระบุไว้ในเว็บไซต์, แอปพลิเคชัน และเอกสารที่เคาน์เตอร์ของเรา ตามมาตรา 13 หากเราไม่สามารถส่งมอบการจัดส่งตามเวลาที่กำหนดไว้ เราจะคืนเงิน 100% ให้แก่คุณ ตามมาตรา 13 หากเราไม่สามารถส่งมอบการจัดส่งขาออกตามเวลาที่กำหนดไว้ เราจะรับผิดชอบในการชำระเงินที่จำเป็นเพื่อส่งกระเป๋าของคุณไปยังปลายทางที่คุณกำหนด เราจะแจ้งให้คุณทราบถึงการเปลี่ยนแปลงใดๆ ที่อาจส่งผลกระทบต่อคุณผ่านช่องทางการติดต่อที่คุณให้ไว้</p>
<h3>ความรับผิดชอบของผู้ใช้</h3>
<p>คุณยินยอมว่าคุณจะไม่บรรจุสิ่งของที่ต้องห้าม ตามที่ระบุในมาตรา 15 ในกระเป๋าที่จะทำการขนส่งหรือรับฝาก และบริการถูกใช้อย่างเหมาะสม คุณรับผิดชอบต่อการสูญเสียหรือความเสียหายที่เกิดจากการใช้งานที่ไม่ถูกต้องหรือการละเมิดเงื่อนไขและข้อกำหนดของเรา ใบรับรองและใบเสร็จควรถูกเก็บรักษาโดยคุณเองและพร้อมที่จะตรวจสอบเมื่อคุณทำการเรียกเก็บเงินหรือเช็กเอาต์ที่เคาน์เตอร์ของเรา คุณยืนยันว่าข้อมูลที่คุณให้ไว้กับเรานั้นถูกต้องและได้รับการยืนยันโดยคุณเอง ไม่ว่าจะเป็นข้อมูลที่คุณให้ไว้ด้วยตัวเองหรือโดยบุคคลที่ได้รับอนุญาต หลักฐานหรือใบรับรอง (บัตรเครดิต/บัตรเดบิต หรือหนังสือเดินทาง) ของลายเซ็นหรือการระบุตัวตนของคุณอาจถูกขอโดยเจ้าหน้าที่ของเราเพื่อยืนยันการระบุตัวตนของคุณ</p>
<h3>นโยบายการจัดส่งและการจัดการความปลอดภัย</h3>
<p>บริการทั้งหมดของเราควรถูกใช้ด้วยวัตถุประสงค์ที่ถูกกฎหมาย โดยการใช้บริการจัดส่งของเรา คุณตกลงกับเงื่อนไขของเราและเคารพกฎหมายของราชอาณาจักรไทย เราจะไม่ทำลายกระเป๋าของคุณด้วยวัตถุประสงค์ที่ผิดกฎหมาย แต่ในกรณีที่จำเป็น เราจะร่วมมือกับหน่วยงานราชการหรือหน่วยงานของรัฐบาลไทยเพื่อการสอบสวนและป้องกันการกระทำผิดกฎหมาย หากมีการตรวจพบสิ่งของที่น่าสงสัย ผิดกฎหมาย มีความเสี่ยง หรืออันตราย จากการแจ้งของหน่วยงานทางการไทยหรือจากการค้นพบโดยเครื่องสแกนเอกซเรย์หรือการตรวจสอบที่ไม่ทำลายสิ่งของ คุณอาจถูกขอให้ยอมให้กระเป๋าของคุณถูกตรวจสอบหรือสอบสวนโดยเจ้าหน้าที่ของเรา หากคุณปฏิเสธที่จะทำเช่นนั้น เราอาจปฏิเสธที่จะให้บริการคุณเพื่อเหตุผลด้านความปลอดภัย เรามีสิทธิ์ปฏิเสธและยกเลิกคำขอ การจอง การสำรองห้องพัก หรือบริการอื่นๆ ของคุณหากคุณละเมิดเงื่อนไขและ/หรือถูกสงสัยว่ากระทำการที่ผิดกฎหมาย มีความเสี่ยง หรืออันตราย โดยไม่มีการคืนเงิน</p>
<p>กระเป๋าธรรมดาถูกนิยามว่ามีแต่ละด้าน (ความกว้าง ความยาว และความสูง) หรือเส้นผ่าศูนย์กลางของกระเป๋ารวมกันในทุกมิติ ไม่เกิน 200 ซม. และน้ำหนักของแต่ละชิ้นของกระเป๋าไม่ควรเกิน 25 กิโลกรัม</p>
<h3>กิจกรรมที่ไม่สามารถควบคุมได้</h3>
<p>เราไม่รับผิดชอบในการไม่สามารถส่งมอบบริการและดูแลกระเป๋าของคุณในกรณีที่เกิดจากบุคคลที่สามหรือสถานการณ์ที่อยู่นอกเหนือการควบคุมของเราดังต่อไปนี้:</p>
<ul>
<li>การไม่สามารถเป็นไปตามข้อกำหนดด้านความปลอดภัยการบิน</li>
<li>การไม่สามารถจัดส่งกระเป๋าของคุณให้ถึงสนามบินได้ทันเวลา</li>
<li>การไม่สามารถจัดส่งกระเป๋าของคุณให้ถึงโรงแรมได้ทันเวลา</li>
<li>การไม่สามารถจอง สำรอง หรือยกเลิกบริการของเราได้ทันเวลา</li>
<li>การกระทำของหน่วยงานราชการหรือองค์กรทางการ (เช่น ตำรวจ ศุลกากร ผู้ดำเนินการสนามบิน และหน่วยงานการบิน)</li>
<li>การหยุดชะงักของการขนส่งทางบกและทางอากาศระดับภูมิภาคหรือชาติ</li>
<li>ภัยธรรมชาติ (เช่น น้ำท่วม แผ่นดินไหว สึนามิ หรือไต้ฝุ่น)</li>
<li>สถานการณ์ที่ไม่สามารถควบคุมได้ที่เกิดจากบุคคลที่สาม (เช่น จลาจล การประท้วง ภัยไฟ การสอบสวนโดยหน่วยงานที่ได้รับอนุญาต)</li>
<li>การแตกหักหรือสูญหายของกระเป๋าหรือทรัพย์สินของคุณโดยการกระทำของบุคคลที่สามซึ่งอยู่นอกเหนือการควบคุมของเรา</li>
</ul>
<h3>รายการที่ถูกห้าม</h3>
<ul>
<li>สินค้าที่มีส่วนผสมของแอลกอฮอล์</li>
<li>สินค้าอันตราย วัตถุอันตราย</li>
<li>ของที่มีมูลค่าสูง เช่น เพชร พลอย ทองคำ</li>
<li>อาวุธปืนหรือสิ่งเทียบอาวุธและของมีคม</li>
<li>เงินสดและสิ่งต่างๆ ที่สามารถทดแทนเงินสดได้ เช่น เช็ค ธนบัตร หรือตราสารหนี้</li>
<li>สินค้าเน่าเสียได้ เช่น พืช ผัก ผลไม้ เนื้อสัตว์</li>
<li>พืชพันธุ์ เมล็ดพันธุ์พืช ไม้ต้องห้ามบางประเภท</li>
<li>วัตถุลามกอนาจาร และสื่อลามกทุกชนิด</li>
<li>สิ่งที่เป็นอันตรายทางชีวภาพ น้ำลาย เชื้อโรค เชื้อแบคทีเรีย เชื้อไวรัส สารกัมมันตภาพรังสี สารพิษ</li>
<li>สมุนไพรที่ขึ้นทะเบียนเป็นยา เช่น ยาดม ยาหม่อง</li>
<li>ผลิตภัณฑ์จากสัตว์ที่ไม่มีใบอนุญาต (ในบางประเทศ)</li>
<li>สินค้าที่เป็นถ่านหรือแบตเตอรี่ทุกชนิด</li>
<li>กระเป๋าเดินทาง (ที่ไม่ได้บรรจุในกล่องพัสดุ) ห้ามล็อค หรือใส่รหัสล็อค</li>
<li>ยาสูบและผลิตภัณฑ์จากยาสูบ</li>
<li>วัตถุไวไฟและสารเคมีที่สามารถก่อประกายไฟและระเบิดได้</li>
<li>สลากกินแบ่ง, ลอตเตอรี่ หรือสื่อการพนันต่างๆ</li>
<li>ยา และสิ่งเสพติดผิดกฎหมาย ยาม้า ไอซ์ หรือแม้กระทั่งกัญชา</li>
<li>สัตว์ที่มีชีวิตต่างๆ รวมถึงปลาและนก</li>
<li>เอกสารข้อมูลบุคคล เช่น พาสปอร์ต บัตรประชาชน บัตรเอทีเอ็ม บัญชีธนาคาร</li>
<li>สินค้าละเมิดลิขสิทธิ์ สินค้าปลอมหรือลอกเลียนแบบเครื่องหมายการค้า</li>
<li>องค์พระ พระเครื่อง เทวรูป และวัตถุโบราณต่างๆ</li>
<li>ชิ้นส่วนมนุษย์ รวมถึงเถ้าอัฐิ</li>
</ul>
<h3>ความรับผิดของ AIRPORTELs</h3>
<p>สำหรับกระเป๋าที่มีป้ายกำกับและคำสั่งซื้อที่ได้รับการยืนยัน เราจะรับรองว่าการจัดส่งหรือบริการจะถูกจัดส่งหรือให้บริการตามเวลา ไปยังจุดหมายปลายทางและผู้รับที่ถูกต้อง หากเราไม่สามารถปฏิบัติตามสัญญาได้ การชดเชยควรจะไม่เกินราคาหรือใดๆ ที่มีมูลค่า 50,000 บาท สำหรับหนึ่งคำสั่งซื้อ</p>
<ul>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับสิ่งของที่เปราะบางหรือที่เสื่อมสภาพได้ง่ายที่อยู่ในกระเป๋าที่เราจัดส่ง</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับสิ่งของที่ถูกห้ามหรือเนื้อหาในกระเป๋าที่เราจัดส่ง</li>
<li>เราจะไม่รับผิดชอบใดๆ ในกรณีที่คุณละเมิดหรือฝ่าฝืนเงื่อนไขของเราหรือกฎหมายไทย</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับสิ่งของที่ถูกแยกออก อันตราย หรือถูกห้ามหรือเนื้อหาในกระเป๋าที่เราจัดส่ง</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับทรัพย์สินหรือของมีค่าของคุณก่อนที่กระเป๋าหรืออุปกรณ์จะถูกมอบให้กับเราในสถานการณ์ใดๆ</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับทรัพย์สินหรือของมีค่าของคุณหลังจากการทำธุรกรรมสิ้นสุดและกระเป๋าถูกกู้คืนโดยลูกค้า</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับทรัพย์สินหรือของมีค่าของคุณหากมีบุคคลใดๆ รวมถึงคุณเอง แสดงหลักฐานที่ถูกต้องเพื่อเรียกคืนของมีค่าของคุณ</li>
<li>เราจะไม่รับผิดชอบใดๆ สำหรับทรัพย์สินหรือของมีค่าของคุณหากมีบุคคลใดๆ รวมถึงคุณเอง ที่ทำการกู้คืนของมีค่าของคุณออกจากเคาน์เตอร์ของเราที่ปลายทาง</li>
<li>มูลค่าทางอารมณ์ของสิ่งของจะไม่เกี่ยวข้องกับการประเมินมูลค่า</li>
<li>การติดของประดับใดๆ บนกระเป๋า เช่น ป้ายชื่อ ตุ๊กตาประดับ หมอน หรือกระเป๋าเล็ก ไม่ได้รับการรับประกันในเรื่องสภาพหรือการสูญหาย</li>
<li>ในกรณีที่กระเป๋าหรือเป้ของคุณเสียหาย และได้รับการยืนยันว่าความเสียหายและการสูญเสียเกิดขึ้นระหว่างการขนส่งโดยยานพาหนะของบริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด การชดเชยจะอ้างอิงตามตารางที่กำหนดไว้ต่อไปนี้</li>
</ul>
<h3>ตารางการเคลมกระเป๋า</h3>
<img src="/docs/terms-and-conditions-2025/fig-2.jpg" alt="" /><p><em>แผนภาพกระเป๋าเดินทางระบุตำแหน่งชิ้นส่วน A-Q (มือจับ, หูหิ้ว, ตัวรอง/ที่กันชน, ปลอกหุ้ม/ฐานรองขาล้อ, ขาล้อ, ล้อ, รางซิป, ยางรองซิป, รหัสล็อกกระเป๋า, ตัวซิป, ฝากระเป๋า, ขอบกระเป๋า ฯลฯ)</em></p>
<table>
<thead>
<tr><th>ส่วนของกระเป๋า</th><th>เคลมได้ไหม</th><th>วงเงินชดเชย (สูงสุด/บาท)</th><th>เงื่อนไข / รายละเอียด</th><th>หมายเหตุ</th></tr>
</thead>
<tbody>
<tr><td>ล้อ</td><td>เคลมได้</td><td>200 (ต่อล้อ)</td><td>แตก/หลุดจากโครง ไม่สามารถใช้งานได้</td><td>เคลม 20% ไม่ครอบคลุมรอยขีดข่วน</td></tr>
<tr><td>ขาล้อ / ปลอกหุ้ม/ฐานรองขาล้อ</td><td>เคลมได้</td><td>200 (ต่อล้อ)</td><td>ชำรุดหลุด ไม่สามารถตั้งกระเป๋าตรงได้</td><td>เคลม 20%</td></tr>
<tr><td>มือจับที่ลาก/ที่เข็น</td><td>เคลมได้</td><td>500</td><td>หัก/ดึงออกมาไม่ได้</td><td>เคลม 10% ไม่รวมกรณีฝืดแต่ยังใช้งานได้</td></tr>
<tr><td>หูหิ้วด้านบน</td><td>เคลมได้</td><td>500</td><td>หัก/ขาด/หลุดจากตัวกระเป๋า</td><td>เคลม 10%</td></tr>
<tr><td>หูหิ้วด้านข้าง / สายกระเป๋า (กรณีเป็นกระเป๋าเป้ Backpack) / ตัวซิป / รางซิป / ยางรองซิป</td><td>เคลมได้</td><td>500</td><td>ซิปหลุด ดึงไม่ได้/แตก ใช้งานไม่ได้ ซิปหลุดจากราง</td><td>เคลม 10%</td></tr>
<tr><td>ขอบกระเป๋า (ร่องซิป)</td><td>เคลมได้</td><td>400</td><td>แตกหรือบิดเสียรูปจากการกระแทก</td><td>เคลม 10%</td></tr>
<tr><td>ตัวรอง/ที่กันชน/ที่รองฐาน</td><td>เคลมได้</td><td>300</td><td>แตก/หาย ไม่สามารถตั้งกระเป๋าได้มั่นคง</td><td>เคลม 10%</td></tr>
<tr><td>ฝาด้านหน้า/ด้านหลัง</td><td>เคลมได้</td><td>1,000</td><td>บุบ, แตก, มีรอยกระแทกรุนแรง</td><td>เคลม 10% แตกน้อยกว่า 5 มม. / เคลม 20% บุบ/แตก 5-10 มม. / ไม่รวมรอยถลอกเล็กน้อย</td></tr>
<tr><td>ฝาด้านหน้า/ด้านหลัง</td><td>เคลมได้</td><td>1,000</td><td>ความเสียหายที่เกิดจากรู รอยขาด จากอุปกรณ์หรือสถานที่ของ AIRPORTELs</td><td>เคลม 50-100% ไม่ครอบคลุมรอยขีดข่วน และไม่ได้เสียหายจากอุปกรณ์ในกระเป๋า เช่น ภายในเก็บของแหลม แล้วทำให้ขาด</td></tr>
<tr><td>รหัสล็อกกระเป๋า</td><td>เคลมได้</td><td>300</td><td>ใช้งานไม่ได้, พัง</td><td>เคลม 10% ลูกค้าควรปลดล็อกก่อนฝาก</td></tr>
<tr><td>โครงกระเป๋าเสียรูป</td><td>เคลมได้</td><td>1,000</td><td>โครงบุ๋มหรือบิดจนใช้งานไม่ได้</td><td>เคลม 50% ต้องมีรูปยืนยันก่อน-หลัง</td></tr>
<tr><td>กระเป๋าสูญหาย</td><td>เคลมได้</td><td>ชดเชยตามจริง แต่ไม่เกิน 5,000 บาท</td><td>หายในช่วงเวลาที่ AIRPORTELs ต้องรับผิดชอบ เช่น ฝากที่สาขา, ขณะขนส่ง</td><td>ยกเว้นปลายทางเป็นโรงแรมหรือสถานที่ที่ไม่ใช่สาขา</td></tr>
<tr><td>ของภายใน</td><td>เคลมไม่ได้</td><td>-</td><td>ของแตกหักภายใน เช่น อาหาร, ของใช้</td><td>ยกเว้นสถานการณ์ฉุกเฉิน เช่น ของเปียกจากการขนส่ง</td></tr>
<tr><td>รอยขีดข่วนเล็กน้อย</td><td>เคลมไม่ได้</td><td>-</td><td>ถือเป็นรอยการใช้งานปกติ</td><td>-</td></tr>
<tr><td>การตกแต่งกระเป๋า (พวงกุญแจ ฯลฯ)</td><td>เคลมไม่ได้</td><td>-</td><td>ไม่รับผิดชอบอุปกรณ์ภายนอกที่ติดเพิ่ม</td><td>แนะนำถอดออกก่อนฝาก/ส่ง</td></tr>
</tbody>
</table>
<h3>ตารางการเคลมถุงกอล์ฟ</h3>
<p><em>[📷 แผนภาพถุงกอล์ฟระบุตำแหน่งชิ้นส่วน A-D (ซิปและรางซิป, หูหิ้ว/สายสะพาย/บ่า, โครงถุง, ตัวกันชน/ฐาน/มุม/ขาตั้งถุงกอล์ฟ)]</em></p>
<table>
<thead>
<tr><th>ส่วนของถุงกอล์ฟ</th><th>เคลมได้ไหม</th><th>วงเงินชดเชย (สูงสุด/บาท)</th><th>เงื่อนไข / รายละเอียด</th><th>หมายเหตุ</th></tr>
</thead>
<tbody>
<tr><td>ตัวกันชน/ฐาน/มุม/ขาตั้งถุงกอล์ฟ</td><td>เคลมได้</td><td>1,000</td><td>แตก/หัก/หลุดจากโครง จนใช้งานไม่ได้</td><td>เคลม 20% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก</td></tr>
<tr><td>ซิปและรางซิป</td><td>เคลมได้</td><td>500</td><td>ซิปหลุด ดึงไม่ไป/แตก ใช้งานไม่ได้</td><td>เคลม 10% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก</td></tr>
<tr><td>หูหิ้ว/สายสะพาย/บ่า</td><td>เคลมได้</td><td>1,000</td><td>ขาด/หลุดจากตัวถุง</td><td>เคลม 10-50% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก</td></tr>
<tr><td>ตัวถุงเสียหาย เช่น เป็นรู/ขาด/เปียก</td><td>เคลมได้</td><td>5,000</td><td>ภายนอกถุงฉีกขาด เป็นรู หรือเปียกฝนจากการขนส่ง</td><td>เคลม 10-50% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก</td></tr>
<tr><td>โครงถุงเสียรูป</td><td>เคลมได้</td><td>10,000</td><td>โครงเหล็ก/ไฟเบอร์งอ โครงบิดเบี้ยวจนใช้ไม่ได้</td><td>เคลม 50% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก</td></tr>
<tr><td>ไม้กอล์ฟ</td><td>เคลมได้</td><td>3,000</td><td>หัวหัก/บุบ จนใช้งานไม่ได้</td><td>เคลม 50% ต้องมีหลักฐานว่าไม่เสียหายตั้งแต่แรก เป็นรอยขีดข่วนไม่รับเคลม</td></tr>
<tr><td>ถุงกอล์ฟสูญหาย</td><td>เคลมได้</td><td>ชดเชยตามจริง แต่ไม่เกิน 50,000 บาท</td><td>หายในช่วงเวลาที่ AIRPORTELs ต้องรับผิดชอบ เช่น ฝากที่สาขา, ขณะขนส่ง</td><td>ยกเว้นปลายทางเป็นโรงแรมหรือสถานที่ที่ไม่ใช่สาขา</td></tr>
<tr><td>รอยขีดข่วนเล็กน้อย</td><td>เคลมไม่ได้</td><td>-</td><td>ถือเป็นรอยการใช้งานปกติ</td><td>-</td></tr>
<tr><td>การตกแต่งกระเป๋า (พวงกุญแจ, tag ติดถุง ฯลฯ)</td><td>เคลมไม่ได้</td><td>-</td><td>ไม่รับผิดชอบอุปกรณ์ภายนอกที่ติดเพิ่ม</td><td>แนะนำถอดออกก่อนฝาก/ส่ง</td></tr>
</tbody>
</table>
<h3>สิทธิ์ของลูกค้า</h3>
<ul>
<li>คุณมีสิทธิ์เปลี่ยนหรือยกเลิกการจองหรือการสำรองของคุณก่อน 3 ชั่วโมงของเวลาใช้งานสำหรับการเก็บกระเป๋า และก่อนเวลาตัดสินใจสำหรับการจัดส่งกระเป๋า</li>
</ul>
<h3>เวลาให้บริการ</h3>
<h4>กรุงเทพฯ (เวลาท้องถิ่นของไทย)</h4>
<ul>
<li>สนามบินสุวรรณภูมิ (BKK) — 24 ชั่วโมง (ชั้น B, ลิงค์เชื่อมต่อสนามบิน, สนามบินสุวรรณภูมิ)</li>
<li>สนามบินดอนเมือง (DMK) — 24 ชั่วโมง (ชั้น 1, ประตู 9, เทอร์มินัล 2, สนามบินดอนเมือง)</li>
<li>ศูนย์การค้า MBK Center — 10:00-22:00 (โซน B, ชั้น 6, MBK Center)</li>
<li>Terminal 21 อโศก — 10:00-22:00 (โซนญี่ปุ่น, ชั้น 1, ศูนย์การค้า Terminal 21 อโศก)</li>
<li>Central World — 10:00-22:00 (ชั้น 1, โซน Hug Thai, ข้างทางออก D ร้านชาตรามือ)</li>
<li>Mixt Chatuchak — จันทร์-พฤหัสบดี 10:00-20:00 / ศุกร์-อาทิตย์ 10:00-21:00 (โซน B, ชั้น 2)</li>
<li>ICONSIAM — 10:00-22:00 (ชั้น Lobby B2, SIAM Takashimaya ICONSIAM)</li>
<li>Yaowarat Chinatown — จันทร์-พฤหัสบดี 10:00-18:00 / ศุกร์-เสาร์ 10:00-14:00 (ชั้น 2, อาคารพิชัยญาติ)</li>
<li>เอ็มสเฟียร์ — 10:00-22:00 (ชั้น B1 ล้อบบี้ B หน้าลิฟต์)</li>
<li>เอ็มโพเรียม — 10:00-22:00 (ชั้น B2 floor ใกล้บันไดเลื่อนกลาง)</li>
<li>ฟินิกซ์ ประตูน้ำ — จันทร์-ศุกร์ 10:00-21:00 / เสาร์-อาทิตย์ 10:00-22:00 (ชั้น M โซนโอท็อป ใกล้โซนมิชลิน)</li>
</ul>
<h4>พัทยา (เวลาท้องถิ่นของไทย)</h4>
<ul>
<li>Terminal 21 พัทยา — จันทร์-พฤหัสบดี 11:00-22:00 / ศุกร์-อาทิตย์ 11:00-23:00 (โซน Paris, ชั้น G, ข้างร้าน EVEANDBOY)</li>
<li>Central Pattaya — จันทร์-พฤหัสบดี 11:00-22:00 / ศุกร์-อาทิตย์ 11:00-23:00 (ชั้น 1, ใกล้ประตูโรงแรม Hilton Pattaya)</li>
</ul>
<h4>เชียงใหม่ (เวลาท้องถิ่นของไทย)</h4>
<ul>
<li>สนามบินเชียงใหม่ — 06:00-24:00 (ชั้น 1 ใกล้ประตู 7 เยื้องกับเคาน์เตอร์ไปรษณีย์ไทย)</li>
</ul>
<h4>ภูเก็ต (เวลาท้องถิ่นของไทย)</h4>
<ul>
<li>สนามบินภูเก็ต (อาคารภายในประเทศ) — 06:00-24:00 (ชั้น 1 ประตู 1)</li>
<li>สนามบินภูเก็ต (อาคารระหว่างประเทศ) — 06:00-24:00 (ชั้น 1 ประตู 2)</li>
</ul>
<h3>การตีความและคำศัพท์</h3>
<ul>
<li><strong>"กระเป๋า"</strong> หมายถึง สิ่งของหรือบุคคลที่ลูกค้าของเราได้ร้องขอให้จัดส่งไปยังจุดหมายปลายทางที่ได้รับการแต่งตั้ง โดยมีขนาดรวมทุกมิติไม่เกิน 200 ซม. และมีน้ำหนักเบากว่า 25 กิโลกรัม</li>
<li><strong>"เรา"</strong> หมายถึง บริษัท แอร์พอเทลส์ อินเตอร์เนชันแนล จำกัด</li>
<li><strong>"คุณ"</strong> หมายถึง บุคคลใดๆ ที่เข้าถึง ใช้งาน และเกี่ยวข้องกับเว็บไซต์และบริการของบริษัทฯ</li>
<li><strong>"ผู้รับ"</strong> หมายถึง บุคคลหรือหน่วยงานที่ให้ข้อมูลอ้างอิงที่ถูกต้องซึ่งได้รับจากบริษัทฯ และหนังสือเดินทางหรือบัตรประจำตัวประชาชนไทยที่ถูกต้องเพื่อรับกระเป๋าจากบริษัทฯ</li>
<li><strong>"ผู้เข้าร่วม"</strong> หมายถึง บุคคล กลุ่ม องค์กร บริษัท สถาบัน หรือหน่วยงานใดๆ ที่มีส่วนร่วมในกิจกรรม (รวมถึงแต่ไม่จำกัดเพียงการทำธุรกรรม การแบ่งปันข้อมูล และธุรกิจ) กับบริษัทฯ</li>
<li><strong>"บริการ"</strong> หมายถึง กิจกรรมและการสนับสนุนที่ให้โดยบริษัทฯ รวมถึงแต่ไม่จำกัดเพียงเว็บไซต์ แอปพลิเคชัน และบริการจัดส่ง</li>
<li><strong>"สิ่งของที่ถูกห้าม"</strong> หมายถึง สิ่งของหรือบุคคลใดๆ ที่เป็นอันตราย มีความเสี่ยง สามารถเน่าเสีย มีศักยภาพที่จะก่อให้เกิดอันตราย และ/หรือไม่ได้รับอนุญาตให้ขนส่งภายใต้ข้อกำหนดการขนส่งทางอากาศและทางบก</li>
<li><strong>"สิ่งของที่ถูกยกเว้น"</strong> หมายถึง สิ่งของหรือบุคคลใดๆ ที่ถูกพิจารณาในการประเมินมูลค่าโดยผู้ขนส่ง (เช่น เครื่องประดับ ของโบราณ ขนสัตว์ หิน เช็ค เงินสด ภาพถ่าย งานศิลปะ เนื้อผ้า และสินค้าที่เปราะบางหรือเน่าเสียได้ง่าย)</li>
<li><strong>"หนังสือเดินทาง"</strong> คือ การรับรองทางการและถูกกฎหมายที่ออกโดยสถาบันราชการหรือผู้กำกับดูแลของรัฐของสัญชาติของบุคคล</li>
<li><strong>"การกระทำที่ผิดกฎหมาย"</strong> หมายถึง การกระทำ กิจกรรม หรือการเคลื่อนไหวใดๆ ที่ถูกห้ามและจะฝ่าฝืนกฎหมายและข้อบังคับของรัฐบาลไทย</li>
<li><strong>"การกระทำที่อันตราย"</strong> คือ การกระทำ กิจกรรม หรือการเคลื่อนไหวที่จะก่อให้เกิดอันตราย การสูญเสีย หรือละเมิดกฎหมายหรือกฎระเบียบใดๆ ของราชอาณาจักรไทย</li>
<li><strong>"การกระทำที่มีความเสี่ยง"</strong> คือ มีศักยภาพและ/หรือมีเจตนาที่จะก่อให้เกิดอันตราย การสูญเสีย หรือละเมิดกฎหมายหรือกฎระเบียบใดๆ ของราชอาณาจักรไทย</li>
<li><strong>"การจัดส่งขาเข้า"</strong> หมายถึง การจัดส่งกระเป๋าจากสนามบินที่ได้รับการแต่งตั้งไปยังโรงแรมที่ได้รับการแต่งตั้ง</li>
<li><strong>"การจัดส่งขาออก"</strong> หมายถึง การจัดส่งกระเป๋าจากโรงแรมที่ได้รับการแต่งตั้งไปยังสนามบินที่ได้รับการแต่งตั้ง</li>
<li><strong>"ที่ได้รับการแต่งตั้ง"</strong> คือ คำคุณศัพท์ที่ใช้บรรยายบุคคลหรือหน่วยงานใดๆ ที่มีความสัมพันธ์กับบริษัทฯ ในการร่วมมือใดๆ</li>
<li><strong>"ผู้ร่วมงาน"</strong> หมายถึง พนักงาน ลูกจ้าง หรือแรงงานที่มีสัญญาจ้างอย่างถูกกฎหมายกับหรือที่ได้รับการจ้างโดยบริษัทฯ และเสมอในเครื่องแบบของบริษัทฯ และป้ายชื่อของเขา/เธอระหว่างการทำงาน</li>
<li><strong>"เวลาจัดส่งตามกำหนด"</strong> คือ เวลาที่ได้รับการแต่งตั้งและ/หรือเวลาที่ได้รับการจัดสรรที่เปิดเผยในแถลงการณ์ที่ได้รับการตีพิมพ์ของบริษัทฯ</li>
<li><strong>"ไม่ทำลาย"</strong> คือ คำคุณศัพท์ที่ใช้บรรยายกระบวนการ วิธีการ หรือเทคนิคที่จะไม่ทำให้สิ่งของใดๆ พิการทางกายภาพ ทำอันตราย หรือทำลายการทำงานหรือรูปลักษณ์ของสิ่งของทางกายภาพใดๆ</li>
</ul>
<h3>การยอมรับเงื่อนไขเวลา</h3>
<ul>
<li>ทุกเวลา วัน และวันที่ที่ระบุไว้ในเอกสารนี้ การจองของลูกค้า คำสั่งซื้อ หรือเอกสารอื่นๆ ที่ได้รับจากบริษัทฯ นั้นเป็นเวลาท้องถิ่นของไทย, ICT, UTC/GMT +7 ชั่วโมง</li>
<li>ในกรณีที่ลูกค้ามารับกระเป๋าก่อนวัน เวลา ที่จองไว้ โดยไม่แจ้งล่วงหน้าก่อน 3 ชั่วโมง ลูกค้าจำเป็นจะต้องรอการค้นหาและตรวจสอบกระเป๋า ไม่สามารถกำหนดเวลาหรือเร่งได้</li>
<li>THB 1,000 if luggage is collected late, starting from 5 minutes after branch closing time (24:00 hrs.)</li>
</ul>
<h3>หลักฐานที่ถูกต้อง</h3>
<p>สำหรับข้อมูลบริการหรือข้อโต้แย้งใดๆ บริษัทฯ ให้การอ้างอิงเฉพาะอีเมลที่ส่งมาจาก center@airportels.asia, ใบเสร็จการเรียกคืนที่พิมพ์ออกมา, เว็บไซต์ของบริษัทฯ, ระบบการจัดการของบริษัทฯ หรือเอกสารทางกายภาพใดๆ ที่ได้รับจากผู้ร่วมงานที่ได้รับอนุญาตของบริษัทฯ</p>
<h2>นโยบายการใช้บริการและการจอง</h2>
<h3>นิยามของกระเป๋า</h3>
<ul>
<li>กระเป๋าลักษณะปกติ ถูกนิยามตามข้อกำหนดของสายการบินและสามารถเช็คอินหรือนำขึ้นเครื่องบินที่ลูกค้าจะเดินทางได้</li>
<li>แต่ละชิ้นของกระเป๋าปกติควรมีขนาดยาวรวมไม่เกิน 200 ซม. ในทุกมิติ และมีน้ำหนักเบากว่า 25 กิโลกรัม</li>
<li>ถุงกอล์ฟ และอุปกรณ์กอล์ฟอื่นๆ ถือว่านับเป็นถุงกอล์ฟ</li>
<li>อุปกรณ์กีฬาใดๆ ยกเว้นถุงกอล์ฟ (รวมถึงแต่ไม่จำกัดเพียง กระดานโต้คลื่น/สโนว์บอร์ด และจักรยาน), เครื่องดนตรี (รวมถึงแต่ไม่จำกัดเพียง เชลโล่, กีตาร์, ปิยาโน, และกลอง), และรถเข็นเด็ก/รถเข็นเด็กทารก ไม่ถือว่าเป็นกระเป๋าลักษณะปกติ</li>
<li>ชิ้นกระเป๋าหรือสิ่งของที่ไม่ใช่กระเป๋าปกติถือว่าเป็นกระเป๋าลักษณะพิเศษ</li>
<li>กระเป๋าทุกใบควรอยู่ในสภาพดีเยี่ยมและสามารถปิด ผนึกหรือซิปได้อย่างเหมาะสม</li>
<li>กระเป๋าทั้งหมดควรแยกจากกันแทนที่จะมัดรวมหรือติดกับสิ่งของอื่นใด รวมถึงแต่ไม่จำกัดเพียงถุงพลาสติก หมอนเดินทาง และกระเป๋าเดินทางขนาดเล็ก</li>
<li>ตามมาตรา 15 ของ "เงื่อนไขมาตรฐาน" กระเป๋าไม่ควรมีสิ่งของที่ผิดกฎหมาย อันตราย ถูกห้าม มีความเสี่ยง หรือน่าสงสัยใดๆ และบริษัทฯ มีสิทธิ์ปฏิเสธกระเป๋าหรือของมีค่าใดๆ ที่ไม่เป็นไปตามเงื่อนไขการให้บริการ</li>
<li>สิ่งที่ติดกับกระเป๋า เช่น ป้ายชื่อ ตุ๊กตาประดับ หมอน หรือกระเป๋าขนาดเล็ก ซึ่งไม่ถูกนับเป็นชิ้นของกระเป๋าเดียว ไม่ได้รับการรับประกันในแง่ของสภาพหรือการสูญหาย</li>
</ul>
<h3>เงื่อนไขการจอง</h3>
<ul>
<li>คำสั่งซื้อควรทำอย่างน้อย 3 ชั่วโมงก่อนใช้บริการและต้องได้รับการยืนยันจากบริษัทฯ</li>
<li>บริษัทฯ มีสิทธิ์ปฏิเสธหรือยกเลิกการจองที่เราเชื่อว่ามีการใช้บริการของเราอย่างไม่เหมาะสมโดยคุณหรือบุคคลที่สามเพื่อการได้ประโยชน์ทางการค้า</li>
<li>ลูกค้าควรตรวจสอบให้แน่ใจว่าข้อมูลและข้อมูลการติดต่อทั้งหมดถูกต้องและสามารถติดต่อได้จริง</li>
<li>หลังจากทำการจอง สามารถตรวจสอบข้อมูลคำสั่งซื้อล่าสุดและสถานะได้ที่ https://app.airportels.asia/tracking โดยใส่รหัสคำสั่งซื้อ</li>
<li>การจองจะได้รับการยืนยันเมื่อการชำระเงินเสร็จสิ้นและลูกค้าได้รับอีเมลยืนยันจาก center@airportels.asia หรือ noreply@airportels.asia เท่านั้น</li>
</ul>
<h3>เงื่อนไขการแก้ไข</h3>
<ul>
<li>เพื่อเปลี่ยนแปลงการจอง คำขอควรทำผ่านอีเมลอย่างน้อย 3 ชั่วโมงก่อนใช้บริการ</li>
<li>หลังจากได้รับการยืนยันการแก้ไข ลูกค้าควรได้รับอีเมลอัปเดตจากบริษัทฯ</li>
<li>หลังจากการแก้ไข สามารถตรวจสอบข้อมูลคำสั่งซื้อล่าสุดได้ที่ https://app.airportels.asia/tracking โดยใส่รหัสคำสั่งซื้อ</li>
</ul>
<h3>เงื่อนไขการยกเลิกและการคืนเงิน</h3>
<ul>
<li>เพื่อยกเลิกคำสั่งซื้อและรับเงินคืนเต็มจำนวน คำขอควรทำผ่านอีเมลอย่างน้อย 3 ชั่วโมงก่อนใช้บริการ</li>
<li>การจองหรือคำสั่งซื้อที่ถูกยกเลิกหลังจากเวลาใช้บริการหรือภายใน 3 ชั่วโมงหลังจากเวลาใช้บริการจะไม่ได้รับการคืนเงิน</li>
<li>การคืนเงินจะดำเนินการภายใน 7-14 วันทำการ</li>
<li>การคืนเงินจะดำเนินการเฉพาะผ่านช่องทางการโอนเงิน หรือช่องทางออนไลน์</li>
<li>การจอง/คำสั่งซื้อจะถือว่าเป็น "ไม่แสดงตน" ตั้งแต่เวลาเริ่มให้บริการที่ได้รับการแต่งตั้ง</li>
</ul>
<h3>การแจ้งเตือนการเปลี่ยนแปลง</h3>
<ul>
<li>การอัพเดทหรือการแจ้งเตือนการเปลี่ยนแปลงของคำสั่งซื้อ/การจองจะถูกแจ้งเตือนเฉพาะจาก center@airportels.asia หรือ noreply@airportels.asia เท่านั้น</li>
<li>หลังจากมีการแก้ไข/เปลี่ยนแปลงบริการ คุณควรเก็บอีเมลยืนยันไว้เป็นหลักฐาน</li>
<li>หลังจากยกเลิกบริการ คุณควรเก็บอีเมลยืนยันไว้เป็นหลักฐาน</li>
<li>ตามมาตรา 4 ในเงื่อนไขมาตรฐาน บริษัทฯ จะเปลี่ยนแปลงเงื่อนไขและข้อกำหนดตามความเหมาะสมหรือเป็นครั้งคราว</li>
</ul>
<h3>เงื่อนไขบริการจัดส่งภายในเมือง</h3>
<ul>
<li>คำสั่งซื้อและการจองของลูกค้าจะได้รับการยืนยันเฉพาะหลังจากการชำระเงินเสร็จสมบูรณ์โดยลูกค้า</li>
<li>สำหรับการจัดส่งตามกำหนดเวลา พนักงานของบริษัทฯ จะติดต่อและยืนยันกับแผนกต้อนรับของที่พักหรือหน่วยงานใดๆ ที่จะเก็บของของลูกค้าไว้จนกว่าบริษัทฯ จะมารับ พนักงานขนส่ง คนขับ หรือพนักงานของบริษัทฯ จะรับกระเป๋าจากที่พักใน 1-3 ชั่วโมงหลังจากเวลาที่กำหนด และส่งถึงภายในวันเดียวกัน</li>
<li>สำหรับการจัดส่งตามกำหนดเวลา กระเป๋าจะถูกส่งไปยังจุดหมายตามตารางเวลาและไม่สามารถนัดเวลาแบบเจาะจงได้</li>
<li>สำหรับบริการจัดส่งแบบ Fast delivery พนักงานขนส่ง คนขับ หรือพนักงานของบริษัทฯ จะรับกระเป๋าจากที่พัก 30 นาทีก่อนหรือหลังเวลาส่งที่ได้รับการแต่งตั้ง ที่ประตูหรือล็อบบี้ของที่พักสำหรับบริการจัดส่งขาออก</li>
<li>สำหรับการจัดส่งแบบ Fast delivery กระเป๋าสามารถจัดส่งได้เร็วที่สุดภายใน 2 ชั่วโมง</li>
<li>บริการจัดส่งแบบ Fast delivery มีให้บริการเฉพาะในพื้นที่กรุงเทพฯ เชียงใหม่ และภูเก็ต</li>
<li>หากลูกค้าวางกระเป๋าไว้ที่สถานที่ส่งสาย รวมถึงแต่ไม่จำกัดเพียง สนามบิน โรงแรม ศูนย์การค้า หรือบ้าน เจ้าหน้าที่ของบริษัทฯ จะรอเพียง 15 นาทีเท่านั้น</li>
<li>หลังจากเวลาที่ได้รับการแต่งตั้ง 15 นาที หรือในกรณีที่บริษัทฯ ไม่สามารถติดต่อลูกค้าได้ คำสั่งซื้อจะกลายเป็น "ไม่แสดงตน" และจะถูกยกเลิกโดยไม่มีการคืนเงิน</li>
<li>หากพนักงานขนส่ง คนขับ หรือพนักงานของบริษัทฯ ไม่พบกระเป๋าจากการจองที่สถานที่ที่ได้รับการแต่งตั้ง บริษัทฯ จะใช้เฉพาะโทรศัพท์หรืออีเมลเพื่อติดต่อลูกค้า</li>
<li>บริษัทฯ จะไม่รับผิดชอบใดๆ สำหรับสิ่งของที่เปราะบางหรือที่เสื่อมสภาพได้ง่าย หรือเนื้อหาในกระเป๋าที่เราจัดส่ง</li>
<li>สำหรับรายละเอียดเพิ่มเติมเกี่ยวกับสิ่งของที่ถูกห้าม กรุณาดูที่มาตรา 13 และ 15 ของเงื่อนไขมาตรฐาน</li>
<li>สำหรับจุดหมายปลายทางในพื้นที่ที่ติดกับกรุงเทพฯ จะมีการเรียกเก็บค่าบริการเพิ่มตามสถานการณ์</li>
</ul>
<p>พื้นที่พิเศษที่ติดกับกรุงเทพฯ รวมถึงสถานที่ต่อไปนี้:</p>
<ul>
<li>จังหวัดสมุทรปราการ</li>
<li>จังหวัดปทุมธานี</li>
<li>จังหวัดนนทบุรี</li>
<li>เมืองพัทยา</li>
</ul>
<p>พื้นที่ในจังหวัดเชียงใหม่ ส่งได้เฉพาะภายใน</p>
<ul>
<li>อำเภอเมืองเชียงใหม่</li>
<li>อำเภอสันทราย เฉพาะ สันทรายน้อย, หนองจ๊อม, สันพระเนตร</li>
<li>อำเภอสันกำแพง เฉพาะพื้นที่ สันกลาง</li>
<li>อำเภอสารภี เฉพาะตำบล ไชยสถาน, หนองผึ้ง, ท่าวังตาล</li>
<li>อำเภอหางดง เฉพาะตำบล สันผักหวาน, หนองควาย</li>
<li>อำเภอแม่ริม เฉพาะตำบล ดอนแก้ว</li>
<li>สนามกอล์ฟรอบๆ เมือง ระยะทาง 50 km จากสนามบินเชียงใหม่</li>
<li>หมายเหตุ: ไม่ขึ้นดอยสุเทพ ดอยอินทนนท์ หรือเขาอื่นๆ</li>
</ul>
<p>พื้นที่ในจังหวัดภูเก็ต ส่งได้เฉพาะภายใน</p>
<ul>
<li>เกาะภูเก็ต (ไม่รวมเกาะรอบๆ)</li>
<li>ตำบลหล่อยูง จ.พังงา</li>
<li>ตำบลโคกกลอย จ.พังงา</li>
</ul>
<p>บริการจัดส่งมีให้บริการทุกวันตั้งแต่ 07:00 ถึง 21:00</p>
<h3>เงื่อนไขการจัดส่งทั่วประเทศไทย</h3>
<p>ค่าบริการเพิ่มเติมจะถูกเรียกเก็บหากกระเป๋าเก็บไว้ที่บริษัทฯ เกินกว่า 24 ชั่วโมง</p>
<h4>บริการจัดส่งในวันถัดไป</h4>
<ul>
<li>บริการนี้มีให้เฉพาะกระเป๋าที่มีขนาดสั้นกว่า 200 ซม. ในทุกด้าน และมีน้ำหนักไม่เกิน 25 กิโลกรัม</li>
<li>สำหรับกระเป๋าที่มีน้ำหนักเกิน 25 กิโลกรัม จะมีการเรียกเก็บเพิ่ม 100 บาท/กิโลกรัม</li>
<li>หากน้ำหนักเพิ่มเติมน้อยกว่า 1 กิโลกรัม ค่าบริการจะถูกคิดเป็น 1 กิโลกรัม</li>
<li>กระเป๋าขนาดใหญ่เกินกำหนด เช่น อุปกรณ์กีฬาที่มีขอบหนึ่งมีขนาดเกินกว่า 200 ซม. ในทุกด้าน ไม่สามารถให้บริการได้</li>
<li>กระเป๋าควรถูกส่งที่บริษัทฯ ก่อน 3 ชั่วโมงก่อนเวลาตัดจำหน่าย (ก่อน 09:00 หรือ 11:00) ในวันจัดส่ง</li>
<li>สำหรับบริการจัดส่งในวันถัดไปทั่วประเทศไทย บริษัทฯ ไม่รับประกันการจัดส่งตรงเวลา ในวันและเวลาที่ได้รับการแต่งตั้ง</li>
<li>บริษัทฯ มีสิทธิ์ปฏิเสธกระเป๋าหรือของมีค่าใดๆ ที่อยู่นอกเหนือเงื่อนไขการให้บริการ</li>
<li>บริการนี้สามารถใช้ได้เฉพาะที่สาขาของบริษัทฯ และไม่สามารถจองออนไลน์ได้ในขณะนี้</li>
<li>หากมีสิ่งของที่ถูกห้ามในกระเป๋า ลูกค้าควรยินยอมให้บริษัทฯ เปิดและเก็บสิ่งของที่ถูกห้ามไว้ และชำระค่าบริการเพิ่มตามอัตราค่าบริการของบริษัทฯ</li>
</ul>
<h4>บริการจัดส่งในวันเดียวกัน</h4>
<ul>
<li>พื้นที่บริการ: กรุงเทพฯ, เชียงใหม่ และภูเก็ต</li>
<li>กระเป๋าจะถูกจัดส่งตามตารางการจัดส่ง</li>
<li>หากมีสิ่งของที่ถูกห้ามอยู่ในกระเป๋า ลูกค้าควรยินยอมให้บริษัทฯ เปิดและเก็บสิ่งของที่ถูกห้ามไว้ และชำระค่าบริการเพิ่มเติมตามอัตราค่าบริการของบริษัทฯ</li>
<li>จะมีการเรียกเก็บค่าบริการเพิ่มเติมเมื่อกระเป๋ามีน้ำหนักเกินขีดจำกัดรวมของคำสั่งซื้อ</li>
<li>บริษัทฯ มีสิทธิ์ปฏิเสธการจัดส่งหากกระเป๋าหรือของมีค่าใดๆ ไม่อยู่ในเงื่อนไขที่กำหนด</li>
<li>สิ่งของที่ถูกห้าม (บริการจัดส่งในวันเดียวกันทั่วประเทศไทย) เป็นไปตามมาตรา 15 ในเงื่อนไขมาตรฐาน รวมถึงรายการที่ถูกห้ามทั้งหมดตามที่ระบุข้างต้น</li>
</ul>
<h3>เงื่อนไขของบริการเก็บรักษา</h3>
<ul>
<li>สำหรับคำสั่งซื้อที่จองออนไลน์ การชำระเงินสำหรับบริการจะทำเฉพาะเมื่อการจองได้รับการยืนยันแล้ว ตามมาตรา 2</li>
<li>ระยะเวลาการเก็บรักษานับตั้งแต่เวลาการจองที่ได้รับการแต่งตั้งหากกระเป๋าถูกส่งหลังจากเวลาที่กำหนด</li>
<li>ระยะเวลาการเก็บรักษานับตั้งแต่เวลาที่กระเป๋าถูกส่งหากกระเป๋าถูกส่งก่อนเวลาที่กำหนด</li>
<li>หากกระเป๋าถูกเรียกคืนหลังจากเวลาที่กำหนดไว้ในการเรียกคืน จะมีการเรียกเก็บค่าบริการเพิ่มเติมตามอัตราค่าบริการของสาขาท้องถิ่น ตามมาตรา 1 ในรายการราคาและการเรียกเก็บค่าโปรโมชั่น</li>
<li>สำหรับคำสั่งซื้อแบบ Walk-in การชำระเงินสำหรับบริการจะทำเฉพาะเมื่อกระเป๋าถูกเรียกคืน ยกเว้นว่าระยะเวลาการเก็บรักษาเกินกว่า 30 วัน</li>
<li>ลูกค้าควรชำระค่าบริการทั้งหมดสำหรับแต่ละชิ้นสัมภาระ หากระยะเวลาการเก็บรักษาเกินกว่า 30 วัน</li>
<li>หากกระเป๋าถูกเรียกคืนก่อนเวลาที่ได้รับการแต่งตั้ง จะไม่มีการคืนเงิน</li>
<li>ลูกค้าสามารถนำฝากกระเป๋าหรือของมีค่าได้เฉพาะในช่วงเวลาให้บริการ ตามกฎข้อบังคับของแต่ละสาขาของบริษัทฯ</li>
<li>เพื่อขยายระยะเวลาการนำฝาก กรุณาติดต่อบริษัทฯ ผ่านทาง center@airportels.asia และรับการยืนยันจากอีเมลของบริษัทฯ center@airportels.asia เท่านั้น</li>
<li>บริษัทฯ จะส่งการยืนยันการขยายระยะเวลาในการรับฝากต่อเมื่อมีการระบุระยะเวลาที่จะยืดการนำฝากครั้งใหม่ และค่าบริการระหว่างการฝากก่อนที่ทำการขยายเวลา และระยะเวลาที่จะยืดการนำฝากครั้งใหม่ได้รับการชำระ</li>
<li>หลังจากสิ้นสุดการนำฝากในระยะเวลา 1 เดือน (30 วัน) และไม่มีการขยายระยะเวลาการรับฝาก กระเป๋าจะถูกจัดการเป็นทรัพย์สินของบริษัทฯ</li>
<li>ลูกค้าควรได้รับใบเรียกคืนหลังจากเก็บกระเป๋าที่บริษัทฯ</li>
<li>หากลูกค้าต้องการเรียกคืนของมีค่าจากกระเป๋าในระหว่างเก็บรักษา ลูกค้าควรเรียกคืนของมีค่าทั้งหมดและปิดคำสั่งซื้อ บริษัทฯ ไม่ยอมรับการเรียกคืนบางส่วน</li>
<li>บริษัทฯ จะไม่เปิดกระเป๋าหรือเอาสิ่งของใดๆ ออกจากกระเป๋า ภายใต้เงื่อนไขใดๆ หรือตามคำขอของลูกค้า ยกเว้นในกรณีที่ร่วมมือกับหน่วยงานราชการหรือหน่วยงานรัฐภายใต้การสอบสวนตามกฎหมาย</li>
<li>บริษัทฯ จะไม่รับผิดชอบใดๆ สำหรับสิ่งของที่เปราะบาง ที่เสื่อมสภาพได้ หรือที่ถูกห้ามในการเก็บไว้ในพื้นที่รับฝากของเรา</li>
<li>สำหรับการเก็บรักษาที่สาขาของบริษัทฯ จะนับหนึ่งวันเป็น 24 ชั่วโมงนับตั้งแต่ลูกค้าเก็บกระเป๋าที่สาขาของบริษัทฯ</li>
</ul>
<h3>เงื่อนไขการเรียกคืนกระเป๋า</h3>
<ul>
<li>ลูกค้าควรให้หลักฐานที่ถูกต้อง รวมถึงหนังสือเดินทาง/บัตรประจำตัวประชาชนไทย/ใบขับขี่ไทย และใบเรียกคืน/อีเมลกับพนักงานของบริษัทฯ เพื่อยืนยันตัวตนของผู้รับที่เคาน์เตอร์ของบริษัทฯ</li>
<li>หากลูกค้าไม่มีหรือไม่ถูกต้องอ้างอิงการสั่งซื้อ บริษัทฯ มีสิทธิ์ปฏิเสธคำขอการเรียกคืน</li>
<li>หากไม่มีคำขอสำหรับการจัดส่ง ลูกค้าสามารถเรียกคืนกระเป๋าหรือของมีค่าได้เฉพาะที่สาขาเดียวกันที่ลูกค้าใช้บริการเก็บของ</li>
<li>บริษัทฯ ไม่ยอมรับคำขอการเรียกคืนบางส่วน หรือเรียกของส่วนตัวจากกระเป๋าในระหว่างการให้บริการเก็บของ</li>
<li>ลูกค้าสามารถเรียกคืนกระเป๋าหรือของมีค่าได้เฉพาะในช่วงเวลาให้บริการตามข้อบังคับของแต่ละสาขาของบริษัทฯ</li>
<li>ลูกค้าสามารถเรียกคืนกระเป๋าหรือของมีค่าได้เฉพาะที่เคาน์เตอร์ของบริษัทฯ ที่แต่ละจุดหมายปลายทาง</li>
<li>ในกรณีที่ของมีค่าที่เก็บไว้จะถูกเรียกคืนโดยบุคคลอื่นหรือบุคคลที่สามอื่นๆ ข้อมูลบัตรประจำตัวประชาชนไทยหรือหนังสือเดินทางที่ถูกต้องควรถูกให้โดยลูกค้าที่เก็บกระเป๋าผ่านทางอีเมล จะมีการขอบัตรประจำตัวประชาชนไทยหรือหนังสือเดินทางที่ถูกต้องเมื่อผู้รับเรียกคืนของมีค่า การถ่ายสำเนาหรือรูปถ่ายของบัตรประจำตัวหรือหนังสือเดินทางของบุคคลนั้นไม่ได้รับการยอมรับ</li>
</ul>
<h3>เงื่อนไขการเรียกคืนกระเป๋าที่ล่าช้าที่เคาน์เตอร์ของบริษัทฯ</h3>
<ul>
<li>เริ่มตั้งแต่เวลาปิดทำการที่ประกาศของแต่ละสาขาของบริษัทฯ จะมีการเรียกเก็บ 500 บาท/30 นาที หากลูกค้าต้องการเรียกคืนกระเป๋าหลังเวลาให้บริการที่สาขาใดๆ ของบริษัทฯ หากเวลาที่เกินมาน้อยกว่า 30 นาที ค่าบริการจะถูกคิดเป็น 30 นาที</li>
<li>บริษัทฯ จะรอลูกค้าเพียง 1 ชั่วโมง นับตั้งแต่เวลาให้บริการของสาขาของบริษัทฯ สิ้นสุด</li>
<li>บริษัทฯ จะรอลูกค้าเฉพาะตามคำขอ ของลูกค้าผ่านทางช่องทางการติดต่อของบริษัทเท่านั้น</li>
<li>หากลูกค้าขอเรียกคืนกระเป๋าหลังเวลาให้บริการ แต่ไม่มาตามเวลาที่แจ้ง จะมีการเพิ่ม 500 บาท/30 นาที ในคำสั่งซื้อเมื่อมารับกระเป๋า</li>
<li>บริษัทฯ มีสิทธิ์ปฏิเสธคำขอ ภายใต้สถานการณ์ใดๆ</li>
</ul>
<h2>รายการราคาและค่าโปรโมชั่น</h2>
<h3>ค่าบริการฝากของ</h3>
<ul>
<li>สำหรับการฝากของที่บริษัทฯ หนึ่งวันถูกนับเป็น 24 ชั่วโมงนับตั้งแต่ลูกค้าฝากกระเป๋าที่สาขา</li>
<li>ส่วนหนึ่งของหนึ่งวัน (24 ชั่วโมง) ถือว่าเป็นหนึ่งวัน</li>
<li>กระเป๋าขนาดปกติ, ถุงกอล์ฟ/24 ชม. = 100 บาท/ชิ้น (สาขาสนามบินสุวรรณภูมิ, สนามบินดอนเมือง และสาขา MBK Mall)</li>
<li>กระเป๋าขนาดปกติ, ถุงกอล์ฟ/24 ชม. = 150 บาท/ชิ้น (สาขาอื่นๆ)</li>
<li>กระเป๋าขนาดพิเศษ/24 ชม. = 200 บาท/ชิ้น</li>
</ul>
<h3>ค่าบริการจัดส่ง</h3>
<h4>จัดส่งภายในกรุงเทพฯ ในวันเดียวกัน</h4>
<ul>
<li>การจัดส่งตามกำหนดเวลา: 299 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ/เที่ยว</li>
<li>การจัดส่งถุงกอล์ฟ: 399 บาท/ชิ้น/เที่ยว</li>
<li>การจัดส่งแบบ Fast delivery: คิด 300 บาท/คำสั่งซื้อ (ไม่จำกัดจำนวนชิ้น)</li>
<li>กระเป๋าพิเศษ: 599 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ/เที่ยว</li>
</ul>
<h4>จัดส่งภายในเชียงใหม่ ในวันเดียวกัน</h4>
<ul>
<li>การจัดส่งตามกำหนดเวลา: 349 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ/เที่ยว</li>
<li>การจัดส่งถุงกอล์ฟ: 399 บาท/ชิ้น/เที่ยว</li>
<li>การจัดส่งแบบ Fast delivery: คิด 300 บาท/คำสั่งซื้อ (ไม่จำกัดจำนวนชิ้น)</li>
<li>กระเป๋าพิเศษ: 599 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ/เที่ยว</li>
</ul>
<h4>จัดส่งภายในภูเก็ต ในวันเดียวกัน</h4>
<ul>
<li>การจัดส่งตามกำหนดเวลา: 349 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ/เที่ยว</li>
<li>การจัดส่งถุงกอล์ฟ: 399 บาท/ชิ้น/เที่ยว</li>
<li>การจัดส่งแบบ Fast delivery: คิด 300 บาท/คำสั่งซื้อ (ไม่จำกัดจำนวนชิ้น)</li>
<li>กระเป๋าพิเศษ: 599 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ/เที่ยว</li>
</ul>
<h4>บริการจัดส่งพัทยา-กรุงเทพฯ</h4>
<ul>
<li>การจัดส่งตามกำหนดเวลา: 499 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ/เที่ยว</li>
<li>การจัดส่งถุงกอล์ฟ: 499 บาท/ชิ้น/เที่ยว</li>
<li>การจัดส่งแบบ Fast delivery: คิด 500 บาท/คำสั่งซื้อ (ไม่จำกัดจำนวนชิ้น)</li>
<li>กระเป๋าพิเศษ: 699 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ/เที่ยว</li>
</ul>
<h4>บริการจัดส่งระหว่างกรุงเทพฯ กับจังหวัดเชียงใหม่และจังหวัดภูเก็ต ในวันเดียวกัน (ราคาขนาดปกติ)</h4>
<ul>
<li>0-14.99 ก.ก. — 599 บาท/ชิ้น</li>
<li>15-19.99 ก.ก. — 699 บาท/ชิ้น</li>
<li>20-24.99 ก.ก. — 799 บาท/ชิ้น</li>
<li>25-30.00 ก.ก. — 899 บาท/ชิ้น</li>
</ul>
<h4>ราคาถุงกอล์ฟ กรุงเทพฯ-เชียงใหม่</h4>
<table>
<thead>
<tr><th>ต้นทาง</th><th>ปลายทาง</th><th>ราคา (บาท)</th></tr>
</thead>
<tbody>
<tr><td>สนามบินในกรุงเทพฯ</td><td>สนามบินเชียงใหม่</td><td>599</td></tr>
<tr><td>สนามบินในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>799</td></tr>
<tr><td>สนามบินเชียงใหม่</td><td>สนามบินในกรุงเทพฯ</td><td>599</td></tr>
<tr><td>สนามบินเชียงใหม่</td><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>699</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>สนามบินเชียงใหม่</td><td>699</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>899</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>สนามบินในกรุงเทพฯ</td><td>799</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>899</td></tr>
</tbody>
</table>
<h4>ราคาถุงกอล์ฟ กรุงเทพฯ-ภูเก็ต</h4>
<table>
<thead>
<tr><th>ต้นทาง</th><th>ปลายทาง</th><th>ราคา (บาท)</th></tr>
</thead>
<tbody>
<tr><td>สนามบินในกรุงเทพฯ</td><td>สนามบินในภูเก็ต</td><td>599</td></tr>
<tr><td>สนามบินในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>799</td></tr>
<tr><td>สนามบินในภูเก็ต</td><td>สนามบินในกรุงเทพฯ</td><td>599</td></tr>
<tr><td>สนามบินในภูเก็ต</td><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>699</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>สนามบินในภูเก็ต</td><td>699</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>899</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>สนามบินในกรุงเทพฯ</td><td>799</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>899</td></tr>
</tbody>
</table>
<h4>บริการจัดส่งถุงกอล์ฟ ระหว่างกรุงเทพฯ กับเชียงราย, ขอนแก่น, กระบี่, หาดใหญ่ และสมุย ในวันเดียวกัน</h4>
<table>
<thead>
<tr><th>ต้นทาง</th><th>ปลายทาง</th><th>ราคา (บาท)</th></tr>
</thead>
<tbody>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงราย</td><td>1,299</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในขอนแก่น</td><td>1,299</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในกระบี่</td><td>1,299</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในหาดใหญ่</td><td>1,299</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในกรุงเทพฯ</td><td>บ้าน/โรงแรม/สนามกอล์ฟในสมุย</td><td>1,299</td></tr>
</tbody>
</table>
<h4>บริการจัดส่งระหว่างจังหวัดเชียงใหม่และจังหวัดภูเก็ต ในวันถัดไป</h4>
<table>
<thead>
<tr><th>ต้นทาง</th><th>ปลายทาง</th><th>ราคา (บาท)</th></tr>
</thead>
<tbody>
<tr><td>สนามบินเชียงใหม่</td><td>สนามบินในภูเก็ต</td><td>599</td></tr>
<tr><td>สนามบินในภูเก็ต</td><td>สนามบินเชียงใหม่</td><td>599</td></tr>
<tr><td>สนามบินเชียงใหม่</td><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>799</td></tr>
<tr><td>สนามบินในภูเก็ต</td><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>799</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>999</td></tr>
<tr><td>บ้าน/โรงแรม/สนามกอล์ฟในภูเก็ต</td><td>บ้าน/โรงแรม/สนามกอล์ฟในเชียงใหม่</td><td>999</td></tr>
</tbody>
</table>
<h4>บริการจัดส่งทั่วประเทศไทย 3-5 วันทำการ (ราคาขนาดปกติ)</h4>
<ul>
<li>0-14.99 ก.ก. — 349 บาท/ชิ้น</li>
<li>15-19.99 ก.ก. — 399 บาท/ชิ้น</li>
<li>20-25.00 ก.ก. — 499 บาท/ชิ้น</li>
<li>เกิน 25 ก.ก.: 100 บาท/ก.ก. (สูงสุด 30 ก.ก.)</li>
</ul>
<h3>แพ็กเกจเก็บของระยะยาว</h3>
<ul>
<li>ฝาก 5-7 วัน: 750 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ, ถุงกอล์ฟ</li>
<li>ฝาก 5-7 วัน: 1,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ</li>
<li>ฝาก 26-30 วัน: 3,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ, ถุงกอล์ฟ</li>
<li>ฝาก 26-30 วัน: 4,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ</li>
</ul>
<h4>แพ็กเกจเก็บของระยะยาวที่สาขาสนามบินดอนเมือง, สนามบินสุวรรณภูมิ, และ MBK Center</h4>
<ul>
<li>นำฝาก 5-7 วัน: 500 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ, ถุงกอล์ฟ</li>
<li>นำฝาก 5-7 วัน: 1,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ</li>
<li>นำฝาก 26-30 วัน: 2,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดปกติ, ถุงกอล์ฟ</li>
<li>นำฝาก 26-30 วัน: 4,000 บาท/หนึ่งชิ้นของกระเป๋าขนาดพิเศษ</li>
<li>MBK Center: ฝากฟรี 2 ชั่วโมงแรก</li>
</ul>
<blockquote>บริการเก็บของฟรีทั้งหมดสามารถใช้ได้เพียงครั้งเดียวกับกระเป๋าเดียวกันหรือหนังสือเดินทางระหว่างเวลาให้บริการของสาขาในวันเดียวกัน</blockquote>
<h2>ToS แบบย่อ</h2>
<h3>การฝาก — รายละเอียดอื่นๆ</h3>
<ul>
<li>วัน = 24 ชั่วโมง</li>
<li>สัปดาห์ = 5-7 วัน</li>
<li>เดือน = 26-30 วัน</li>
<li>กระเป๋าเดินทาง = กระเป๋าเดินทางปกติ หมายถึงกระเป๋าทุกขนาด ไม่ว่าจะเป็นกระเป๋าเดินทาง กระเป๋าถือ กระเป๋าเป้ กระเป๋าสะพาย กระเป๋าผ้า หรือกระเป๋าช้อปปิ้ง รวมถึงสิ่งของที่มีลักษณะเป็นกระเป๋าและมีน้ำหนักไม่เกิน 25 กก. ขนาดของกระเป๋ารวมแล้วต้องไม่เกิน 200 ซม.</li>
<li>สิ่งของพิเศษ = อุปกรณ์กีฬาต่างๆ (ยกเว้นถุงกอล์ฟ) เครื่องดนตรี จักรยาน (ทั้งแบบพับและไม่พับ) รถเข็นเด็ก ทั้งแบบเปลือยหรือใส่กล่อง รวมถึงสิ่งของที่ไม่ใช่กระเป๋าเดินทาง</li>
</ul>
<h4>เงื่อนไขการยกเลิกและคืนเงิน (การฝาก)</h4>
<ol>
<li>หากต้องการแก้ไข/ยกเลิกคำสั่งซื้อต้องแจ้งผ่านช่องทางของเราล่วงหน้า 3 ชั่วโมงเพื่อรับเงินคืนเต็มจำนวน</li>
<li>หากยกเลิกการจองหรือคำสั่งซื้อหลังจากเวลาที่กำหนด จะไม่สามารถคืนเงินได้</li>
<li>การคืนเงินจะดำเนินการภายใน 7-14 วันทำการ</li>
<li>การจอง/คำสั่งซื้อจะถือเป็น "ไม่มาใช้บริการ" นับตั้งแต่เวลาที่เริ่มให้บริการที่นัดหมายไว้แล้วไม่มีการใช้งาน</li>
<li>เงื่อนไขเป็นไปตามที่บริษัทกำหนด</li>
</ol>
<h3>การส่ง — รายละเอียดอื่นๆ</h3>
<ul>
<li>กระเป๋าเดินทาง = กระเป๋าเดินทางปกติ หมายถึงกระเป๋าทุกขนาด ไม่ว่าจะเป็นกระเป๋าเดินทาง กระเป๋าถือ กระเป๋าเป้ กระเป๋าสะพาย กระเป๋าผ้า หรือกระเป๋าช้อปปิ้ง รวมถึงสิ่งของที่มีลักษณะเป็นกระเป๋าและมีน้ำหนักไม่เกิน 25 กก. ขนาดของกระเป๋ารวมแล้วต้องไม่เกิน 200 ซม.</li>
<li>สิ่งของพิเศษ = อุปกรณ์กีฬาต่างๆ (ยกเว้นถุงกอล์ฟ) เครื่องดนตรี จักรยาน (ทั้งแบบพับและไม่พับ) รถเข็นเด็ก ทั้งแบบเปลือยหรือใส่กล่อง รวมถึงสิ่งของที่ไม่ใช่กระเป๋าเดินทาง</li>
<li>บางประเภทการขนส่ง อาจจำเป็นต้องเปิดเพื่อทำการตรวจสอบสิ่งของต้องห้าม</li>
</ul>
<h4>เงื่อนไขการยกเลิกและคืนเงิน (การส่ง)</h4>
<ol>
<li>ต้องทำการจองล่วงหน้า 3 ชั่วโมงก่อนเวลาตัดรอบ</li>
<li>หากต้องการแก้ไข/ยกเลิกคำสั่งซื้อต้องแจ้งผ่านช่องทางของเราล่วงหน้า 3 ชั่วโมงเพื่อรับเงินคืนเต็มจำนวน</li>
<li>หากยกเลิกการจองหรือคำสั่งซื้อหลังจากเวลาที่กำหนด จะไม่สามารถคืนเงินได้</li>
<li>การคืนเงินจะดำเนินการภายใน 7-14 วันทำการ</li>
<li>การจอง/คำสั่งซื้อจะถือเป็น "ไม่มาใช้บริการ" นับตั้งแต่เวลาที่เริ่มให้บริการที่นัดหมายไว้แล้วไม่มีการใช้งาน</li>
<li>เงื่อนไขเป็นไปตามที่บริษัทกำหนด</li>
</ol>', cover_image = '/docs/terms-and-conditions-2025/fig-1.jpg' where slug = 'terms-and-conditions-2025';

