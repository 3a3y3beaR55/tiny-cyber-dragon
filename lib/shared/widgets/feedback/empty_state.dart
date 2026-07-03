import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../byte/byte.dart';
import '../buttons/primary_button.dart';

/// EmptyState — friendly placeholder for screens/sections with no content
/// yet. Byte delivers the message, keeping empty screens on-brand and
/// encouraging rather than dead ends.
///
/// Reuse: placeholder screens this sprint; later, empty search results,
/// completed queues, offline states.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.byteMood = ByteMood.happy,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final ByteMood byteMood;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ByteWidget(
              mood: byteMood,
              position: BytePosition.messageNone,
              size: 88,
            ),
            Spacing.gapMd,
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              Spacing.gapXs,
              Text(
                message!,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null) ...[
              Spacing.gapLg,
              PrimaryButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
