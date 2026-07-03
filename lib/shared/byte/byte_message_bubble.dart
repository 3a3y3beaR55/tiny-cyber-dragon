import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// ByteMessageBubble — Byte's speech bubble as a standalone widget.
///
/// Composed by [ByteWidget] and [ByteStatusCard]; reusable anywhere Byte
/// "speaks" (future lesson callouts, mission hints). Optional [accentColor]
/// tints the border to match the current status.
class ByteMessageBubble extends StatelessWidget {
  const ByteMessageBubble({
    super.key,
    required this.message,
    this.accentColor,
    this.maxWidth = 320,
  });

  final String message;

  /// Border tint; defaults to the theme outline.
  final Color? accentColor;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(
          color: accentColor?.withValues(alpha: 0.45) ??
              theme.colorScheme.outline,
        ),
      ),
      child: Text(message, style: theme.textTheme.bodyLarge),
    );
  }
}
