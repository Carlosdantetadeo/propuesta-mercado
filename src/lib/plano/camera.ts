import type { Rect } from './types';
export class Camera {
  view:Rect={x:0,y:0,w:1888,h:778};
  private raf=0;
  private pointers=new Map<number,{x:number;y:number}>();
  private last:{x:number;y:number;time:number}|null=null;
  private velocity={x:0,y:0};
  private pinch=0;
  private moved=false;
  private down={x:0,y:0};
  private lastTap=0;
  suppressClick=false;
  onFrame=()=>{};
  constructor(private svg: SVGSVGElement) {
    svg.addEventListener('wheel',e=>{e.preventDefault();this.zoom(e.deltaY>0?1.15:1/1.15,e.clientX,e.clientY);},{passive:false});
    svg.addEventListener('dblclick',e=>{e.preventDefault();this.zoom(.6,e.clientX,e.clientY);});
    svg.addEventListener('pointerdown',e=>{
      if(e.button!==0)return;
      cancelAnimationFrame(this.raf);
      this.pointers.set(e.pointerId,{x:e.clientX,y:e.clientY});
      this.down={x:e.clientX,y:e.clientY};this.moved=false;this.velocity={x:0,y:0};
      this.last={x:e.clientX,y:e.clientY,time:performance.now()};
      if(this.pointers.size===2)this.pinch=this.distance();
    });
    window.addEventListener('pointermove',e=>{
      if(!this.pointers.has(e.pointerId))return;
      const now=performance.now(),dx=e.clientX-(this.last?.x??e.clientX),dy=e.clientY-(this.last?.y??e.clientY);
      this.pointers.set(e.pointerId,{x:e.clientX,y:e.clientY});
      if(Math.hypot(e.clientX-this.down.x,e.clientY-this.down.y)>6)this.moved=true;
      if(this.pointers.size===2) {
        this.moved=true;const distance=this.distance(),points=[...this.pointers.values()];
        if(this.pinch>0)this.zoom(this.pinch/distance,(points[0].x+points[1].x)/2,(points[0].y+points[1].y)/2,false);
        this.pinch=distance;
      }else if(this.moved&&this.last){
        const factor=this.view.w/this.svg.clientWidth;
        this.view.x-=dx*factor;this.view.y-=dy*factor;
        const dt=Math.max(8,now-this.last.time);this.velocity={x:dx/dt,y:dy/dt};this.draw();
      }
      this.last={x:e.clientX,y:e.clientY,time:now};
    });
    const finish=(e:PointerEvent)=>{
      if(!this.pointers.has(e.pointerId))return;
      this.pointers.delete(e.pointerId);
      if(this.moved||e.type==='pointercancel') {
        this.suppressClick=true;setTimeout(()=>this.suppressClick=false,100);
        if(!this.pointers.size&&e.type!=='pointercancel')this.inertia();
      }else if(e.pointerType==='touch'){
        const now=performance.now();
        if(now-this.lastTap<300){this.zoom(.6,e.clientX,e.clientY);this.suppressClick=true;setTimeout(()=>this.suppressClick=false,100);}
        this.lastTap=now;
      }
      this.last=null;
    };
    window.addEventListener('pointerup',finish);window.addEventListener('pointercancel',finish);
    svg.addEventListener('keydown',e=>{
      if(!['ArrowLeft','ArrowRight','ArrowUp','ArrowDown','+','-'].includes(e.key))return;
      e.preventDefault();
      if(e.key==='+')this.zoom(.75);else if(e.key==='-')this.zoom(1.3);
      else {this.view.x+=(e.key==='ArrowRight'?1:e.key==='ArrowLeft'?-1:0)*this.view.w*.12;
        this.view.y+=(e.key==='ArrowDown'?1:e.key==='ArrowUp'?-1:0)*this.view.h*.12;this.draw();}
    });
    new ResizeObserver(()=>this.onFrame()).observe(svg);
  }
  private distance(){const [a,b]=[...this.pointers.values()];return Math.max(1,Math.hypot(a.x-b.x,a.y-b.y));}
  private draw(){
    this.view.x=Math.max(-1888,Math.min(1888,this.view.x));this.view.y=Math.max(-778,Math.min(778,this.view.y));
    this.svg.setAttribute('viewBox',`${this.view.x} ${this.view.y} ${this.view.w} ${this.view.h}`);this.onFrame();
  }
  fit(r:Rect, animate=true) {
    const ratio=this.svg.clientWidth/Math.max(1,this.svg.clientHeight);
    let w=r.w*1.24,h=r.h*1.24;
    if(w/h<ratio)w=h*ratio;else h=w/ratio;
    this.to({x:r.x+r.w/2-w/2,y:r.y+r.h/2-h/2,w,h},animate);
  }
  private to(dest:Rect,animate:boolean){
    cancelAnimationFrame(this.raf);
    if(!animate||matchMedia('(prefers-reduced-motion: reduce)').matches){this.view=dest;this.draw();return;}
    const origin={...this.view},start=performance.now();
    const frame=(now:number)=>{
      const t=Math.min(1,(now-start)/360),ease=1-Math.pow(1-t,3);
      for(const key of ['x','y','w','h'] as const)this.view[key]=origin[key]+(dest[key]-origin[key])*ease;
      this.draw();if(t<1)this.raf=requestAnimationFrame(frame);
    };this.raf=requestAnimationFrame(frame);
  }
  zoom(factor:number,cx?:number,cy?:number,animate=true){
    const w=Math.max(35,Math.min(3000,this.view.w*factor)),scale=w/this.view.w;
    const box=this.svg.getBoundingClientRect();
    const point=this.svg.createSVGPoint();point.x=cx??box.x+box.width/2;point.y=cy??box.y+box.height/2;
    const world=point.matrixTransform(this.svg.getScreenCTM()!.inverse());
    this.to({x:world.x-(world.x-this.view.x)*scale,y:world.y-(world.y-this.view.y)*scale,w,h:this.view.h*scale},animate);
  }
  private inertia(){
    if(matchMedia('(prefers-reduced-motion: reduce)').matches)return;
    let {x,y}=this.velocity;
    const frame=()=>{x*=.90;y*=.90;if(Math.hypot(x,y)<.015)return;
      this.view.x-=x*16*this.view.w/this.svg.clientWidth;this.view.y-=y*16*this.view.w/this.svg.clientWidth;
      this.draw();this.raf=requestAnimationFrame(frame);
    };this.raf=requestAnimationFrame(frame);
  }
}
