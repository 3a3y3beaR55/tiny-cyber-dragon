import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

/// LoadingWidget — the standard "please wait" state.
///
/// Reuse: any async gap (future Supabase fetches, scans, content loads).
/// Keeps loading friendly with an optional message.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.message, this.compact = false});

  /// Optional friendly status ("Byte is fetching your lessons…").
  final String? message;

  /// Compact = inline spinner; otherwise centered block.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget spinner = SizedBox(
      width: compact ? 18 : 36,
      height: compact ? 18 : 36,
      child: CircularProgressIndicator(
        strokeWidth: compact ? 2.2 : 3,
        color: theme.colorScheme.primary,
      ),
    );

    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          spinner,
          if (message != null) ...[
            Spacing.gapXs,
            Text(message!, style: theme.textTheme.bodyMedium),
          ],
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spinner,
          if (message != null) ...[
            Spacing.gapMd,
            Text(
              message!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
