import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'byte_avatar.dart';
import 'byte_enums.dart';
import 'byte_message_bubble.dart';

/// ByteWidget — avatar + optional speech bubble, positioned.
///
/// The convenience composition of [ByteAvatar] and [ByteMessageBubble].
/// Sprint 001 API preserved: mood, animationState, eyeColor, message,
/// position, size. Screens typically feed it from `byteStatusProvider`:
///
/// ```dart
/// final byte = ref.watch(byteStatusProvider);
/// ByteWidget(
///   mood: byte.mood,
///   animationState: byte.animationState,
///   eyeColor: byte.eyeColor,
///   message: byte.message,
/// )
/// ```
class ByteWidget extends StatelessWidget {
  const ByteWidget({
    super.key,
    this.mood = ByteMood.happy,
    this.animationState = ByteAnimationState.idle,
    this.eyeColor,
    this.glowColor,
    this.message,
    this.position = BytePosition.messageRight,
    this.size = 96,
  });

  final ByteMood mood;
  final ByteAnimationState animationState;

  /// Overrides the mood's default eye color when non-null.
  final Color? eyeColor;

  /// Overrides the glow (defaults to eye color).
  final Color? glowColor;

  /// Speech-bubble text. Hidden when null or [position] is `messageNone`.
  final String? message;

  final BytePosition position;

  /// Avatar diameter in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final Widget avatar = ByteAvatar(
      expression: mood,
      eyeColor: eyeColor,
      glowColor: glowColor,
      animationState: animationState,
      size: size,
    );

    final bool showBubble = message != null &&
        message!.isNotEmpty &&
        position != BytePosition.messageNone;

    if (!showBubble) return avatar;

    final Widget bubble = ByteMessageBubble(
      message: message!,
      accentColor: eyeColor ?? ByteAvatar.moodColor(mood),
    );

    return switch (position) {
      BytePosition.messageRight => Row(
          mainAxisSize: MainAxisSize.min,
          children: [avatar, Spacing.gapSm, Flexible(child: bubble)],
        ),
      BytePosition.messageLeft => Row(
          mainAxisSize: MainAxisSize.min,
          children: [Flexible(child: bubble), Spacing.gapSm, avatar],
        ),
      BytePosition.messageBelow => Column(
          mainAxisSize: MainAxisSize.min,
          children: [avatar, Spacing.gapXs, bubble],
        ),
      BytePosition.messageNone => avatar,
    };
  }
}
