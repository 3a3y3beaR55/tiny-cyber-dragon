import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// ProgressWidget — a labeled, animated progress bar.
///
/// Reuse: lesson progress, mission progress, future scan progress — anything
/// that moves from 0 to done renders through this widget.
class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.value,
    this.label,
    this.color,
    this.showPercent = true,
  });

  /// Progress from 0.0 to 1.0.
  final double value;
  final String? label;

  /// Bar color; defaults to the theme primary.
  final Color? color;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color barColor = color ?? theme.colorScheme.primary;
    final double clamped = value.clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showPercent)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.xxs),
            child: Row(
              children: [
                if (label != null)
                  Expanded(
                    child: Text(label!, style: theme.textTheme.labelSmall),
                  )
                else
                  const Spacer(),
                if (showPercent)
                  Text(
                    '${(clamped * 100).round()}%',
                    style: theme.textTheme.labelSmall!
                        .copyWith(color: barColor),
                  ),
              ],
            ),
          ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: clamped),
          duration: AnimationConstants.normal,
          curve: AnimationConstants.standard,
          builder: (context, animated, _) => ClipRRect(
            borderRadius: BorderRadius.circular(Spacing.radiusFull),
            child: LinearProgressIndicator(
              value: animated,
              minHeight: 8,
              color: barColor,
              backgroundColor: barColor.withValues(alpha: 0.15),
            ),
          ),
        ),
      ],
    );
  }
}
