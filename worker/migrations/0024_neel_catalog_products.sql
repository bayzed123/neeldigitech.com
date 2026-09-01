-- Neel Digi Tech starter catalogue completion.
-- Every storefront category has at least five active products after this migration.

-- ---------- Smartphones (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-PH-005','oneplus-nord-ce4','OnePlus Nord CE4 8/128GB','OnePlus',id,
 '120Hz AMOLED · 5500mAh · 100W charging',
 'A fast everyday phone with a 6.7-inch 120Hz AMOLED display, Snapdragon 7 Gen 3 performance, 5500mAh battery and 100W SUPERVOOC charging.',
 2780000,3290000,3590000,24,5,1,'phone,5g,amoled,fast-charge',0,4.4,76 FROM categories WHERE slug='smartphones';

-- ---------- Wearables (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-WR-005','huawei-watch-fit-3','Huawei Watch Fit 3','Huawei',id,
 'AMOLED · GPS · 10-day battery',
 'Slim square AMOLED smartwatch with built-in GPS, Bluetooth calling, sleep tracking and up to ten days of typical battery life.',
 890000,1090000,1290000,32,6,1,'watch,gps,fitness,amoled',0,4.5,184 FROM categories WHERE slug='wearables';

-- ---------- Power & Charging (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-PW-005','ugreen-100w-gan-charger','Ugreen Nexode 100W GaN Charger','Ugreen',id,
 '100W USB-C · 4 ports · PD 3.0',
 'Four-port desktop charger with 100W USB-C Power Delivery, PPS support and intelligent power sharing for laptops, tablets and phones.',
 720000,890000,1050000,44,8,1,'charger,gan,usb-c,laptop',1,4.6,132 FROM categories WHERE slug='power';

-- ---------- Computing (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-CP-005','tp-link-archer-ax23','TP-Link Archer AX23 Wi-Fi 6 Router','TP-Link',id,
 'AX1800 · OFDMA · WPA3 security',
 'Dual-band Wi-Fi 6 router with 1.8Gbps combined speed, OFDMA for busy homes and WPA3 encryption. Easy setup through the Tether app.',
 680000,850000,990000,28,5,1,'router,wifi,network,home-office',0,4.4,97 FROM categories WHERE slug='computing';

-- ---------- Smart Home (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-SH-003','tapo-p110-smart-plug','TP-Link Tapo P110 Smart Plug','TP-Link',id,
 'Energy monitoring · Remote control · 16A',
 'Wi-Fi smart plug with live energy monitoring, schedules, timers and overload protection. Works without a separate hub.',
 105000,165000,199000,150,25,2,'smart-home,plug,wifi,energy',0,4.3,241 FROM categories WHERE slug='smart-home';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-SH-004','xiaomi-mi-smart-led-bulb','Xiaomi Mi Smart LED Bulb Essential','Xiaomi',id,
 'Colour light · Wi-Fi · Voice control',
 'Dimmable smart bulb with adjustable colour temperature, millions of colours, schedules and app or voice control over Wi-Fi.',
 145000,225000,279000,110,20,2,'smart-home,lighting,wifi,bulb',0,4.2,196 FROM categories WHERE slug='smart-home';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-SH-005','google-nest-mini-2','Google Nest Mini (2nd gen)','Google',id,
 'Compact smart speaker · Google Assistant',
 'Compact smart speaker for music, timers, reminders and compatible smart-home control. Wall-mountable design with improved bass.',
 315000,425000,499000,22,5,1,'smart-home,speaker,voice,assistant',1,4.5,163 FROM categories WHERE slug='smart-home';

-- ---------- Cameras (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-CM-003','tapo-c320ws','TP-Link Tapo C320WS Outdoor Camera','TP-Link',id,
 '2K QHD · Colour night vision · IP66',
 'Weatherproof outdoor security camera with 2K QHD video, colour night vision, motion alerts and two-way audio.',
 420000,560000,649000,36,7,1,'camera,security,outdoor,wifi',0,4.4,154 FROM categories WHERE slug='cameras';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-CM-004','canon-eos-2000d-kit','Canon EOS 2000D 18-55mm Kit','Canon',id,
 '24.1MP DSLR · Wi-Fi · Beginner friendly',
 'Entry DSLR with a 24.1MP APS-C sensor, optical viewfinder, Full HD video and Wi-Fi sharing. Includes the versatile 18-55mm kit lens.',
 3950000,4490000,4990000,5,2,1,'camera,dslr,photography,wifi',1,4.6,88 FROM categories WHERE slug='cameras';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-CM-005','logitech-c920s-pro','Logitech C920S Pro Webcam','Logitech',id,
 '1080p video · Privacy shutter · Dual mics',
 'Full HD webcam with autofocus, stereo microphones and a built-in privacy shutter for meetings, classes and streaming.',
 650000,790000,890000,18,4,1,'camera,webcam,streaming,office',0,4.5,205 FROM categories WHERE slug='cameras';

-- ---------- Accessories (5 total) ----------
INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-AC-003','anker-633-magnetic-battery','Anker 633 Magnetic Battery 10K','Anker',id,
 '10,000mAh · Magnetic wireless charging · Stand',
 'Magnetic wireless power bank with a fold-out stand, USB-C output and enough capacity for day trips and long work sessions.',
 610000,790000,920000,38,7,1,'powerbank,magnetic,wireless,iphone',1,4.5,149 FROM categories WHERE slug='accessories';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-AC-004','baseus-metal-age-laptop-stand','Baseus Metal Age Laptop Stand','Baseus',id,
 'Aluminium foldable stand · Ventilated design',
 'Adjustable aluminium laptop stand that raises the screen for better posture and leaves room for a keyboard or notebook underneath.',
 270000,385000,449000,72,12,2,'stand,laptop,desk,ergonomic',0,4.4,118 FROM categories WHERE slug='accessories';

INSERT OR IGNORE INTO products (sku,slug,name,brand,category_id,summary,description,cost_price,price,compare_at_price,stock,low_stock_threshold,moq,tags,featured,rating,review_count)
SELECT 'NDT-AC-005','ugreen-usb-c-cable-100w','Ugreen USB-C to USB-C Cable 100W','Ugreen',id,
 '100W E-marker · 2m braided cable',
 'Durable two-metre braided USB-C cable with an E-marker chip for safe 100W charging and 480Mbps data transfer.',
 65000,120000,149000,310,50,5,'cable,usb-c,charging,bulk',0,4.3,633 FROM categories WHERE slug='accessories';
