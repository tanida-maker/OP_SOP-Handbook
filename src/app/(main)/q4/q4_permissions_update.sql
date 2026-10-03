-- Q4: tighten permissions
--   * Staff can edit ONLY their own entries (no one else can edit them, admins included)
--   * Staff can NOT delete — only SOP admins (central team) can delete
--   * Central team keeps writing Status / Team / Central action in sop.q4_reviews
drop policy if exists "q4 entries update" on sop.q4_entries;
create policy "q4 entries update" on sop.q4_entries
  for update using (created_by = auth.uid())
  with check (created_by = auth.uid());

drop policy if exists "q4 entries delete" on sop.q4_entries;
create policy "q4 entries delete" on sop.q4_entries
  for delete using (sop.is_admin());

-- check: should list 'q4 entries update' (created_by = auth.uid()) and 'q4 entries delete' (sop.is_admin())
select policyname, cmd, qual from pg_policies
where schemaname = 'sop' and tablename = 'q4_entries' order by policyname;
