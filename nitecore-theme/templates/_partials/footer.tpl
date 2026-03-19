{**
 * footer.tpl — Full site footer partial
 *
 * Sections:
 *  1. Newsletter block
 *  2. Multi-column footer (brand info, links, trust badges, payment methods)
 *  3. Copyright bar
 *
 * PrestaShop hooks used:
 *  displayFooter, displayFooterBefore, displayFooterAfter
 *}

<footer class="site-footer" role="contentinfo">

  {hook h='displayFooterBefore'}

  {* ══════════════════════════════════════════════════════════════════════════
     1. NEWSLETTER
     ══════════════════════════════════════════════════════════════════════════ *}
  {include file='./_partials/newsletter-block.tpl'}

  {* ══════════════════════════════════════════════════════════════════════════
     2. MAIN FOOTER COLUMNS
     ══════════════════════════════════════════════════════════════════════════ *}
  <div class="footer-main">
    <div class="container">
      <div class="footer-grid">

        {* ── Brand / Contact ────────────────────────────────────────────── *}
        <div class="footer-col">
          <div class="footer-brand">
            <a class="footer-brand__logo" href="{$urls.base_url}" aria-label="{l s='Go to home page' d='Shop.Theme.Global'}">
              {if isset($shop.logo) && $shop.logo}
                <img src="{$shop.logo}" alt="{$shop.name|escape:'html'}" height="40" width="auto">
              {else}
                {$shop.name|escape:'html'}
              {/if}
            </a>
            <p class="footer-brand__desc">
              {l s='Professional lighting solutions for the most demanding environments.' d='Shop.Theme.Global'}
            </p>
            <ul class="footer-brand__contact" role="list" aria-label="{l s='Contact information' d='Shop.Theme.Global'}">
              {if isset($contact_infos.phone) && $contact_infos.phone}
                <li>
                  <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M6.6 10.8c1.4 2.8 3.8 5.1 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1-9.4 0-17-7.6-17-17 0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.3.2 2.5.6 3.6.1.3 0 .7-.2 1L6.6 10.8z"/>
                  </svg>
                  <a href="tel:{$contact_infos.phone}">{$contact_infos.phone|escape:'html'}</a>
                </li>
              {/if}
              {if isset($contact_infos.email) && $contact_infos.email}
                <li>
                  <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                  </svg>
                  <a href="mailto:{$contact_infos.email}">{$contact_infos.email|escape:'html'}</a>
                </li>
              {/if}
              {if isset($contact_infos.address) && $contact_infos.address.formatted}
                <li>
                  <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                  </svg>
                  {$contact_infos.address.formatted|nl2br}
                </li>
              {/if}
            </ul>
          </div>
        </div>

        {* ── Information Links ──────────────────────────────────────────── *}
        <div class="footer-col">
          <h3 class="footer-col__title">{l s='Information' d='Shop.Theme.Global'}</h3>
          <ul class="footer-links" role="list">
            {if isset($cms_pages)}
              {foreach from=$cms_pages item=page}
                <li><a href="{$page.url}">{$page.title|escape:'html'}</a></li>
              {/foreach}
            {/if}
            <li><a href="{$urls.pages.sitemap}">{l s='Sitemap' d='Shop.Theme.Global'}</a></li>
          </ul>
        </div>

        {* ── Service Links ──────────────────────────────────────────────── *}
        <div class="footer-col">
          <h3 class="footer-col__title">{l s='Customer Service' d='Shop.Theme.Global'}</h3>
          <ul class="footer-links" role="list">
            <li><a href="{$urls.pages.order_tracking}">{l s='Track my order' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.my_account}">{l s='My account' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.contact}">{l s='Contact us' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.order_slip}">{l s='Returns' d='Shop.Theme.Global'}</a></li>
            <li><a href="{$urls.pages.addresses}">{l s='My addresses' d='Shop.Theme.Global'}</a></li>
          </ul>
        </div>

        {* ── Support Links ──────────────────────────────────────────────── *}
        <div class="footer-col">
          <h3 class="footer-col__title">{l s='Support' d='Shop.Theme.Global'}</h3>
          <ul class="footer-links" role="list">
            <li><a href="#">{l s='FAQ' d='Shop.Theme.Global'}</a></li>
            <li><a href="#">{l s='Warranty' d='Shop.Theme.Global'}</a></li>
            <li><a href="#">{l s='Repairs' d='Shop.Theme.Global'}</a></li>
            <li><a href="#">{l s='Downloads' d='Shop.Theme.Global'}</a></li>
            <li><a href="#">{l s='Compatibility chart' d='Shop.Theme.Global'}</a></li>
          </ul>
        </div>

        {* ── Trust Badges & Payment ─────────────────────────────────────── *}
        <div class="footer-col">
          <h3 class="footer-col__title">{l s='Secure Shopping' d='Shop.Theme.Global'}</h3>
          <div class="trust-badges" role="list">
            <div class="trust-badges__item" role="listitem">
              <svg aria-hidden="true" focusable="false" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm0 10.99h7c-.53 4.12-3.28 7.79-7 8.94V12H5V6.3l7-3.11v8.8z"/>
              </svg>
              <div class="trust-badges__label">
                {l s='SSL Encrypted' d='Shop.Theme.Global'}
                <span>{l s='Secure checkout' d='Shop.Theme.Global'}</span>
              </div>
            </div>
            <div class="trust-badges__item" role="listitem">
              <svg aria-hidden="true" focusable="false" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.7 1.3 3 3 3s3-1.3 3-3h6c0 1.7 1.3 3 3 3s3-1.3 3-3h2v-5l-3-4zm-1 1l1.96 2.5H17V9h2zm-7 9c-.8 0-1.5-.7-1.5-1.5S11.2 15 12 15s1.5.7 1.5 1.5S12.8 18 12 18zm8 0c-.8 0-1.5-.7-1.5-1.5S19.2 15 20 15s1.5.7 1.5 1.5S20.8 18 20 18z"/>
              </svg>
              <div class="trust-badges__label">
                {l s='Fast Delivery' d='Shop.Theme.Global'}
                <span>{l s='1–3 business days' d='Shop.Theme.Global'}</span>
              </div>
            </div>
            <div class="trust-badges__item" role="listitem">
              <svg aria-hidden="true" focusable="false" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                <path d="M19 8l-4 4h3c0 3.31-2.69 6-6 6-1.01 0-1.97-.25-2.8-.7l-1.46 1.46C8.97 19.54 10.43 20 12 20c4.42 0 8-3.58 8-8h3l-4-4zM6 12c0-3.31 2.69-6 6-6 1.01 0 1.97.25 2.8.7l1.46-1.46C15.03 4.46 13.57 4 12 4c-4.42 0-8 3.58-8 8H1l4 4 4-4H6z"/>
              </svg>
              <div class="trust-badges__label">
                {l s='Free Returns' d='Shop.Theme.Global'}
                <span>{l s='30-day return policy' d='Shop.Theme.Global'}</span>
              </div>
            </div>
          </div>

          {* Payment methods *}
          <div class="payment-methods" role="list" aria-label="{l s='Accepted payment methods' d='Shop.Theme.Global'}">
            <span class="payment-methods__icon" role="listitem" aria-label="Visa">VISA</span>
            <span class="payment-methods__icon" role="listitem" aria-label="Mastercard">MC</span>
            <span class="payment-methods__icon" role="listitem" aria-label="PayPal">PP</span>
            <span class="payment-methods__icon" role="listitem" aria-label="American Express">AMEX</span>
            <span class="payment-methods__icon" role="listitem" aria-label="Apple Pay">⌘Pay</span>
          </div>
        </div>

      </div>{* /.footer-grid *}

      {* Hook for extra footer content from modules *}
      {hook h='displayFooter'}

    </div>{* /.container *}
  </div>{* /.footer-main *}

  {* ══════════════════════════════════════════════════════════════════════════
     3. COPYRIGHT BAR
     ══════════════════════════════════════════════════════════════════════════ *}
  <div class="footer-copyright">
    <div class="container">
      <div class="footer-copyright__inner">
        <p class="footer-copyright__text">
          &copy; {$smarty.now|date_format:"%Y"} <a href="{$urls.base_url}">{$shop.name|escape:'html'}</a>.
          {l s='All rights reserved.' d='Shop.Theme.Global'}
          {l s='Powered by' d='Shop.Theme.Global'} <a href="https://www.prestashop.com" target="_blank" rel="noopener">PrestaShop</a>.
        </p>
        <ul class="footer-copyright__links" role="list">
          {if isset($cms_pages)}
            {foreach from=$cms_pages item=page}
              {if $page.id lte 4}
                <li><a href="{$page.url}">{$page.title|escape:'html'}</a></li>
              {/if}
            {/foreach}
          {/if}
        </ul>
      </div>
    </div>
  </div>

  {hook h='displayFooterAfter'}

  {* ── Back to top button ─────────────────────────────────────────────────── *}
  <button
    class="back-to-top"
    aria-label="{l s='Back to top' d='Shop.Theme.Global'}"
    type="button"
  >
    <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
      <path d="M7.41 15.41L12 10.83l4.59 4.58L18 14l-6-6-6 6z"/>
    </svg>
  </button>

</footer>
