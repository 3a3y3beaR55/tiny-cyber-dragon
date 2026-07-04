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
    ByteAnimationState.scanning: [
      'assets/byte/scan/byte_33.png',
      'assets/byte/scan/byte_34.png',
      'assets/byte/scan/byte_35.png',
      'assets/byte/scan/byte_36.png',
      'assets/byte/scan/byte_37.png',
      'assets/byte/scan/byte_38.png',
    ],
    ByteAnimationState.warning: [
      'assets/byte/fire/byte_17.png',
      'assets/byte/fire/byte_18.png',
    ],
    ByteAnimationState.threat: [
      'assets/byte/fire/byte_17.png',
      'assets/byte/fire/byte_18.png',
      'assets/byte/fire/byte_19.png',
      'assets/byte/fire/byte_20.png',
      'assets/byte/fire/byte_21.png',
      'assets/byte/fire/byte_22.png',
      'assets/byte/fire/byte_23.png',
      'assets/byte/fire/byte_24.png',
    ],
    ByteAnimationState.complete: [
      'assets/byte/idle/byte_01.png',
      'assets/byte/idle/byte_02.png',
      'assets/byte/idle/byte_01.png',
    ],
    ByteAnimationState.learning: [
      'assets/byte/idle/byte_03.png',
      'assets/byte/idle/byte_04.png',
    ],
    ByteAnimationState.updating: [
      'assets/byte/scan/byte_33.png',
      'assets/byte/scan/byte_34.png',
      'assets/byte/scan/byte_35.png',
    ],
    ByteAnimationState.sleeping: [
      'assets/byte/idle/byte_08.png',
    ],
  };
}
