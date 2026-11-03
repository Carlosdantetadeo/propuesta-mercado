import { chromium } from '@playwright/test';
const browser = await chromium.launch({headless:true, executablePath:'C:/Users/User-pc/AppData/Local/ms-playwright/chromium-1234/chrome-win64/chrome.exe'});
for (const [name,viewport] of [['desktop',{width:1440,height:1200}],['mobile',{width:390,height:844}]]) {
  const page = await browser.newPage({viewport});
  await page.goto('http://localhost:4321/recursos',{waitUntil:'networkidle'});
  await page.screenshot({path:`docs/mercado/recursos-${name}.png`,fullPage:true,timeout:120000});
  console.log(name,await page.locator('.resource-card').count(),await page.locator('h1').innerText(),await page.evaluate(()=>document.documentElement.scrollWidth+'x'+document.documentElement.scrollHeight));
}
await browser.close();
