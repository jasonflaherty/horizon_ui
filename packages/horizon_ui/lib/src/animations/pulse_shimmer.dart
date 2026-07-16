import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import 'horizon_motion.dart';

/// Soft scale/opacity pulse for status indicators and glow accents.
class HorizonPulse extends StatefulWidget {
  const HorizonPulse({
    super.key,
    required this.child,
    this.minScale = 0.96,
    this.maxScale = 1.04,
    this.minOpacity = 0.7,
    this.maxOpacity = 1,
  });

  final Widget child;
  final double minScale;
  final double maxScale;
  final double minOpacity;
  final double maxOpacity;

  @override
  State<HorizonPulse> createState() => _HorizonPulseState();
}

class _HorizonPulseState extends State<HorizonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Duration duration = HorizonMotion.slow(context) * 2;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat(reverse: true);
    } else {
      _controller
        ..stop()
        ..value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value;
        final double scale =
            widget.minScale + (widget.maxScale - widget.minScale) * t;
        final double opacity =
            widget.minOpacity + (widget.maxOpacity - widget.minOpacity) * t;
        return Opacity(
          opacity: opacity,
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: widget.child,
    );
  }
}

/// Skeleton shimmer for loading placeholders.
class HorizonShimmer extends StatefulWidget {
  const HorizonShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<HorizonShimmer> createState() => _HorizonShimmerState();
}

class _HorizonShimmerState extends State<HorizonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Duration duration = HorizonMotion.slow(context) * 3;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat();
    } else {
      _controller
        ..stop()
        ..value = 0.5;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.horizon.colors;
    final BorderRadius radius =
        widget.borderRadius ?? BorderRadius.circular(context.horizon.radius.sm);

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment(-1 + 2 * _controller.value, 0),
              end: Alignment(0 + 2 * _controller.value, 0),
              colors: [
                colors.resolvedSurfaceVariant.withValues(alpha: 0.35),
                colors.surface.withValues(alpha: 0.9),
                colors.resolvedSurfaceVariant.withValues(alpha: 0.35),
              ],
            ),
          ),
        );
      },
    );
  }
}
