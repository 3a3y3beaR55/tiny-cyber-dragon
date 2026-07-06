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
  Timer? _timer;
  int _frame = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant DragonAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.frames != widget.frames ||
        oldWidget.frameDuration != widget.frameDuration) {
      _frame = 0;
      _timer?.cancel();
      _startTimer();
    }
  }

  void _startTimer() {
    if (widget.frames.length <= 1) return;

    _timer = Timer.periodic(widget.frameDuration, (_) {
      if (!mounted || widget.frames.isEmpty) return;

      setState(() {
        _frame = (_frame + 1) % widget.frames.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.frames.isEmpty) {
      return SizedBox.square(dimension: widget.size);
    }

    return Image.asset(
      widget.frames[_frame],
      width: widget.size,
      height: widget.size,
      filterQuality: FilterQuality.high,
      gaplessPlayback: true,
    );
  }
}
