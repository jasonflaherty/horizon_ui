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
      surface: Color(0xFFF4FBFD),
      onSurface: Color(0xFF0A2A32),
      background: Color(0xFFDCEEF4),
      onBackground: Color(0xFF0A2A32),
      border: Color(0xFF8EB8C4),
      glow: Color(0xFF7EC8D4),
      surfaceVariant: Color(0xFFDAEBEF),
      onSurfaceVariant: Color(0xFF3A5A64),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFF0A2A32),
    ),
    elevation: HorizonElevationTokens.liquid(
      shadowColor: const Color(0xFF0A2A32),
      tint: const Color(0x88C8ECF5),
    ),
    radius: HorizonRadiusTokens.optical,
  );

  static ThemeData luxuryCoastalDark() => _build(
    id: 'luxury-coastal-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF8ED4E0),
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
      surface: Color(0xFF152630),
      onSurface: Color(0xFFE8F4F7),
      background: Color(0xFF030D14),
      onBackground: Color(0xFFE8F4F7),
      border: Color(0xFF4A7A88),
      glow: Color(0xFF7EC8D4),
      surfaceVariant: Color(0xFF1A3A44),
      onSurfaceVariant: Color(0xFFB0C8D0),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFFE8F4F7),
    ),
    elevation: HorizonElevationTokens.liquid(
      shadowColor: Colors.black,
      tint: const Color(0x667EC8D4),
    ),
    radius: HorizonRadiusTokens.optical,
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
      surface: Color(0xFF101828),
      onSurface: Color(0xFFE6F9FF),
      background: Color(0xFF020508),
      onBackground: Color(0xFFE6F9FF),
      border: Color(0xFF1A4A55),
      glow: Color(0xFF00E5FF),
      surfaceVariant: Color(0xFF142030),
      onSurfaceVariant: Color(0xFF9AD4E0),
    ),
    typography: HorizonTypographyTokens.hud(color: const Color(0xFFE6F9FF)),
    elevation: HorizonElevationTokens.cyber(glow: const Color(0xFF00E5FF)),
    radius: HorizonRadiusTokens.optical,
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
      success: Color(0xFF007A3D),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8A5A00),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFC41E3A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF2FBFD),
      onSurface: Color(0xFF051018),
      background: Color(0xFFD8EEF4),
      onBackground: Color(0xFF051018),
      border: Color(0xFF7AB8C4),
      glow: Color(0xFF00B8CC),
      surfaceVariant: Color(0xFFD4EEF2),
      onSurfaceVariant: Color(0xFF1A3A44),
    ),
    typography: HorizonTypographyTokens.hud(color: const Color(0xFF051018)),
    elevation: HorizonElevationTokens.cyber(glow: const Color(0xFF00B8CC)),
    radius: HorizonRadiusTokens.optical,
  );

  static ThemeData alpine({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? alpineDark() : _alpineLight();
  }

  static ThemeData _alpineLight() => _build(
    id: 'alpine-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF3D5A80),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF4A6A8A),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFF98C1D9),
      onAccent: Color(0xFF0F1C24),
      success: Color(0xFF2A6F5F),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8A5A14),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFB5453A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF4F7FA),
      onSurface: Color(0xFF1B242C),
      background: Color(0xFFE8EEF4),
      onBackground: Color(0xFF1B242C),
      border: Color(0xFFB8C5D1),
      glow: Color(0xFF98C1D9),
      surfaceVariant: Color(0xFFD7E1EA),
      onSurfaceVariant: Color(0xFF4A5A68),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFF1B242C),
    ),
  );

  static ThemeData alpineDark() => _build(
    id: 'alpine-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF98C1D9),
      onPrimary: Color(0xFF0F1C24),
      secondary: Color(0xFF6B8CAE),
      onSecondary: Color(0xFF0F1C24),
      accent: Color(0xFFE0FBFC),
      onAccent: Color(0xFF1B242C),
      success: Color(0xFF6FBF9A),
      onSuccess: Color(0xFF003822),
      warning: Color(0xFFE0B878),
      onWarning: Color(0xFF3A2800),
      danger: Color(0xFFE08A80),
      onDanger: Color(0xFF3F0A08),
      surface: Color(0xFF1A2430),
      onSurface: Color(0xFFE8EEF4),
      background: Color(0xFF0F161E),
      onBackground: Color(0xFFE8EEF4),
      border: Color(0xFF3A4A5A),
      glow: Color(0xFF98C1D9),
      surfaceVariant: Color(0xFF243040),
      onSurfaceVariant: Color(0xFFA8B8C8),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFFE8EEF4),
    ),
  );

  static ThemeData forest({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? forestDark() : _forestLight();
  }

  static ThemeData _forestLight() => _build(
    id: 'forest-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF3D5C3A),
      onPrimary: Color(0xFFF5F7F0),
      secondary: Color(0xFF6B5A3E),
      onSecondary: Color(0xFFF5F7F0),
      accent: Color(0xFF8B9A4A),
      onAccent: Color(0xFF1A1F12),
      success: Color(0xFF2F6B3A),
      onSuccess: Color(0xFFF5F7F0),
      warning: Color(0xFFA67C2A),
      onWarning: Color(0xFF1A1208),
      danger: Color(0xFF8B3A2A),
      onDanger: Color(0xFFFFF8F6),
      surface: Color(0xFFF3F0E8),
      onSurface: Color(0xFF1F2418),
      background: Color(0xFFE8E4D8),
      onBackground: Color(0xFF1F2418),
      border: Color(0xFFC4BBA8),
      glow: Color(0xFF8B9A4A),
      surfaceVariant: Color(0xFFDDD6C6),
      onSurfaceVariant: Color(0xFF4A5240),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFF1F2418),
    ),
  );

  static ThemeData forestDark() => _build(
    id: 'forest-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF8B9A4A),
      onPrimary: Color(0xFF1A1F12),
      secondary: Color(0xFFA89060),
      onSecondary: Color(0xFF1A1208),
      accent: Color(0xFFC4B896),
      onAccent: Color(0xFF1A1208),
      success: Color(0xFF6FBF7A),
      onSuccess: Color(0xFF003816),
      warning: Color(0xFFE0B878),
      onWarning: Color(0xFF3A2800),
      danger: Color(0xFFE08A70),
      onDanger: Color(0xFF3F0A08),
      surface: Color(0xFF1A2218),
      onSurface: Color(0xFFE8E4D8),
      background: Color(0xFF0F140E),
      onBackground: Color(0xFFE8E4D8),
      border: Color(0xFF3A4434),
      glow: Color(0xFF8B9A4A),
      surfaceVariant: Color(0xFF243020),
      onSurfaceVariant: Color(0xFFB0B8A0),
    ),
    typography: HorizonTypographyTokens.editorial(
      color: const Color(0xFFE8E4D8),
    ),
  );

  static ThemeData aurora({Brightness brightness = Brightness.dark}) {
    return brightness == Brightness.light ? auroraLight() : auroraDark();
  }

  static ThemeData auroraDark() => _build(
    id: 'aurora-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF5EF0B8),
      onPrimary: Color(0xFF00281C),
      secondary: Color(0xFF7B6CFF),
      onSecondary: Color(0xFF120A40),
      accent: Color(0xFFE0A0FF),
      onAccent: Color(0xFF2A0040),
      success: Color(0xFF5EF0B8),
      onSuccess: Color(0xFF00281C),
      warning: Color(0xFFFFC14D),
      onWarning: Color(0xFF2A1A00),
      danger: Color(0xFFFF6B9A),
      onDanger: Color(0xFF2A0014),
      surface: Color(0xFF121528),
      onSurface: Color(0xFFE8ECFF),
      background: Color(0xFF080A14),
      onBackground: Color(0xFFE8ECFF),
      border: Color(0xFF2A3050),
      glow: Color(0xFF5EF0B8),
      surfaceVariant: Color(0xFF1A1E38),
      onSurfaceVariant: Color(0xFFA8B0D8),
    ),
    typography: HorizonTypographyTokens.hud(color: const Color(0xFFE8ECFF)),
    elevation: HorizonElevationTokens.cyber(glow: const Color(0xFF5EF0B8)),
  );

  static ThemeData auroraLight() => _build(
    id: 'aurora-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF0A7A5C),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF4A3DB8),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFF8B40B8),
      onAccent: Color(0xFFFFFFFF),
      success: Color(0xFF0A7A5C),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8A5A00),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFC41E5A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF2F4FC),
      onSurface: Color(0xFF141828),
      background: Color(0xFFE6EAF8),
      onBackground: Color(0xFF141828),
      border: Color(0xFFB8C0E0),
      glow: Color(0xFF3DB88A),
      surfaceVariant: Color(0xFFD8DCF0),
      onSurfaceVariant: Color(0xFF3A4060),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFF141828),
    ),
  );

  static ThemeData minimal({Brightness brightness = Brightness.light}) {
    return brightness == Brightness.dark ? minimalDark() : _minimalLight();
  }

  static ThemeData _minimalLight() => _build(
    id: 'minimal-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF111111),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF555555),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFF222222),
      onAccent: Color(0xFFFFFFFF),
      success: Color(0xFF1B6B36),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8B5000),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFBA1A1A),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF111111),
      background: Color(0xFFFAFAFA),
      onBackground: Color(0xFF111111),
      border: Color(0xFFDDDDDD),
      glow: Color(0xFF888888),
      surfaceVariant: Color(0xFFF0F0F0),
      onSurfaceVariant: Color(0xFF555555),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFF111111),
    ),
    elevation: const HorizonElevationTokens(
      glassBlur: 8,
      glassOpacity: 0.9,
      flat: [],
      raised: [],
      floating: [],
    ),
  );

  static ThemeData minimalDark() => _build(
    id: 'minimal-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFFF5F5F5),
      onPrimary: Color(0xFF111111),
      secondary: Color(0xFFAAAAAA),
      onSecondary: Color(0xFF111111),
      accent: Color(0xFFE0E0E0),
      onAccent: Color(0xFF111111),
      success: Color(0xFF86D992),
      onSuccess: Color(0xFF003919),
      warning: Color(0xFFFFB95C),
      onWarning: Color(0xFF432C00),
      danger: Color(0xFFFFB4AB),
      onDanger: Color(0xFF690005),
      surface: Color(0xFF141414),
      onSurface: Color(0xFFF5F5F5),
      background: Color(0xFF0A0A0A),
      onBackground: Color(0xFFF5F5F5),
      border: Color(0xFF333333),
      glow: Color(0xFF888888),
      surfaceVariant: Color(0xFF1E1E1E),
      onSurfaceVariant: Color(0xFFAAAAAA),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFFF5F5F5),
    ),
    elevation: const HorizonElevationTokens(
      glassBlur: 8,
      glassOpacity: 0.5,
      flat: [],
      raised: [],
      floating: [],
    ),
  );

  /// Calm UI — dark-first wellness palette with bright accent dopamine.
  static ThemeData calm({Brightness brightness = Brightness.dark}) {
    return brightness == Brightness.light ? calmLight() : calmDark();
  }

  static ThemeData calmDark() => _build(
    id: 'calm-dark',
    brightness: Brightness.dark,
    colors: const HorizonColorTokens(
      primary: Color(0xFF6EC8FF),
      onPrimary: Color(0xFF00324A),
      secondary: Color(0xFF8A9AAB),
      onSecondary: Color(0xFF121820),
      accent: Color(0xFFFFB86B),
      onAccent: Color(0xFF2A1800),
      success: Color(0xFF7BCFA0),
      onSuccess: Color(0xFF003822),
      warning: Color(0xFFE0B878),
      onWarning: Color(0xFF3A2800),
      danger: Color(0xFFE08A90),
      onDanger: Color(0xFF3F0A10),
      surface: Color(0xFF161B22),
      onSurface: Color(0xFFD8DEE6),
      background: Color(0xFF0C1016),
      onBackground: Color(0xFFD8DEE6),
      border: Color(0xFF2A3340),
      glow: Color(0xFF6EC8FF),
      surfaceVariant: Color(0xFF1E2530),
      onSurfaceVariant: Color(0xFF9AA6B4),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFFD8DEE6),
    ),
    elevation: HorizonElevationTokens.calm(),
    spacing: HorizonSpacingTokens.calm,
    motion: HorizonMotionTokens.calmTokens,
  );

  static ThemeData calmLight() => _build(
    id: 'calm-light',
    brightness: Brightness.light,
    colors: const HorizonColorTokens(
      primary: Color(0xFF2A6F97),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF5A6A78),
      onSecondary: Color(0xFFFFFFFF),
      accent: Color(0xFFA65F12),
      onAccent: Color(0xFFFFFFFF),
      success: Color(0xFF2F7A5A),
      onSuccess: Color(0xFFFFFFFF),
      warning: Color(0xFF8A5A00),
      onWarning: Color(0xFFFFFFFF),
      danger: Color(0xFFB54550),
      onDanger: Color(0xFFFFFFFF),
      surface: Color(0xFFF4F6F8),
      onSurface: Color(0xFF1A222C),
      background: Color(0xFFEAEFF3),
      onBackground: Color(0xFF1A222C),
      border: Color(0xFFC5CED6),
      glow: Color(0xFF2A6F97),
      surfaceVariant: Color(0xFFDCE3EA),
      onSurfaceVariant: Color(0xFF4A5664),
    ),
    typography: HorizonTypographyTokens.material(
      color: const Color(0xFF1A222C),
    ),
    elevation: HorizonElevationTokens.calm(
      shadowColor: const Color(0xFF1A222C),
    ),
    spacing: HorizonSpacingTokens.calm,
    motion: HorizonMotionTokens.calmTokens,
  );

  static ThemeData _build({
    required String id,
    required Brightness brightness,
    required HorizonColorTokens colors,
    required HorizonTypographyTokens typography,
    HorizonElevationTokens? elevation,
    HorizonSpacingTokens? spacing,
    HorizonMotionTokens? motion,
    HorizonRadiusTokens? radius,
  }) {
    final HorizonTokens tokens = HorizonTokens(
      colors: colors,
      typography: typography,
      spacing: spacing ?? HorizonSpacingTokens.standard,
      radius: radius ?? HorizonRadiusTokens.standard,
      elevation:
          elevation ??
          HorizonElevationTokens.standard(
            shadowColor: brightness == Brightness.dark
                ? Colors.black
                : const Color(0xFF1A1C1E),
          ),
      motion: motion ?? HorizonMotionTokens.standardTokens,
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
