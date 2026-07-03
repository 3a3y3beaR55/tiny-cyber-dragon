import 'package:flutter/widgets.dart';

/// Spacing — the 4px-grid spacing scale.
///
/// Purpose: consistent rhythm everywhere. No widget invents its own padding
/// numbers; it picks from this scale. Doubles as the radius scale.
abstract final class Spacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // ── Radii ────────────────────────────────────────────────────────────
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusFull = 999;

  // ── Common gaps (const-friendly SizedBoxes) ──────────────────────────
  static const SizedBox gapXxs = SizedBox(width: xxs, height: xxs);
  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);

  /// Standard page padding for desktop screens.
  static const EdgeInsets pagePadding = EdgeInsets.all(lg);

  /// Standard card inner padding.
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
}
