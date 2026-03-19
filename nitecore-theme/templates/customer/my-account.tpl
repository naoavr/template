{**
 * customer/my-account.tpl — My account dashboard page
 *
 * Extends layout-full-width.tpl.
 * Variables: $customer (PrestaShop customer object), $urls.pages.*
 *}

{extends file='layouts/layout-full-width.tpl'}

{block name='content'}

<section class="my-account-page" style="padding:48px 0;" aria-label="{l s='My account' d='Shop.Theme.CustomerAccount'}">
  <div class="container">

    <header style="margin-bottom:40px;">
      <h1 style="font-size:28px;font-weight:700;color:#fff;margin-bottom:8px;">
        {l s='My Account' d='Shop.Theme.CustomerAccount'}
      </h1>
      {if isset($customer.firstname)}
        <p style="font-size:15px;color:#b0b0b0;">
          {l s='Welcome back,' d='Shop.Theme.CustomerAccount'}
          <strong style="color:#FFD700;">{$customer.firstname|escape:'html'} {$customer.lastname|escape:'html'}</strong>
        </p>
      {/if}
    </header>

    {* ── Account navigation grid ───────────────────────────────────────────── *}
    <nav aria-label="{l s='Account navigation' d='Shop.Theme.CustomerAccount'}">
      <ul
        style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:16px;list-style:none;margin:0;padding:0;"
        role="list"
      >

        {* Orders *}
        <li>
          <a
            href="{$urls.pages.history}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FFD700">
              <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='Order history' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

        {* Returns *}
        <li>
          <a
            href="{$urls.pages.order_slip}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FFD700">
              <path d="M19 8l-4 4h3c0 3.31-2.69 6-6 6-1.01 0-1.97-.25-2.8-.7l-1.46 1.46C8.97 19.54 10.43 20 12 20c4.42 0 8-3.58 8-8h3l-4-4zM6 12c0-3.31 2.69-6 6-6 1.01 0 1.97.25 2.8.7l1.46-1.46C15.03 4.46 13.57 4 12 4c-4.42 0-8 3.58-8 8H1l4 4 4-4H6z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='Returns' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

        {* Addresses *}
        <li>
          <a
            href="{$urls.pages.addresses}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FFD700">
              <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='My addresses' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

        {* Personal info *}
        <li>
          <a
            href="{$urls.pages.identity}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FFD700">
              <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='Personal info' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

        {* Vouchers *}
        <li>
          <a
            href="{$urls.pages.discount}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FFD700">
              <path d="M20 12c0-.56-.07-1.1-.18-1.63L21.5 9l-1.5-2.6-1.82.65A7.98 7.98 0 0 0 16 5.46V3.5L13 2 12 3.73 11 2 8 3.5v1.96A7.98 7.98 0 0 0 5.82 7.05L4 6.4 2.5 9l1.68 1.37C4.07 10.9 4 11.44 4 12s.07 1.1.18 1.63L2.5 15l1.5 2.6 1.82-.65A7.98 7.98 0 0 0 8 18.54V20.5L11 22l1-1.73L13 22l3-1.5v-1.96a7.98 7.98 0 0 0 2.18-1.54l1.82.65L21.5 15l-1.68-1.37c.11-.53.18-1.07.18-1.63zM12 16c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='Vouchers' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

        {* Wishlist (if module installed) *}
        {hook h='displayCustomerAccount'}

        {* Sign out *}
        <li>
          <a
            href="{$urls.actions.logout}"
            style="display:flex;flex-direction:column;align-items:center;gap:12px;padding:28px 20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;text-decoration:none;color:#b0b0b0;transition:border-color .2s,color .2s;"
          >
            <svg aria-hidden="true" width="32" height="32" viewBox="0 0 24 24" fill="#FF4444">
              <path d="M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.58L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z"/>
            </svg>
            <span style="font-size:14px;font-weight:600;">{l s='Sign out' d='Shop.Theme.CustomerAccount'}</span>
          </a>
        </li>

      </ul>
    </nav>

  </div>
</section>

{/block}
