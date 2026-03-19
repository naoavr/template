{**
 * head.tpl — HTML <head> partial
 *
 * Outputs meta tags, title, canonical URL, Open Graph tags, CSS links,
 * and the Web Font preconnect. Extend or override this block in child layouts.
 *
 * Available variables (standard PrestaShop):
 *   $meta_title, $meta_description, $meta_keywords, $canonicalURL,
 *   $og_image, $css_files, $js_def, $shop.name, $shop.logo, $language.iso_code
 *}

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  {* ── Title ─────────────────────────────────────────────────────────────── *}
  <title>{block name='head_title'}{$meta_title|escape:'html'}{/block}</title>

  {* ── SEO meta ──────────────────────────────────────────────────────────── *}
  {if isset($meta_description) && $meta_description}
    <meta name="description" content="{$meta_description|escape:'html'}">
  {/if}
  {if isset($meta_keywords) && $meta_keywords}
    <meta name="keywords" content="{$meta_keywords|escape:'html'}">
  {/if}
  {if isset($canonicalURL) && $canonicalURL}
    <link rel="canonical" href="{$canonicalURL|escape:'html'}">
  {/if}

  {* ── Robots ────────────────────────────────────────────────────────────── *}
  {block name='head_robots'}
    <meta name="robots" content="index,follow">
  {/block}

  {* ── Open Graph ────────────────────────────────────────────────────────── *}
  <meta property="og:type"        content="website">
  <meta property="og:site_name"   content="{$shop.name|escape:'html'}">
  <meta property="og:title"       content="{$meta_title|escape:'html'}">
  {if isset($meta_description) && $meta_description}
    <meta property="og:description" content="{$meta_description|escape:'html'}">
  {/if}
  {if isset($og_image) && $og_image}
    <meta property="og:image" content="{$og_image|escape:'html'}">
  {/if}

  {* ── Favicon ───────────────────────────────────────────────────────────── *}
  {if isset($favicon) && $favicon}
    <link rel="icon" type="image/x-icon" href="{$favicon|escape:'html'}">
  {/if}

  {* ── Web Fonts preconnect ──────────────────────────────────────────────── *}
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
    rel="stylesheet"
  >

  {* ── Swiper CSS (CDN, only on pages that use the slider) ───────────────── *}
  {block name='head_swiper'}
  {/block}

  {* ── Theme CSS ─────────────────────────────────────────────────────────── *}
  {block name='head_css'}
    {foreach from=$css_files item=css_uri key=media}
      <link rel="stylesheet" href="{$css_uri}" media="{$media}">
    {/foreach}
  {/block}

  {* ── Inline JS definitions (PrestaShop globals) ────────────────────────── *}
  {if isset($js_def)}
    <script>
      var prestashop = {$js_def|json_encode};
    </script>
  {/if}

  {* ── Extra head content from hooks ─────────────────────────────────────── *}
  {hook h='displayHeader'}
  {hook h='displayBeforeBodyClosingTag' position='head'}

  {* ── Allow child templates to inject extra <head> content ──────────────── *}
  {block name='head_extra'}{/block}
</head>
