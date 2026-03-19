{**
 * header.tpl — Full site header partial
 *
 * Sections:
 *  1. Top bar (contacts, promo text, account links)
 *  2. Main header (logo, search bar, action icons)
 *  3. Mega-menu navigation bar
 *  4. Mobile navigation drawer + overlay
 *
 * PrestaShop hooks used:
 *  displayNav1, displayNav2, displayTop, displaySearch, displayNavFullWidth
 *}

<header class="site-header" role="banner" id="header">

  {* ══════════════════════════════════════════════════════════════════════════
     1. TOP BAR
     ══════════════════════════════════════════════════════════════════════════ *}
  <div class="topbar" role="note" aria-label="{l s='Top information bar' d='Shop.Theme.Global'}">
    <div class="container">
      <div class="topbar__inner">

        {* Left — contact / shipping info *}
        <ul class="topbar__left" role="list" aria-label="{l s='Contact info' d='Shop.Theme.Global'}">
          <li>
            <a class="topbar__item" href="tel:{hook h='displayNav1'}">
              <svg aria-hidden="true" focusable="false" width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
                <path d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.3.2 2.5.6 3.6.1.3 0 .7-.2 1L6.6 10.8z"/>
              </svg>
              {hook h='displayNav1'}
            </a>
          </li>
          <li>
            <span class="topbar__item">
              <svg aria-hidden="true" focusable="false" width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
                <path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
              </svg>
              {hook h='displayNav2'}
            </span>
          </li>
        </ul>

        {* Centre — promotional text *}
        <p class="topbar__promo">
          <svg aria-hidden="true" focusable="false" width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
            <path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.7 1.3 3 3 3s3-1.3 3-3h6c0 1.7 1.3 3 3 3s3-1.3 3-3h2v-5l-3-4zM6 18.5c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5 1.5.7 1.5 1.5-.7 1.5-1.5 1.5zm13.5-9l1.96 2.5H17V9.5h2.5zm-1.5 9c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5 1.5.7 1.5 1.5-.7 1.5-1.5 1.5z"/>
          </svg>
          {l s='Free shipping on orders over €99' d='Shop.Theme.Global'}
        </p>

        {* Right — account, language, currency *}
        <ul class="topbar__right" role="list">
          {hook h='displayTop'}
        </ul>

      </div>{* /.topbar__inner *}
    </div>{* /.container *}
  </div>{* /.topbar *}

  {* ══════════════════════════════════════════════════════════════════════════
     2. MAIN HEADER
     ══════════════════════════════════════════════════════════════════════════ *}
  <div class="header-main">
    <div class="container">
      <div class="header-main__inner">

        {* Mobile hamburger *}
        <button
          class="mobile-menu-toggle"
          aria-label="{l s='Open navigation menu' d='Shop.Theme.Global'}"
          aria-expanded="false"
          aria-controls="mobile-nav"
          type="button"
        >
          <span></span>
          <span></span>
          <span></span>
        </button>

        {* Logo *}
        <div class="header-logo">
          <a href="{$urls.base_url}" aria-label="{l s='Go to home page' d='Shop.Theme.Global'} — {$shop.name}">
            {if isset($shop.logo) && $shop.logo}
              <img
                src="{$shop.logo}"
                alt="{$shop.name|escape:'html'}"
                width="160"
                height="48"
                loading="eager"
              >
            {else}
              <span class="header-logo__text" aria-hidden="true">{$shop.name|escape:'html'}</span>
            {/if}
          </a>
        </div>

        {* Search *}
        <div class="header-search" role="search" aria-label="{l s='Search' d='Shop.Theme.Global'}">
          {hook h='displaySearch'}
        </div>

        {* Action icons *}
        <nav class="header-actions" aria-label="{l s='Account and cart' d='Shop.Theme.Global'}">
          {hook h='displayNavFullWidth'}
        </nav>

      </div>{* /.header-main__inner *}
    </div>{* /.container *}
  </div>{* /.header-main *}

  {* ══════════════════════════════════════════════════════════════════════════
     3. MEGA-MENU NAVIGATION BAR
     ══════════════════════════════════════════════════════════════════════════ *}
  <nav class="header-nav" role="navigation" aria-label="{l s='Main navigation' d='Shop.Theme.Global'}">
    <div class="container">
      <div class="header-nav__inner">

        <ul class="header-nav__list" role="list">
          {if isset($categories)}
            {foreach from=$categories item=category}
              <li class="header-nav__item">
                <a
                  href="{$category.url}"
                  class="header-nav__link{if $category.active} active{/if}"
                  {if $category.children}
                    aria-haspopup="true"
                    aria-expanded="false"
                  {/if}
                >
                  {$category.name|escape:'html'}
                  {if isset($category.is_new) && $category.is_new}
                    <span class="header-nav__badge header-nav__badge--neu" aria-label="New">NEU</span>
                  {/if}
                  {if isset($category.is_hot) && $category.is_hot}
                    <span class="header-nav__badge header-nav__badge--hot" aria-label="Best seller">HOT</span>
                  {/if}
                </a>

                {* Mega-menu for categories with children *}
                {if $category.children}
                  <div class="mega-menu" role="region" aria-label="{$category.name|escape:'html'} submenu" aria-hidden="true">
                    {foreach from=$category.children item=sub}
                      <div class="mega-menu__col">
                        <p class="mega-menu__title">{$sub.name|escape:'html'}</p>
                        {if $sub.children}
                          {foreach from=$sub.children item=leaf}
                            <a class="mega-menu__link" href="{$leaf.url}">{$leaf.name|escape:'html'}</a>
                          {/foreach}
                        {/if}
                      </div>
                    {/foreach}
                  </div>
                {/if}

              </li>
            {/foreach}
          {/if}

          {* Hook for extra nav items added by modules *}
          {hook h='displayTop'}
        </ul>

      </div>{* /.header-nav__inner *}
    </div>{* /.container *}
  </nav>{* /.header-nav *}

</header>{* /.site-header *}

{* ══════════════════════════════════════════════════════════════════════════════
   4. MOBILE NAVIGATION DRAWER
   ══════════════════════════════════════════════════════════════════════════════ *}
<div class="mobile-overlay" aria-hidden="true"></div>

<nav
  class="mobile-nav"
  id="mobile-nav"
  role="navigation"
  aria-label="{l s='Mobile navigation' d='Shop.Theme.Global'}"
  aria-hidden="true"
>
  <div class="mobile-nav__header">
    <span class="header-logo__text">{$shop.name|escape:'html'}</span>
    <button
      class="mobile-nav__close"
      aria-label="{l s='Close navigation menu' d='Shop.Theme.Global'}"
      type="button"
    >
      <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
        <path d="M19 6.4L17.6 5 12 10.6 6.4 5 5 6.4 10.6 12 5 17.6 6.4 19 12 13.4 17.6 19 19 17.6 13.4 12z"/>
      </svg>
    </button>
  </div>

  <ul class="mobile-nav__list" role="list">
    {if isset($categories)}
      {foreach from=$categories item=category}
        <li class="mobile-nav__item">
          <a href="{$category.url}">
            {$category.name|escape:'html'}
            {if $category.children}
              <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <path d="M7 10l5 5 5-5z"/>
              </svg>
            {/if}
          </a>
        </li>
      {/foreach}
    {/if}
  </ul>
</nav>
