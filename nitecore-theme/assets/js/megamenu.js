/**
 * megamenu.js — Mega-menu dropdown behaviour
 *
 * Handles:
 *  - Desktop: hover intent (small delay to avoid accidental closes)
 *  - Desktop: keyboard navigation (arrow keys, Escape, Tab)
 *  - Touch: tap to open/close
 *  - ARIA attributes update
 */

'use strict';

const HOVER_DELAY = 120; // ms — prevents flicker on mouse-over
const qs  = (sel, ctx = document) => ctx.querySelector(sel);
const qsa = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

class MegaMenu {
  constructor(navElement) {
    this.nav        = navElement;
    this.items      = qsa('.header-nav__item', navElement);
    this.timers     = new WeakMap();
    this.activeItem = null;

    this._bindEvents();
  }

  // ─── Bind Events ────────────────────────────────────────────────────────────

  _bindEvents() {
    this.items.forEach((item) => {
      const link    = qs(':scope > .header-nav__link', item);
      const submenu = qs(':scope > .mega-menu, :scope > .nav-dropdown', item);

      if (!submenu) return;

      // Set ARIA
      if (link) {
        link.setAttribute('aria-haspopup', 'true');
        link.setAttribute('aria-expanded', 'false');
      }

      // Desktop — hover intent
      item.addEventListener('mouseenter', () => this._scheduleOpen(item, link, submenu));
      item.addEventListener('mouseleave', () => this._scheduleClose(item, link, submenu));

      // Touch — tap toggle
      link?.addEventListener('click', (e) => {
        if (!window.matchMedia('(hover: none)').matches) return;
        e.preventDefault();
        const isOpen = submenu.getAttribute('aria-hidden') !== 'true';
        isOpen ? this._close(item, link, submenu) : this._open(item, link, submenu);
      });

      // Keyboard — Enter / Space on link
      link?.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          const isOpen = link.getAttribute('aria-expanded') === 'true';
          isOpen ? this._close(item, link, submenu) : this._open(item, link, submenu);
        }
        if (e.key === 'ArrowDown') {
          e.preventDefault();
          this._open(item, link, submenu);
          const firstLink = qs('a, button', submenu);
          firstLink?.focus();
        }
        if (e.key === 'Escape') {
          this._close(item, link, submenu);
          link?.focus();
        }
      });

      // Keyboard — Escape inside submenu
      submenu.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
          this._close(item, link, submenu);
          link?.focus();
        }
      });

      // Close when focus leaves the whole item
      item.addEventListener('focusout', (e) => {
        // Use a tiny timeout so the new focus target is known
        setTimeout(() => {
          if (!item.contains(document.activeElement)) {
            this._close(item, link, submenu);
          }
        }, 0);
      });
    });

    // Close all on outside click
    document.addEventListener('click', (e) => {
      if (!this.nav.contains(e.target)) {
        this._closeAll();
      }
    });
  }

  // ─── Hover Intent ───────────────────────────────────────────────────────────

  _scheduleOpen(item, link, submenu) {
    this._clearTimer(item);
    const timer = setTimeout(() => this._open(item, link, submenu), HOVER_DELAY);
    this.timers.set(item, timer);
  }

  _scheduleClose(item, link, submenu) {
    this._clearTimer(item);
    const timer = setTimeout(() => this._close(item, link, submenu), HOVER_DELAY);
    this.timers.set(item, timer);
  }

  _clearTimer(item) {
    const existing = this.timers.get(item);
    if (existing) {
      clearTimeout(existing);
      this.timers.delete(item);
    }
  }

  // ─── Open / Close ───────────────────────────────────────────────────────────

  _open(item, link, submenu) {
    // Close any previously open item that isn't this one
    if (this.activeItem && this.activeItem !== item) {
      const prevLink    = qs(':scope > .header-nav__link', this.activeItem);
      const prevSubmenu = qs(':scope > .mega-menu, :scope > .nav-dropdown', this.activeItem);
      this._close(this.activeItem, prevLink, prevSubmenu);
    }

    item.classList.add('is-open');
    link?.setAttribute('aria-expanded', 'true');
    submenu.removeAttribute('hidden');
    submenu.setAttribute('aria-hidden', 'false');
    this.activeItem = item;
  }

  _close(item, link, submenu) {
    this._clearTimer(item);
    item.classList.remove('is-open');
    link?.setAttribute('aria-expanded', 'false');
    submenu.setAttribute('aria-hidden', 'true');
    if (this.activeItem === item) this.activeItem = null;
  }

  _closeAll() {
    this.items.forEach((item) => {
      const link    = qs(':scope > .header-nav__link', item);
      const submenu = qs(':scope > .mega-menu, :scope > .nav-dropdown', item);
      if (submenu) this._close(item, link, submenu);
    });
  }
}

// ─── Bootstrap ────────────────────────────────────────────────────────────────

function initMegaMenu() {
  const nav = document.querySelector('.header-nav__list');
  if (!nav) return;
  new MegaMenu(nav);
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initMegaMenu);
} else {
  initMegaMenu();
}
