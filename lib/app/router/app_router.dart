import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/learn/presentation/learn_screen.dart';
import '../../features/missions/presentation/missions_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/threat_library/presentation/threat_library_screen.dart';
import '../shell/app_shell.dart';

/// Route paths — referenced by name everywhere; never hard-code path
/// strings in feature code.
abstract final class AppRoutes {
  static const String home = '/home';
  static const String learn = '/learn';
  static const String threats = '/threats';
  static const String missions = '/missions';
  static const String settings = '/settings';
}

/// appRouter — declarative navigation for the whole product.
///
/// Architecture: `StatefulShellRoute.indexedStack` keeps each section's
/// navigation stack alive when switching tabs (desktop users expect this),
/// and gives us URL-style deep links for free — valuable when lessons and
/// threats become linkable in later sprints. Child routes (e.g.
/// `/learn/lesson/:id`) nest inside their branch without shell changes.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: _page(const HomeScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.learn,
              pageBuilder: _page(const LearnScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.threats,
              pageBuilder: _page(const ThreatLibraryScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.missions,
              pageBuilder: _page(const MissionsScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              pageBuilder: _page(const SettingsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Fade transition shared by all top-level sections — calm, desktop-feel.
Page<void> Function(BuildContext, GoRouterState) _page(Widget child) {
  return (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}
