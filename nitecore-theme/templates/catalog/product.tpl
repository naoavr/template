{**
 * catalog/product.tpl — Single product detail page
 *
 * Extends layout-both-columns.tpl.
 * Variables: $product, $product_images, $product_features, $product_attachments,
 *            $combinations, $accessories
 *}

{extends file='layouts/layout-both-columns.tpl'}

{block name='content'}

<div
  class="product-detail"
  itemscope
  itemtype="https://schema.org/Product"
  aria-label="{l s='Product details' d='Shop.Theme.Catalog'}"
>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:48px;align-items:start;" class="product-detail__grid">

    {* ── Left: Images ─────────────────────────────────────────────────────── *}
    <div class="product-detail__gallery">

      {* Main image *}
      <div
        style="position:relative;background:#161616;border:1px solid #2a2a2a;border-radius:12px;overflow:hidden;aspect-ratio:1/1;margin-bottom:16px;"
        id="product-main-image"
      >
        {if isset($product.cover) && $product.cover}
          <img
            src="{$product.cover.bySize.large_default.url}"
            alt="{$product.cover.legend|default:$product.name|escape:'html'}"
            id="product-main-img"
            style="width:100%;height:100%;object-fit:contain;"
            loading="eager"
            itemprop="image"
          >
        {/if}

        {* Discount badge *}
        {if $product.discount_percentage}
          <span
            class="badge badge--sale"
            style="position:absolute;top:16px;left:16px;font-size:14px;padding:4px 10px;"
          >
            -{$product.discount_percentage}
          </span>
        {/if}
        {if $product.new}
          <span
            class="badge badge--new"
            style="position:absolute;top:16px;left:{if $product.discount_percentage}80{else}16{/if}px;font-size:14px;padding:4px 10px;"
          >
            {l s='New' d='Shop.Theme.Catalog.Labels'}
          </span>
        {/if}
      </div>

      {* Thumbnails *}
      {if isset($product_images) && $product_images|@count > 1}
        <div
          style="display:flex;gap:8px;flex-wrap:wrap;"
          role="list"
          aria-label="{l s='Product images' d='Shop.Theme.Catalog'}"
        >
          {foreach from=$product_images item=image}
            <button
              type="button"
              role="listitem"
              onclick="document.getElementById('product-main-img').src='{$image.bySize.medium_default.url}'"
              style="background:#161616;border:1px solid #2a2a2a;border-radius:6px;overflow:hidden;width:72px;height:72px;cursor:pointer;padding:0;transition:border-color 0.2s;"
              aria-label="{$image.legend|default:$product.name|escape:'html'}"
            >
              <img
                src="{$image.bySize.small_default.url}"
                alt="{$image.legend|default:$product.name|escape:'html'}"
                style="width:100%;height:100%;object-fit:contain;"
                loading="lazy"
              >
            </button>
          {/foreach}
        </div>
      {/if}

    </div>{* /.product-detail__gallery *}

    {* ── Right: Info & Add to cart ───────────────────────────────────────── *}
    <div class="product-detail__info">

      {* Brand / Reference *}
      {if $product.reference}
        <p style="font-size:12px;color:#777;margin-bottom:8px;" itemprop="sku">
          {l s='Ref:' d='Shop.Theme.Catalog'} {$product.reference|escape:'html'}
        </p>
      {/if}

      {* Name *}
      <h1
        style="font-size:28px;font-weight:700;color:#fff;line-height:1.2;margin-bottom:16px;"
        itemprop="name"
      >
        {$product.name|escape:'html'}
      </h1>

      {* Rating (hook) *}
      {hook h='displayProductAdditionalInfo' product=$product}

      {* Price *}
      <div
        style="display:flex;align-items:baseline;gap:12px;margin-bottom:24px;flex-wrap:wrap;"
        itemprop="offers"
        itemscope
        itemtype="https://schema.org/Offer"
      >
        <meta itemprop="priceCurrency" content="{$currency.iso_code}">
        <span
          style="font-size:32px;font-weight:700;color:#FFD700;"
          itemprop="price"
          content="{$product.price_amount}"
        >
          {$product.price}
        </span>
        {if $product.regular_price_amount && $product.regular_price_amount > $product.price_amount}
          <span style="font-size:18px;color:#777;text-decoration:line-through;">
            {$product.regular_price}
          </span>
          <span style="font-size:14px;font-weight:700;color:#FF4444;background:rgba(255,68,68,.15);padding:3px 8px;border-radius:4px;">
            -{$product.discount_percentage}
          </span>
        {/if}
        <link
          itemprop="availability"
          href="https://schema.org/{if $product.quantity > 0}InStock{else}OutOfStock{/if}"
        >
      </div>

      {* Short description *}
      {if $product.description_short}
        <div
          style="font-size:15px;color:#b0b0b0;line-height:1.7;margin-bottom:24px;"
          itemprop="description"
        >
          {$product.description_short}
        </div>
      {/if}

      {* Combinations / variants *}
      {if isset($groups) && $groups}
        {foreach from=$groups item=group key=id_attribute_group}
          <div style="margin-bottom:20px;">
            <p style="font-size:13px;font-weight:600;color:#b0b0b0;margin-bottom:8px;text-transform:uppercase;letter-spacing:.5px;">
              {$group.name}
            </p>
            <div style="display:flex;gap:8px;flex-wrap:wrap;">
              {foreach from=$group.attributes item=attribute key=id_attribute}
                <label
                  style="cursor:pointer;"
                  title="{$attribute.name|escape:'html'}"
                >
                  <input
                    type="radio"
                    name="group[{$id_attribute_group}]"
                    value="{$id_attribute}"
                    class="visually-hidden"
                    {if $attribute.selected}checked{/if}
                  >
                  <span
                    style="display:inline-flex;align-items:center;justify-content:center;padding:6px 14px;background:#1a1a1a;border:1.5px solid {if $attribute.selected}#FFD700{else}#2a2a2a{/if};border-radius:6px;font-size:13px;color:{if $attribute.selected}#FFD700{else}#b0b0b0{/if};transition:border-color .2s,color .2s;"
                  >
                    {$attribute.name|escape:'html'}
                  </span>
                </label>
              {/foreach}
            </div>
          </div>
        {/foreach}
      {/if}

      {* Stock *}
      <p
        style="font-size:13px;font-weight:500;margin-bottom:20px;display:flex;align-items:center;gap:6px;"
        aria-live="polite"
      >
        {if $product.quantity > 0}
          <span style="width:8px;height:8px;background:#28a745;border-radius:50%;display:inline-block;"></span>
          <span style="color:#28a745;">{l s='In stock' d='Shop.Theme.Catalog'}</span>
          {if $product.quantity < 10}
            <span style="color:#777;">— {l s='Only' d='Shop.Theme.Catalog'} {$product.quantity} {l s='left' d='Shop.Theme.Catalog'}</span>
          {/if}
        {else}
          <span style="width:8px;height:8px;background:#777;border-radius:50%;display:inline-block;"></span>
          <span style="color:#777;">{l s='Out of stock' d='Shop.Theme.Catalog'}</span>
        {/if}
      </p>

      {* Quantity + Add to cart *}
      <form
        id="add-to-cart-form"
        action="{$urls.pages.cart}"
        method="post"
        style="margin-bottom:24px;"
      >
        <input type="hidden" name="token" value="{$static_token}">
        <input type="hidden" name="id_product" value="{$product.id_product|intval}">
        {if isset($product.id_product_attribute)}
          <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute|intval}">
        {/if}

        <div style="display:flex;gap:12px;align-items:center;margin-bottom:16px;" data-qty-wrap>
          <label for="product-qty" class="visually-hidden">{l s='Quantity' d='Shop.Theme.Catalog'}</label>
          <button type="button" data-qty="dec" style="background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;width:40px;height:40px;border-radius:8px;font-size:18px;cursor:pointer;display:flex;align-items:center;justify-content:center;" aria-label="{l s='Decrease quantity' d='Shop.Theme.Catalog'}">−</button>
          <input
            id="product-qty"
            type="number"
            name="qty"
            value="1"
            min="1"
            max="{$product.quantity}"
            step="1"
            style="width:64px;text-align:center;background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;border-radius:8px;padding:8px;font-size:16px;font-family:inherit;"
            aria-label="{l s='Quantity' d='Shop.Theme.Catalog'}"
          >
          <button type="button" data-qty="inc" style="background:#1a1a1a;border:1px solid #2a2a2a;color:#fff;width:40px;height:40px;border-radius:8px;font-size:18px;cursor:pointer;display:flex;align-items:center;justify-content:center;" aria-label="{l s='Increase quantity' d='Shop.Theme.Catalog'}">+</button>
        </div>

        <div style="display:flex;gap:12px;flex-wrap:wrap;">
          {if $product.quantity > 0}
            <button
              type="submit"
              name="add"
              class="btn btn-primary btn-lg"
              data-button-action="add-to-cart"
              style="flex:1;min-width:180px;"
            >
              <svg aria-hidden="true" focusable="false" width="18" height="18" viewBox="0 0 24 24" fill="currentColor" style="flex-shrink:0;">
                <path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z"/>
              </svg>
              {l s='Add to cart' d='Shop.Theme.Actions'}
            </button>
          {else}
            <button type="button" class="btn btn-secondary btn-lg" disabled aria-disabled="true" style="flex:1;min-width:180px;">
              {l s='Out of stock' d='Shop.Theme.Catalog'}
            </button>
          {/if}

          <button
            type="button"
            class="product-card__wishlist"
            style="width:48px;height:48px;border-radius:8px;border:1px solid #2a2a2a;background:#1a1a1a;color:#777;cursor:pointer;display:flex;align-items:center;justify-content:center;transition:all .2s;flex-shrink:0;"
            aria-label="{l s='Add to wishlist' d='Shop.Theme.Global'}"
            aria-pressed="false"
            data-id-product="{$product.id_product|intval}"
          >
            <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>
          </button>
        </div>

      </form>

      {* Trust badges under add-to-cart *}
      <div style="display:flex;gap:16px;padding:16px 0;border-top:1px solid #2a2a2a;flex-wrap:wrap;">
        <span style="font-size:12px;color:#777;display:flex;align-items:center;gap:4px;">
          <svg aria-hidden="true" width="14" height="14" viewBox="0 0 24 24" fill="#FFD700"><path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/></svg>
          {l s='Secure payment' d='Shop.Theme.Global'}
        </span>
        <span style="font-size:12px;color:#777;display:flex;align-items:center;gap:4px;">
          <svg aria-hidden="true" width="14" height="14" viewBox="0 0 24 24" fill="#FFD700"><path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.7 1.3 3 3 3s3-1.3 3-3h6c0 1.7 1.3 3 3 3s3-1.3 3-3h2v-5l-3-4z"/></svg>
          {l s='Free shipping over €99' d='Shop.Theme.Global'}
        </span>
        <span style="font-size:12px;color:#777;display:flex;align-items:center;gap:4px;">
          <svg aria-hidden="true" width="14" height="14" viewBox="0 0 24 24" fill="#FFD700"><path d="M19 8l-4 4h3c0 3.31-2.69 6-6 6-1.01 0-1.97-.25-2.8-.7l-1.46 1.46C8.97 19.54 10.43 20 12 20c4.42 0 8-3.58 8-8h3l-4-4z"/></svg>
          {l s='30-day returns' d='Shop.Theme.Global'}
        </span>
      </div>

    </div>{* /.product-detail__info *}
  </div>{* /.product-detail__grid *}

  {* ── Product Tabs: Description, Features, Reviews ─────────────────────── *}
  <div style="margin-top:64px;" class="product-tabs">
    <div
      role="tablist"
      style="display:flex;border-bottom:1px solid #2a2a2a;gap:0;margin-bottom:32px;"
      aria-label="{l s='Product information tabs' d='Shop.Theme.Catalog'}"
    >
      <button
        role="tab"
        aria-selected="true"
        aria-controls="tab-description"
        id="tab-btn-description"
        style="background:none;border:none;border-bottom:2px solid #FFD700;color:#FFD700;font-size:14px;font-weight:600;padding:12px 20px;cursor:pointer;font-family:inherit;margin-bottom:-1px;"
      >
        {l s='Description' d='Shop.Theme.Catalog'}
      </button>
      {if isset($product_features) && $product_features}
        <button
          role="tab"
          aria-selected="false"
          aria-controls="tab-features"
          id="tab-btn-features"
          style="background:none;border:none;border-bottom:2px solid transparent;color:#b0b0b0;font-size:14px;font-weight:600;padding:12px 20px;cursor:pointer;font-family:inherit;margin-bottom:-1px;transition:color .2s,border-color .2s;"
        >
          {l s='Specifications' d='Shop.Theme.Catalog'}
        </button>
      {/if}
      {hook h='displayProductTabContent' product=$product}
    </div>

    <div id="tab-description" role="tabpanel" aria-labelledby="tab-btn-description" style="color:#b0b0b0;line-height:1.8;">
      {if $product.description}
        {$product.description}
      {else}
        <p style="color:#777;">{l s='No description available.' d='Shop.Theme.Catalog'}</p>
      {/if}
    </div>

    {if isset($product_features) && $product_features}
      <div id="tab-features" role="tabpanel" aria-labelledby="tab-btn-features" hidden>
        <table style="width:100%;border-collapse:collapse;font-size:14px;" aria-label="{l s='Product specifications' d='Shop.Theme.Catalog'}">
          <tbody>
            {foreach from=$product_features item=feature}
              <tr style="border-bottom:1px solid #2a2a2a;">
                <th style="text-align:left;padding:12px 0;color:#b0b0b0;font-weight:600;width:40%;" scope="row">
                  {$feature.name|escape:'html'}
                </th>
                <td style="padding:12px 0;color:#fff;">
                  {$feature.value|escape:'html'}
                </td>
              </tr>
            {/foreach}
          </tbody>
        </table>
      </div>
    {/if}
  </div>

  {* ── Accessories / Related products ────────────────────────────────────── *}
  {if isset($accessories) && $accessories}
    <section style="margin-top:64px;" aria-labelledby="accessories-title">
      <div class="section-header">
        <h2 class="section-header__title" id="accessories-title">
          {l s='Accessories' d='Shop.Theme.Catalog'}
        </h2>
      </div>
      <div class="products-grid" role="list">
        {foreach from=$accessories item=product}
          <div role="listitem">
            {include file='../_partials/product-card.tpl' product=$product}
          </div>
        {/foreach}
      </div>
    </section>
  {/if}

</div>{* /.product-detail *}

{* Tab switching is handled by theme.js initProductTabs() *}

{/block}
