{**
 * breadcrumb.tpl — Breadcrumb navigation
 *
 * Renders an accessible, schema.org-annotated breadcrumb trail.
 * Variables: $breadcrumb.links (array of {title, url})
 *}

{if isset($breadcrumb.links) && $breadcrumb.links|@count > 1}
  <nav class="breadcrumb-nav" aria-label="{l s='You are here' d='Shop.Theme.Global'}">
    <div class="container">
      <ol
        class="breadcrumb"
        itemscope
        itemtype="https://schema.org/BreadcrumbList"
      >
        {foreach from=$breadcrumb.links item=link name=bc}
          <li
            itemprop="itemListElement"
            itemscope
            itemtype="https://schema.org/ListItem"
            {if $smarty.foreach.bc.last}aria-current="page"{/if}
          >
            {if not $smarty.foreach.bc.last}
              <a
                href="{$link.url}"
                itemprop="item"
                aria-label="{$link.title|escape:'html'}"
              >
                <span itemprop="name">{$link.title|escape:'html'}</span>
              </a>
            {else}
              <span itemprop="name">{$link.title|escape:'html'}</span>
            {/if}
            <meta itemprop="position" content="{$smarty.foreach.bc.iteration}">
          </li>
        {/foreach}
      </ol>
    </div>
  </nav>
{/if}
