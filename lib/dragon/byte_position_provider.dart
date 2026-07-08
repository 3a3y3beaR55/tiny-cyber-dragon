import 'package:flutter_riverpod/flutter_riverpod.dart';

class BytePositionState {
  final double x;
  final double y;

  const BytePositionState({
    required this.x,
    required this.y,
  });

  BytePositionState copyWith({
    double? x,
    double? y,
  }) {
    return BytePositionState(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}

class BytePositionNotifier extends StateNotifier<BytePositionState> {
  BytePositionNotifier() : super(const BytePositionState(x: 0.5, y: 0.08));

  void moveTo(double x, double y) {
    state = BytePositionState(x: x, y: y);
  }

  void home() {
    state = const BytePositionState(x: 0.5, y: 0.08);
  }

  void learn() {
    state = const BytePositionState(x: 0.82, y: 0.20);
  }

  void missions() {
    state = const BytePositionState(x: 0.18, y: 0.45);
  }

  void threats() {
    state = const BytePositionState(x: 0.82, y: 0.55);
  }

  void settings() {
    state = const BytePositionState(x: 0.90, y: 0.12);
  }
}

final bytePositionProvider =
    StateNotifierProvider<BytePositionNotifier, BytePositionState>((ref) {
  return BytePositionNotifier();
});
