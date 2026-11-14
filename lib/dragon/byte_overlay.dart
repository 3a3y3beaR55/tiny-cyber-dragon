
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'byte_animation_frames.dart';
import 'byte_animation_state.dart';
import 'byte_position_provider.dart';
import 'dragon_animation.dart';

const _heroAnchorAsset =
    'assets/byte/hero/byte_hero_anchor_open.png';

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

    const dragonSize = 175.0;
    const verticalOffset = 20.0;

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              left: (size.width * position.x) -
                  (dragonSize / 2),
              top: (size.height * position.y) -
                  verticalOffset,
              width: dragonSize,
              height: dragonSize,
              child: DragonAnimation(
                size: dragonSize,
                frames: ByteAnimationFrames.frames[state]!,
                heroImage:
                    state == ByteAnimationState.idle
                        ? _heroAnchorAsset
                        : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
