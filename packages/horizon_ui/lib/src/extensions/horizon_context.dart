import 'package:flutter/material.dart';

import '../theme/horizon_theme_extension.dart';
import '../tokens/tokens.dart';

/// Convenient access to Horizon tokens from a [BuildContext].
extension HorizonContext on BuildContext {
  /// Returns the [HorizonThemeExtension] from the ambient [Theme].
  ///
  /// Falls back to Classic light tokens if the extension is missing.
  HorizonThemeExtension get horizonTheme {
    final HorizonThemeExtension? extension = Theme.of(
      this,
    ).extension<HorizonThemeExtension>();
    if (extension != null) {
      return extension;
    }
    // Lazy import avoided — callers should always wrap with HorizonThemes.
    throw FlutterError(
      'HorizonThemeExtension not found. '
      'Wrap your app with Theme(data: HorizonThemes.classic()) or similar.',
    );
  }

  HorizonTokens get horizon => horizonTheme.tokens;

  bool get horizonReduceMotion => MediaQuery.disableAnimationsOf(this);
}
