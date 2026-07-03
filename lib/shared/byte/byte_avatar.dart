import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'byte_enums.dart';
import 'byte_status.dart';

/// ByteAvatar — Byte's face, and nothing else.
///
/// The smallest Byte building block: give it an expression, colors, and an
/// animation, and it renders the dragon. [ByteWidget] and [ByteStatusCard]
/// compose it; use it directly anywhere a bare Byte face is needed (rail,
/// list leading icons, celebration overlays).
///
/// The `ByteAvatar.forStatus` factory derives everything from a
/// [ByteStatus], which is the common case.
///
/// Animation is a local [AnimationController] (local motion = local state,
/// per the TradeSpark state standard) and honors the OS reduced-motion
/// setting.
class ByteAvatar extends StatefulWidget {
  const ByteAvatar({
    super.key,
    this.expression = ByteMood.happy,
    this.eyeColor,
    this.glowColor,
    this.animationState = ByteAnimationState.idle,
    this.size = 96,
  });

  /// Derive expression, colors, and animation from a status.
  factory ByteAvatar.forStatus(
    ByteStatus status, {
    Key? key,
    double size = 96,
  }) {
    final ByteStatusData data = status.data;
    return ByteAvatar(
      key: key,
      expression: data.expression,
      eyeColor: data.eyeColor,
      glowColor: data.glowColor,
      animationState: data.animation,
      size: size,
    );
  }

  final ByteMood expression;

  /// Defaults to the expression's mood color when null.
  final Color? eyeColor;

  /// Defaults to [eyeColor] when null.
  final Color? glowColor;

  final ByteAnimationState animationState;

  /// Avatar diameter in logical pixels.
  final double size;

  /// Expression → default color (semantic, from StatusColors).
  static Color moodColor(ByteMood mood) => switch (mood) {
        ByteMood.happy => ColorTokens.primary,
        ByteMood.alert => StatusColors.warning,
        ByteMood.thinking => StatusColors.info,
        ByteMood.sleeping => StatusColors.neutral,
        ByteMood.celebrating => ColorTokens.celebration,
      };

  @override
  State<ByteAvatar> createState() => _ByteAvatarState();
}

class _ByteAvatarState extends State<ByteAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimationConstants.byteIdleLoop,
    );
    _configureMotion();
  }

  @override
  void didUpdateWidget(ByteAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationState != widget.animationState) {
      _configureMotion();
    }
  }

  void _configureMotion() {
    switch (widget.animationState) {
      case ByteAnimationState.idle:
        _controller
          ..duration = AnimationConstants.byteIdleLoop
          ..repeat(reverse: true);
      case ByteAnimationState.pulse:
        _controller
          ..duration = AnimationConstants.bytePulseLoop
          ..repeat(reverse: true);
      case ByteAnimationState.still:
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);
    final Color eyes =
        widget.eyeColor ?? ByteAvatar.moodColor(widget.expression);
    final Color glow = widget.glowColor ?? eyes;

    return Semantics(
      label: 'Byte the cyber dragon, feeling ${widget.expression.name}',
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final double t = reduceMotion ? 0 : _controller.value;
          final bool pulsing =
              widget.animationState == ByteAnimationState.pulse;
          // Idle: gentle vertical bob. Pulse: stay put, glow breathes.
          final double dy = pulsing ? 0 : math.sin(t * math.pi) * 3;
          final double glowStrength = pulsing ? 0.25 + t * 0.45 : 0.30;

          return Transform.translate(
            offset: Offset(0, dy),
            child: CustomPaint(
              size: Size.square(widget.size),
              painter: _BytePainter(
                mood: widget.expression,
                eyeColor: eyes,
                glowColor: glow,
                glowStrength: glowStrength,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Paints Byte's face: glowing body, horns, expression-driven eyes and
/// mouth. New expressions and future skins are contained here.
class _BytePainter extends CustomPainter {
  const _BytePainter({
    required this.mood,
    required this.eyeColor,
    required this.glowColor,
    required this.glowStrength,
  });

  final ByteMood mood;
  final Color eyeColor;
  final Color glowColor;
  final double glowStrength;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double r = size.width / 2;

    // Glow halo.
    canvas.drawCircle(
      center,
      r * 0.92,
      Paint()
        ..color = glowColor.withValues(alpha: glowStrength)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.25),
    );

    // Horns.
    final Paint hornPaint = Paint()..color = ColorTokens.surfaceRaisedDark;
    for (final double dir in [-1.0, 1.0]) {
      final Path horn = Path()
        ..moveTo(center.dx + dir * r * 0.38, center.dy - r * 0.55)
        ..lineTo(center.dx + dir * r * 0.62, center.dy - r * 0.95)
        ..lineTo(center.dx + dir * r * 0.72, center.dy - r * 0.42)
        ..close();
      canvas.drawPath(horn, hornPaint);
    }

    // Body.
    canvas.drawCircle(
      center,
      r * 0.78,
      Paint()..color = ColorTokens.surfaceRaisedDark,
    );
    canvas.drawCircle(
      center,
      r * 0.78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.05
        ..color = glowColor.withValues(alpha: 0.7),
    );

    // Eyes.
    final Paint eyePaint = Paint()..color = eyeColor;
    final double eyeY = center.dy - r * 0.12;
    final double eyeDx = r * 0.30;
    final double eyeR = r * 0.13;

    if (mood == ByteMood.sleeping) {
      // Closed eyes: soft arcs.
      final Paint lid = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.06
        ..strokeCap = StrokeCap.round
        ..color = eyeColor;
      for (final double dir in [-1.0, 1.0]) {
        canvas.drawArc(
          Rect.fromCircle(
            center: Offset(center.dx + dir * eyeDx, eyeY),
            radius: eyeR,
          ),
          0,
          math.pi,
          false,
          lid,
        );
      }
    } else if (mood == ByteMood.celebrating) {
      // Star-bright wide eyes.
      for (final double dir in [-1.0, 1.0]) {
        canvas.drawCircle(
          Offset(center.dx + dir * eyeDx, eyeY),
          eyeR * 1.25,
          eyePaint,
        );
      }
    } else {
      for (final double dir in [-1.0, 1.0]) {
        canvas.drawCircle(
          Offset(center.dx + dir * eyeDx, eyeY),
          eyeR,
          eyePaint,
        );
      }
      if (mood == ByteMood.alert) {
        // Raised brow lines above the eyes.
        final Paint brow = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = r * 0.05
          ..strokeCap = StrokeCap.round
          ..color = eyeColor;
        for (final double dir in [-1.0, 1.0]) {
          canvas.drawLine(
            Offset(center.dx + dir * (eyeDx + eyeR), eyeY - eyeR * 2.1),
            Offset(center.dx + dir * (eyeDx - eyeR), eyeY - eyeR * 1.6),
            brow,
          );
        }
      }
    }

    // Mouth.
    final Paint mouth = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.055
      ..strokeCap = StrokeCap.round
      ..color = eyeColor.withValues(alpha: 0.85);
    final double mouthY = center.dy + r * 0.30;
    final Rect mouthRect = Rect.fromCenter(
      center: Offset(center.dx, mouthY),
      width: r * 0.55,
      height: r * 0.35,
    );
    switch (mood) {
      case ByteMood.happy || ByteMood.celebrating:
        canvas.drawArc(mouthRect, math.pi * 0.15, math.pi * 0.7, false, mouth);
      case ByteMood.thinking:
        canvas.drawLine(
          Offset(center.dx - r * 0.18, mouthY),
          Offset(center.dx + r * 0.10, mouthY - r * 0.05),
          mouth,
        );
      case ByteMood.alert:
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(center.dx, mouthY),
            width: r * 0.22,
            height: r * 0.26,
          ),
          mouth,
        );
      case ByteMood.sleeping:
        canvas.drawLine(
          Offset(center.dx - r * 0.14, mouthY),
          Offset(center.dx + r * 0.14, mouthY),
          mouth,
        );
    }
  }

  @override
  bool shouldRepaint(_BytePainter oldDelegate) =>
      oldDelegate.mood != mood ||
      oldDelegate.eyeColor != eyeColor ||
      oldDelegate.glowColor != glowColor ||
      oldDelegate.glowStrength != glowStrength;
}
