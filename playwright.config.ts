import { defineConfig } from '@playwright/test';
import { existsSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
function installedChromium(){
  if(process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE)return process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE;
  const cache=process.env.PLAYWRIGHT_BROWSERS_PATH||join(process.env.LOCALAPPDATA||'','ms-playwright');
  try{
    const versioned=readdirSync(cache).filter(name=>/^chromium-\d+$/.test(name)).sort((a,b)=>Number(b.slice(9))-Number(a.slice(9)));
    for(const version of versioned)for(const folder of ['chrome-win64','chrome-win']){
      const binary=join(cache,version,folder,'chrome.exe');if(existsSync(binary))return binary;
    }
  }catch{}
  return undefined;
}
const executable=installedChromium();
export default defineConfig({
  testDir:'tests/e2e',
  timeout:60000,
  expect:{timeout:10000},
  workers:1,
  reporter:[['list'],['json',{outputFile:'test-results/results.json'}]],
  use:{
    baseURL:process.env.PLAYWRIGHT_BASE_URL??'http://localhost:4321',
    viewport:{width:1440,height:1000},
    launchOptions:executable?{executablePath:executable}:{},
    screenshot:'only-on-failure',
    trace:'retain-on-failure'
  }
});
