{**
 * catalog/listing/product-list.tpl — Category / search results listing page
 *
 * Extends layout-both-columns.tpl (sidebar for filters).
 * Variables: $listing (PrestaShop product listing object), $category, $sort_orders,
 *            $pagination, $current_url
 *}

{extends file='layouts/layout-both-columns.tpl'}

{block name='content'}

<div class="product-listing-page" aria-label="{l s='Product listing' d='Shop.Theme.Catalog'}">

  {* ── Page heading ─────────────────────────────────────────────────────── *}
  {if isset($category) && $category.name}
    <header class="listing-header" style="margin-bottom:24px;">
      <h1 style="font-size:28px;font-weight:700;color:#fff;margin-bottom:8px;">
        {$category.name|escape:'html'}
      </h1>
      {if $category.description}
        <div style="font-size:14px;color:#b0b0b0;max-width:700px;">
          {$category.description}
        </div>
      {/if}
    </header>
  {/if}

  {* ── Toolbar: sort, results count ───────────────────────────────────────── *}
  <div
    class="listing-toolbar"
    style="display:flex;align-items:center;justify-content:space-between;gap:16px;margin-bottom:24px;padding:12px 16px;background:#161616;border:1px solid #2a2a2a;border-radius:8px;"
    aria-label="{l s='Product sorting options' d='Shop.Theme.Catalog'}"
  >
    {if isset($listing.products_count)}
      <p style="font-size:14px;color:#b0b0b0;margin:0;">
        <strong style="color:#fff;">{$listing.products_count}</strong>
        {l s='products' d='Shop.Theme.Catalog'}
      </p>
    {/if}

    {if isset($sort_orders)}
      <div style="display:flex;align-items:center;gap:8px;">
        <label for="sort-select" style="font-size:14px;color:#b0b0b0;white-space:nowrap;">
          {l s='Sort by:' d='Shop.Theme.Catalog'}
        </label>
        <select
          id="sort-select"
          name="order"
          class="form-control"
          style="width:auto;min-width:160px;"
          aria-label="{l s='Sort products' d='Shop.Theme.Catalog'}"
        >
          {foreach from=$sort_orders item=sort_order}
            <option
              value="{$sort_order.urlParameter.value}"
              {if $sort_order.current}selected{/if}
            >
              {$sort_order.label}
            </option>
          {/foreach}
        </select>
      </div>
    {/if}
  </div>

  {* ── Active filters ─────────────────────────────────────────────────────── *}
  {hook h='displayActiveFilters'}

  {* ── Product grid ───────────────────────────────────────────────────────── *}
  {if isset($listing.products) && $listing.products}
    <div
      class="products-grid"
      id="js-product-list"
      role="list"
      aria-label="{l s='Products' d='Shop.Theme.Catalog'}"
      aria-live="polite"
    >
      {foreach from=$listing.products item=product}
        <div role="listitem">
          {include file='../_partials/product-card.tpl' product=$product}
        </div>
      {/foreach}
    </div>
  {else}
    <p style="color:#777;text-align:center;padding:48px 0;" role="status">
      {l s='No products match your selection.' d='Shop.Theme.Catalog'}
    </p>
  {/if}

  {* ── Pagination ─────────────────────────────────────────────────────────── *}
  {if isset($pagination) && $pagination.pages_count > 1}
    <nav
      class="pagination-nav"
      role="navigation"
      aria-label="{l s='Page navigation' d='Shop.Theme.Catalog'}"
      style="margin-top:32px;"
    >
      <ul class="pagination">
        {if $pagination.current_page > 1}
          <li class="page-item">
            <a class="page-link" href="{$pagination.pages[0].url}" aria-label="{l s='First page' d='Shop.Theme.Catalog'}">&laquo;</a>
          </li>
        {/if}

        {foreach from=$pagination.pages item=page}
          <li class="page-item{if $page.current} active{/if}">
            {if $page.current}
              <span class="page-link" aria-current="page" aria-label="{l s='Page' d='Shop.Theme.Catalog'} {$page.page}">{$page.page}</span>
            {else}
              <a class="page-link" href="{$page.url}" aria-label="{l s='Page' d='Shop.Theme.Catalog'} {$page.page}">{$page.page}</a>
            {/if}
          </li>
        {/foreach}

        {if $pagination.current_page < $pagination.pages_count}
          <li class="page-item">
            <a class="page-link" href="{$pagination.pages[$pagination.pages_count-1].url}" aria-label="{l s='Last page' d='Shop.Theme.Catalog'}">&raquo;</a>
          </li>
        {/if}
      </ul>
    </nav>
  {/if}

</div>

{/block}
