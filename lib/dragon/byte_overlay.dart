import 'package:flutter/material.dart';

import 'dragon_animation.dart';
import 'byte_animation_frames.dart';
import 'byte_animation_state.dart';

class ByteOverlay extends StatelessWidget {
  final ByteAnimationState state;

  const ByteOverlay({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 28),
          child: DragonAnimation(
            size: 150,
            frames: ByteAnimationFrames.frames[state]!,
          ),
        ),
      ),
    );
  }
}
