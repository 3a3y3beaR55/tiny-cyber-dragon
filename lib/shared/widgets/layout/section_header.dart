import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// SectionHeader — titles a content section, optionally with a subtitle and
/// a trailing action ("See all →").
///
/// Reuse: every screen that groups content under headings uses this, so
/// section rhythm is identical product-wide.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;

  /// Trailing action text (rendered as a link-style button).
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                if (subtitle != null) ...[
                  Spacing.gapXxs,
                  Text(subtitle!, style: theme.textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          if (actionLabel != null)
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}
