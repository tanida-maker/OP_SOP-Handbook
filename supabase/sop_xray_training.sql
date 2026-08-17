-- ============================================================
-- AIRPORTELs SOP Hub — X-Ray Operator Training Course (NEW)
--   Aviation-security training: threats, ICAO/IATA/CAAT, dangerous
--   goods (9 classes), Thai aviation law, airport areas, prohibited
--   items, X-ray operation & radiation safety, image colours, keyboard
--   functions, IED/IID, HOLD vocabulary, registration form.
--   Structured text + embedded figures + scrollable tables, coloured
--   headings, section dividers, mobile & desktop responsive.
-- Images already deployed under /public/sop/xray-operator-training/*.
-- Idempotent (upsert on slug). Run in the Supabase SQL Editor.
-- ============================================================
begin;
insert into sop.documents (slug, title, summary, category_id, content_html, tags, status, is_onboarding)
values (
  'xray-operator-training',
  '☢️ X-Ray Operator Training Course (หลักสูตรอบรมพนักงานเครื่องเอกซเรย์)',
  'หลักสูตรอบรมพนักงานผู้ปฏิบัติงานเครื่องเอกซเรย์ (X-Ray Screening) — ภัยคุกคามต่อการบินพลเรือน, องค์กร ICAO/IATA/CAAT, วัตถุอันตราย 9 ประเภท, กฎหมายการเดินอากาศ, พื้นที่สนามบิน, วัตถุต้องห้าม, การใช้งานเครื่อง X-Ray และความปลอดภัยจากรังสี, การอ่านสี, ปุ่มฟังก์ชัน, IED/IID และคำศัพท์หมวดยึด (HOLD)',
  (select id from sop.categories where slug = 'counter-service'),
  '<style>
.prose h3.xr{color:#12326e;border-left:5px solid #f59e0b;padding-left:11px;margin-top:6px;line-height:1.35}
:root:not([data-theme="light"]) .prose h3.xr{color:#bcd2ff}
@media (prefers-color-scheme:dark){:root:not([data-theme="light"]) .prose h3.xr{color:#bcd2ff}}
:root[data-theme="dark"] .prose h3.xr{color:#bcd2ff}
.prose h4.xr{color:#c4881f}
.prose table.sop-tbl th{white-space:nowrap;text-align:center;font-size:13.5px;background:var(--surface-2)}
.prose table.sop-tbl td{min-width:150px;max-width:420px;vertical-align:top;font-size:13.5px;line-height:1.6}
.prose table.sop-tbl td:first-child,.prose table.sop-tbl th:first-child{min-width:120px;font-weight:700;position:sticky;left:0;background:var(--surface-2);z-index:1}
.prose .sop-tblwrap{overflow-x:auto;-webkit-overflow-scrolling:touch;margin:10px 0;border:1px solid var(--border,#e5e7eb);border-radius:8px}
.prose .sop-tblwrap table.sop-tbl{margin:0;border:0;min-width:520px}
.prose hr.sop-hr{border:0;border-top:2px solid var(--border,#e5e7eb);margin:26px 0;opacity:.85}
.prose li{margin:5px 0;line-height:1.7}
.prose figure{margin:14px 0;text-align:center}
.sop-en{color:var(--text-muted,#6b7280)}
.sop-note{background:var(--surface-2);border-left:3px solid #f59e0b;border-radius:6px;padding:10px 14px;margin:10px 0;font-size:14px;line-height:1.65}
.xr-badge{display:inline-block;background:#12326e;color:#fff;font-size:12px;font-weight:700;border-radius:6px;padding:3px 10px;margin-bottom:6px}
@media (max-width:480px){
.prose .sop-tblwrap table.sop-tbl{min-width:440px}
.prose table.sop-tbl th,.prose table.sop-tbl td{font-size:12.5px;min-width:110px}
}
</style>

<blockquote><p><strong>หลักสูตรอบรม / Training Course:</strong> ☢️ X-Ray Operator Training Course<br><strong>หน่วยงาน / Department:</strong> Operations &nbsp;·&nbsp; <strong>สำหรับ:</strong> พนักงานผู้ปฏิบัติงานเครื่องเอกซเรย์ (X-Ray Screening)</p></blockquote>
<figure><img src="/sop/xray-operator-training/threat.jpg" alt="ภัยคุกคามต่อการบินพลเรือน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>

<hr class="sop-hr">
<h3 class="xr">🛡️ ภัยคุกคามต่อการบินพลเรือนคืออะไร?</h3>
<p><strong>คำจำกัดความ "ภัยคุกคาม" (Threat):</strong> <em>"The probability or likelihood of an attack"</em> — สิ่งที่อาจจะมีความเป็นไปได้ที่จะใช้ในการจู่โจมหรือโจมตี การโจมตีอาจกระทำโดยบุคคลหรือกลุ่มคน มีเหตุผลและเป้าหมายที่หลากหลาย</p>
<h4 class="xr">การกระทำอันเป็นการแทรกแซงโดยมิชอบด้วยกฎหมาย (Unlawful Interference)</h4>
<ul>
<li>การยึดอากาศยานโดยมิชอบด้วยกฎหมาย</li>
<li>การทำลายอากาศยานในระหว่างบริการ</li>
<li>การจับบุคคลเป็นตัวประกันในอากาศยานหรือในสนามบิน</li>
<li>การบุกรุกโดยใช้กำลังเข้าไปในอากาศยานหรือสนามบิน หรือที่ตั้งสิ่งอำนวยความสะดวกในการเดินอากาศ</li>
<li>การนำอาวุธ กลอุปกรณ์ วัตถุ หรือสิ่งของที่อาจเป็นอันตรายขึ้นไปในอากาศยานหรือเข้าไปในสนามบิน โดยมีเจตนากระทำการที่เป็นอันตรายต่อความปลอดภัยของการบินพลเรือน</li>
<li>การใช้อากาศยานในระหว่างบริการอันอาจเป็นเหตุให้ถึงแก่ความตาย บาดเจ็บสาหัส หรือความเสียหายร้ายแรงต่อทรัพย์สินหรือสิ่งแวดล้อม</li>
<li>การแจ้งข้อมูลอันเป็นเท็จซึ่งเป็นอันตรายต่อความปลอดภัยของอากาศยาน ผู้โดยสาร ลูกเรือ เจ้าหน้าที่ภาคพื้น หรือสาธารณชน</li>
<li>การกระทำในลักษณะอื่นตามที่กำหนดในข้อบังคับของคณะกรรมการการบินพลเรือน</li>
</ul>
<h4 class="xr">ภัยคุกคามการบินในปัจจุบันและอนาคต</h4>
<ul>
<li>ผู้ก่อการร้าย (มีแรงจูงใจทางการเมืองและศาสนา)</li>
<li>อาชญากร (ถูกจ้างมา)</li>
<li>ผู้ป่วยทางจิต</li>
<li>กลุ่มผู้ประท้วง (กลุ่มสิทธิสัตว์ หรือทรัพยากรธรรมชาติ)</li>
<li>ผู้อพยพลี้ภัยทางการเมือง เศรษฐกิจ</li>
<li>ภัยคุกคามจากภายใน / ผู้ที่มีความแค้นส่วนตัวต่อการบิน</li>
<li>ผู้ก่อการร้ายโดยการฆ่าตัวตาย</li>
<li>ผู้ก่อการร้ายที่ก่อเหตุเพียงลำพังคนเดียว (Lone Attacker / Lone Wolf) ได้รับแรงจูงใจจากลัทธิหัวรุนแรงทางศาสนา</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">🌐 องค์กรระหว่างประเทศ — ICAO</h3>
<p class="sop-en">International Civil Aviation Organization — องค์การการบินพลเรือนระหว่างประเทศ</p>
<figure><img src="/sop/xray-operator-training/logo-icao.jpg" alt="ICAO logo" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<p>กำหนดให้ประเทศสมาชิกต้องจัดตั้งคณะกรรมการการบินพลเรือน และข้อกำหนดด้านการรักษาความปลอดภัยสำหรับการบินพลเรือน มาตรฐานและข้อแนะนำในการปฏิบัติ (Standards and Recommended Practices) ถูกระบุอยู่ใน <strong>"Annex 17"</strong> จากการประชุมที่ชิคาโก</p>
<ul>
<li><strong>ANNEX 17:</strong> Security (การรักษาความปลอดภัย)</li>
<li><strong>Document 8973:</strong> คู่มือรักษาความปลอดภัยการบิน</li>
<li><strong>ANNEX 18:</strong> Dangerous Goods by Air (การขนส่งสินค้าอันตรายทางอากาศ)</li>
<li><strong>ANNEX 19:</strong> Safety Management (การจัดการความปลอดภัย)</li>
<li><strong>LAGs:</strong> การจำกัดปริมาณของเหลว (Liquids, Aerosols &amp; Gels)</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">🌐 องค์กรระหว่างประเทศ — IATA</h3>
<p class="sop-en">International Air Transport Association — สมาคมขนส่งทางอากาศระหว่างประเทศ</p>
<figure><img src="/sop/xray-operator-training/logo-iata.jpg" alt="IATA logo" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<p>IATA ได้แบ่ง <strong>วัตถุอันตรายออกเป็น 9 ประเภท</strong> สินค้าที่จัดอยู่ในประเภทเหล่านี้จะไม่สามารถทำการขนส่งทางอากาศได้ เว้นแต่มีการเตรียมการ ยอมรับ จัดการ และโหลด ที่สอดคล้องกับข้อกำหนด โดยเจ้าหน้าที่ซึ่งได้รับการอบรมและมีคุณสมบัติ</p>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ประเภท / Class</th><th>วัตถุอันตราย / Dangerous Goods</th></tr></thead><tbody><tr><td>1</td><td>วัตถุระเบิด (Explosives)</td></tr><tr><td>2</td><td>ก๊าซ (Gases)</td></tr><tr><td>3</td><td>ของเหลวติดไฟ (Flammable liquids)</td></tr><tr><td>4</td><td>ของแข็งติดไฟ (Flammable solids)</td></tr><tr><td>5</td><td>สารออกซิไดเซอร์ (Oxidisers &amp; organic peroxides)</td></tr><tr><td>6</td><td>สารพิษและวัตถุติดเชื้อ (Poisons; Health Hazards)</td></tr><tr><td>7</td><td>สารกัมมันตรังสี (Radioactive materials)</td></tr><tr><td>8</td><td>สารกัดกร่อน (Corrosives)</td></tr><tr><td>9</td><td>อื่นๆ (Miscellaneous)</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3 class="xr">🇹🇭 CAAT — สำนักงานการบินพลเรือนแห่งประเทศไทย (กพท.)</h3>
<p class="sop-en">The Civil Aviation Authority of Thailand</p>
<figure><img src="/sop/xray-operator-training/caat-logo.jpg" alt="CAAT logo" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<h4 class="xr">บทบาท หน้าที่ และความรับผิดชอบ</h4>
<ul>
<li>จัดทำและพัฒนาแผนรักษาความปลอดภัยการบินพลเรือนแห่งชาติ (NCASP)</li>
<li>จัดทำและพัฒนาแผนฝึกอบรมการรักษาความปลอดภัยการบินพลเรือนแห่งชาติ (NCASTP)</li>
<li>ให้คำแนะนำแก่รัฐบาล รัฐมนตรี และผู้มีอำนาจหน้าที่ที่เกี่ยวข้อง</li>
<li>ดำเนินการเพื่อให้การบินพลเรือนในประเทศไทยมีความเป็นระเบียบเรียบร้อย</li>
<li>ทำให้สนามบินในความรับผิดชอบให้บริการแก่สาธารณชนได้อย่างปลอดภัย</li>
<li>สืบสวนและทบทวนเหตุการณ์ที่เกี่ยวข้องกับการรักษาความปลอดภัยภายใต้ข้อกำหนดของกฎหมาย</li>
<li>ให้การรับรองพนักงานตรวจค้นและครูผู้สอนด้านการรักษาความปลอดภัยการบิน</li>
<li>ประสานงานระหว่างองค์กรในท้องถิ่นและองค์กรระหว่างประเทศ</li>
</ul>
<figure><img src="/sop/xray-operator-training/caat-map.jpg" alt="โครงสร้าง/พื้นที่รับผิดชอบ CAAT" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<h4 class="xr">พ.ร.บ. การเดินอากาศ (ฉบับที่ 14) พ.ศ. 2497</h4>
<ul>
<li><strong>มาตรา 60/17:</strong> ผู้ได้รับใบรับรองการดำเนินงานสนามบินสาธารณะมีอำนาจหน้าที่ (1) ตรวจค้นผู้โดยสาร ผู้ประจำหน้าที่ หรือผู้ปฏิบัติงานที่จะขึ้นอากาศยาน รวมถึงสิ่งของที่จะนำขึ้น (2) ตรวจค้นสัมภาระหรือสิ่งของที่จะบรรทุกไปกับอากาศยาน (3) ตรวจค้นบุคคล ยานพาหนะ และสิ่งของที่จะเข้าไปในเขตหวงห้ามของสนามบิน</li>
<li><strong>มาตรา 25:</strong> ห้ามมิให้ผู้ใดส่งหรือพายุทธภัณฑ์ไปกับอากาศยาน เว้นแต่ได้รับอนุญาตเป็นหนังสือจากรัฐมนตรีและปฏิบัติตามเงื่อนไข</li>
<li><strong>มาตรา 15/31:</strong> ห้ามมิให้ผู้ใดส่งหรือพาวัตถุอันตรายหรือสิ่งของต้องห้าม หรือต้องดูแลเป็นพิเศษไปกับอากาศยาน เว้นแต่จะให้หรือสำแดงข้อมูลต่อผู้ขนส่งตามข้อกำหนด</li>
<li><strong>มาตรา 67/19:</strong> ผู้ฝ่าฝืน (เช่น ส่ง/พาวัตถุอันตรายโดยมิได้สำแดง) ต้องระวางโทษจำคุกไม่เกิน 2 ปี ปรับไม่เกิน 80,000 บาท หรือทั้งจำทั้งปรับ</li>
<li><strong>มาตรา 78:</strong> ผู้ขัดขวางหรือหลีกเลี่ยงการตรวจค้นตามมาตรา 60/17–60/19 ต้องระวางโทษจำคุกไม่เกิน 1 ปี ปรับไม่เกิน 40,000 บาท หรือทั้งจำทั้งปรับ</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">⚖️ พ.ร.บ. ว่าด้วยความผิดบางประการต่อการเดินอากาศ พ.ศ. 2558</h3>
<ul>
<li><strong>มาตรา 19:</strong> ใช้อาวุธหรือวัสดุอื่นใดกระทำการที่เป็นอันตรายต่อความปลอดภัยของท่าอากาศยาน (ทำร้ายร่างกายจนสาหัส/ถึงตาย, ทำลายท่าอากาศยาน/สิ่งอำนวยความสะดวก/อากาศยานที่จอด, ทำให้บริการหยุดชะงัก) → โทษประหารชีวิต จำคุกตลอดชีวิต หรือจำคุก 15–20 ปี และปรับ 600,000–800,000 บาท</li>
<li><strong>มาตรา 20:</strong> ใช้อาวุธหรือวัสดุอื่นใดฆ่าผู้อื่นในท่าอากาศยาน (เป็นอันตรายต่อความปลอดภัยของท่าอากาศยาน) → โทษประหารชีวิต</li>
<li><strong>มาตรา 21:</strong> ทำลาย/ทำให้เสียหายแก่เครื่องอำนวยความสะดวกในการเดินอากาศ จนน่าจะเป็นอันตรายต่ออากาศยานระหว่างการบิน → โทษประหารชีวิต จำคุกตลอดชีวิต หรือ 15–20 ปี และปรับ 600,000–800,000 บาท</li>
<li><strong>มาตรา 22:</strong> แจ้งข้อความ/ส่งข่าวสารเท็จจนทำให้ผู้ที่อยู่ในท่าอากาศยานหรืออากาศยานตื่นตกใจ → จำคุกไม่เกิน 5 ปี หรือปรับไม่เกิน 200,000 บาท (หากเป็นเหตุให้เกิดอันตรายจริง → จำคุก 5–15 ปี หรือปรับ 200,000–600,000 บาท)</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">🗺️ พื้นที่ของสนามบิน (Airport Areas)</h3>
<p>ผู้ดำเนินการสนามบินต้องกำหนดพื้นที่โดยแบ่งออกเป็นอย่างน้อย 4 ประเภท:</p>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>พื้นที่ / Area</th><th>ความหมาย</th></tr></thead><tbody><tr><td>เขตหวงห้าม<br>Security Restricted Area (SRA)</td><td>พื้นที่สำคัญที่มีความเสี่ยงในระดับที่ต้องจัดให้มีการตรวจค้นและควบคุมการเข้าออกเพื่อการรักษาความปลอดภัย</td></tr><tr><td>พื้นที่ควบคุม<br>Controlled Area</td><td>พื้นที่สำคัญที่มีความเสี่ยงในระดับที่ต้องจัดให้มีการควบคุมการเข้าออกพื้นที่</td></tr><tr><td>เขตการบิน<br>Airside</td><td>พื้นที่ที่มีการเคลื่อนไหวของอากาศยานและยานพาหนะที่เกี่ยวข้องกับกิจกรรมการบิน รวมถึงอาคารที่ติดต่อกับพื้นที่เคลื่อนไหวที่มีการควบคุมการเข้าออก</td></tr><tr><td>พื้นที่นอกเขตการบิน<br>Landside</td><td>พื้นที่และอาคารที่ไม่ใช่เขตการบิน แต่มีความสำคัญ อ่อนไหว และอาจตกเป็นเป้าในการโจมตีได้</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3 class="xr">🚫 วัตถุต้องห้าม (Prohibited Items)</h3>
<p class="sop-note">"วัตถุใดๆ ซึ่งอาจนำมาใช้ในการกระทำอันเป็นการแทรกแซงโดยมิชอบด้วยกฎหมาย และไม่ได้สำแดงให้เห็นอย่างถูกต้องภายใต้กฎหมายและข้อบังคับที่ใช้บังคับ"</p>
<h4 class="xr">1. ห้ามนำเข้าสู่เขตหวงห้ามและนำขึ้นห้องโดยสารอากาศยาน</h4>
<ul><li>อาวุธปืน / สิ่งเทียมอาวุธปืน</li><li>อุปกรณ์หรือสารเคมีที่ทำให้เกิดสภาวะช็อก</li><li>วัตถุแหลมคม / วัตถุไม่มีคม</li><li>เครื่องมือช่าง</li><li>วัตถุระเบิด</li></ul>
<h4 class="xr">2. ห้ามจัดเก็บในห้องระวางเก็บสินค้าของอากาศยาน</h4>
<ul><li>อาวุธปืน / เครื่องกระสุนปืน / เชื้อประทุระเบิด / ที่จุดระเบิดและฟิวส์</li><li>กับระเบิด ลูกระเบิด สรรพภัณฑ์ระเบิดทางทหาร</li><li>ดอกไม้เพลิง / ระเบิดควันหรือกระสุนควัน</li><li>ระเบิดไดนาไมต์ ดินระเบิด หรือระเบิดพลาสติก / อุปกรณ์ระเบิดเทียม</li></ul>
<h4 class="xr">3. วัตถุที่ได้รับการยกเว้น (เข้าเขตหวงห้าม/ขึ้นอากาศยานได้)</h4>
<ul><li>เครื่องมือช่าง สรรพภัณฑ์ หรืออุปกรณ์ที่ใช้ในเขตหวงห้าม ตามมาตรการที่สนามบินประกาศกำหนด</li><li>อาวุธปืน เครื่องกระสุนปืน สิ่งเทียมอาวุธปืน ตามประกาศ กพท. ว่าด้วยการอนุญาตให้ผู้โดยสารพาไปกับอากาศยาน</li><li>ของเหลว เจล สเปรย์ ตามประกาศ กพท. ว่าด้วยหลักเกณฑ์การตรวจค้น LAGs</li></ul>

<hr class="sop-hr">
<h3 class="xr">☢️ การใช้งานเครื่อง X-Ray และความปลอดภัยจากรังสี</h3>
<p class="sop-en">Operating X-Ray Equipment &amp; Using its Various Features — สุขภาพและความปลอดภัยจากรังสี</p>
<div style="display:flex;gap:12px;flex-wrap:wrap;justify-content:center"><figure><img src="/sop/xray-operator-training/xray-machine.jpg" alt="เครื่อง X-Ray" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure><figure><img src="/sop/xray-operator-training/radiation.jpg" alt="สัญลักษณ์ทางรังสี" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure></div>
<ul>
<li><strong>ปุ่มหยุดฉุกเฉิน (Emergency Stop):</strong> ปิดการทำงานของเครื่องทั้งหมด (ภาพหน้าจอจะหายไปด้วย)</li>
<li><strong>ป้ายเตือน:</strong> เตือนว่ามีรังสีในบริเวณนั้น</li>
<li><strong>ไฟเตือน:</strong> แสดงว่ากำลังมีการฉายรังสีอยู่</li>
<li><strong>สัญลักษณ์ทางรังสี:</strong> อย่านำมือ/แขนเข้าไปในอุโมงค์เครื่อง</li>
<li><strong>สายพาน:</strong> ระวังการดึงเสื้อผ้า/นิ้วมือเข้าไปได้</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">🎨 ชนิดของวัตถุ ความหนาแน่น และมวลอะตอม (สีบนภาพ X-Ray)</h3>
<figure><img src="/sop/xray-operator-training/xray-colors.jpg" alt="การแทนสีบนภาพ X-Ray: อินทรีย์=ส้ม, อนินทรีย์=เขียว, โลหะ=น้ำเงิน" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<ul>
<li><strong style="color:#e8890c">สีส้ม</strong> — สารอินทรีย์ (Organic Material) เช่น อาหาร ของเหลว พลาสติก วัตถุระเบิด</li>
<li><strong style="color:#1f9e3d">สีเขียว</strong> — สารอนินทรีย์ (Inorganic Material)</li>
<li><strong style="color:#2f6fe0">สีน้ำเงิน</strong> — โลหะ (Metal Material)</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">⌨️ ปุ่มฟังก์ชันของเครื่อง X-Ray (Keyboard Function)</h3>
<figure><img src="/sop/xray-operator-training/keyboard.jpg" alt="แผงควบคุมเครื่อง X-Ray (Smiths Heimann)" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>ปุ่ม / Key</th><th>หน้าที่ / Function</th></tr></thead><tbody><tr><td>STOP</td><td>หยุดสายพาน</td></tr><tr><td>NEG (Negative)</td><td>กลับสีภาพ จากสว่างเป็นมืด / จากมืดเป็นสว่าง</td></tr><tr><td>O2 (Organic Only)</td><td>แสดงเฉพาะวัตถุที่เป็นสารอินทรีย์</td></tr><tr><td>OS (Organic Stripping)</td><td>แสดงเฉพาะวัตถุที่เป็นสารอนินทรีย์</td></tr><tr><td>BW (Black &amp; White)</td><td>เปลี่ยนจากภาพ 3 สี เป็นภาพขาว-ดำ</td></tr><tr><td>SEN (Super Enhancement)</td><td>เห็นพื้นผิวและเส้นขอบของวัตถุชัดเจนขึ้น</td></tr><tr><td>VARI</td><td>เร่งหรือลดความสว่างของภาพอย่างต่อเนื่อง</td></tr><tr><td>HIGH (High brightness)</td><td>เร่งความสว่างของภาพขึ้น 50%</td></tr><tr><td>Emergency</td><td>ใช้กรณี (1) กระแสไฟฟ้าขัดข้อง (2) มีสิ่งมีชีวิตกำลังจะเข้าไปในเครื่อง X-Ray</td></tr><tr><td>EXIT</td><td>ออกจากฟังก์ชันใดๆ กลับมาสู่ภาพล่าสุดแบบ HI-MAT</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3 class="xr">💣 กลอุปกรณ์ระเบิดแสวงเครื่อง (IED / IID)</h3>
<h4 class="xr">Improvised Explosive Device (IED)</h4>
<p>ระเบิดที่ประดิษฐ์ขึ้นเป็นครั้งๆ ไม่มีรูปแบบตายตัว โดยทั่วไปประกอบด้วย:</p>
<ul>
<li>เนื้อสารระเบิดที่มีจำนวนมาก (Main Charge, Explosive)</li>
<li>ชนวนระเบิด (Detonator)</li>
<li>กลไกเชื่อมต่อวงจร (Mechanism)</li>
<li>แบตเตอรี่ หรือแหล่งให้พลังงาน (Batteries, Power source)</li>
</ul>
<h4 class="xr">Improvised Incendiary Device (IID)</h4>
<p>กลอุปกรณ์ระเบิดเพลิง ประกอบด้วย:</p>
<ul>
<li>วัตถุไวไฟ (น้ำมันเชื้อเพลิง สารเคมี ฟอสฟอรัส หรือสารเคมีที่ติดไฟง่าย)</li>
<li>ส่วนที่ทำให้เกิดประกายไฟ (อาจประกอบด้วยแหล่งพลังงาน)</li>
</ul>

<hr class="sop-hr">
<h3 class="xr">📕 VOCABULARY — สิ่งของในหมวดยึด (HOLD)</h3>
<div class="sop-tblwrap"><table class="sop-tbl"><thead><tr><th>#</th><th>หมวด / Category</th><th>ตัวอย่าง / Examples</th></tr></thead><tbody><tr><td>1</td><td>Dangerous Goods</td><td>ไฟเย็น, พลุ</td></tr><tr><td>2</td><td>IEDs, IIDs, Grenade, Mines</td><td>กลอุปกรณ์ระเบิดแสวงเครื่อง, ลูกระเบิด</td></tr><tr><td>3</td><td>Firearms, Component, Ammunition</td><td>อาวุธปืนทุกชนิด, ลูกกระสุนปืน, ชิ้นส่วนประกอบอาวุธปืน, ปืนจำลอง</td></tr><tr><td>4</td><td>Knives, Sharp Items</td><td>มีด, กรรไกร</td></tr><tr><td>5</td><td>LAGs, Powders</td><td>ของเหลวชนิดต่างๆ (Liquids, Aerosols &amp; Gels)</td></tr><tr><td>6</td><td>Laptops, Drones &amp; complex Electrical Items</td><td>คอมพิวเตอร์พกพา (Laptop), Drone</td></tr><tr><td>7</td><td>Prohibited Items for Cabin Baggage</td><td>ดัมเบล, ดอกสว่าน, บุหรี่ไฟฟ้า, กล่องเครื่องมือ, ตะขอโลหะ</td></tr></tbody></table></div>

<hr class="sop-hr">
<h3 class="xr">📝 แบบฟอร์มลงทะเบียนเข้าอบรม (Registration Form)</h3>
<p>พนักงานที่เข้ารับการอบรมกรอกแบบฟอร์มลงทะเบียน — <em>แบบฟอร์มลงทะเบียนเข้าอบรม X-Ray Operator Course</em></p>
<figure><img src="/sop/xray-operator-training/reg-form.jpg" alt="แบบฟอร์มลงทะเบียนเข้าอบรม X-Ray Operator Course" loading="lazy" style="max-width:100%;border:1px solid var(--border,#e5e7eb);border-radius:8px;background:#fff" /></figure>',
  array['xray','security','training','dangerous-goods','screening','aviation','caat','icao','iata'],
  'published',
  false
)
on conflict (slug) do update set
  title = excluded.title,
  summary = excluded.summary,
  category_id = excluded.category_id,
  content_html = excluded.content_html,
  tags = excluded.tags,
  status = excluded.status;
commit;
