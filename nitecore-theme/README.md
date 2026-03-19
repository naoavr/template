# Nitecore Theme for PrestaShop 8 / 9

A professional **dark-theme** for PrestaShop 8.x (compatible with PrestaShop 9.x) inspired by the design of [nitecore.de](https://www.nitecore.de/).

---

## Screenshots

> Replace the placeholder images below after installing the theme in your store.

| Homepage | Product Page | Cart |
|---|---|---|
| *(screenshot)* | *(screenshot)* | *(screenshot)* |

---

## Requirements

| Dependency | Minimum version |
|---|---|
| PrestaShop | 8.0.0 |
| PHP | 8.1 |
| Node.js | 18.x |
| npm | 9.x |

---

## Installation

### 1 — Copy theme files

```bash
cp -r nitecore-theme /path/to/prestashop/themes/
```

### 2 — Install npm dependencies and compile assets

```bash
cd /path/to/prestashop/themes/nitecore-theme
npm install
npm run build
```

This produces:
- `assets/css/custom.css` — compiled CSS
- `assets/js/theme.js` — minified JS bundle
- `assets/js/megamenu.js` — minified mega-menu bundle

### 3 — Activate the theme

1. Log in to your PrestaShop back-office.
2. Go to **Design → Theme & Logo**.
3. Click **Add new theme** and upload the `nitecore-theme` folder, or select it if it was already copied.
4. Click **Use this theme**.

### 4 — Configure fonts (optional)

The theme loads **Inter** from Google Fonts via CDN (no local files needed). If you want to self-host the font, download it from [Google Fonts](https://fonts.google.com/specimen/Inter) and update `_variables.scss` and `templates/_partials/head.tpl`.

---

## Development

```bash
# Watch mode — rebuild on every SCSS/JS change
npm run dev

# Production build — minified output
npm run build
```

### Lint

```bash
npm run lint:scss   # Stylelint (requires stylelint + stylelint-config-standard-scss)
npm run lint:js     # ESLint    (requires eslint + @eslint/js)
```

---

## File Structure

```
nitecore-theme/
├── config/
│   └── theme.yml                    # Theme metadata & PrestaShop compatibility
├── assets/
│   ├── css/
│   │   ├── _variables.scss          # Design tokens (colours, typography, spacing)
│   │   ├── _header.scss             # Topbar, logo, search, mega-menu
│   │   ├── _hero.scss               # Hero slider (Swiper.js)
│   │   ├── _product-card.scss       # Reusable product card component
│   │   ├── _footer.scss             # Newsletter, footer columns, copyright
│   │   ├── _responsive.scss         # Media queries & mobile overrides
│   │   └── custom.scss              # Main SCSS entry point
│   ├── js/
│   │   ├── theme.js                 # Sticky header, mobile menu, search toggle, Swiper init
│   │   └── megamenu.js              # Mega-menu keyboard & hover behaviour
│   └── img/
│       └── .gitkeep                 # Add your images here
├── templates/
│   ├── _partials/
│   │   ├── head.tpl                 # <head> — meta, fonts, CSS
│   │   ├── header.tpl               # Topbar + main header + mega-menu nav
│   │   ├── footer.tpl               # Newsletter + columns + copyright
│   │   ├── breadcrumb.tpl           # Schema.org breadcrumbs
│   │   ├── hero-slider.tpl          # Swiper.js hero banner
│   │   ├── product-card.tpl         # Product card (listing + homepage)
│   │   └── newsletter-block.tpl     # Email subscription block
│   ├── catalog/
│   │   ├── listing/
│   │   │   └── product-list.tpl     # Category / search results
│   │   └── product.tpl              # Single product page
│   ├── checkout/
│   │   └── cart.tpl                 # Cart page
│   ├── customer/
│   │   └── my-account.tpl           # Account dashboard
│   ├── cms/
│   │   └── page.tpl                 # CMS pages
│   ├── index.tpl                    # Homepage
│   └── layouts/
│       ├── layout-full-width.tpl    # Full-width layout
│       └── layout-both-columns.tpl  # Two-column layout (sidebar)
├── modules/                         # Module template overrides (empty by default)
├── webpack.config.js
├── package.json
├── preview.png
└── README.md
```

---

## Customising Colours & Variables

All design tokens are defined in `assets/css/_variables.scss`:

```scss
$color-primary:      #FFD700;  // Yellow/Gold — main brand colour
$color-accent:       #FF4444;  // Red — HOT badges, discounts
$bg-black:           #0A0A0A;  // Page background
$bg-dark:            #111111;  // Section backgrounds
$font-family-base:   'Inter', sans-serif;
```

After editing, recompile:

```bash
npm run build
```

---

## PrestaShop 8/9 Compatibility Notes

| Feature | Implementation |
|---|---|
| **Theme inheritance** | `parent: classic` in `theme.yml` |
| **Hooks** | Only official, non-deprecated PS8 hooks used |
| **Templating** | Smarty 3 with `{block}` / `{extends}` |
| **Core overrides** | Zero — only hooks and template inheritance |
| **Deprecated APIs** | None used |
| **Accessibility** | Semantic HTML5, ARIA labels, WCAG 2.1 AA |
| **SEO** | Schema.org microdata, proper heading hierarchy |

### Hooks used

| Hook | Location |
|---|---|
| `displayHeader` | `<head>` extra content |
| `displayNav1` | Topbar left (phone) |
| `displayNav2` | Topbar left (email) |
| `displayTop` | Topbar right (account/language/currency) |
| `displaySearch` | Header search bar area |
| `displayNavFullWidth` | Header action icons (cart/account/wishlist) |
| `displayHome` | Homepage main content area |
| `displayHomeTab` | Homepage additional module content |
| `displayFooter` | Footer extra content from modules |
| `displayFooterBefore` | Before footer |
| `displayFooterAfter` | After footer |
| `displayBeforeBodyClosingTag` | Before `</body>` |
| `displayProductAdditionalInfo` | Product page (ratings, etc.) |
| `displayActiveFilters` | Category listing active facets |
| `displayShoppingCartFooter` | Cart promo code / voucher |
| `displayCustomerAccount` | My account extra links |
| `displayCMSPrintButton` | CMS pages |
| `displayCMSDisputeInformation` | CMS pages |

---

## JavaScript Features

| Feature | Implementation |
|---|---|
| Hero slider | Swiper.js 11 (autoplay, fade, keyboard, a11y) |
| Sticky header | `IntersectionObserver`-free scroll listener with `requestAnimationFrame` |
| Hide-on-scroll header | Shows when scrolling up, hides when scrolling down |
| Mobile menu | Slide-in drawer with overlay and focus trap |
| Mega-menu | Hover-intent + keyboard navigation (arrows, Escape) |
| Search toggle | Mobile full-width search bar |
| Wishlist toggle | Pure JS, no jQuery |
| Back-to-top button | Smooth scroll |
| Quantity inputs | `+` / `−` buttons with min/max validation |

---

## Licence

[MIT](https://opensource.org/licenses/MIT) — free to use, modify and distribute.
