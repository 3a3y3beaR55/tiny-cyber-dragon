import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'app_card.dart';

/// ThreatCard — an educational threat-library entry (phishing, weak
/// passwords, public Wi-Fi…).
///
/// Educational, never alarming: severity is informational and always pairs
/// with the reassuring frame "here's how to stay safe".
class ThreatCard extends StatelessWidget {
  const ThreatCard({
    super.key,
    required this.title,
    required this.severity,
    this.summary,
    this.categoryLabel,
    this.onTap,
  });

  final String title;

  /// Severity expressed with the shared [StatusLevel] vocabulary.
  final StatusLevel severity;

  /// One-line plain-language description.
  final String? summary;

  /// e.g. "Email", "Passwords", "Wi-Fi".
  final String? categoryLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color color = StatusColors.of(severity);

    return AppCard(
      onTap: onTap,
      accentColor: color,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.xs),
            decoration: BoxDecoration(
              color: StatusColors.surfaceOf(severity),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(Icons.shield_outlined, color: color, size: 22),
          ),
          Spacing.gapSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                if (summary != null) ...[
                  Spacing.gapXxs,
                  Text(
                    summary!,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (categoryLabel != null) ...[
            Spacing.gapSm,
            Text(
              categoryLabel!.toUpperCase(),
              style: theme.textTheme.labelSmall,
            ),
          ],
        ],
      ),
    );
  }
}
