import 'package:flutter/material.dart';

/// Elevation recipes: glass blur, flat, raised, floating.
@immutable
class HorizonElevationTokens {
  const HorizonElevationTokens({
    required this.glassBlur,
    required this.glassOpacity,
    required this.flat,
    required this.raised,
    required this.floating,
  });

  final double glassBlur;
  final double glassOpacity;
  final List<BoxShadow> flat;
  final List<BoxShadow> raised;
  final List<BoxShadow> floating;

  factory HorizonElevationTokens.standard({Color shadowColor = Colors.black}) {
    return HorizonElevationTokens(
      glassBlur: 16,
      glassOpacity: 0.55,
      flat: const [],
      raised: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      floating: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.18),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.08),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  factory HorizonElevationTokens.cyber({required Color glow}) {
    return HorizonElevationTokens(
      glassBlur: 12,
      glassOpacity: 0.35,
      flat: const [],
      raised: [
        BoxShadow(
          color: glow.withValues(alpha: 0.25),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ],
      floating: [
        BoxShadow(
          color: glow.withValues(alpha: 0.45),
          blurRadius: 28,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  HorizonElevationTokens lerp(HorizonElevationTokens other, double t) {
    return HorizonElevationTokens(
      glassBlur: glassBlur + (other.glassBlur - glassBlur) * t,
      glassOpacity: glassOpacity + (other.glassOpacity - glassOpacity) * t,
      flat: t < 0.5 ? flat : other.flat,
      raised: t < 0.5 ? raised : other.raised,
      floating: t < 0.5 ? floating : other.floating,
    );
  }
}
