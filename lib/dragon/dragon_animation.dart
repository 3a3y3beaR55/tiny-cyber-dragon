import 'dart:async';

import 'package:flutter/material.dart';

class DragonAnimation extends StatefulWidget {
  final List<String> frames;
  final double size;
  final Duration frameDuration;

  const DragonAnimation({
    super.key,
    required this.frames,
    this.size = 200,
    this.frameDuration = const Duration(milliseconds: 140),
  });

  @override
  State<DragonAnimation> createState() => _DragonAnimationState();
}

class _DragonAnimationState extends State<DragonAnimation> {
  late Timer _timer;
  int _frame = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.frameDuration, (_) {
      if (!mounted) return;

      setState(() {
        _frame++;
        if (_frame >= widget.frames.length) {
          _frame = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.frames[_frame],
      width: widget.size,
      height: widget.size,
      filterQuality: FilterQuality.high,
    );
  }
}
