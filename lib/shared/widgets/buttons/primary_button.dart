import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// PrimaryButton — the main call-to-action button.
///
/// Reuse: one visual definition of "primary action" everywhere. Supports an
/// optional leading icon and a built-in loading state (spinner replaces the
/// label, width is preserved, taps are ignored while loading).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expanded = false,
  });

  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  /// Stretch to fill available width.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget child = isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: theme.colorScheme.onPrimary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                Spacing.gapXs,
              ],
              Text(label),
            ],
          );

    final Widget button = FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg,
          vertical: Spacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusSm),
        ),
        textStyle: theme.textTheme.labelLarge,
      ),
      child: child,
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
