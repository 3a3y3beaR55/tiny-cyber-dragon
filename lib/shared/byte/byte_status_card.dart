import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import '../widgets/cards/app_card.dart';
import 'byte_avatar.dart';
import 'byte_state.dart';
import 'byte_status.dart';

/// ByteStatusCard — the dashboard's Byte panel.
///
/// Renders a [ByteState]: avatar with the status's colors and animation, a
/// status label badge, and Byte's message (bubble override if set,
/// otherwise the status's default message). The card's accent stripe uses
/// the status's dashboard accent color, so the whole dashboard "agrees"
/// with Byte about the current situation.
///
/// [trailing] hosts contextual actions (e.g. the Run Safety Check button).
class ByteStatusCard extends StatelessWidget {
  const ByteStatusCard({
    super.key,
    required this.state,
    this.trailing,
    this.onTap,
  });

  final ByteState state;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ByteStatusData data = state.statusData;
    final String message = state.message ?? data.message;

    return AppCard(
      onTap: onTap,
      accentColor: data.accentColor,
      padding: const EdgeInsets.all(Spacing.lg),
      child: Row(
        children: [
          ByteAvatar(
            expression: state.mood,
            eyeColor: state.eyeColor,
            glowColor: state.glowColor,
            animationState: state.animationState,
            size: 84,
          ),
          Spacing.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text('Byte', style: theme.textTheme.titleMedium),
                    ),
                    Spacing.gapXs,
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: data.accentColor.withValues(alpha: 0.14),
                        borderRadius:
                            BorderRadius.circular(Spacing.radiusFull),
                      ),
                      child: Text(
                        data.label.toUpperCase(),
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: data.accentColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacing.gapXs,
                Text(message, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          if (trailing != null) ...[Spacing.gapMd, trailing!],
        ],
      ),
    );
  }
}
