(function () {
  'use strict';

  const scroller = document.getElementById('scroller');
  const slides   = Array.from(document.querySelectorAll('.slide'));
  const total    = slides.length;
  const dotsNav  = document.getElementById('dots');
  const counter  = document.getElementById('counter');
  const btnPrev  = document.getElementById('nav-prev');
  const btnNext  = document.getElementById('nav-next');
  const bar      = document.getElementById('progress');

  /* ── Número de sección en cada slide ── */
  slides.forEach((s, i) => {
    const num = document.createElement('span');
    num.className = 'slide-num';
    num.textContent = (i + 1) + ' / ' + total;
    s.appendChild(num);
  });

  /* ── Dots laterales ── */
  slides.forEach((s, i) => {
    const a = document.createElement('a');
    a.href = '#' + s.id;
    a.dataset.idx = i;
    a.setAttribute('aria-label', s.dataset.title || 'Sección ' + (i + 1));
    const tip = document.createElement('span');
    tip.textContent = (i + 1) + '. ' + (s.dataset.title || '');
    a.appendChild(tip);
    dotsNav.appendChild(a);
  });
  const dots = Array.from(dotsNav.querySelectorAll('a'));

  /* ── Estado ── */
  let activeIdx = 0;

  function updateUI(idx) {
    activeIdx = Math.max(0, Math.min(total - 1, idx));
    counter.textContent = (activeIdx + 1) + ' / ' + total;
    btnPrev.disabled = activeIdx === 0;
    btnNext.disabled = activeIdx === total - 1;
    dots.forEach((d, i) => d.classList.toggle('active', i === activeIdx));
  }

  /* ── Progress bar — usa el scroller como contenedor ── */
  function updateProgress() {
    const pct = scroller.scrollTop / (scroller.scrollHeight - scroller.clientHeight);
    bar.style.width = Math.min(pct * 100, 100) + '%';
  }
  scroller.addEventListener('scroll', updateProgress, { passive: true });
  updateProgress();

  /* ── IntersectionObserver con root = scroller ── */
  const sectionObserver = new IntersectionObserver((entries) => {
    entries.forEach((e) => {
      if (e.isIntersecting) {
        const idx = slides.indexOf(e.target);
        if (idx !== -1) updateUI(idx);
      }
    });
  }, { root: scroller, rootMargin: '-40% 0px -40% 0px', threshold: 0 });
  slides.forEach((s) => sectionObserver.observe(s));

  /* ── Ir a sección ── */
  function goTo(idx) {
    idx = Math.max(0, Math.min(total - 1, idx));
    slides[idx].scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
  btnPrev.addEventListener('click', () => goTo(activeIdx - 1));
  btnNext.addEventListener('click', () => goTo(activeIdx + 1));
  updateUI(0);

  /* ── Dots click ── */
  dots.forEach((d) => {
    d.addEventListener('click', (e) => {
      e.preventDefault();
      goTo(parseInt(d.dataset.idx));
    });
  });

  /* ── Teclado ── */
  window.addEventListener('keydown', (e) => {
    if (['INPUT', 'TEXTAREA', 'SELECT'].includes(document.activeElement.tagName)) return;
    const fwd = ['ArrowDown', 'ArrowRight', 'PageDown'].includes(e.key);
    const bwd = ['ArrowUp', 'ArrowLeft', 'PageUp'].includes(e.key);
    if (!fwd && !bwd) return;
    e.preventDefault();
    goTo(activeIdx + (fwd ? 1 : -1));
  });

  /* ── Swipe táctil ── */
  let touchY = 0;
  let touchT = 0;
  scroller.addEventListener('touchstart', (e) => {
    touchY = e.touches[0].clientY;
    touchT = Date.now();
  }, { passive: true });
  scroller.addEventListener('touchend', (e) => {
    const dy = touchY - e.changedTouches[0].clientY;
    if (Math.abs(dy) > 48 && Date.now() - touchT < 380) {
      goTo(activeIdx + (dy > 0 ? 1 : -1));
    }
  }, { passive: true });

  /* ── Animaciones reveal ── */
  const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!prefersReduced) {
    document.body.classList.add('js-anim');
    const items = Array.from(document.querySelectorAll(
      '.card,.step,.level,.fn,.tl,.checklist li,.term,.agreements li'
    ));
    items.forEach((el) => el.classList.add('anim'));
    const revealObserver = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.classList.add('in');
          revealObserver.unobserve(e.target);
        }
      });
    }, { root: scroller, rootMargin: '0px 0px -50px 0px', threshold: 0 });
    items.forEach((el) => revealObserver.observe(el));
  }
})();
