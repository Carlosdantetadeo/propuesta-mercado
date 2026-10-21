import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { writeFile } from 'node:fs/promises';

async function ready(page:any,path='/plano/'){
  await page.goto(path);
  await expect(page.locator('#app')).toHaveAttribute('aria-busy','false');
  await expect(page.locator('#connection-label')).toContainText('Vista demo');
}
async function sector(page:any,name='Pescados y mariscos'){
  await page.locator('#sector-cards button').filter({hasText:name}).click();
  await expect(page.locator('#stall-layer .stall')).toHaveCount(10);
  if(page.viewportSize().width>760)await expect(page.locator('#stall-layer .stall-code').first()).toBeVisible();
}
async function confirm(page:any,reason='Prueba verificada'){
  await page.locator('#confirm-reason').fill(reason);
  await page.locator('#submit-confirm').click();
  await expect(page.locator('#confirm-dialog')).not.toBeVisible();
}
test('vista general sin cÃ³digos; sector, ficha, separaciÃ³n, auditorÃ­a y roles',async({page})=>{
  const errors:string[]=[];page.on('pageerror',error=>errors.push(error.message));
  await ready(page);
  await expect(page.locator('#stall-layer .stall')).toHaveCount(0);
  await sector(page);
  const first=page.locator('#stall-layer [data-puesto]').first();
  await first.click();
  await expect(page.locator('#detail-code')).toHaveText('PES-01');
  await page.locator('[data-action=separar]').click();
  await confirm(page,'Cliente interesado: demostraciÃ³n');
  await expect(page.locator('#detail-state')).toContainText('Separado');
  await page.locator('#show-audit').click();
  await expect(page.locator('#admin-tools #audit-list')).toContainText('Cliente interesado: demostraciÃ³n');
  await page.locator('#demo-role').selectOption('asesor');
  await expect(page.locator('#admin-tools')).toBeHidden();
  // Reservation belongs to demo-admin, so this advisor cannot release it.
  await expect(page.locator('#actions button')).toHaveCount(0);
  await page.locator('#close-detail').click();
  await page.locator('#stall-layer .bloqueado').click();
  await expect(page.locator('#actions button')).toHaveCount(0);
  await page.locator('#demo-role').selectOption('lector');
  await expect(page.locator('#admin-link')).toBeHidden();
  expect(errors).toEqual([]);
});
test('bloqueo masivo, desbloqueo y CSV con vista previa',async({page})=>{
  await ready(page,'/admin/puestos/');
  await page.locator('#select-sector').click();
  await expect(page.locator('#selection-count')).toHaveText('10 seleccionados');
  await page.locator('#bulk-block').click();
  await expect(page.locator('#confirm-description')).toContainText('3 puestos no compatibles');
  await expect(page.locator('#confirm-preview > div')).toHaveCount(7);
  await confirm(page,'Reserva temporal del propietario');
  await expect(page.locator('#stall-layer .bloqueado')).toHaveCount(8);
  await page.locator('#select-sector').click();
  await page.locator('#bulk-unblock').click();
  await confirm(page,'Reapertura autorizada');
  await expect(page.locator('#stall-layer .bloqueado')).toHaveCount(0);
  await page.locator('#csv-file').setInputFiles({name:'asignacion.csv',mimeType:'text/csv',buffer:Buffer.from('codigo,sector\nPES-01,Carnes')});
  await expect(page.locator('#confirm-preview')).toContainText('PES-01');
  await expect(page.locator('#confirm-preview')).toContainText('Carnes');
  await confirm(page,'ReclasificaciÃ³n comercial');
  await page.locator('#toggle-multi').click();
  await page.locator('#search').fill('PES-01');
  await expect(page.locator('#stall-list [data-puesto]')).toHaveCount(0); // Old sector scope.
  await page.locator('[data-home]').click();
  await page.locator('#search').fill('PES-01 ');
  await expect(page.locator('#stall-list [data-puesto]')).toHaveCount(1);
  await page.locator('#stall-list button').first().click();
  await expect(page.locator('#detail-sector')).toHaveText('Carnes');
});
test('filtros, estado vacÃ­o, original, navegaciÃ³n por teclado y conexiÃ³n perdida',async({page,context})=>{
  await ready(page);
  const first=page.locator('#sector-layer [data-sector]').first();
  await first.focus();await page.keyboard.press('Enter');
  await expect(page.locator('#stall-layer .stall')).toHaveCount(10);
  await page.locator('#show-original').check();
  await expect(page.locator('#original-image')).toHaveAttribute('visibility','visible');
  await page.locator('#show-original').uncheck();
  await page.locator('#search').fill('NO-EXISTE');
  await expect(page.locator('#empty-state')).toBeVisible();
  await page.locator('#search').fill('PES-01');
  await expect(page.locator('#stall-list button')).toHaveCount(1);
  await page.locator('#stall-list button').click();
  await context.setOffline(true);
  await expect(page.locator('#connection-banner')).toContainText('deshabilitadas');
  await expect(page.locator('[data-action=separar]')).toBeDisabled();
  await context.setOffline(false);
  await expect(page.locator('[data-action=separar]')).toBeEnabled();
  await page.locator('#filters-toggle').click();
  await page.locator('#price-min').fill('999999');
  await expect(page.locator('#empty-state')).toBeVisible();
});
for(const width of [360,390,430]){
  test(`mÃ³vil ${width}: ficha, gestos, safe area y accesibilidad`,async({page})=>{
    await page.setViewportSize({width,height:844});
    await ready(page);
    expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBeTruthy();
    if(width===390)await page.screenshot({path:'docs/capturas/movil-general.png',fullPage:false});
    await sector(page);
    await page.locator('#stall-layer .disponible').first().click();
    await expect(page.locator('#inspector')).toHaveAttribute('data-snap','collapsed');
    await page.locator('#sheet-handle').click();
    await expect(page.locator('#inspector')).toHaveAttribute('data-snap','middle');
    await page.locator('#sheet-handle').focus();await page.keyboard.press('Enter');
    await expect(page.locator('#inspector')).toHaveAttribute('data-snap','full');
    if(width===390)await page.screenshot({path:'docs/capturas/movil-detalle.png'});
    const results=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();
    await writeFile(`test-results/axe-mobile-${width}.json`,JSON.stringify(results.violations,null,2));
    expect(results.violations).toEqual([]);
    await page.locator('#close-detail').click();
    const box=await page.locator('#map').boundingBox();expect(box).toBeTruthy();
    const before=await page.locator('#map').getAttribute('viewBox');
    await page.mouse.move(box!.x+box!.width/2,box!.y+box!.height/2);
    await page.mouse.down();await page.mouse.move(box!.x+box!.width/2+45,box!.y+box!.height/2+30,{steps:8});await page.mouse.up();
    await expect(page.locator('#map')).not.toHaveAttribute('viewBox',before!);
  });
}
test('accesibilidad de escritorio y ficha con contraste de estados',async({page})=>{
  await ready(page);await sector(page);
  await page.locator('#stall-layer .disponible').first().click();
  await page.screenshot({path:'docs/capturas/escritorio-detalle.png',fullPage:false});
  const results=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();
  await writeFile('test-results/axe-desktop.json',JSON.stringify(results.violations,null,2));
  expect(results.violations).toEqual([]);
});
test('1000 puestos: solo sector visible; evento conserva nodos ajenos y ofrece lista',async({page})=>{
  await ready(page,'/plano/?stress=1000');
  await expect(page.locator('#stall-layer .stall')).toHaveCount(0);
  await page.locator('#sector-cards button').first().click();
  const count=await page.locator('#stall-layer .stall').count();
  expect(count).toBeGreaterThan(300);expect(count).toBeLessThan(340);
  await expect(page.locator('#list-fallback')).toBeVisible();
  const metrics=await page.evaluate(()=>{
    const app=(window as any).__planoTest;
    const p=[...app.store.puestos.values()][0] as any;
    const other=document.querySelectorAll('#stall-layer .stall')[1];
    let added=0,removed=0;
    const observer=new MutationObserver(records=>{for(const r of records){added+=r.addedNodes.length;removed+=r.removedNodes.length;}});
    observer.observe(document.querySelector('#stall-layer')!,{childList:true});
    const start=performance.now();
    app.store.update({...p,estado:'separado',version:p.version+1});
    const duration=performance.now()-start;
    return new Promise(resolve=>requestAnimationFrame(()=>{observer.disconnect();resolve({duration,added,removed,same:other===document.querySelectorAll('#stall-layer .stall')[1]});}));
  });
  expect((metrics as any).same).toBeTruthy();
  expect((metrics as any).added).toBe(0);expect((metrics as any).removed).toBe(0);
  // A broad regression budget on this host; not a claim of physical-phone FPS.
  expect((metrics as any).duration).toBeLessThan(200);
  await writeFile('test-results/performance.json',JSON.stringify({count,...metrics as object},null,2));
  await page.locator('#fallback-list').click();
  expect(await page.locator('#stall-list [data-puesto]').count()).toBe(60);
});
