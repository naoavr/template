{**
 * newsletter-block.tpl — Email subscription block
 *
 * Used in: footer, homepage.
 * Rendered by the ps_emailsubscription module hook (displayFooter / displayHome).
 * This template provides the visual wrapper; the module hook handles the form action.
 *}

<section class="newsletter-section" aria-labelledby="newsletter-title">
  <div class="container">
    <div class="newsletter-section__inner">

      <div class="newsletter-section__text">
        <h2 class="newsletter-section__title" id="newsletter-title">
          {l s='Subscribe to our' d='Shop.Theme.Global'}
          <span>{l s='Newsletter' d='Shop.Theme.Global'}</span>
        </h2>
        <p class="newsletter-section__desc">
          {l s='Get exclusive deals, new product announcements and expert lighting tips.' d='Shop.Theme.Global'}
        </p>
      </div>

      {* The actual form is provided by the ps_emailsubscription module hook.
         Wrap it so the module output is styled correctly. *}
      <div class="newsletter-section__form" role="search" aria-label="{l s='Newsletter signup' d='Shop.Theme.Global'}">
        {hook h='displayGDPRConsent' id_module=26}
        {hook h='displayNewsletterRegistration'}

        {* Fallback static form (shown if the module is not installed) *}
        {if !hook_executed}
          <form
            method="post"
            action="{$urls.pages.index}"
            class="newsletter-section__form"
            aria-label="{l s='Newsletter subscription form' d='Shop.Theme.Global'}"
          >
            <label for="newsletter-email" class="visually-hidden">
              {l s='Email address' d='Shop.Theme.Global'}
            </label>
            <input
              id="newsletter-email"
              class="newsletter-section__input"
              type="email"
              name="email"
              placeholder="{l s='Enter your email address' d='Shop.Theme.Global'}"
              required
              autocomplete="email"
              aria-required="true"
            >
            <button class="newsletter-section__btn" type="submit">
              {l s='Subscribe' d='Shop.Theme.Global'}
            </button>
          </form>
        {/if}
      </div>

    </div>
  </div>
</section>
