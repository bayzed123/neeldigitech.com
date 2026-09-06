/**
 * The dashboard logo upload, end to end: the panel in Settings → the media
 * upload → the setting → what the storefront actually renders.
 *
 * This repository has no other automated tests. This one exists because the
 * feature spans four layers that each look fine alone — a logo can save and
 * still never reach the header — so only a full round trip proves it.
 *
 * Not wired into CI and not a package.json dependency — the deploy workflow
 * installs production dependencies only, and a browser download does not
 * belong in it. Install the runner yourself first:
 *
 *   npm i --no-save playwright && npx playwright install chromium
 *
 * Run it against a local stack:
 *
 *   cd worker && npx wrangler d1 migrations apply neeldigitech-db --local
 *   printf 'JWT_SECRET="local-test-secret"\n' > worker/.dev.vars
 *   (cd worker && npx wrangler dev --local --port 8788 &)
 *   curl -s -X POST http://127.0.0.1:8788/api/admin/setup -H 'Content-Type: application/json' \
 *     -d '{"username":"localtest","name":"Local Test","password":"local-test-password-123"}'
 *   VITE_BASE=/ VITE_API_BASE=http://127.0.0.1:8788 npm run build --workspace web
 *   # serve web/dist with an SPA fallback on :5599, then:
 *   node tests/logo.mjs
 *
 * It resets the two logo settings before asserting, so it can be run twice in
 * a row and mean the same thing both times.
 */
import { chromium } from 'playwright';

/** A 240x60 solid magenta PNG — small, and obvious if it ends up in the wrong slot. */
const FIXTURE_PNG_BASE64 =
  'iVBORw0KGgoAAAANSUhEUgAAAPAAAAA8CAIAAADXHaAKAAAAiElEQVR42u3SAQkAAADCMPuX1h4yWILzNIUbkQBDg6HB0GBoDA2GBkODocHQGBoMDYYGQ4OhMTQYGgwNhgZDY2gwNBgaDA2GxtBgaDA0GBoMjaHB0GBoMDQYGkODocHQYGgMDYYGQ4OhwdAYGgwNhgZDg6ExNBgaDA2GBkNjaDA0GBoMDYbm3wAyIxYRjryRDwAAAABJRU5ErkJggg==';
let pass=0,fail=0;
const check=(n,c,d='')=>{ if(c){pass++;console.log(`  ok   ${n}`);} else {fail++;console.log(`  FAIL ${n}${d?`\n       ${d}`:''}`);} };

const browser = await chromium.launch({ executablePath: process.env.CHROMIUM_PATH });
const page = await browser.newPage({ viewport:{width:1440,height:1100} });
const errors=[]; page.on('pageerror',e=>errors.push(String(e)));

await page.goto('http://127.0.0.1:5599/admin', { waitUntil:'networkidle' });
await page.waitForSelector('input[type="password"]', { timeout: 15000 });
await page.locator('input').first().fill('localtest');
await page.locator('input[type="password"]').fill('local-test-password-123');
await page.getByRole('button', { name: /sign in/i }).click();
await page.waitForTimeout(2500);
check('signed in to the dashboard', !/\/admin\/?$/.test(new URL(page.url()).pathname) || await page.locator('.admin-main').count() > 0,
  `url=${page.url()}`);

// Reset to a fresh install's state so this script is repeatable — a leftover
// logo from an earlier run would make the empty-state assertions below pass or
// fail for the wrong reason.
await page.evaluate(async () => {
  const token = localStorage.getItem('ag.admin.token');
  await fetch('http://127.0.0.1:8788/api/admin/settings', {
    method: 'PATCH',
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
    body: JSON.stringify({ logo_url: '', logo_footer_url: '' }),
  });
});

await page.goto('http://127.0.0.1:5599/admin/settings', { waitUntil:'networkidle' });
await page.waitForTimeout(2000);

const logoPanel = page.locator('.panel').filter({ hasText: 'Header logo' }).first();
check('the Logo panel is on the Settings page', await logoPanel.count() === 1);
check('it offers a Header logo slot', await page.getByText('Header logo', { exact:true }).count() === 1);
check('it offers a Footer logo slot', await page.getByText('Footer logo', { exact:true }).count() === 1);
check('with nothing uploaded it says so rather than showing a broken image',
  await page.getByText('Using the built-in logo').count() === 2);

// The client's actual journey: pick a file in the Header slot.
await logoPanel.locator('input[type=file]').first()
  .setInputFiles({ name:'logo.png', mimeType:'image/png', buffer: Buffer.from(FIXTURE_PNG_BASE64, 'base64') });
await page.waitForTimeout(3000);

// Both slots now preview an image: the header shows what was uploaded, and the
// footer shows the same file because an empty footer slot reuses the header one.
check('no "built-in logo" placeholder remains once a logo is uploaded',
  await page.getByText('Using the built-in logo').count() === 0);
check('both slots preview the uploaded logo', await logoPanel.locator('img').count() === 2);
check('the footer slot explains that it is reusing the header logo',
  await page.getByText('Empty — the header logo is being used here.').count() === 1);
check('the header slot offers Replace and Remove once set',
  (await logoPanel.getByRole('button', { name: 'Replace' }).count()) === 1 &&
  (await logoPanel.getByRole('button', { name: 'Remove' }).count()) === 1);

// End to end: the storefront must actually serve it.
const shop = await browser.newPage();
await shop.goto('http://127.0.0.1:5599/', { waitUntil: 'networkidle' });
await shop.waitForTimeout(1200);
const shopSrc = await shop.locator('.brand-link img.brand-logo-img').getAttribute('src').catch(() => '');
check('the uploaded logo reaches the live storefront header', !!shopSrc && shopSrc.includes('/files/'),
  `got ${shopSrc}`);
const shopFooter = await shop.locator('.footer-logo img.brand-logo-img').getAttribute('src').catch(() => '');
check('and the storefront footer', !!shopFooter && shopFooter === shopSrc, `got ${shopFooter}`);
const loaded = await shop.locator('.brand-link img.brand-logo-img')
  .evaluate((el) => el.complete && el.naturalWidth > 0).catch(() => false);
check('the image actually loads (not a broken link)', loaded === true);
await shop.close();
check('no JS errors during the upload', errors.length===0, errors.join('\n'));

// Written next to this script so .gitignore's tests/*.png rule covers it.
await page.screenshot({ path: new URL('./admin-settings-logo.png', import.meta.url).pathname, fullPage: false });
console.log(`\npassed: ${pass}   failed: ${fail}`);
await browser.close(); process.exit(fail?1:0);
