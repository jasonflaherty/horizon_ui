import 'package:flutter/foundation.dart';

/// Corner radius scale.
@immutable
class HorizonRadiusTokens {
  const HorizonRadiusTokens({
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 20,
    this.xxl = 28,
    this.pill = 40,
  });

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double pill;

  static const HorizonRadiusTokens standard = HorizonRadiusTokens();

  /// Softer, larger corners for optical / liquid glass themes.
  static const HorizonRadiusTokens optical = HorizonRadiusTokens(
    sm: 10,
    md: 14,
    lg: 20,
    xl: 26,
    xxl: 34,
    pill: 44,
  );

  HorizonRadiusTokens lerp(HorizonRadiusTokens other, double t) {
    double lerpDouble(double a, double b) => a + (b - a) * t;
    return HorizonRadiusTokens(
      sm: lerpDouble(sm, other.sm),
      md: lerpDouble(md, other.md),
      lg: lerpDouble(lg, other.lg),
      xl: lerpDouble(xl, other.xl),
      xxl: lerpDouble(xxl, other.xxl),
      pill: lerpDouble(pill, other.pill),
    );
  }
}
