
import 'dart:async';

import 'package:flutter/material.dart';

class DragonAnimation extends StatefulWidget {
  final List<String> frames;
  final double size;
  final Duration frameDuration;
  final String? heroImage;

  const DragonAnimation({
    super.key,
    required this.frames,
    this.size = 200,
    this.frameDuration = const Duration(milliseconds: 140),
    this.heroImage,
  });

  @override
  State<DragonAnimation> createState() => _DragonAnimationState();
}

class _DragonAnimationState extends State<DragonAnimation>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _frame = 0;

  late final AnimationController _heroController;
  late final Animation<double> _heroLift;
  late final Animation<double> _heroScale;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    final curve = CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeInOutSine,
    );

    _heroLift = Tween<double>(
      begin: 0,
      end: -4,
    ).animate(curve);

    _heroScale = Tween<double>(
      begin: 1,
      end: 1.01,
    ).animate(curve);

    if (widget.heroImage == null) {
      _startTimer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncHeroAnimation();
  }

  @override
  void didUpdateWidget(covariant DragonAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.heroImage != widget.heroImage) {
      if (widget.heroImage != null) {
        _timer?.cancel();
        _timer = null;
      } else {
        _frame = 0;
        _startTimer();
      }
    } else if (widget.heroImage == null &&
        (oldWidget.frames != widget.frames ||
            oldWidget.frameDuration != widget.frameDuration)) {
      _frame = 0;
      _startTimer();
    }

    _syncHeroAnimation();
  }

  void _syncHeroAnimation() {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final shouldAnimate =
        widget.heroImage != null && !reduceMotion;

    if (shouldAnimate) {
      if (!_heroController.isAnimating) {
        _heroController.repeat(reverse: true);
      }
    } else {
      _heroController.stop();
      _heroController.value = 0;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = null;

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
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.heroImage != null) {
      return AnimatedBuilder(
        animation: _heroController,
        child: Image.asset(
          widget.heroImage!,
          width: widget.size,
          height: widget.size,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          gaplessPlayback: true,
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _heroLift.value),
            child: Transform.scale(
              scale: _heroScale.value,
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          );
        },
      );
    }

    if (widget.frames.isEmpty) {
      return SizedBox.square(dimension: widget.size);
    }

    return Image.asset(
      widget.frames[_frame],
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      gaplessPlayback: true,
    );
  }
}
