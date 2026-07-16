import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Motion durations and shared curves.
@immutable
class HorizonMotionTokens {
  const HorizonMotionTokens({
    this.fast = const Duration(milliseconds: 150),
    this.medium = const Duration(milliseconds: 250),
    this.slow = const Duration(milliseconds: 450),
    this.standard = Curves.easeInOutCubic,
    this.emphasized = Curves.easeOutCubic,
    this.spring = const SpringDescription(mass: 1, stiffness: 180, damping: 18),
  });

  final Duration fast;
  final Duration medium;
  final Duration slow;
  final Curve standard;
  final Curve emphasized;
  final SpringDescription spring;

  static const HorizonMotionTokens standardTokens = HorizonMotionTokens();

  HorizonMotionTokens lerp(HorizonMotionTokens other, double t) {
    return t < 0.5 ? this : other;
  }
}
