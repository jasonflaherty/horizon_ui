import 'package:flutter/foundation.dart';

import 'color_tokens.dart';
import 'elevation_tokens.dart';
import 'motion_tokens.dart';
import 'radius_tokens.dart';
import 'spacing_tokens.dart';
import 'typography_tokens.dart';

/// Immutable bag of all Horizon design tokens for a theme.
@immutable
class HorizonTokens {
  const HorizonTokens({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.elevation,
    required this.motion,
  });

  final HorizonColorTokens colors;
  final HorizonTypographyTokens typography;
  final HorizonSpacingTokens spacing;
  final HorizonRadiusTokens radius;
  final HorizonElevationTokens elevation;
  final HorizonMotionTokens motion;

  HorizonTokens copyWith({
    HorizonColorTokens? colors,
    HorizonTypographyTokens? typography,
    HorizonSpacingTokens? spacing,
    HorizonRadiusTokens? radius,
    HorizonElevationTokens? elevation,
    HorizonMotionTokens? motion,
  }) {
    return HorizonTokens(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      elevation: elevation ?? this.elevation,
      motion: motion ?? this.motion,
    );
  }

  bool get isCalmDensity => spacing.density == HorizonDensity.calm;

  HorizonTokens lerp(HorizonTokens other, double t) {
    return HorizonTokens(
      colors: colors.lerp(other.colors, t),
      typography: typography.lerp(other.typography, t),
      spacing: spacing.lerp(other.spacing, t),
      radius: radius.lerp(other.radius, t),
      elevation: elevation.lerp(other.elevation, t),
      motion: motion.lerp(other.motion, t),
    );
  }
}
