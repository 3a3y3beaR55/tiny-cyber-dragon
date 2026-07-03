import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// SecondaryButton — outlined companion to [PrimaryButton] for supporting
/// actions ("Cancel", "Learn more").
///
/// Mirrors PrimaryButton's API so the two are interchangeable at call sites.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expanded = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        side: BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: 0.55),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg,
          vertical: Spacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusSm),
        ),
        textStyle: theme.textTheme.labelLarge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            Spacing.gapXs,
          ],
          Text(label),
        ],
      ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
