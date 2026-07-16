import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import 'horizon_motion.dart';

/// Animates a numeric value with count-up (respects reduced motion).
class AnimatedNumber extends StatelessWidget {
  const AnimatedNumber({
    super.key,
    required this.value,
    this.duration,
    this.curve,
    this.decimalPlaces = 0,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.semanticLabel,
  });

  final double value;
  final Duration? duration;
  final Curve? curve;
  final int decimalPlaces;
  final String prefix;
  final String suffix;
  final TextStyle? style;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final TextStyle resolved = style ?? context.horizon.typography.numeric;
    final Duration d = duration ?? HorizonMotion.slow(context);
    final Curve c = curve ?? context.horizon.motion.emphasized;

    if (!HorizonMotion.shouldAnimate(context) || d == Duration.zero) {
      return Text(
        _format(value),
        style: resolved,
        semanticsLabel: semanticLabel ?? _format(value),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: d,
      curve: c,
      builder: (BuildContext context, double v, Widget? child) {
        return Text(
          _format(v),
          style: resolved,
          semanticsLabel: semanticLabel ?? _format(value),
        );
      },
    );
  }

  String _format(double v) {
    final String number = decimalPlaces <= 0
        ? v.round().toString()
        : v.toStringAsFixed(decimalPlaces);
    return '$prefix$number$suffix';
  }
}
