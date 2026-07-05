import 'package:flutter/foundation.dart';

import 'byte_animation_state.dart';

class ByteController extends ChangeNotifier {
  ByteAnimationState _state = ByteAnimationState.idle;

  ByteAnimationState get state => _state;

  void setState(ByteAnimationState state) {
    if (_state == state) return;

    _state = state;
    notifyListeners();
  }

  void idle() => setState(ByteAnimationState.idle);

  void scanning() => setState(ByteAnimationState.pulse);

  void warning() => setState(ByteAnimationState.pulse);

  void threat() => setState(ByteAnimationState.pulse);

  void complete() => setState(ByteAnimationState.pulse);

  void learning() => setState(ByteAnimationState.pulse);

  void updating() => setState(ByteAnimationState.pulse);

  void sleeping() => setState(ByteAnimationState.still);
}
