import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_cyber_dragon/app/app.dart';

/// Application shell smoke tests.
///
/// Byte animates on an infinite loop, so tests use `pump` with fixed
/// durations — never `pumpAndSettle`.
void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const ProviderScope(child: TinyCyberDragonApp()),
    );
    await tester.pump(const Duration(milliseconds: 400));
  }

  testWidgets('launches to the Home dashboard', (tester) async {
    await pumpApp(tester);

    expect(find.text('Continue Learning'), findsOneWidget);
    expect(find.text('Run Safety Check'), findsOneWidget);
  });

  testWidgets('rail shows all five destinations', (tester) async {
    await pumpApp(tester);

    for (final String label in [
      'Home',
      'Learn',
      'Threats',
      'Missions',
      'Settings',
    ]) {
      expect(find.text(label), findsWidgets);
    }
  });

  testWidgets('navigates to Learn via the rail', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Learn'));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Lessons are hatching'), findsOneWidget);
  });

  testWidgets('navigates to Settings and shows theme toggle', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Settings'));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Appearance'), findsOneWidget);
  });
}
