import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Soft settle curve for anti-perfect / human motion.
class HorizonHumanCurve extends Curve {
  const HorizonHumanCurve();

  @override
  double transformInternal(double t) {
    // Ease-out with a slight late settle (micro-delay feel).
    final double eased = Curves.easeOutCubic.transform(t);
    final double settle = (1 - (1 - t) * (1 - t)) * 0.04;
    return (eased - settle * (1 - t)).clamp(0.0, 1.0);
  }
}

/// Motion durations and shared curves.
@immutable
class HorizonMotionTokens {
  const HorizonMotionTokens({
    this.fast = const Duration(milliseconds: 150),
    this.medium = const Duration(milliseconds: 250),
    this.slow = const Duration(milliseconds: 450),
    this.standard = Curves.easeInOutCubic,
    this.emphasized = Curves.easeOutCubic,
    this.human = const HorizonHumanCurve(),
    this.spring = const SpringDescription(mass: 1, stiffness: 180, damping: 18),
  });

  final Duration fast;
  final Duration medium;
  final Duration slow;
  final Curve standard;
  final Curve emphasized;

  /// Slightly imperfect settle curve for human-centric motion.
  final Curve human;
  final SpringDescription spring;

  static const HorizonMotionTokens standardTokens = HorizonMotionTokens();

  static const HorizonMotionTokens calmTokens = HorizonMotionTokens(
    fast: Duration(milliseconds: 180),
    medium: Duration(milliseconds: 320),
    slow: Duration(milliseconds: 520),
  );

  HorizonMotionTokens lerp(HorizonMotionTokens other, double t) {
    return t < 0.5 ? this : other;
  }
}
