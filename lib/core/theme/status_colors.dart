import 'package:flutter/material.dart';

/// Semantic status levels used across the entire product — lessons, threats,
/// missions, scans, and Byte's mood all speak this shared language.
enum StatusLevel { safe, info, warning, danger, neutral }

/// StatusColors — semantic colors for security/education state.
///
/// Purpose: a threat card, a scan result, and Byte's glow must always agree
/// on what "warning" looks like. Widgets take a [StatusLevel] and resolve
/// color here — never their own reds and greens.
///
/// Future expansion: colorblind-safe and high-contrast variants resolve from
/// the same [StatusLevel] API, so callers never change.
abstract final class StatusColors {
  /// Protected / correct / completed.
  static const Color safe = Color(0xFF34D399);

  /// Informational / in progress.
  static const Color info = Color(0xFF38BDF8);

  /// Caution / needs attention.
  static const Color warning = Color(0xFFFBBF24);

  /// Threat / error / blocked.
  static const Color danger = Color(0xFFF87171);

  /// Inactive / not yet started.
  static const Color neutral = Color(0xFF64748B);

  static Color of(StatusLevel level) => switch (level) {
        StatusLevel.safe => safe,
        StatusLevel.info => info,
        StatusLevel.warning => warning,
        StatusLevel.danger => danger,
        StatusLevel.neutral => neutral,
      };

  /// Low-opacity fill for badges/chips carrying a status color.
  static Color surfaceOf(StatusLevel level) =>
      of(level).withValues(alpha: 0.12);
}
