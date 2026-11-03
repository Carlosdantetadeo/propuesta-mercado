import { chromium } from '@playwright/test';
import assert from 'node:assert/strict';
const browser = await chromium.launch({headless:true,executablePath:'C:/Users/User-pc/AppData/Local/ms-playwright/chromium-1234/chrome-win64/chrome.exe'});
try {
  const page = await browser.newPage();
  await page.goto('http://localhost:4321/',{waitUntil:'domcontentloaded'});
  const free=page.locator('.map-unit.disponible').first();
  const sold=page.locator('.map-unit.vendido').first();
  await free.waitFor({state:'attached',timeout:60000});
  await free.dispatchEvent('click');
  assert.equal(await page.locator('#map-detail').isVisible(),true);
  await sold.dispatchEvent('click');
  assert.equal(await page.locator('#map-detail').isVisible(),false);
  assert.equal(await page.locator('#detail-price').textContent(),'');
  await page.locator('#map-search').fill(await sold.getAttribute('data-code'));
  await page.locator('#search-go').click();
  assert.equal(await page.locator('#map-detail').isVisible(),false);
  await sold.dispatchEvent('keydown',{key:'Enter'});
  assert.equal(await page.locator('#map-detail').isVisible(),false);
  console.log('OK: available details visible; occupied click, search and keyboard reveal no details or price.');
} finally { await browser.close(); }
