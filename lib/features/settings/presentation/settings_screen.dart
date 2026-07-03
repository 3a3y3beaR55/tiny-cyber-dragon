import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/theme_mode_provider.dart';
import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';

/// SettingsScreen — app preferences.
///
/// Sprint 001: theme mode toggle only (it exercises the theme system
/// end-to-end). Accessibility options, profiles, and data controls arrive
/// in future sprints.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode mode = ref.watch(themeModeProvider);
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: Spacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Settings',
            subtitle: 'Make Tiny Cyber Dragon yours',
          ),
          AppCard(
            child: Row(
              children: [
                Icon(
                  Icons.dark_mode_outlined,
                  color: theme.colorScheme.primary,
                ),
                Spacing.gapSm,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Appearance', style: theme.textTheme.titleMedium),
                      Spacing.gapXxs,
                      Text(
                        'Dark is our signature look. Light theme is a '
                        'work in progress.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Spacing.gapSm,
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode, size: 16),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode, size: 16),
                    ),
                  ],
                  selected: {mode},
                  onSelectionChanged: (selection) => ref
                      .read(themeModeProvider.notifier)
                      .state = selection.first,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
