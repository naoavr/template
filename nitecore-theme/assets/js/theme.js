/**
 * theme.js — Main theme JavaScript
 *
 * Features:
 *  1. Sticky/hide-on-scroll header
 *  2. Mobile menu toggle with overlay
 *  3. Search toggle for mobile
 *  4. Hero Slider (Swiper.js)
 *  5. Product card wishlist toggle
 *  6. Back-to-top button
 *  7. Smooth quantity inputs
 */

'use strict';

// ─── Helpers ──────────────────────────────────────────────────────────────────

const qs  = (selector, ctx = document) => ctx.querySelector(selector);
const qsa = (selector, ctx = document) => [...ctx.querySelectorAll(selector)];

// ─── 1. Sticky / Hide-on-scroll Header ────────────────────────────────────────

function initStickyHeader() {
  const header = qs('.site-header');
  if (!header) return;

  let lastScrollY = 0;
  let ticking = false;

  const HIDE_THRESHOLD  = 80;   // px scrolled before we allow hiding
  const MIN_SCROLL_DELTA = 5;   // minimum scroll distance to trigger state change

  function update() {
    const currentScrollY = window.scrollY;
    const scrollDelta    = currentScrollY - lastScrollY;

    if (currentScrollY > HIDE_THRESHOLD) {
      header.classList.add('header--scrolled');
    } else {
      header.classList.remove('header--scrolled');
    }

    if (Math.abs(scrollDelta) > MIN_SCROLL_DELTA) {
      if (scrollDelta > 0 && currentScrollY > HIDE_THRESHOLD) {
        // Scrolling down — hide
        header.classList.add('header--hidden');
      } else {
        // Scrolling up — show
        header.classList.remove('header--hidden');
      }
    }

    lastScrollY = currentScrollY;
    ticking     = false;
  }

  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(update);
      ticking = true;
    }
  }, { passive: true });
}

// ─── 2. Mobile Menu ───────────────────────────────────────────────────────────

function initMobileMenu() {
  const toggleBtn = qs('.mobile-menu-toggle');
  const mobileNav = qs('.mobile-nav');
  const overlay   = qs('.mobile-overlay');
  if (!toggleBtn || !mobileNav) return;

  function openMenu() {
    mobileNav.classList.add('is-open');
    toggleBtn.classList.add('is-active');
    toggleBtn.setAttribute('aria-expanded', 'true');
    if (overlay) {
      overlay.style.display = 'block';
      requestAnimationFrame(() => overlay.classList.add('is-active'));
    }
    document.body.style.overflow = 'hidden';
  }

  function closeMenu() {
    mobileNav.classList.remove('is-open');
    toggleBtn.classList.remove('is-active');
    toggleBtn.setAttribute('aria-expanded', 'false');
    if (overlay) {
      overlay.classList.remove('is-active');
      overlay.addEventListener('transitionend', () => {
        overlay.style.display = '';
      }, { once: true });
    }
    document.body.style.overflow = '';
  }

  toggleBtn.addEventListener('click', () => {
    const isOpen = mobileNav.classList.contains('is-open');
    isOpen ? closeMenu() : openMenu();
  });

  if (overlay) {
    overlay.addEventListener('click', closeMenu);
  }

  // Close on Escape key
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') closeMenu();
  });

  // Accordion-style sub-menus in mobile nav
  qsa('.mobile-nav__item > a[data-toggle="submenu"]').forEach((link) => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      const parent  = link.closest('.mobile-nav__item');
      const submenu = qs('.mobile-nav__submenu', parent);
      if (!submenu) return;

      const isOpen = parent.classList.contains('is-open');
      // Close siblings
      qsa('.mobile-nav__item.is-open').forEach((item) => {
        if (item !== parent) {
          item.classList.remove('is-open');
          qs('.mobile-nav__submenu', item)?.setAttribute('hidden', '');
        }
      });

      if (isOpen) {
        parent.classList.remove('is-open');
        submenu.setAttribute('hidden', '');
      } else {
        parent.classList.add('is-open');
        submenu.removeAttribute('hidden');
      }
    });
  });
}

// ─── 3. Search Toggle (mobile) ────────────────────────────────────────────────

function initSearchToggle() {
  const toggleBtn = qs('.header-search__toggle');
  const searchBar = qs('.header-search');
  if (!toggleBtn || !searchBar) return;

  toggleBtn.addEventListener('click', () => {
    const isOpen = searchBar.classList.contains('is-open');
    searchBar.classList.toggle('is-open');
    toggleBtn.setAttribute('aria-expanded', String(!isOpen));

    if (!isOpen) {
      const input = qs('.header-search__input', searchBar);
      input?.focus();
    }
  });
}

// ─── 4. Hero Slider (Swiper.js) ───────────────────────────────────────────────

function initHeroSlider() {
  const sliderEl = qs('.hero-swiper');
  if (!sliderEl || typeof Swiper === 'undefined') return;

  new Swiper(sliderEl, {
    loop: true,
    speed: 800,
    effect: 'fade',
    fadeEffect: { crossFade: true },
    autoplay: {
      delay: 5000,
      disableOnInteraction: false,
      pauseOnMouseEnter: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    a11y: {
      prevSlideMessage: 'Previous slide',
      nextSlideMessage: 'Next slide',
    },
    keyboard: { enabled: true },
  });
}

// ─── 5. Product Card — Wishlist Toggle ────────────────────────────────────────

function initWishlistToggle() {
  document.addEventListener('click', (e) => {
    const btn = e.target.closest('.product-card__wishlist');
    if (!btn) return;

    e.preventDefault();
    const isActive = btn.classList.toggle('is-active');
    const label    = isActive ? 'Remove from wishlist' : 'Add to wishlist';
    btn.setAttribute('aria-label', label);
    btn.setAttribute('aria-pressed', String(isActive));
  });
}

// ─── 6. Back-to-top button ────────────────────────────────────────────────────

function initBackToTop() {
  const btn = qs('.back-to-top');
  if (!btn) return;

  window.addEventListener('scroll', () => {
    btn.classList.toggle('is-visible', window.scrollY > 400);
  }, { passive: true });

  btn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
}

// ─── 7. Quantity Inputs ───────────────────────────────────────────────────────

function initQuantityInputs() {
  document.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-qty]');
    if (!btn) return;

    const container = btn.closest('[data-qty-wrap]');
    if (!container) return;

    const input = qs('input[type="number"]', container);
    if (!input) return;

    const min  = parseInt(input.min || '1', 10);
    const max  = parseInt(input.max || '999', 10);
    const step = parseInt(input.step || '1', 10);
    let value  = parseInt(input.value || '1', 10);

    if (btn.dataset.qty === 'inc') {
      value = Math.min(value + step, max);
    } else if (btn.dataset.qty === 'dec') {
      value = Math.max(value - step, min);
    }

    input.value = value;
    input.dispatchEvent(new Event('change', { bubbles: true }));
  });
}

// ─── 8. Product page tab switching ───────────────────────────────────────────

function initProductTabs() {
  const tablist = qs('[role="tablist"]');
  if (!tablist) return;

  const tabs = qsa('[role="tab"]', tablist);

  tabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      tabs.forEach((t) => {
        t.setAttribute('aria-selected', 'false');
        t.style.borderBottomColor = 'transparent';
        t.style.color = '#b0b0b0';
        const panel = qs(`#${t.getAttribute('aria-controls')}`);
        if (panel) panel.hidden = true;
      });

      tab.setAttribute('aria-selected', 'true');
      tab.style.borderBottomColor = '#FFD700';
      tab.style.color = '#FFD700';
      const activePanel = qs(`#${tab.getAttribute('aria-controls')}`);
      if (activePanel) activePanel.hidden = false;
    });

    // Keyboard navigation within tablist
    tab.addEventListener('keydown', (e) => {
      const idx = tabs.indexOf(tab);
      if (e.key === 'ArrowRight' && idx < tabs.length - 1) {
        tabs[idx + 1].focus();
        tabs[idx + 1].click();
      }
      if (e.key === 'ArrowLeft' && idx > 0) {
        tabs[idx - 1].focus();
        tabs[idx - 1].click();
      }
    });
  });
}

// ─── Bootstrap all modules ────────────────────────────────────────────────────

function bootstrap() {
  initStickyHeader();
  initMobileMenu();
  initSearchToggle();
  initHeroSlider();
  initWishlistToggle();
  initBackToTop();
  initQuantityInputs();
  initProductTabs();
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', bootstrap);
} else {
  bootstrap();
}
