import 'package:flutter/material.dart';

/// Typography scale with a dedicated numeric style (tabular figures).
@immutable
class HorizonTypographyTokens {
  const HorizonTypographyTokens({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.numeric,
  });

  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle numeric;

  static const List<FontFeature> tabularFigures = [
    FontFeature.tabularFigures(),
  ];

  /// Material-aligned scale used by Classic.
  factory HorizonTypographyTokens.material({
    Color? color,
    String? fontFamily,
    String? numericFontFamily,
  }) {
    final Color c = color ?? const Color(0xFF1A1C1E);
    return HorizonTypographyTokens(
      display: TextStyle(
        fontFamily: fontFamily,
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -0.5,
        color: c,
      ),
      headline: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.25,
        color: c,
      ),
      title: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: c,
      ),
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: c,
      ),
      label: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.2,
        color: c,
      ),
      numeric: TextStyle(
        fontFamily: numericFontFamily ?? fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.2,
        fontFeatures: tabularFigures,
        color: c,
      ),
    );
  }

  /// Editorial scale for Luxury Coastal.
  factory HorizonTypographyTokens.editorial({
    Color? color,
    String? fontFamily,
    String? numericFontFamily,
  }) {
    final Color c = color ?? const Color(0xFF0A2A32);
    return HorizonTypographyTokens(
      display: TextStyle(
        fontFamily: fontFamily,
        fontSize: 42,
        fontWeight: FontWeight.w500,
        height: 1.1,
        letterSpacing: -0.8,
        color: c,
      ),
      headline: TextStyle(
        fontFamily: fontFamily,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        height: 1.15,
        letterSpacing: -0.4,
        color: c,
      ),
      title: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: c,
      ),
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: c,
      ),
      label: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.8,
        color: c,
      ),
      numeric: TextStyle(
        fontFamily: numericFontFamily ?? fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.15,
        fontFeatures: tabularFigures,
        color: c,
      ),
    );
  }

  /// HUD / tech scale for Cyber Surf.
  factory HorizonTypographyTokens.hud({
    Color? color,
    String? fontFamily,
    String? numericFontFamily,
  }) {
    final Color c = color ?? const Color(0xFFE6F9FF);
    return HorizonTypographyTokens(
      display: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: 1.5,
        color: c,
      ),
      headline: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: 1.2,
        color: c,
      ),
      title: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0.6,
        color: c,
      ),
      body: TextStyle(
        fontFamily: fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        letterSpacing: 0.3,
        color: c,
      ),
      label: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: 0.35,
        color: c,
      ),
      numeric: TextStyle(
        fontFamily: numericFontFamily ?? fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: 0.5,
        fontFeatures: tabularFigures,
        color: c,
      ),
    );
  }

  HorizonTypographyTokens applyColor(Color color) {
    return HorizonTypographyTokens(
      display: display.copyWith(color: color),
      headline: headline.copyWith(color: color),
      title: title.copyWith(color: color),
      body: body.copyWith(color: color),
      label: label.copyWith(color: color),
      numeric: numeric.copyWith(color: color),
    );
  }

  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: display,
      displayMedium: display.copyWith(fontSize: (display.fontSize ?? 40) * 0.9),
      displaySmall: headline,
      headlineLarge: headline,
      headlineMedium: headline.copyWith(
        fontSize: (headline.fontSize ?? 28) * 0.9,
      ),
      headlineSmall: title,
      titleLarge: title,
      titleMedium: title.copyWith(fontSize: (title.fontSize ?? 18) * 0.9),
      titleSmall: label.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: body.copyWith(fontSize: (body.fontSize ?? 14) + 2),
      bodyMedium: body,
      bodySmall: body.copyWith(fontSize: (body.fontSize ?? 14) - 2),
      labelLarge: label.copyWith(fontSize: 14),
      labelMedium: label,
      labelSmall: label.copyWith(fontSize: 10),
    );
  }

  HorizonTypographyTokens lerp(HorizonTypographyTokens other, double t) {
    return HorizonTypographyTokens(
      display: TextStyle.lerp(display, other.display, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      numeric: TextStyle.lerp(numeric, other.numeric, t)!,
    );
  }
}
