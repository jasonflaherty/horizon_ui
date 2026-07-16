import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

void main() {
  group('HorizonThemes', () {
    test('classic light includes HorizonThemeExtension', () {
      final ThemeData theme = HorizonThemes.classic();
      final HorizonThemeExtension? ext = theme
          .extension<HorizonThemeExtension>();
      expect(ext, isNotNull);
      expect(ext!.id, 'classic-light');
      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
    });

    test('cyber dark exposes glow token', () {
      final ThemeData theme = HorizonThemes.cyberDark();
      final HorizonThemeExtension ext = theme
          .extension<HorizonThemeExtension>()!;
      expect(ext.id, 'cyber-dark');
      expect(ext.tokens.colors.glow, const Color(0xFF00E5FF));
    });

    test('luxury coastal dark uses editorial typography metrics', () {
      final ThemeData theme = HorizonThemes.luxuryCoastalDark();
      final HorizonThemeExtension ext = theme
          .extension<HorizonThemeExtension>()!;
      expect(ext.tokens.typography.display.fontSize, 42);
      expect(ext.tokens.elevation.glassBlur, greaterThan(16));
      expect(ext.tokens.elevation.rimIntensity, greaterThan(0.7));
      expect(ext.tokens.radius.lg, greaterThan(16));
    });

    test('cyber dark uses neon-rimmed liquid glass elevation', () {
      final ThemeData theme = HorizonThemes.cyberDark();
      final HorizonThemeExtension ext = theme
          .extension<HorizonThemeExtension>()!;
      expect(ext.tokens.colors.glow, const Color(0xFF00E5FF));
      expect(ext.tokens.elevation.glassBlur, greaterThan(24));
      expect(ext.tokens.elevation.glassOpacity, lessThan(0.4));
      expect(ext.tokens.elevation.rimIntensity, 1);
    });

    test('mono theme is flat black and white', () {
      final ThemeData light = HorizonThemes.monoLight();
      final ThemeData dark = HorizonThemes.monoDark();
      final HorizonThemeExtension lightExt = light
          .extension<HorizonThemeExtension>()!;
      final HorizonThemeExtension darkExt = dark
          .extension<HorizonThemeExtension>()!;
      expect(lightExt.id, 'mono-light');
      expect(darkExt.id, 'mono-dark');
      expect(lightExt.tokens.colors.primary, const Color(0xFF000000));
      expect(darkExt.tokens.colors.primary, const Color(0xFFFFFFFF));
      expect(lightExt.tokens.elevation.glassBlur, 0);
      expect(lightExt.tokens.elevation.raised, isEmpty);
      expect(lightExt.tokens.radius.lg, 0);
    });

    test('motion tokens match design scale', () {
      final HorizonMotionTokens motion = HorizonThemes.classic()
          .extension<HorizonThemeExtension>()!
          .tokens
          .motion;
      expect(motion.fast, const Duration(milliseconds: 150));
      expect(motion.medium, const Duration(milliseconds: 250));
      expect(motion.slow, const Duration(milliseconds: 450));
    });
  });
}
