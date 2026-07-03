import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// Entry point. Kept minimal by design: bootstrapping (Supabase init,
/// window sizing, crash reporting) will slot in here in future sprints
/// without touching the widget tree.
void main() {
  runApp(
    const ProviderScope(
      child: TinyCyberDragonApp(),
    ),
  );
}
