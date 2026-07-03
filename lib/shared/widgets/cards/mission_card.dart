import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'app_card.dart';

/// Mission difficulty tiers. Shared vocabulary for all mission features.
enum MissionDifficulty { beginner, intermediate, advanced }

/// MissionCard — a guided-simulation mission entry.
///
/// Reuse: Home preview, Missions screen, future mission chains.
class MissionCard extends StatelessWidget {
  const MissionCard({
    super.key,
    required this.title,
    this.description,
    this.difficulty = MissionDifficulty.beginner,
    this.completed = false,
    this.onTap,
  });

  final String title;
  final String? description;
  final MissionDifficulty difficulty;
  final bool completed;
  final VoidCallback? onTap;

  Color get _difficultyColor => switch (difficulty) {
        MissionDifficulty.beginner => StatusColors.safe,
        MissionDifficulty.intermediate => StatusColors.warning,
        MissionDifficulty.advanced => ColorTokens.accent,
      };

  String get _difficultyLabel => switch (difficulty) {
        MissionDifficulty.beginner => 'Beginner',
        MissionDifficulty.intermediate => 'Intermediate',
        MissionDifficulty.advanced => 'Advanced',
      };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      accentColor: ColorTokens.accent,
      child: Row(
        children: [
          Icon(
            completed ? Icons.verified_outlined : Icons.flag_outlined,
            color: completed ? StatusColors.safe : ColorTokens.accent,
            size: 22,
          ),
          Spacing.gapSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                if (description != null) ...[
                  Spacing.gapXxs,
                  Text(
                    description!,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Spacing.gapSm,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.xs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: _difficultyColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
            child: Text(
              _difficultyLabel,
              style: theme.textTheme.labelSmall!
                  .copyWith(color: _difficultyColor),
            ),
          ),
        ],
      ),
    );
  }
}
