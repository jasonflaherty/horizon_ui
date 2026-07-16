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
    this.rimIntensity = 0.35,
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

  /// Optical rim lighting strength for gradient glass edges (0–1).
  final double rimIntensity;

  /// Slightly imperfect shadow offset for anti-perfect UI.
  final Offset imperfectShadowOffset;

  factory HorizonElevationTokens.standard({Color shadowColor = Colors.black}) {
    return HorizonElevationTokens(
      glassBlur: 16,
      glassOpacity: 0.55,
      refraction: 0.06,
      specular: 0.28,
      tint: const Color(0x55FFFFFF),
      rimIntensity: 0.3,
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

  /// Deep frosted optical glass — Luxury Coastal and similar.
  factory HorizonElevationTokens.liquid({
    Color shadowColor = Colors.black,
    Color tint = const Color(0x66B8E0F0),
  }) {
    return HorizonElevationTokens(
      glassBlur: 40,
      glassOpacity: 0.28,
      refraction: 0.22,
      specular: 0.78,
      tint: tint,
      edgeWidth: 1.8,
      rimIntensity: 0.9,
      imperfectShadowOffset: const Offset(1.4, 4.2),
      flat: const [],
      raised: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.14),
          blurRadius: 18,
          offset: const Offset(1, 4),
        ),
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.06),
          blurRadius: 4,
          offset: const Offset(0.4, 1.2),
        ),
      ],
      floating: [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.22),
          blurRadius: 36,
          offset: const Offset(1.6, 14),
        ),
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0.6, 3),
        ),
      ],
    );
  }

  /// Neon-rimmed liquid glass HUD — Cyber / Aurora-adjacent.
  factory HorizonElevationTokens.cyber({required Color glow}) {
    return HorizonElevationTokens(
      glassBlur: 36,
      glassOpacity: 0.22,
      refraction: 0.26,
      specular: 0.82,
      tint: glow.withValues(alpha: 0.2),
      edgeWidth: 1.55,
      rimIntensity: 1,
      imperfectShadowOffset: const Offset(1.6, 4.5),
      flat: const [],
      raised: [
        BoxShadow(color: glow.withValues(alpha: 0.28), blurRadius: 18),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
      floating: [
        BoxShadow(
          color: glow.withValues(alpha: 0.42),
          blurRadius: 40,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 28,
          offset: const Offset(0, 12),
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
      rimIntensity: 0.2,
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
      rimIntensity: rimIntensity + (other.rimIntensity - rimIntensity) * t,
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
