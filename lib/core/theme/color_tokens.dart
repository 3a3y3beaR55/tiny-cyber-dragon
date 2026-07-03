import 'package:flutter/material.dart';

/// ColorTokens — the single source of truth for every color in
/// Tiny Cyber Dragon.
///
/// Purpose: widgets never hard-code colors; they consume tokens (directly or
/// through [ThemeData]). Changing the brand palette or adding a new theme
/// means editing this file only.
///
/// Aesthetic: "friendly cyberpunk" — deep navy surfaces, dragon-glow cyan,
/// ember accents. Protective, never intimidating.
///
/// Future expansion: additional palettes (light, high-contrast, seasonal)
/// are added as new token sets here and wired up in `app_theme.dart`.
abstract final class ColorTokens {
  // ── Brand ────────────────────────────────────────────────────────────
  /// Dragon-glow cyan. Primary actions, active navigation, Byte's glow.
  static const Color primary = Color(0xFF22D3EE);

  /// Deep teal used for hover/pressed variants of [primary].
  static const Color primaryDim = Color(0xFF0E7490);

  /// Ember violet. Secondary accents, highlights, mission energy.
  static const Color accent = Color(0xFFA78BFA);

  /// Dragon-scale magenta. Sparingly, for celebration moments.
  static const Color celebration = Color(0xFFF472B6);

  // ── Dark surfaces (primary theme) ────────────────────────────────────
  /// App background — near-black navy, easy on the eyes.
  static const Color backgroundDark = Color(0xFF0B1120);

  /// Card / panel surface.
  static const Color surfaceDark = Color(0xFF111A2E);

  /// Raised surface (dialogs, menus).
  static const Color surfaceRaisedDark = Color(0xFF1A2440);

  /// Hairline borders and dividers.
  static const Color borderDark = Color(0xFF243052);

  // ── Text on dark ─────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFE6EDF7);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textDisabledDark = Color(0xFF475569);

  // ── Light surfaces (future light theme) ──────────────────────────────
  static const Color backgroundLight = Color(0xFFF5F8FC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFD8E0EC);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);

  // ── On-color ─────────────────────────────────────────────────────────
  /// Text/icons placed on top of [primary] fills.
  static const Color onPrimary = Color(0xFF06202A);
}
