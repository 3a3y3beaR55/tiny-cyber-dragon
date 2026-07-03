import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'app_card.dart';

/// StatusCard — communicates a security/education status at a glance.
///
/// Reuse: protection summary on Home, future scan results, account health.
/// Color and badge derive from [StatusLevel], never from ad-hoc colors.
class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.level,
    this.description,
    this.icon,
    this.badgeLabel,
    this.trailing,
    this.onTap,
  });

  final String title;
  final StatusLevel level;
  final String? description;
  final IconData? icon;

  /// Short badge text ("PROTECTED", "3 NEW"). Defaults to none.
  final String? badgeLabel;

  /// Optional trailing widget (button, chevron, Byte…).
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = StatusColors.of(level);

    return AppCard(
      onTap: onTap,
      accentColor: color,
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(Spacing.xs),
              decoration: BoxDecoration(
                color: StatusColors.surfaceOf(level),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            Spacing.gapSm,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(title, style: theme.textTheme.titleMedium),
                    ),
                    if (badgeLabel != null) ...[
                      Spacing.gapXs,
                      _StatusBadge(label: badgeLabel!, color: color),
                    ],
                  ],
                ),
                if (description != null) ...[
                  Spacing.gapXxs,
                  Text(description!, style: theme.textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[Spacing.gapSm, trailing!],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(Spacing.radiusFull),
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: color, letterSpacing: 0.8),
      ),
    );
  }
}
