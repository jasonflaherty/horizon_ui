import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/color_tokens.dart';
import '../tokens/tokens.dart';

/// Builds Material 3 chrome themes (AppBar, nav, menus) from Horizon tokens.
abstract final class HorizonChromeThemes {
  static ThemeData apply(ThemeData base, HorizonTokens tokens) {
    final HorizonColorTokens c = tokens.colors;
    final bool strongGlass = tokens.elevation.rimIntensity >= 0.75;
    final Color chromeSurface = c.surface;
    final Color chromeOn = c.onSurface;
    final Color indicator = c.primary.withValues(alpha: 0.18);
    final BorderRadius menuRadius = BorderRadius.circular(tokens.radius.md);

    final SystemUiOverlayStyle overlay = c.background.computeLuminance() > 0.5
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return base.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: strongGlass ? 0.5 : 1,
        centerTitle: false,
        backgroundColor: chromeSurface,
        foregroundColor: chromeOn,
        surfaceTintColor: Colors.transparent,
        shadowColor: c.background.withValues(alpha: 0.35),
        iconTheme: IconThemeData(color: chromeOn),
        actionsIconTheme: IconThemeData(color: chromeOn),
        titleTextStyle: tokens.typography.title.copyWith(color: chromeOn),
        toolbarTextStyle: tokens.typography.body.copyWith(color: chromeOn),
        systemOverlayStyle: overlay,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: chromeSurface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: indicator,
        overlayColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return c.primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return c.primary.withValues(alpha: 0.06);
          }
          return null;
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          final TextStyle baseStyle = tokens.typography.label.copyWith(
            fontSize: 12,
          );
          if (states.contains(WidgetState.selected)) {
            return baseStyle.copyWith(color: c.primary);
          }
          return baseStyle.copyWith(color: c.resolvedOnSurfaceVariant);
        }),
        iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: c.primary, size: 24);
          }
          return IconThemeData(color: c.resolvedOnSurfaceVariant, size: 24);
        }),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: chromeSurface,
        elevation: 0,
        selectedItemColor: c.primary,
        unselectedItemColor: c.resolvedOnSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: tokens.typography.label.copyWith(fontSize: 12),
        unselectedLabelStyle: tokens.typography.label.copyWith(fontSize: 12),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: chromeSurface,
        elevation: 0,
        indicatorColor: indicator,
        selectedIconTheme: IconThemeData(color: c.primary),
        unselectedIconTheme: IconThemeData(color: c.resolvedOnSurfaceVariant),
        selectedLabelTextStyle: tokens.typography.label.copyWith(
          color: c.primary,
        ),
        unselectedLabelTextStyle: tokens.typography.label.copyWith(
          color: c.resolvedOnSurfaceVariant,
        ),
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: chromeSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        indicatorColor: indicator,
        labelTextStyle: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return tokens.typography.body.copyWith(color: c.primary);
          }
          return tokens.typography.body.copyWith(color: chromeOn);
        }),
        iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: c.primary);
          }
          return IconThemeData(color: c.resolvedOnSurfaceVariant);
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: chromeSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(tokens.radius.lg),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: chromeSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.25),
        textStyle: tokens.typography.body.copyWith(color: chromeOn),
        labelTextStyle: WidgetStatePropertyAll(
          tokens.typography.body.copyWith(color: chromeOn),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: menuRadius,
          side: BorderSide(color: c.border.withValues(alpha: 0.7)),
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(chromeSurface),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shadowColor: WidgetStatePropertyAll(
            Colors.black.withValues(alpha: 0.25),
          ),
          elevation: const WidgetStatePropertyAll(4),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: menuRadius,
              side: BorderSide(color: c.border.withValues(alpha: 0.7)),
            ),
          ),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: tokens.spacing.x1),
          ),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(chromeSurface),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: menuRadius,
              side: BorderSide(color: c.border.withValues(alpha: 0.7)),
            ),
          ),
        ),
        textStyle: tokens.typography.body.copyWith(color: chromeOn),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: c.resolvedSurfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.md),
            borderSide: BorderSide(color: c.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.md),
            borderSide: BorderSide(color: c.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.md),
            borderSide: BorderSide(color: c.primary, width: 1.5),
          ),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) {
              return chromeOn.withValues(alpha: 0.38);
            }
            return chromeOn;
          }),
          textStyle: WidgetStatePropertyAll(tokens.typography.body),
        ),
      ),
    );
  }
}
