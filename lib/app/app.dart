import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/theme_mode_provider.dart';
import '../core/theme/theme.dart';
import '../dragon/byte_controller_provider.dart';
import '../dragon/byte_overlay.dart';
import 'router/app_router.dart';

/// TinyCyberDragonApp — the root widget.
class TinyCyberDragonApp extends ConsumerWidget {
  const TinyCyberDragonApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode mode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Tiny Cyber Dragon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      routerConfig: appRouter,
      builder: (context, child) {
        final animationState = ref.watch(byteControllerProvider).state;

        return Stack(
          children: [
            if (child != null) child,
            ByteOverlay(state: animationState),
          ],
        );
      },
    );
  }
}
