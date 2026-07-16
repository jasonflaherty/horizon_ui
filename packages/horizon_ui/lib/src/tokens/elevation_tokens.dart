import 'package:flutter/material.dart';

/// Elevation recipes: glass blur, liquid glass optics, flat, raised, floating.
@immutable
class HorizonElevationTokens {
  const HorizonElevationTokens({
    required this.glassBlur,
    required this.glassOpacity,
    required this.flat,
    required this.raised,
    required this.floating,
    this.refraction = 0.08,
    this.specular = 0.35,
    this.tint = const Color(0x66FFFFFF),
    this.edgeWidth = 1.25,
    this.imperfectShadowOffset = const Offset(0.6, 2.4),
  });

  final double glassBlur;
  final double glassOpacity;
  final List<BoxShadow> flat;
  final List<BoxShadow> raised;
  final List<BoxShadow> floating;

  /// How strongly the liquid highlight shifts with content (0–1).
  final double refraction;

  /// Edge specular strength (0–1).
  final double specular;

  /// Glass wash tint.
  final Color tint;

  /// Specular edge stroke width.
  final double edgeWidth;

  /// Slightly imperfect shadow offset for anti-perfect UI.
  final Offset imperfectShadowOffset;

  factory HorizonElevationTokens.standard({Color shadowColor = Colors.black}) {
    return HorizonElevationTokens(
      glassBlur: 16,
      glassOpacity: 0.55,
      refraction: 0.06,
      specular: 0.28,
      tint: const Color(0x55FFFFFF),
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

  factory HorizonElevationTokens.liquid({
    Color shadowColor = Colors.black,
    Color tint = const Color(0x66B8E0F0),
  }) {
    return HorizonElevationTokens(
      glassBlur: 28,
      glassOpacity: 0.42,
      refraction: 0.16,
      specular: 0.55,
      tint: tint,
      edgeWidth: 1.6,
      imperfectShadowOffset: const Offset(1.1, 3.2),
      flat: const [],
      raised: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.1),
          blurRadius: 14,
          offset: const Offset(0.8, 3),
        ),
      ],
      floating: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.16),
          blurRadius: 28,
          offset: const Offset(1.2, 10),
        ),
      ],
    );
  }

  factory HorizonElevationTokens.cyber({required Color glow}) {
    return HorizonElevationTokens(
      glassBlur: 12,
      glassOpacity: 0.35,
      refraction: 0.02,
      specular: 0.45,
      tint: glow.withValues(alpha: 0.12),
      edgeWidth: 1.5,
      flat: const [],
      raised: [BoxShadow(color: glow.withValues(alpha: 0.25), blurRadius: 12)],
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

  factory HorizonElevationTokens.calm({Color shadowColor = Colors.black}) {
    return HorizonElevationTokens(
      glassBlur: 20,
      glassOpacity: 0.5,
      refraction: 0.05,
      specular: 0.2,
      tint: const Color(0x44FFFFFF),
      edgeWidth: 1,
      imperfectShadowOffset: const Offset(0.4, 2),
      flat: const [],
      raised: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0.4, 2.2),
        ),
      ],
      floating: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.12),
          blurRadius: 20,
          offset: const Offset(0.6, 6),
        ),
      ],
    );
  }

  HorizonElevationTokens lerp(HorizonElevationTokens other, double t) {
    return HorizonElevationTokens(
      glassBlur: glassBlur + (other.glassBlur - glassBlur) * t,
      glassOpacity: glassOpacity + (other.glassOpacity - glassOpacity) * t,
      refraction: refraction + (other.refraction - refraction) * t,
      specular: specular + (other.specular - specular) * t,
      tint: Color.lerp(tint, other.tint, t)!,
      edgeWidth: edgeWidth + (other.edgeWidth - edgeWidth) * t,
      imperfectShadowOffset: Offset.lerp(
        imperfectShadowOffset,
        other.imperfectShadowOffset,
        t,
      )!,
      flat: t < 0.5 ? flat : other.flat,
      raised: t < 0.5 ? raised : other.raised,
      floating: t < 0.5 ? floating : other.floating,
    );
  }
}
