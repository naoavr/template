{**
 * layout-both-columns.tpl — Two-column layout with left and/or right sidebar
 *
 * Used for: category listing, product pages, CMS pages with sidebar widgets.
 *}
<!DOCTYPE html>
<html lang="{$language.iso_code|escape:'html'}" dir="{$language.is_rtl ? 'rtl' : 'ltr'}">

{include file='./_partials/head.tpl'}

<body class="page-{$page.page_name|default:'index'|escape:'html'} layout-both-columns" id="top">

  <a class="visually-hidden" href="#main-content">{l s='Skip to main content' d='Shop.Theme.Global'}</a>

  {include file='./_partials/header.tpl'}

  {* ── Notifications ─────────────────────────────────────────────────────── *}
  {if isset($notifications) && $notifications}
    <div class="container" role="alert" aria-live="polite">
      {foreach from=$notifications.success item=message}
        <div class="alert alert-success">{$message}</div>
      {/foreach}
      {foreach from=$notifications.error item=message}
        <div class="alert alert-danger">{$message}</div>
      {/foreach}
      {foreach from=$notifications.info item=message}
        <div class="alert alert-info">{$message}</div>
      {/foreach}
      {foreach from=$notifications.warning item=message}
        <div class="alert alert-warning">{$message}</div>
      {/foreach}
    </div>
  {/if}

  {block name='breadcrumb'}
    {include file='./_partials/breadcrumb.tpl'}
  {/block}

  <main id="main-content" role="main" tabindex="-1">
    <div class="container">
      <div class="layout-columns{if isset($left_column) && isset($right_column)} layout-columns--both{elseif isset($left_column)} layout-columns--left{elseif isset($right_column)} layout-columns--right{/if}">

        {* ── Left Sidebar ───────────────────────────────────────────────── *}
        {if isset($left_column)}
          <aside id="left-column" role="complementary" aria-label="{l s='Filters and navigation' d='Shop.Theme.Global'}">
            {block name='left_column'}
              {$left_column}
            {/block}
          </aside>
        {/if}

        {* ── Main Content ───────────────────────────────────────────────── *}
        <section>
          {block name='content'}{/block}
        </section>

        {* ── Right Sidebar ──────────────────────────────────────────────── *}
        {if isset($right_column)}
          <aside id="right-column" role="complementary" aria-label="{l s='Additional information' d='Shop.Theme.Global'}">
            {block name='right_column'}
              {$right_column}
            {/block}
          </aside>
        {/if}

      </div>
    </div>
  </main>

  {include file='./_partials/footer.tpl'}

  {block name='javascript_bottom'}
    {foreach from=$js_files item=js_uri}
      <script src="{$js_uri}" defer></script>
    {/foreach}
  {/block}

  {hook h='displayBeforeBodyClosingTag'}

</body>
</html>
