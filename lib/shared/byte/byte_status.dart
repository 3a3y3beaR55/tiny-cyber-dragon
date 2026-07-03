import 'dart:ui' show Color;

import '../../core/theme/color_tokens.dart';
import '../../core/theme/status_colors.dart';
import 'byte_enums.dart';

/// ByteStatus — the primary axis of Byte's state: what Byte is *doing* or
/// *reporting* security-wise. Every status fully describes how Byte looks
/// and how the dashboard should react, via [data].
///
/// [ByteMood] remains the *facial expression* layer — each status declares
/// which expression it wears, so the avatar painter needs no knowledge of
/// statuses.
///
/// Adding a status = one enum value + one entry in [data]. Nothing else.
enum ByteStatus {
  /// Keeping watch; everything is fine.
  idle,

  /// A (future) safety check is running.
  scanning,

  /// Something needs attention — not dangerous yet.
  warning,

  /// A concrete risk was found.
  threat,

  /// Act now — highest severity. Still calm, never panicked.
  critical,

  /// A task/lesson/scan finished successfully.
  complete,

  /// Byte is teaching or the user is in a lesson.
  learning,

  /// The app or Byte's knowledge is updating.
  updating,

  /// Resting / long-idle state.
  sleeping;

  /// Visual + copy metadata for this status.
  ByteStatusData get data => ByteStatusData.of(this);
}

/// ByteStatusData — everything a status controls: eye color, glow color,
/// human-readable label, default message, dashboard accent color, the
/// recommended animation, and the expression Byte wears.
///
/// `animationName` is a stable string identifier for richer animation
/// systems later (Rive/Lottie); `animation` is what today's avatar
/// actually plays.
class ByteStatusData {
  const ByteStatusData({
    required this.eyeColor,
    required this.glowColor,
    required this.label,
    required this.message,
    required this.accentColor,
    required this.animation,
    required this.animationName,
    required this.expression,
  });

  final Color eyeColor;
  final Color glowColor;

  /// Short badge label ("All Clear", "Threat Detected").
  final String label;

  /// Default status message, shown by [ByteStatusCard] when no explicit
  /// message override is set.
  final String message;

  /// Accent color the dashboard uses for this status (card stripes, badges).
  final Color accentColor;

  /// Animation the avatar plays today.
  final ByteAnimationState animation;

  /// Stable identifier for future rich animation assets.
  final String animationName;

  /// Facial expression Byte wears.
  final ByteMood expression;

  static ByteStatusData of(ByteStatus status) => switch (status) {
        ByteStatus.idle => const ByteStatusData(
            eyeColor: ColorTokens.primary,
            glowColor: ColorTokens.primary,
            label: 'All Clear',
            message: 'Byte is keeping watch. Everything looks good.',
            accentColor: ColorTokens.primary,
            animation: ByteAnimationState.idle,
            animationName: 'breathe',
            expression: ByteMood.happy,
          ),
        ByteStatus.scanning => const ByteStatusData(
            eyeColor: StatusColors.info,
            glowColor: StatusColors.info,
            label: 'Scanning',
            message: 'Byte is checking things over…',
            accentColor: StatusColors.info,
            animation: ByteAnimationState.pulse,
            animationName: 'radar_sweep',
            expression: ByteMood.thinking,
          ),
        ByteStatus.warning => const ByteStatusData(
            eyeColor: StatusColors.warning,
            glowColor: StatusColors.warning,
            label: 'Heads Up',
            message: 'Something needs your attention.',
            accentColor: StatusColors.warning,
            animation: ByteAnimationState.pulse,
            animationName: 'pulse_slow',
            expression: ByteMood.alert,
          ),
        ByteStatus.threat => const ByteStatusData(
            eyeColor: StatusColors.danger,
            glowColor: StatusColors.danger,
            label: 'Threat Detected',
            message: "Byte found something risky. Let's handle it together.",
            accentColor: StatusColors.danger,
            animation: ByteAnimationState.pulse,
            animationName: 'pulse_fast',
            expression: ByteMood.alert,
          ),
        ByteStatus.critical => const ByteStatusData(
            eyeColor: StatusColors.danger,
            glowColor: Color(0xFFFF5A5A), // hotter glow than standard danger
            label: 'Critical',
            message: 'Act now — Byte will walk you through it step by step.',
            accentColor: StatusColors.danger,
            animation: ByteAnimationState.pulse,
            animationName: 'alarm_pulse',
            expression: ByteMood.alert,
          ),
        ByteStatus.complete => const ByteStatusData(
            eyeColor: StatusColors.safe,
            glowColor: StatusColors.safe,
            label: 'All Done',
            message: "Great work! You're safer than you were five minutes "
                'ago.',
            accentColor: StatusColors.safe,
            animation: ByteAnimationState.idle,
            animationName: 'bounce',
            expression: ByteMood.celebrating,
          ),
        ByteStatus.learning => const ByteStatusData(
            eyeColor: ColorTokens.accent,
            glowColor: ColorTokens.accent,
            label: 'Learning Mode',
            message: 'Byte is teaching — soak it up!',
            accentColor: ColorTokens.accent,
            animation: ByteAnimationState.idle,
            animationName: 'bob',
            expression: ByteMood.thinking,
          ),
        ByteStatus.updating => const ByteStatusData(
            eyeColor: StatusColors.info,
            glowColor: StatusColors.info,
            label: 'Updating',
            message: 'Byte is getting stronger. One moment…',
            accentColor: StatusColors.info,
            animation: ByteAnimationState.pulse,
            animationName: 'spin',
            expression: ByteMood.thinking,
          ),
        ByteStatus.sleeping => const ByteStatusData(
            eyeColor: StatusColors.neutral,
            glowColor: StatusColors.neutral,
            label: 'Resting',
            message: 'Byte is napping. Wake him anytime.',
            accentColor: StatusColors.neutral,
            animation: ByteAnimationState.still,
            animationName: 'sleep',
            expression: ByteMood.sleeping,
          ),
      };
}
