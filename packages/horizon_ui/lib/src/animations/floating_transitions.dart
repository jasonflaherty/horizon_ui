import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import 'horizon_motion.dart';

/// Gently floats a child on the Y axis.
class FloatingCard extends StatefulWidget {
  const FloatingCard({super.key, required this.child, this.amplitude = 6});

  final Widget child;
  final double amplitude;

  @override
  State<FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard>
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
    final Duration duration = HorizonMotion.slow(context) * 5;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat(reverse: true);
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
    final Curve curve = context.horizon.motion.standard;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = curve.transform(_controller.value);
        final double dy = (t - 0.5) * 2 * widget.amplitude;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: widget.child,
    );
  }
}

/// Shared page route builders with Horizon motion tokens.
abstract final class HorizonPageTransitions {
  static Route<T> fade<T extends Object?>({
    required Widget page,
    required BuildContext context,
    RouteSettings? settings,
  }) {
    final Duration duration = HorizonMotion.medium(context);
    final Curve curve = context.horizon.motion.emphasized;
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: curve),
              child: child,
            );
          },
    );
  }

  static Route<T> slideUp<T extends Object?>({
    required Widget page,
    required BuildContext context,
    RouteSettings? settings,
  }) {
    final Duration duration = HorizonMotion.medium(context);
    final Curve curve = context.horizon.motion.emphasized;
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final Animation<Offset> offset = Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: curve));
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offset, child: child),
            );
          },
    );
  }

  /// Continuous journey: scale + fade for cause/effect navigation.
  static Route<T> journey<T extends Object?>({
    required Widget page,
    required BuildContext context,
    RouteSettings? settings,
  }) {
    final Duration duration = HorizonMotion.medium(context);
    final Curve curve = context.horizon.motion.human;
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final Animation<double> curved = CurvedAnimation(
              parent: animation,
              curve: curve,
            );
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
                child: child,
              ),
            );
          },
    );
  }
}

/// Drives a 0→1 draw progress for charts (instant when reduced motion).
class ChartDrawAnimation extends StatelessWidget {
  const ChartDrawAnimation({
    super.key,
    required this.builder,
    this.duration,
    this.curve,
  });

  final Widget Function(BuildContext context, double progress) builder;
  final Duration? duration;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    final Duration d = duration ?? HorizonMotion.slow(context);
    final Curve c = curve ?? context.horizon.motion.emphasized;

    if (!HorizonMotion.shouldAnimate(context) || d == Duration.zero) {
      return builder(context, 1);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: d,
      curve: c,
      builder: (BuildContext context, double value, Widget? child) {
        return builder(context, value);
      },
    );
  }
}
