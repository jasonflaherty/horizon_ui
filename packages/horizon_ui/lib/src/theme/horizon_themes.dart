import 'package:flutter/material.dart';

import '../tokens/color_tokens.dart';
import '../tokens/elevation_tokens.dart';
import '../tokens/motion_tokens.dart';
import '../tokens/radius_tokens.dart';
import '../tokens/spacing_tokens.dart';
import '../tokens/tokens.dart';
import '../tokens/typography_tokens.dart';
import 'horizon_theme_extension.dart';

/// Factory for Horizon [ThemeData] variants that compose with Material 3.
abstract final class HorizonThemes {
  static ThemeData classic({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? classicDark() : _classicLight();
  }

  static ThemeData classicDark() => _build(
    id: 'classic-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFFA8C8FF),
      onPrimary: Color(0xFF00315F),
      secondary: Color(0xFFBCC7DC),
      onSecondary: Color(0xFF263141),
      accent: Color(0xFF9FCAFF),
      onAccent: Color(0xFF003258),
      success: Color(0xFF86D992),
      onSuccess: Color(0xFF003919),
      warning: Color(0xFFFFB95C),
      onWarning: Color(0xFF432C00),
      danger: Color(0xFFFFB4AB),
      onDanger: Color(0xFF690005),
      surface: Color(0xFF1A1C1E),
      onSurface: Color(0xFFE2E2E6),
      background: Color(0xFF121316),
      onBackground: Color(0xFFE2E2E6),
      border: Color(0xFF43474E),
      glow: Color(0xFFA8C8FF),
      surfaceVariant: Color(0xFF43474E),
      onSurfaceVariant: Color(0xFFC3C6CF),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFFE2E2E6),
    ),
  );

  static ThemeData _classicLight() => _build(
    id: 'classic-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF2F5FAF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF535F70),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFF006493),
      onAccent: Color(0xFFFFFFFF),
      success: Color(0xFF1B6B36),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8B5000),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFBA1A1A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF8F9FC),
      onSurface: Color(0xFF1A1C1E),
      background: Color(0xFFFCFCFF),
      onBackground: Color(0xFF1A1C1E),
      border: Color(0xFFC3C6CF),
      glow: Color(0xFF2F5FAF),
      surfaceVariant: Color(0xFFE1E2EC),
      onSurfaceVariant: Color(0xFF44474E),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFF1A1C1E),
    ),
  );

  static ThemeData luxuryCoastal({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark
        ? luxuryCoastalDark()
        : _luxuryCoastalLight();
  }

  static ThemeData _luxuryCoastalLight() => _build(
    id: 'luxury-coastal-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF0B6E7A),
      onPrimary: Color(0xFFF5FBFC),
      secondary: Color(0xFF3D6B7A),
      onSecondary: Color(0xFFF5FBFC),
      accent: Color(0xFFC4A574),
      onAccent: Color(0xFF1A1208),
      success: Color(0xFF2F7A5A),
      onSuccess: Color(0xFFF5FBFC),
      warning: Color(0xFFB07A00),
      onWarning: Color(0xFF1A1208),
      danger: Color(0xFFB5453A),
      onDanger: Color(0xFFFFF8F6),
      surface: Color(0xE6F2F8FA),
      onSurface: Color(0xFF0A2A32),
      background: Color(0xFFE8F4F7),
      onBackground: Color(0xFF0A2A32),
      border: Color(0x6690B8C4),
      glow: Color(0xFF7EC8D4),
      surfaceVariant: Color(0xCCDAEBEF),
      onSurfaceVariant: Color(0xFF3A5A64),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFF0A2A32),
    ),
    elevation: HorizonElevationTokens(
      glassBlur: 24,
      glassOpacity: 0.62,
      flat: const [],
      raised: [
        BoxShadow(
          color: const Color(0xFF0A2A32).withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
      floating: [
        BoxShadow(
          color: const Color(0xFF0A2A32).withValues(alpha: 0.14),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ],
    ),
  );

  static ThemeData luxuryCoastalDark() => _build(
    id: 'luxury-coastal-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF7EC8D4),
      onPrimary: Color(0xFF00363E),
      secondary: Color(0xFF9BB8C4),
      onSecondary: Color(0xFF0A2A32),
      accent: Color(0xFFD4B896),
      onAccent: Color(0xFF1A1208),
      success: Color(0xFF6FBF9A),
      onSuccess: Color(0xFF003822),
      warning: Color(0xFFE0B878),
      onWarning: Color(0xFF3A2800),
      danger: Color(0xFFE08A80),
      onDanger: Color(0xFF3F0A08),
      surface: Color(0xCC0F2A32),
      onSurface: Color(0xFFE8F4F7),
      background: Color(0xFF071820),
      onBackground: Color(0xFFE8F4F7),
      border: Color(0x664A7A88),
      glow: Color(0xFF7EC8D4),
      surfaceVariant: Color(0x991A3A44),
      onSurfaceVariant: Color(0xFFB0C8D0),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFFE8F4F7),
    ),
    elevation: HorizonElevationTokens(
      glassBlur: 28,
      glassOpacity: 0.45,
      flat: const [],
      raised: [
        BoxShadow(
          color: const Color(0xFF7EC8D4).withValues(alpha: 0.12),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
      floating: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 36,
          offset: const Offset(0, 14),
        ),
      ],
    ),
  );

  static ThemeData cyber({Brightness brightness = Brightness.dark}) {
    // Cyber defaults to dark HUD; light variant still available.
    return brightness == Brightness.light ? cyberLight() : cyberDark();
  }

  static ThemeData cyberDark() => _build(
    id: 'cyber-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF00E5FF),
      onPrimary: Color(0xFF002A33),
      secondary: Color(0xFF5CE1E6),
      onSecondary: Color(0xFF002A33),
      accent: Color(0xFFFF2BD6),
      onAccent: Color(0xFF1A0014),
      success: Color(0xFF39FF88),
      onSuccess: Color(0xFF002410),
      warning: Color(0xFFFFC14D),
      onWarning: Color(0xFF2A1A00),
      danger: Color(0xFFFF4D6A),
      onDanger: Color(0xFF2A0010),
      surface: Color(0xFF0A1218),
      onSurface: Color(0xFFE6F9FF),
      background: Color(0xFF05080C),
      onBackground: Color(0xFFE6F9FF),
      border: Color(0xFF1A3A44),
      glow: Color(0xFF00E5FF),
      surfaceVariant: Color(0xFF101C24),
      onSurfaceVariant: Color(0xFF9AD4E0),
    ),
    typography: HorizonTypographyTokens.hud(color: const Color(0xFFE6F9FF)),
    elevation: HorizonElevationTokens.cyber(glow: const Color(0xFF00E5FF)),
  );

  static ThemeData cyberLight() => _build(
    id: 'cyber-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF007A8A),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF0A6B72),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFFC4009A),
      onAccent: Color(0xFFFFFFFF),
      success: Color(0xFF008C45),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFFB07800),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFC41E3A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF0FAFC),
      onSurface: Color(0xFF051018),
      background: Color(0xFFE6F4F7),
      onBackground: Color(0xFF051018),
      border: Color(0xFF9AC8D0),
      glow: Color(0xFF00B8CC),
      surfaceVariant: Color(0xFFD4EEF2),
      onSurfaceVariant: Color(0xFF1A3A44),
    ),
    typography: HorizonTypographyTokens.hud(color: const Color(0xFF051018)),
    elevation: HorizonElevationTokens.cyber(glow: const Color(0xFF00B8CC)),
  );

  static ThemeData _build({
    required String id,
    required Brightness brightness,
    required HorizonColorTokens colors,
    required HorizonTypographyTokens typography,
    HorizonElevationTokens? elevation,
  }) {
    final HorizonTokens tokens = HorizonTokens(
      colors: colors,
      typography: typography,
      spacing: HorizonSpacingTokens.standard,
      radius: HorizonRadiusTokens.standard,
      elevation:
          elevation ??
          HorizonElevationTokens.standard(
            shadowColor: brightness == Brightness.dark
                ? Colors.black
                : const Color(0xFF1A1C1E),
          ),
      motion: HorizonMotionTokens.standardTokens,
    );

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      tertiary: colors.accent,
      onTertiary: colors.onAccent,
      error: colors.danger,
      onError: colors.onDanger,
      surface: colors.surface,
      onSurface: colors.onSurface,
      outline: colors.border,
      surfaceContainerHighest: colors.resolvedSurfaceVariant,
    );

    final TextTheme textTheme = typography.toTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        HorizonThemeExtension(tokens: tokens, id: id),
      ],
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radius.lg),
          side: BorderSide(color: colors.border.withValues(alpha: 0.6)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radius.md),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      dividerColor: colors.border,
    );
  }
}
