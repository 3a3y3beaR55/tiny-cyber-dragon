import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode for the whole app. Settings writes to it; the root app
/// consumes it. Dark is the product default.
///
/// Lives in core (not app/) so features can import it without depending on
/// the application frame — keeping the dependency rule one-directional.
///
/// Future expansion: persist the choice via a core storage service.
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((ref) => ThemeMode.dark);
