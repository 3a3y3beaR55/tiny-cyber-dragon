import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_cyber_dragon/core/theme/theme.dart';
import 'package:tiny_cyber_dragon/shared/byte/byte.dart';

/// ByteWidget tests.
///
/// Note: Byte animates on an infinite loop, so tests use `pump` with fixed
/// durations — never `pumpAndSettle`, which would wait forever.
void main() {
  Widget wrap(Widget child) => MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: Center(child: child)),
      );

  testWidgets('renders avatar with semantic mood label', (tester) async {
    await tester.pumpWidget(wrap(const ByteWidget(mood: ByteMood.thinking)));
    await tester.pump(const Duration(milliseconds: 100));

    expect(
      find.bySemanticsLabel('Byte the cyber dragon, feeling thinking'),
      findsOneWidget,
    );
  });

  testWidgets('shows speech bubble when message is set', (tester) async {
    await tester.pumpWidget(
      wrap(const ByteWidget(message: 'Stay sharp out there!')),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Stay sharp out there!'), findsOneWidget);
  });

  testWidgets('hides bubble when position is messageNone', (tester) async {
    await tester.pumpWidget(
      wrap(
        const ByteWidget(
          message: 'Hidden words',
          position: BytePosition.messageNone,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Hidden words'), findsNothing);
  });

  test('ByteStatusNotifier intention methods update state', () {
    final ProviderContainer container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(byteStatusProvider.notifier).warn('Careful!');
    ByteState state = container.read(byteStatusProvider);
    expect(state.status, ByteStatus.warning);
    expect(state.mood, ByteMood.alert);
    expect(state.animationState, ByteAnimationState.pulse);
    expect(state.message, 'Careful!');

    container.read(byteStatusProvider.notifier).relax();
    state = container.read(byteStatusProvider);
    expect(state.status, ByteStatus.idle);
    expect(state.mood, ByteMood.happy);
    expect(state.message, isNull);
  });

  test('every ByteStatus resolves complete visual metadata', () {
    for (final ByteStatus status in ByteStatus.values) {
      final ByteStatusData data = status.data;
      expect(data.label, isNotEmpty, reason: '$status label');
      expect(data.message, isNotEmpty, reason: '$status message');
      expect(data.animationName, isNotEmpty, reason: '$status animation');
    }
  });
}
