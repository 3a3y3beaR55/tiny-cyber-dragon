import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// AppCard — the base card every content card builds on.
///
/// Purpose: one place owns card chrome (surface, border, radius, hover glow,
/// tap ripple). StatusCard, LessonCard, MissionCard, and ThreatCard compose
/// this instead of re-implementing Card + InkWell.
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.accentColor,
    this.padding = Spacing.cardPadding,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Optional left accent stripe + hover glow color.
  final Color? accentColor;

  final EdgeInsetsGeometry padding;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color accent = widget.accentColor ?? theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AnimationConstants.fast,
        curve: AnimationConstants.standard,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: _hovered && widget.onTap != null
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.18),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : const [],
        ),
        child: Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                border: Border.all(
                  color: _hovered && widget.onTap != null
                      ? accent.withValues(alpha: 0.6)
                      : theme.colorScheme.outline,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.accentColor != null)
                     Container(
  width: 3,
  constraints: const BoxConstraints(minHeight: 80),
  color: widget.accentColor,
),
                    Expanded(
                      child: Padding(
                        padding: widget.padding,
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
