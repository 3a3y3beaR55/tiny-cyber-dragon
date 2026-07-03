import 'package:flutter/animation.dart';

/// AnimationConstants — shared durations and curves.
///
/// Purpose: motion feels coherent when every widget animates on the same
/// clock. Byte's idle bob, card hovers, and page fades all pull from here.
///
/// Accessibility note: callers should respect
/// `MediaQuery.disableAnimationsOf(context)` for reduced-motion users.
abstract final class AnimationConstants {
  // ── Durations ────────────────────────────────────────────────────────
  /// Micro-interactions: hovers, presses, focus rings.
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard transitions: cards, dialogs, reveals.
  static const Duration normal = Duration(milliseconds: 280);

  /// Emphasis moments: celebrations, screen transitions.
  static const Duration slow = Duration(milliseconds: 450);

  /// Byte's idle breathing/bobbing loop.
  static const Duration byteIdleLoop = Duration(milliseconds: 2400);

  /// Byte's alert pulse loop.
  static const Duration bytePulseLoop = Duration(milliseconds: 900);

  // ── Curves ───────────────────────────────────────────────────────────
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve bounce = Curves.elasticOut;
  static const Curve breathe = Curves.easeInOutSine;
}
