import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

double _relLum(Color c) {
  double chan(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * chan(c.r) + 0.7152 * chan(c.g) + 0.0722 * chan(c.b);
}

double _contrast(Color a, Color b) {
  final double la = _relLum(a);
  final double lb = _relLum(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

Color _composite(Color fg, Color bg) {
  final double a = fg.a;
  return Color.from(
    alpha: 1,
    red: fg.r * a + bg.r * (1 - a),
    green: fg.g * a + bg.g * (1 - a),
    blue: fg.b * a + bg.b * (1 - a),
  );
}

/// WCAG 2.1 AA normal text requires ≥ 4.5:1.
void main() {
  final Map<String, ThemeData> themes = {
    'classic-light': HorizonThemes.classic(),
    'classic-dark': HorizonThemes.classicDark(),
    'luxury-light': HorizonThemes.luxuryCoastal(),
    'luxury-dark': HorizonThemes.luxuryCoastalDark(),
    'cyber-dark': HorizonThemes.cyberDark(),
    'cyber-light': HorizonThemes.cyberLight(),
    'alpine-light': HorizonThemes.alpine(),
    'alpine-dark': HorizonThemes.alpineDark(),
    'forest-light': HorizonThemes.forest(),
    'forest-dark': HorizonThemes.forestDark(),
    'aurora-dark': HorizonThemes.aurora(),
    'aurora-light': HorizonThemes.auroraLight(),
    'minimal-light': HorizonThemes.minimal(),
    'minimal-dark': HorizonThemes.minimalDark(),
    'mono-light': HorizonThemes.monoLight(),
    'mono-dark': HorizonThemes.monoDark(),
    'calm-dark': HorizonThemes.calmDark(),
    'calm-light': HorizonThemes.calmLight(),
  };

  test('theme text pairs meet WCAG AA 4.5:1', () {
    final List<String> fails = [];
    for (final MapEntry<String, ThemeData> e in themes.entries) {
      final HorizonTokens t = e.value
          .extension<HorizonThemeExtension>()!
          .tokens;
      final HorizonColorTokens c = t.colors;
      final Color opaqueSurface = _composite(c.surface, c.background);
      final Color glassFill = _composite(
        Color.from(
          alpha: t.elevation.glassOpacity,
          red: c.surface.r,
          green: c.surface.g,
          blue: c.surface.b,
        ),
        c.background,
      );

      final Map<String, double> pairs = {
        'onBackground/background': _contrast(c.onBackground, c.background),
        'onSurface/surface': _contrast(c.onSurface, opaqueSurface),
        'onSurface/glassFill': _contrast(c.onSurface, glassFill),
        'onSurfaceVariant/surface': _contrast(
          c.resolvedOnSurfaceVariant,
          opaqueSurface,
        ),
        'onPrimary/primary': _contrast(c.onPrimary, c.primary),
        'onSecondary/secondary': _contrast(c.onSecondary, c.secondary),
        'onAccent/accent': _contrast(c.onAccent, c.accent),
        'onSuccess/success': _contrast(c.onSuccess, c.success),
        'onWarning/warning': _contrast(c.onWarning, c.warning),
        'onDanger/danger': _contrast(c.onDanger, c.danger),
      };

      for (final MapEntry<String, double> p in pairs.entries) {
        if (p.value < 4.5) {
          fails.add('${e.key} ${p.key} ${p.value.toStringAsFixed(2)}');
        }
      }
    }
    expect(fails, isEmpty, reason: fails.join('\n'));
  });
}
