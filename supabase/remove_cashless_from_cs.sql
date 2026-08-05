-- Remove "นโยบายการชำระเงินแบบไร้เงินสด" from the Customer Service onboarding track.
-- (The document still exists in the Payment category — just not part of onboarding.)
-- Run in Supabase SQL Editor (Scheduling project, schema sop).
update sop.documents
set onboarding_roles = '{}', is_onboarding = false, onboarding_order = null
where slug = 'cashless-payment-policy';
