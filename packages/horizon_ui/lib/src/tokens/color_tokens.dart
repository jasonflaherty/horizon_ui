import 'package:flutter/material.dart';

/// Semantic color tokens shared by every Horizon theme.
@immutable
class HorizonColorTokens {
  const HorizonColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.border,
    required this.glow,
    this.surfaceVariant,
    this.onSurfaceVariant,
  });

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color accent;
  final Color onAccent;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color border;
  final Color glow;
  final Color? surfaceVariant;
  final Color? onSurfaceVariant;

  Color get resolvedSurfaceVariant => surfaceVariant ?? surface;
  Color get resolvedOnSurfaceVariant =>
      onSurfaceVariant ?? onSurface.withValues(alpha: 0.7);

  HorizonColorTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? onBackground,
    Color? border,
    Color? glow,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
  }) {
    return HorizonColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      border: border ?? this.border,
      glow: glow ?? this.glow,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
    );
  }

  HorizonColorTokens lerp(HorizonColorTokens other, double t) {
    return HorizonColorTokens(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      surfaceVariant: Color.lerp(
        resolvedSurfaceVariant,
        other.resolvedSurfaceVariant,
        t,
      ),
      onSurfaceVariant: Color.lerp(
        resolvedOnSurfaceVariant,
        other.resolvedOnSurfaceVariant,
        t,
      ),
    );
  }
}
