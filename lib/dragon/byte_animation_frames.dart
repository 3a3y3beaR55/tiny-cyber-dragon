import 'byte_animation_state.dart';

class ByteAnimationFrames {
  static const Map<ByteAnimationState, List<String>> frames = {
    ByteAnimationState.idle: [
      'assets/byte/idle/byte_01.png',
      'assets/byte/idle/byte_02.png',
      'assets/byte/idle/byte_03.png',
      'assets/byte/idle/byte_04.png',
      'assets/byte/idle/byte_05.png',
      'assets/byte/idle/byte_06.png',
      'assets/byte/idle/byte_07.png',
      'assets/byte/idle/byte_08.png',
    ],
    ByteAnimationState.pulse: [
      'assets/byte/idle/byte_01.png',
      'assets/byte/idle/byte_02.png',
      'assets/byte/idle/byte_01.png',
    ],
    ByteAnimationState.still: [
      'assets/byte/idle/byte_08.png',
    ],
  };
}
