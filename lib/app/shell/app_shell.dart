import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../dragon/byte_position_provider.dart';
import '../../core/theme/theme.dart';
import '../../shared/byte/byte.dart';

/// AppShell — the desktop navigation frame around every screen.
///
/// Layout: NavigationRail on the left (standard desktop pattern, scales to
/// more sections), current section on the right. A mini Byte lives at the
/// bottom of the rail so the companion is always present.
///
/// The shell renders whatever branch `navigationShell` provides — it knows
/// nothing about individual screens, so adding a section means adding a
/// branch in `app_router.dart` and a destination here. Nothing else.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<_ShellDestination> _destinations = [
    _ShellDestination('Home', Icons.home_outlined, Icons.home),
    _ShellDestination('Learn', Icons.school_outlined, Icons.school),
    _ShellDestination('Threats', Icons.shield_outlined, Icons.shield),
    _ShellDestination('Missions', Icons.flag_outlined, Icons.flag),
    _ShellDestination('Settings', Icons.settings_outlined, Icons.settings),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ByteState byte = ref.watch(byteStatusProvider);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              final bytePosition = ref.read(bytePositionProvider.notifier);

              switch (index) {
                case 0:
                  bytePosition.home();
                  break;
                case 1:
                  bytePosition.learn();
                  break;
                case 2:
                  bytePosition.threats();
                  break;
                case 3:
                  bytePosition.missions();
                  break;
                case 4:
                  bytePosition.settings();
                  break;
              }

              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              child: Column(
                children: [
                  ByteAvatar(
                    expression: byte.mood,
                    eyeColor: byte.eyeColor,
                    glowColor: byte.glowColor,
                    animationState: byte.animationState,
                    size: 44,
                  ),
                  Spacing.gapXxs,
                  Text(
                    'BYTE',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            destinations: [
              for (final _ShellDestination d in _destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _ShellDestination {
  const _ShellDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
