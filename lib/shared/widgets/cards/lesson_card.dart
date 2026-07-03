import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../feedback/progress_widget.dart';
import 'app_card.dart';

/// LessonCard — a lesson entry anywhere lessons are listed.
///
/// Reuse: Home preview, Learn screen lists, future search results.
/// Content-only widget: takes plain values now; when the lesson model
/// arrives in a later sprint, add a `LessonCard.fromModel` factory.
class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.title,
    this.description,
    this.durationMinutes,
    this.progress = 0,
    this.onTap,
  });

  final String title;
  final String? description;
  final int? durationMinutes;

  /// 0.0–1.0. Zero hides the progress bar and shows "Start".
  final double progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool started = progress > 0;

    return AppCard(
      onTap: onTap,
      accentColor: StatusColors.info,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school_outlined,
                  color: StatusColors.info, size: 20),
              Spacing.gapXs,
              Expanded(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
              if (durationMinutes != null)
                Text(
                  '$durationMinutes min',
                  style: theme.textTheme.labelSmall,
                ),
            ],
          ),
          if (description != null) ...[
            Spacing.gapXs,
            Text(
              description!,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          Spacing.gapSm,
          if (started)
            ProgressWidget(value: progress, color: StatusColors.info)
          else
            Text(
              'Not started',
              style: theme.textTheme.labelSmall,
            ),
        ],
      ),
    );
  }
}
