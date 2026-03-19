{**
 * hero-slider.tpl — Homepage hero banner slider (Swiper.js)
 *
 * Expects a $slides array with keys:
 *   image, image_alt, eyebrow, title, title_highlight, subtitle, cta_label, cta_url,
 *   cta2_label (optional), cta2_url (optional)
 *
 * Falls back to static demo slides when $slides is empty.
 *}

{* Include Swiper CSS from CDN *}
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">

<section class="hero-section" aria-label="{l s='Featured promotions' d='Shop.Theme.Global'}">

  <div class="hero-swiper swiper" aria-roledescription="carousel">

    <div class="swiper-wrapper">

      {if isset($slides) && $slides}
        {foreach from=$slides item=slide name=slider}
          <div
            class="swiper-slide hero-slide"
            role="group"
            aria-roledescription="slide"
            aria-label="{$smarty.foreach.slider.iteration} / {$slides|@count}"
          >
            <img
              class="hero-slide__image"
              src="{$slide.image|escape:'html'}"
              alt="{$slide.image_alt|escape:'html'}"
              {if $smarty.foreach.slider.first}loading="eager"{else}loading="lazy"{/if}
              width="1920"
              height="600"
            >

            <div class="hero-content container">
              {if isset($slide.eyebrow) && $slide.eyebrow}
                <span class="hero-content__eyebrow">{$slide.eyebrow|escape:'html'}</span>
              {/if}
              <h2 class="hero-content__title">
                {$slide.title|escape:'html'}
                {if isset($slide.title_highlight) && $slide.title_highlight}
                  <span>{$slide.title_highlight|escape:'html'}</span>
                {/if}
              </h2>
              {if isset($slide.subtitle) && $slide.subtitle}
                <p class="hero-content__subtitle">{$slide.subtitle|escape:'html'}</p>
              {/if}
              <div class="hero-content__actions">
                <a class="btn-hero-primary" href="{$slide.cta_url|escape:'html'}">
                  {$slide.cta_label|escape:'html'}
                  <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
                  </svg>
                </a>
                {if isset($slide.cta2_label) && $slide.cta2_label}
                  <a class="btn-hero-secondary" href="{$slide.cta2_url|escape:'html'}">
                    {$slide.cta2_label|escape:'html'}
                  </a>
                {/if}
              </div>
            </div>

          </div>{* /.swiper-slide *}
        {/foreach}

      {else}

        {* ── Default / demo slides (no data from back-office) ────────────── *}
        <div class="swiper-slide hero-slide" role="group" aria-roledescription="slide" aria-label="1 / 2">
          <div style="width:100%;height:100%;background:linear-gradient(135deg,#111 0%,#1a1a1a 100%);display:flex;align-items:center;" aria-hidden="true"></div>
          <div class="hero-content container">
            <span class="hero-content__eyebrow">{l s='New Arrival' d='Shop.Theme.Global'}</span>
            <h2 class="hero-content__title">
              {l s='Unleash the' d='Shop.Theme.Global'}
              <span>{l s='Power of Light' d='Shop.Theme.Global'}</span>
            </h2>
            <p class="hero-content__subtitle">
              {l s='Professional-grade flashlights engineered for extreme performance.' d='Shop.Theme.Global'}
            </p>
            <div class="hero-content__actions">
              <a class="btn-hero-primary" href="{$urls.pages.index}">
                {l s='Shop Now' d='Shop.Theme.Global'}
                <svg aria-hidden="true" focusable="false" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
                </svg>
              </a>
              <a class="btn-hero-secondary" href="{$urls.pages.index}">
                {l s='Discover More' d='Shop.Theme.Global'}
              </a>
            </div>
          </div>
        </div>

        <div class="swiper-slide hero-slide" role="group" aria-roledescription="slide" aria-label="2 / 2">
          <div style="width:100%;height:100%;background:linear-gradient(135deg,#0a0a0a 0%,#222 100%);display:flex;align-items:center;" aria-hidden="true"></div>
          <div class="hero-content container">
            <span class="hero-content__eyebrow">{l s='Best Sellers' d='Shop.Theme.Global'}</span>
            <h2 class="hero-content__title">
              {l s='Trusted by' d='Shop.Theme.Global'}
              <span>{l s='Professionals' d='Shop.Theme.Global'}</span>
            </h2>
            <p class="hero-content__subtitle">
              {l s='Explore our most popular tactical and EDC flashlight series.' d='Shop.Theme.Global'}
            </p>
            <div class="hero-content__actions">
              <a class="btn-hero-primary" href="{$urls.pages.index}">
                {l s='View Best Sellers' d='Shop.Theme.Global'}
              </a>
            </div>
          </div>
        </div>

      {/if}

    </div>{* /.swiper-wrapper *}

    {* Navigation arrows *}
    <button class="swiper-button-prev" aria-label="{l s='Previous slide' d='Shop.Theme.Global'}"></button>
    <button class="swiper-button-next" aria-label="{l s='Next slide' d='Shop.Theme.Global'}"></button>

    {* Pagination dots *}
    <div class="swiper-pagination" role="tablist" aria-label="{l s='Slide navigation' d='Shop.Theme.Global'}"></div>

  </div>{* /.hero-swiper *}

  {* ── Trust feature strip ─────────────────────────────────────────────── *}
  <div class="hero-features" aria-label="{l s='Key benefits' d='Shop.Theme.Global'}">
    <ul class="hero-features__list" role="list">
      <li class="hero-features__item">
        <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M20 8h-3V4H3c-1.1 0-2 .9-2 2v11h2c0 1.7 1.3 3 3 3s3-1.3 3-3h6c0 1.7 1.3 3 3 3s3-1.3 3-3h2v-5l-3-4zm-1 1l1.96 2.5H17V9h2zM6 18.5c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5 1.5.7 1.5 1.5-.7 1.5-1.5 1.5zm13.5-9.5V9.5h2.5L20 9.5zM18 18.5c-.8 0-1.5-.7-1.5-1.5s.7-1.5 1.5-1.5 1.5.7 1.5 1.5-.7 1.5-1.5 1.5z"/>
        </svg>
        {l s='Free shipping over €99' d='Shop.Theme.Global'}
      </li>
      <li class="hero-features__item">
        <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4z"/>
        </svg>
        {l s='2-year warranty' d='Shop.Theme.Global'}
      </li>
      <li class="hero-features__item">
        <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M19 8l-4 4h3c0 3.31-2.69 6-6 6-1.01 0-1.97-.25-2.8-.7l-1.46 1.46C8.97 19.54 10.43 20 12 20c4.42 0 8-3.58 8-8h3l-4-4zM6 12c0-3.31 2.69-6 6-6 1.01 0 1.97.25 2.8.7l1.46-1.46C15.03 4.46 13.57 4 12 4c-4.42 0-8 3.58-8 8H1l4 4 4-4H6z"/>
        </svg>
        {l s='30-day free returns' d='Shop.Theme.Global'}
      </li>
      <li class="hero-features__item">
        <svg aria-hidden="true" focusable="false" width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
        </svg>
        {l s='Expert support 7 days' d='Shop.Theme.Global'}
      </li>
    </ul>
  </div>

</section>

{* Swiper JS (deferred) *}
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js" defer></script>
