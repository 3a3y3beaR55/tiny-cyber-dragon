import 'dart:ui' show Color;

import 'byte_enums.dart';
import 'byte_status.dart';

/// ByteState — immutable snapshot of Byte's app-wide presence.
///
/// The primary field is [status]; everything visual derives from it via
/// [ByteStatusData]. Optional overrides let features customize the message
/// or eye color for a moment without inventing a new status.
///
/// The derived getters ([mood], [eyeColor], [animationState]) preserve the
/// original Sprint 001 API, so consumers written against moods keep
/// working unchanged.
class ByteState {
  const ByteState({
    this.status = ByteStatus.idle,
    this.messageOverride,
    this.eyeColorOverride,
    this.animationOverride,
  });

  /// What Byte is doing/reporting. The single source of truth.
  final ByteStatus status;

  /// Speech-bubble text. When null, no bubble is shown (the status card
  /// falls back to the status's default message).
  final String? messageOverride;

  /// Momentary eye-color override; null = status default.
  final Color? eyeColorOverride;

  /// Momentary animation override; null = status default.
  final ByteAnimationState? animationOverride;

  // ── Derived (stable public API) ──────────────────────────────────────

  ByteStatusData get statusData => status.data;

  /// Facial expression for the current status.
  ByteMood get mood => statusData.expression;

  Color get eyeColor => eyeColorOverride ?? statusData.eyeColor;

  Color get glowColor => eyeColorOverride ?? statusData.glowColor;

  ByteAnimationState get animationState =>
      animationOverride ?? statusData.animation;

  /// Bubble text (override-only by design — bubbles are for moments,
  /// the status card carries the persistent status message).
  String? get message => messageOverride;

  ByteState copyWith({
    ByteStatus? status,
    String? messageOverride,
    Color? eyeColorOverride,
    ByteAnimationState? animationOverride,
    bool clearMessage = false,
    bool clearEyeColor = false,
    bool clearAnimation = false,
  }) {
    return ByteState(
      status: status ?? this.status,
      messageOverride:
          clearMessage ? null : (messageOverride ?? this.messageOverride),
      eyeColorOverride:
          clearEyeColor ? null : (eyeColorOverride ?? this.eyeColorOverride),
      animationOverride: clearAnimation
          ? null
          : (animationOverride ?? this.animationOverride),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ByteState &&
      other.status == status &&
      other.messageOverride == messageOverride &&
      other.eyeColorOverride == eyeColorOverride &&
      other.animationOverride == animationOverride;

  @override
  int get hashCode =>
      Object.hash(status, messageOverride, eyeColorOverride, animationOverride);
}
