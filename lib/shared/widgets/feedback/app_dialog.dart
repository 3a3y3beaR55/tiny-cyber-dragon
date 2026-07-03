import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// AppDialog — the standard product dialog.
///
/// Reuse: confirmations, info moments, "coming soon" notices. One entry
/// point (`AppDialog.show`) so every dialog shares chrome, motion, and
/// button styling. Optional [StatusLevel] icon keeps semantics consistent.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.body,
    this.level,
    this.confirmLabel = 'OK',
    this.cancelLabel,
    this.onConfirm,
  });

  final String title;
  final String body;

  /// Optional status accent (icon + color).
  final StatusLevel? level;
  final String confirmLabel;

  /// When null, no cancel button is shown.
  final String? cancelLabel;
  final VoidCallback? onConfirm;

  /// Shows the dialog. Resolves to `true` when confirmed.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    StatusLevel? level,
    String confirmLabel = 'OK',
    String? cancelLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        body: body,
        level: level,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: () => Navigator.of(context).pop(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? accent = level == null ? null : StatusColors.of(level!);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (accent != null) ...[
                    Icon(Icons.shield_outlined, color: accent),
                    Spacing.gapXs,
                  ],
                  Expanded(
                    child: Text(title, style: theme.textTheme.titleLarge),
                  ),
                ],
              ),
              Spacing.gapSm,
              Text(body, style: theme.textTheme.bodyLarge),
              Spacing.gapLg,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (cancelLabel != null) ...[
                    SecondaryButton(
                      label: cancelLabel!,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    Spacing.gapSm,
                  ],
                  PrimaryButton(
                    label: confirmLabel,
                    onPressed: onConfirm ??
                        () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
