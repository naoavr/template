{**
 * checkout/cart.tpl — Shopping cart page
 *
 * Extends layout-full-width.tpl.
 * Variables: $cart (PrestaShop cart object), $cart_summary_subtotals,
 *            $cart_summary_totals, $products, $gift_products
 *}

{extends file='layouts/layout-full-width.tpl'}

{block name='content'}

<section class="cart-page" style="padding:48px 0;" aria-label="{l s='Shopping cart' d='Shop.Theme.Checkout'}">
  <div class="container">

    <h1 style="font-size:28px;font-weight:700;color:#fff;margin-bottom:32px;">
      {l s='Shopping Cart' d='Shop.Theme.Checkout'}
      {if isset($cart.products_count) && $cart.products_count}
        <span style="font-size:16px;font-weight:400;color:#777;margin-left:8px;">
          ({$cart.products_count} {l s='items' d='Shop.Theme.Checkout'})
        </span>
      {/if}
    </h1>

    {if isset($products) && $products}

      <div style="display:grid;grid-template-columns:1fr 360px;gap:32px;align-items:start;">

        {* ── Product list ─────────────────────────────────────────────────── *}
        <div>
          <div
            role="list"
            aria-label="{l s='Cart items' d='Shop.Theme.Checkout'}"
            style="display:flex;flex-direction:column;gap:16px;"
          >
            {foreach from=$products item=product}
              <article
                role="listitem"
                class="cart-item"
                style="display:flex;gap:20px;background:#161616;border:1px solid #2a2a2a;border-radius:12px;padding:20px;"
                data-id-product="{$product.id_product|intval}"
                data-id-product-attribute="{$product.id_product_attribute|intval}"
              >

                {* Image *}
                <a
                  href="{$product.url}"
                  style="flex-shrink:0;"
                  aria-label="{$product.name|escape:'html'}"
                >
                  {if isset($product.cover)}
                    <img
                      src="{$product.cover.bySize.cart_default.url}"
                      alt="{$product.cover.legend|default:$product.name|escape:'html'}"
                      style="width:96px;height:96px;object-fit:cover;border-radius:8px;background:#222;"
                      loading="lazy"
                    >
                  {/if}
                </a>

                {* Info *}
                <div style="flex:1;min-width:0;">
                  <a
                    href="{$product.url}"
                    style="font-size:16px;font-weight:600;color:#fff;text-decoration:none;display:block;margin-bottom:4px;"
                  >
                    {$product.name|escape:'html'}
                  </a>
                  {if $product.attributes}
                    <p style="font-size:12px;color:#777;margin-bottom:8px;">{$product.attributes}</p>
                  {/if}
                  {if $product.reference}
                    <p style="font-size:12px;color:#555;">{l s='Ref:' d='Shop.Theme.Catalog'} {$product.reference|escape:'html'}</p>
                  {/if}
                </div>

                {* Quantity *}
                <div style="display:flex;flex-direction:column;align-items:center;gap:8px;">
                  <div style="display:flex;align-items:center;gap:6px;" data-qty-wrap>
                    <button
                      type="button"
                      data-qty="dec"
                      style="background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;width:30px;height:30px;border-radius:6px;font-size:16px;cursor:pointer;display:flex;align-items:center;justify-content:center;"
                      aria-label="{l s='Decrease quantity' d='Shop.Theme.Catalog'}"
                    >−</button>
                    <input
                      type="number"
                      value="{$product.cart_quantity}"
                      min="1"
                      style="width:48px;text-align:center;background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;border-radius:6px;padding:4px;font-size:14px;font-family:inherit;"
                      aria-label="{l s='Quantity for' d='Shop.Theme.Catalog'} {$product.name|escape:'html'}"
                    >
                    <button
                      type="button"
                      data-qty="inc"
                      style="background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;width:30px;height:30px;border-radius:6px;font-size:16px;cursor:pointer;display:flex;align-items:center;justify-content:center;"
                      aria-label="{l s='Increase quantity' d='Shop.Theme.Catalog'}"
                    >+</button>
                  </div>
                </div>

                {* Price *}
                <div style="text-align:right;flex-shrink:0;min-width:80px;">
                  <span style="font-size:18px;font-weight:700;color:#FFD700;display:block;">
                    {$product.total}
                  </span>
                  {if $product.cart_quantity > 1}
                    <span style="font-size:12px;color:#777;">{$product.price} {l s='each' d='Shop.Theme.Checkout'}</span>
                  {/if}
                </div>

                {* Remove *}
                <div>
                  <a
                    href="{$product.remove_from_cart_url}"
                    style="color:#555;display:flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:6px;border:1px solid #2a2a2a;transition:color .2s,border-color .2s;"
                    aria-label="{l s='Remove' d='Shop.Theme.Actions'} {$product.name|escape:'html'} {l s='from cart' d='Shop.Theme.Actions'}"
                    title="{l s='Remove' d='Shop.Theme.Actions'}"
                  >
                    <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M19 6.4L17.6 5 12 10.6 6.4 5 5 6.4 10.6 12 5 17.6 6.4 19 12 13.4 17.6 19 19 17.6 13.4 12z"/>
                    </svg>
                  </a>
                </div>

              </article>
            {/foreach}
          </div>

          {* Continue shopping *}
          <div style="margin-top:20px;">
            <a
              href="{$urls.pages.index}"
              style="font-size:14px;color:#b0b0b0;text-decoration:none;display:inline-flex;align-items:center;gap:6px;transition:color .2s;"
            >
              <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                <path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/>
              </svg>
              {l s='Continue shopping' d='Shop.Theme.Checkout'}
            </a>
          </div>
        </div>

        {* ── Order summary ────────────────────────────────────────────────── *}
        <aside
          aria-label="{l s='Order summary' d='Shop.Theme.Checkout'}"
          style="background:#161616;border:1px solid #2a2a2a;border-radius:12px;padding:24px;position:sticky;top:20px;"
        >
          <h2 style="font-size:18px;font-weight:700;color:#fff;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid #2a2a2a;">
            {l s='Order Summary' d='Shop.Theme.Checkout'}
          </h2>

          {if isset($cart_summary_subtotals)}
            {foreach from=$cart_summary_subtotals item=subtotal}
              {if $subtotal.value}
                <div style="display:flex;justify-content:space-between;margin-bottom:10px;">
                  <span style="font-size:14px;color:#b0b0b0;">{$subtotal.label}</span>
                  <span style="font-size:14px;color:#fff;">{$subtotal.value}</span>
                </div>
              {/if}
            {/foreach}
          {/if}

          {if isset($cart_summary_totals.total)}
            <div style="display:flex;justify-content:space-between;padding-top:16px;border-top:1px solid #2a2a2a;margin-top:8px;">
              <span style="font-size:16px;font-weight:700;color:#fff;">{l s='Total' d='Shop.Theme.Checkout'}</span>
              <span style="font-size:20px;font-weight:700;color:#FFD700;">{$cart_summary_totals.total}</span>
            </div>
          {/if}

          {* Promo code *}
          {hook h='displayShoppingCartFooter'}

          {* Checkout button *}
          <a
            href="{$urls.pages.order}"
            class="btn btn-primary"
            style="width:100%;margin-top:20px;justify-content:center;font-size:16px;padding:14px;"
            rel="nofollow"
          >
            {l s='Proceed to Checkout' d='Shop.Theme.Checkout'}
            <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
              <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
            </svg>
          </a>

          {* Payment icons *}
          <div class="payment-methods" style="margin-top:16px;justify-content:center;" role="list" aria-label="{l s='Accepted payment methods' d='Shop.Theme.Checkout'}">
            <span class="payment-methods__icon" role="listitem">VISA</span>
            <span class="payment-methods__icon" role="listitem">MC</span>
            <span class="payment-methods__icon" role="listitem">PP</span>
            <span class="payment-methods__icon" role="listitem">AMEX</span>
          </div>
        </aside>

      </div>{* /.grid *}

    {else}

      {* ── Empty cart ─────────────────────────────────────────────────────── *}
      <div style="text-align:center;padding:96px 0;" role="status">
        <svg aria-hidden="true" width="64" height="64" viewBox="0 0 24 24" fill="#2a2a2a" style="margin:0 auto 24px;">
          <path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z"/>
        </svg>
        <h2 style="font-size:22px;font-weight:600;color:#777;margin-bottom:12px;">
          {l s='Your cart is empty' d='Shop.Theme.Checkout'}
        </h2>
        <p style="color:#555;margin-bottom:24px;">
          {l s='Looks like you haven\'t added anything yet.' d='Shop.Theme.Checkout'}
        </p>
        <a href="{$urls.pages.index}" class="btn btn-primary">
          {l s='Start shopping' d='Shop.Theme.Checkout'}
        </a>
      </div>

    {/if}

  </div>
</section>

{/block}
