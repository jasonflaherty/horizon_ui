import 'package:flutter/foundation.dart';

/// Spacing scale used across layout and components.
@immutable
class HorizonSpacingTokens {
  const HorizonSpacingTokens({
    this.x1 = 4,
    this.x2 = 8,
    this.x3 = 12,
    this.x4 = 16,
    this.x5 = 20,
    this.x6 = 24,
    this.x8 = 32,
    this.x10 = 40,
    this.x12 = 48,
    this.x16 = 64,
  });

  final double x1;
  final double x2;
  final double x3;
  final double x4;
  final double x5;
  final double x6;
  final double x8;
  final double x10;
  final double x12;
  final double x16;

  static const HorizonSpacingTokens standard = HorizonSpacingTokens();

  HorizonSpacingTokens lerp(HorizonSpacingTokens other, double t) {
    double lerpDouble(double a, double b) => a + (b - a) * t;
    return HorizonSpacingTokens(
      x1: lerpDouble(x1, other.x1),
      x2: lerpDouble(x2, other.x2),
      x3: lerpDouble(x3, other.x3),
      x4: lerpDouble(x4, other.x4),
      x5: lerpDouble(x5, other.x5),
      x6: lerpDouble(x6, other.x6),
      x8: lerpDouble(x8, other.x8),
      x10: lerpDouble(x10, other.x10),
      x12: lerpDouble(x12, other.x12),
      x16: lerpDouble(x16, other.x16),
    );
  }
}
