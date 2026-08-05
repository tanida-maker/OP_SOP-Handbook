-- ============================================================
-- New sub-manual: "สิ่งที่ห้ามทำใน Google Sheet สาขา"
-- Linked from the parent SOP (luggage-delivery-google-sheet).
-- Run in Supabase SQL Editor of the Scheduling project (schema sop).
-- Re-runnable. Images served from /docs/google-sheet-donts/.
-- ============================================================

insert into sop.documents
  (slug, title, summary, category_id, content_html, tags, status, is_onboarding, onboarding_order)
values (
  'google-sheet-donts',
  'สิ่งที่ห้ามทำใน Google Sheet สาขา',
  'ข้อห้ามและข้อควรระวังในการกรอกข้อมูลใน Google Sheet ของสาขา — คู่มือย่อยประกอบ SOP การบันทึกออเดอร์ผ่าน Google Sheet',
  (select id from sop.categories where slug = 'delivery'),
  '<p><em>📎 คู่มือย่อยประกอบ SOP: <a href="/sop/luggage-delivery-google-sheet">การบันทึกออเดอร์บริการขนส่งกระเป๋าผ่าน Google Sheet</a></em></p>
<blockquote>รวมข้อ <strong>ห้ามทำ</strong> เวลากรอกข้อมูลใน Google Sheet ของสาขา เพื่อป้องกันข้อมูลและรายงานผิดพลาด</blockquote>
<h2>1. วันที่ในทุกชีต — ห้ามคีย์เอง</h2>
<p>ช่องวันที่ในทุกชีต <strong>ห้ามพิมพ์เอง</strong> ต้องเลือกจาก <strong>ปฏิทิน (calendar picker)</strong> เท่านั้น เพื่อให้รูปแบบวันที่ถูกต้องตรงกันทั้งระบบ</p>
<img src="/docs/google-sheet-donts/fig-1.jpg" alt="" />
<img src="/docs/google-sheet-donts/fig-2.jpg" alt="" />
<h2>2. จำนวนกระเป๋า (#Bags) — ใส่ตัวเลขเท่านั้น</h2>
<p>ช่อง <strong>#Bags</strong> ให้ใส่ <strong>ตัวเลขล้วน</strong> เท่านั้น <strong>ห้าม</strong> มีเครื่องหมายอื่น เช่น <code>2,1</code> หรือ <code>-</code> หรือ <code>2/3</code></p>
<img src="/docs/google-sheet-donts/fig-3.jpg" alt="" />
<img src="/docs/google-sheet-donts/fig-4.jpg" alt="" />
<h2>3. Channel (ช่องทางการจอง)</h2>
<ul>
<li>ถ้าเป็น <strong>พาร์ทเนอร์</strong> จองมา ให้ใส่ <strong>ชื่อพาร์ทเนอร์</strong> นั้นๆ (เช่น KLOOK, KKday)</li>
<li>เลือก <strong>Online</strong> เฉพาะเมื่อลูกค้าจองผ่าน <strong>ระบบของบริษัท</strong> (ช่องทาง Postels)</li>
<li>ลูกค้า Walk-in ให้เลือก <strong>Walk-In</strong></li>
</ul>
<img src="/docs/google-sheet-donts/fig-5.jpg" alt="" />
<h2>4. ชื่อ Agent</h2>
<ul>
<li>ต้อง <strong>ตรงกับชื่อในตารางงาน</strong> เท่านั้น <strong>ห้ามเปลี่ยนเอง</strong> — หากต้องการเปลี่ยนต้องแจ้งหัวหน้างานเท่านั้น</li>
<li>ชื่อพนักงาน <strong>ต้องไม่ซ้ำกัน</strong></li>
</ul>
<img src="/docs/google-sheet-donts/fig-6.jpg" alt="" />
<img src="/docs/google-sheet-donts/fig-7.jpg" alt="" />
<h2>5. หน้า Dashboard</h2>
<p>หน้าแดชบอร์ด ให้ <strong>เปลี่ยนได้เฉพาะวันที่</strong> เท่านั้น เนื้อหาส่วนอื่น <strong>ห้ามเปลี่ยนแปลง</strong></p>
<img src="/docs/google-sheet-donts/fig-8.jpg" alt="" />
<hr />
<h2>สาขาที่ต้องส่ง Report ให้ห้างตอนปิดร้าน</h2>
<h3>T21</h3>
<ul><li>Kanokphorn@terminal21.co.th</li><li>khwunrutai.t@terminal21.co.th</li></ul>
<h3>CTW</h3>
<ul><li>khakanjana@centralpattana.co.th</li><li>financecenter4.consign@centralpattana.co.th</li></ul>',
  ARRAY['Google Sheet','ข้อห้าม','บันทึกออเดอร์','สาขา']::text[],
  'published', false, null
)
on conflict (slug) do update set
  title = excluded.title, summary = excluded.summary, category_id = excluded.category_id,
  content_html = excluded.content_html, tags = excluded.tags, status = excluded.status;

-- Link the parent SOP to this sub-manual (idempotent: only adds once).
update sop.documents
set content_html = '<blockquote>📌 <strong>คู่มือย่อยที่ต้องอ่านคู่กัน:</strong> <a href="/sop/google-sheet-donts">สิ่งที่ห้ามทำใน Google Sheet สาขา</a></blockquote>' || content_html
where slug = 'luggage-delivery-google-sheet'
  and content_html not like '%/sop/google-sheet-donts%';
