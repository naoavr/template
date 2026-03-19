{**
 * index.tpl — Homepage template
 *
 * Extends layout-full-width.tpl.
 * Sections:
 *  1. Hero Slider
 *  2. Hook displayHome (modules: featured products, banners, etc.)
 *  3. New Arrivals product grid
 *  4. Best Sellers product grid
 *  5. Promotional banner
 *  6. Newsletter
 *}

{extends file='layouts/layout-full-width.tpl'}

{block name='breadcrumb'}{/block}{* No breadcrumb on homepage *}

{block name='head_swiper'}
  {* Swiper CSS is included inside hero-slider.tpl *}
{/block}

{block name='content'}

  {* ── 1. Hero Slider ──────────────────────────────────────────────────────── *}
  {include file='./_partials/hero-slider.tpl'}

  {* ── displayHome hook — featured products, banners, carousels ────────────── *}
  {hook h='displayHome'}

  {* ── 2. New Arrivals ─────────────────────────────────────────────────────── *}
  {if isset($new_products) && $new_products}
    <section class="products-section" aria-labelledby="new-arrivals-title">
      <div class="container">
        <div class="section-header">
          <h2 class="section-header__title" id="new-arrivals-title">
            {l s='New Arrivals' d='Shop.Theme.Catalog'}
          </h2>
          <a class="section-header__link" href="{$urls.pages.index}?order=date_add+desc">
            {l s='View all' d='Shop.Theme.Global'}
            <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
              <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
            </svg>
          </a>
        </div>

        <div class="products-grid" role="list" aria-label="{l s='New arrivals product list' d='Shop.Theme.Catalog'}">
          {foreach from=$new_products item=product}
            <div role="listitem">
              {include file='./_partials/product-card.tpl' product=$product}
            </div>
          {/foreach}
        </div>
      </div>
    </section>
  {/if}

  {* ── 3. Best Sellers ─────────────────────────────────────────────────────── *}
  {if isset($best_sellers) && $best_sellers}
    <section class="products-section products-section--alt" aria-labelledby="best-sellers-title">
      <div class="container">
        <div class="section-header">
          <h2 class="section-header__title" id="best-sellers-title">
            {l s='Best Sellers' d='Shop.Theme.Catalog'}
          </h2>
          <a class="section-header__link" href="{$urls.pages.index}?order=sales+desc">
            {l s='View all' d='Shop.Theme.Global'}
            <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
              <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
            </svg>
          </a>
        </div>

        <div class="products-grid" role="list" aria-label="{l s='Best sellers product list' d='Shop.Theme.Catalog'}">
          {foreach from=$best_sellers item=product}
            <div role="listitem">
              {include file='./_partials/product-card.tpl' product=$product}
            </div>
          {/foreach}
        </div>
      </div>
    </section>
  {/if}

  {* ── 4. Promotional Banner ───────────────────────────────────────────────── *}
  <section
    class="promo-banner"
    aria-label="{l s='Promotional offer' d='Shop.Theme.Global'}"
  >
    <div class="container">
      <span class="promo-banner__eyebrow">
        {l s='Limited Time Offer' d='Shop.Theme.Global'}
      </span>
      <h2 class="promo-banner__title">
        {l s='Up to' d='Shop.Theme.Global'}
        <span>30% OFF</span>
        {l s='Selected Items' d='Shop.Theme.Global'}
      </h2>
      <p class="promo-banner__desc">
        {l s='Don\'t miss our seasonal sale on top-rated flashlights and accessories.' d='Shop.Theme.Global'}
      </p>
      <a
        href="{$urls.pages.index}?on_sale=1"
        class="btn btn-primary btn-lg"
      >
        {l s='Shop the Sale' d='Shop.Theme.Global'}
        <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
          <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
        </svg>
      </a>
    </div>
  </section>

  {* ── 5. displayHomeTab hook (additional module content) ──────────────────── *}
  {hook h='displayHomeTab'}

{/block}
