{**
 * product-card.tpl — Reusable product card component
 *
 * Used on: homepage sections, category listing, search results.
 *
 * Expected variables (PrestaShop product array keys):
 *   $product.id_product, $product.name, $product.link, $product.cover.bySize.home_default.url
 *   $product.cover.legend, $product.price, $product.regular_price,
 *   $product.discount_percentage, $product.new, $product.condition,
 *   $product.quantity, $product.description_short, $product.features (optional)
 *}

<article
  class="product-card"
  data-id-product="{$product.id_product|intval}"
  itemscope
  itemtype="https://schema.org/Product"
>

  {* ── Image ──────────────────────────────────────────────────────────────── *}
  <div class="product-card__image-wrap">
    <a href="{$product.url}" tabindex="-1" aria-hidden="true">
      {if isset($product.cover) && $product.cover}
        <img
          class="product-card__image"
          src="{$product.cover.bySize.home_default.url}"
          alt="{$product.cover.legend|default:$product.name|escape:'html'}"
          width="{$product.cover.bySize.home_default.width}"
          height="{$product.cover.bySize.home_default.height}"
          loading="lazy"
          itemprop="image"
        >
      {else}
        <div class="product-card__image-placeholder" aria-hidden="true">
          <svg width="48" height="48" viewBox="0 0 24 24" fill="currentColor">
            <path d="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z"/>
          </svg>
        </div>
      {/if}
    </a>

    {* ── Badges ────────────────────────────────────────────────────────── *}
    <div class="product-card__badges" aria-label="{l s='Product labels' d='Shop.Theme.Global'}">
      {if $product.new}
        <span class="badge badge--new">{l s='New' d='Shop.Theme.Catalog.Labels'}</span>
      {/if}
      {if isset($product.condition) && $product.condition === 'refurbished'}
        <span class="badge badge--sale">{l s='Refurbished' d='Shop.Theme.Catalog.Labels'}</span>
      {/if}
      {if $product.discount_percentage}
        <span class="badge badge--sale" aria-label="{l s='Discount' d='Shop.Theme.Catalog.Labels'} {$product.discount_percentage}">
          -{$product.discount_percentage}
        </span>
      {/if}
      {if $product.quantity <= 0}
        <span class="badge badge--out-of-stock">{l s='Out of stock' d='Shop.Theme.Catalog.Labels'}</span>
      {/if}
    </div>

    {* ── Wishlist toggle ───────────────────────────────────────────────── *}
    <button
      class="product-card__wishlist"
      type="button"
      aria-label="{l s='Add to wishlist' d='Shop.Theme.Global'}"
      aria-pressed="false"
      data-id-product="{$product.id_product|intval}"
    >
      <svg aria-hidden="true" focusable="false" width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
      </svg>
    </button>
  </div>

  {* ── Body ───────────────────────────────────────────────────────────────── *}
  <div class="product-card__body">

    {* Product name *}
    <a
      class="product-card__name"
      href="{$product.url}"
      itemprop="url"
      title="{$product.name|escape:'html'}"
    >
      <span itemprop="name">{$product.name|escape:'html'}</span>
    </a>

    {* Short feature list (from description_short stripped) *}
    {if isset($product.description_short) && $product.description_short}
      <ul class="product-card__features" aria-label="{l s='Key features' d='Shop.Theme.Global'}">
        {* Show max 3 bullet points extracted from short description *}
        {assign var='desc_clean' value=$product.description_short|strip_tags|truncate:120:'...'}
        <li>{$desc_clean}</li>
      </ul>
    {/if}

    {* Stock indicator *}
    <p class="product-card__stock
      {if $product.quantity > 5} product-card__stock--in-stock
      {elseif $product.quantity > 0} product-card__stock--low-stock
      {else} product-card__stock--out-of-stock{/if}"
      aria-live="polite"
    >
      {if $product.quantity > 5}
        {l s='In stock' d='Shop.Theme.Catalog'}
      {elseif $product.quantity > 0}
        {l s='Only' d='Shop.Theme.Catalog'} {$product.quantity} {l s='left' d='Shop.Theme.Catalog'}
      {else}
        {l s='Out of stock' d='Shop.Theme.Catalog'}
      {/if}
    </p>

    {* Pricing *}
    <div class="product-card__pricing" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
      <meta itemprop="priceCurrency" content="{$currency.iso_code}">
      <span class="product-card__price" itemprop="price" content="{$product.price_amount}">
        {$product.price}
      </span>
      {if $product.regular_price_amount && $product.regular_price_amount > $product.price_amount}
        <span class="product-card__price-original" aria-label="{l s='Original price' d='Shop.Theme.Catalog'}">
          {$product.regular_price}
        </span>
      {/if}
      {if $product.discount_percentage}
        <span class="product-card__discount" aria-label="{l s='You save' d='Shop.Theme.Catalog'}">
          -{$product.discount_percentage}
        </span>
      {/if}
      <link itemprop="availability" href="https://schema.org/{if $product.quantity > 0}InStock{else}OutOfStock{/if}">
    </div>

  </div>{* /.product-card__body *}

  {* ── Actions ────────────────────────────────────────────────────────────── *}
  <div class="product-card__actions">
    {if $product.quantity > 0}
      <button
        class="btn-cart"
        type="button"
        data-button-action="add-to-cart"
        data-id-product="{$product.id_product|intval}"
        data-id-product-attribute="{$product.id_product_attribute|intval}"
        {if $product.add_to_cart_url}
          data-url="{$product.add_to_cart_url}"
        {/if}
        aria-label="{l s='Add' d='Shop.Theme.Actions'} {$product.name|escape:'html'} {l s='to cart' d='Shop.Theme.Actions'}"
      >
        <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
          <path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z"/>
        </svg>
        {l s='Add to cart' d='Shop.Theme.Actions'}
      </button>
    {else}
      <button class="btn-cart" type="button" disabled aria-disabled="true">
        {l s='Out of stock' d='Shop.Theme.Catalog'}
      </button>
    {/if}
    <a
      class="btn-details"
      href="{$product.url}"
      aria-label="{l s='View details for' d='Shop.Theme.Actions'} {$product.name|escape:'html'}"
    >
      {l s='Details' d='Shop.Theme.Actions'}
    </a>
  </div>

</article>
