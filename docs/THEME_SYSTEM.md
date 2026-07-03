# Theme System

The theme system is token-based: widgets never hard-code a color, size, duration, or text style. They consume tokens from `lib/core/theme/` (imported via the `theme.dart` barrel) directly or through `Theme.of(context)`. Changing the brand, adding a theme, or passing an accessibility audit therefore touches token files only.

## The token files

**`color_tokens.dart` — ColorTokens.** Brand colors (dragon-glow cyan `primary`, ember-violet `accent`, magenta `celebration`), dark surfaces (near-black navy background through raised surfaces and hairline borders), text colors for dark and light, and on-color contrast pairs. The aesthetic is "friendly cyberpunk": glowing accents on calm, deep surfaces — protective, never intimidating.

**`status_colors.dart` — StatusLevel + StatusColors.** The product-wide semantic vocabulary: `safe`, `info`, `warning`, `danger`, `neutral`. A threat card, a scan result, Byte's alert glow, and a dialog icon all resolve the same level to the same color via `StatusColors.of(level)`; `surfaceOf(level)` gives the matching low-opacity badge fill. Widgets accept a `StatusLevel`, never a raw color, so a future colorblind-safe palette is a token-file change.

**`typography.dart` — AppTypography.** The type scale, built on the platform system font (Segoe UI on Windows) for native feel and zero asset weight. Roles: `displayMedium` for hero numbers, `headlineMedium` for screen titles, `titleLarge` for section headers, `titleMedium` for card titles, `bodyLarge`/`bodyMedium` for reading text, `labelLarge` for buttons, `labelSmall` for badges and metadata. Sizes scale with the OS text-scale factor automatically.

**`spacing.dart` — Spacing.** A 4px-grid scale (`xxs` 4 → `xxl` 48), corner radii, const `SizedBox` gaps (`Spacing.gapMd`), and standard paddings (`pagePadding`, `cardPadding`). No widget invents its own numbers.

**`animation_constants.dart` — AnimationConstants.** Shared durations (`fast` 150ms micro-interactions, `normal` 280ms transitions, `slow` 450ms emphasis, plus Byte's idle and pulse loop timings) and curves. Coherent motion comes from everything animating on the same clock. Widgets honor `MediaQuery.disableAnimationsOf(context)` for reduced-motion users.

**`app_theme.dart` — AppTheme.** The only file that constructs `ThemeData`. `AppTheme.dark` is the signature theme; `AppTheme.light` exists so `ThemeMode` switching works from day one and will be polished in a future design pass. Component themes (cards, dialogs, navigation rail, tooltips, snackbars) are configured here from tokens.

## Adding a theme

Add its token set to `color_tokens.dart`, add a static getter in `app_theme.dart`, and expose it wherever theme selection lives. No widget changes. High-contrast and colorblind-safe variants are the planned next additions, followed by unlockable cosmetic themes as a learner reward.

## Accessibility commitments

Text colors meet WCAG AA contrast on their surfaces. Status is never communicated by color alone — levels always pair with an icon or label. Motion respects the OS reduced-motion setting. Font sizes respect OS text scaling.
