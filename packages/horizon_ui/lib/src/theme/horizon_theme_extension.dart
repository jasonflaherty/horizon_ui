import 'package:flutter/material.dart';

import '../tokens/tokens.dart';

/// Material 3 [ThemeExtension] carrying Horizon design tokens.
@immutable
class HorizonThemeExtension extends ThemeExtension<HorizonThemeExtension> {
  const HorizonThemeExtension({required this.tokens, this.id = 'horizon'});

  final HorizonTokens tokens;
  final String id;

  @override
  HorizonThemeExtension copyWith({HorizonTokens? tokens, String? id}) {
    return HorizonThemeExtension(
      tokens: tokens ?? this.tokens,
      id: id ?? this.id,
    );
  }

  @override
  HorizonThemeExtension lerp(
    ThemeExtension<HorizonThemeExtension>? other,
    double t,
  ) {
    if (other is! HorizonThemeExtension) {
      return this;
    }
    return HorizonThemeExtension(
      tokens: tokens.lerp(other.tokens, t),
      id: t < 0.5 ? id : other.id,
    );
  }
}
