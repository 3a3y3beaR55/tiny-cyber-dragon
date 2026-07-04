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

  void scanning() => setState(ByteAnimationState.scanning);

  void warning() => setState(ByteAnimationState.warning);

  void threat() => setState(ByteAnimationState.threat);

  void complete() => setState(ByteAnimationState.complete);

  void learning() => setState(ByteAnimationState.learning);

  void updating() => setState(ByteAnimationState.updating);

  void sleeping() => setState(ByteAnimationState.sleeping);
}
