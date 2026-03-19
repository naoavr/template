{**
 * layout-full-width.tpl — Full-width page layout (no sidebar)
 *
 * Used for: homepage, landing pages, CMS pages that need full-width content.
 * All content from {block name='content'} stretches the full container width.
 *}
<!DOCTYPE html>
<html lang="{$language.iso_code|escape:'html'}" dir="{$language.is_rtl ? 'rtl' : 'ltr'}">

{include file='./_partials/head.tpl'}

<body class="page-{$page.page_name|default:'index'|escape:'html'} layout-full-width" id="top">

  {* ── Skip navigation link (accessibility) ─────────────────────────────── *}
  <a class="visually-hidden" href="#main-content">{l s='Skip to main content' d='Shop.Theme.Global'}</a>

  {* ── Header ────────────────────────────────────────────────────────────── *}
  {include file='./_partials/header.tpl'}

  {* ── Notifications / Alerts ────────────────────────────────────────────── *}
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

  {* ── Breadcrumb ────────────────────────────────────────────────────────── *}
  {block name='breadcrumb'}
    {include file='./_partials/breadcrumb.tpl'}
  {/block}

  {* ── Main content ──────────────────────────────────────────────────────── *}
  <main id="main-content" role="main" tabindex="-1">
    {block name='content'}{/block}
  </main>

  {* ── Footer ────────────────────────────────────────────────────────────── *}
  {include file='./_partials/footer.tpl'}

  {* ── JavaScript ────────────────────────────────────────────────────────── *}
  {block name='javascript_bottom'}
    {foreach from=$js_files item=js_uri}
      <script src="{$js_uri}" defer></script>
    {/foreach}
  {/block}

  {hook h='displayBeforeBodyClosingTag'}

</body>
</html>
