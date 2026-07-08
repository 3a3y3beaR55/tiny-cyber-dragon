import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'byte_animation_frames.dart';
import 'byte_animation_state.dart';
import 'byte_position_provider.dart';
import 'dragon_animation.dart';

class ByteOverlay extends ConsumerWidget {
  final ByteAnimationState state;

  const ByteOverlay({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(bytePositionProvider);

    final size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            left: (size.width * position.x) - 75,
            top: size.height * position.y,
            child: DragonAnimation(
              size: 150,
              frames: ByteAnimationFrames.frames[state]!,
            ),
          ),
        ],
      ),
    );
  }
}
