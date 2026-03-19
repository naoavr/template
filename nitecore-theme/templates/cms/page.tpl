{**
 * cms/page.tpl — Generic CMS content page (Privacy policy, Terms, About, etc.)
 *
 * Extends layout-both-columns.tpl.
 * Variables: $cms (PrestaShop CMS page object with .content, .meta_title, etc.)
 *}

{extends file='layouts/layout-both-columns.tpl'}

{block name='content'}

<article
  class="cms-page"
  itemscope
  itemtype="https://schema.org/Article"
  aria-label="{$cms.meta_title|escape:'html'}"
  style="padding:32px 0;"
>

  {* ── Page title ────────────────────────────────────────────────────────── *}
  <header style="margin-bottom:32px;padding-bottom:24px;border-bottom:1px solid #2a2a2a;">
    <h1
      style="font-size:28px;font-weight:700;color:#fff;line-height:1.2;"
      itemprop="headline"
    >
      {$cms.meta_title|escape:'html'}
    </h1>
  </header>

  {* ── Body content ──────────────────────────────────────────────────────── *}
  <div
    class="cms-content"
    itemprop="articleBody"
    style="
      font-size:15px;
      line-height:1.8;
      color:#b0b0b0;
      max-width:860px;
    "
  >
    {* Smarty outputs HTML from the back-office WYSIWYG editor *}
    {$cms.content nofilter}
  </div>

  {* ── Hook for modules (social share, etc.) ──────────────────────────────── *}
  {hook h='displayCMSPrintButton'}
  {hook h='displayCMSDisputeInformation'}

</article>

{/block}
