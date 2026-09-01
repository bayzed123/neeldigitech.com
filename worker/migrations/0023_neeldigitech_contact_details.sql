-- Neel Digi Tech white-label contact details.
-- This forward migration also updates an already-provisioned database.
INSERT OR REPLACE INTO settings (key, value, updated_at) VALUES
  ('support_email', 'neeldigitech@gmail.com', strftime('%s','now')),
  ('facebook_url', 'https://www.facebook.com/neeldigitech', strftime('%s','now')),
  ('whatsapp_number', '01511922073', strftime('%s','now')),
  ('support_whatsapp_url', 'https://wa.me/8801511922073', strftime('%s','now')),
  ('order_whatsapp', '8801511922073', strftime('%s','now'));
