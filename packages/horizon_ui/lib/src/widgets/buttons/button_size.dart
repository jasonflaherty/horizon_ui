import 'package:flutter/material.dart';

/// Shared size variants for Horizon buttons.
enum HorizonButtonSize { sm, md, lg }

extension HorizonButtonSizeX on HorizonButtonSize {
  double get height => switch (this) {
    HorizonButtonSize.sm => 36,
    HorizonButtonSize.md => 44,
    HorizonButtonSize.lg => 52,
  };

  EdgeInsets get padding => switch (this) {
    HorizonButtonSize.sm => const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    HorizonButtonSize.md => const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    HorizonButtonSize.lg => const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 14,
    ),
  };

  double get iconSize => switch (this) {
    HorizonButtonSize.sm => 18,
    HorizonButtonSize.md => 20,
    HorizonButtonSize.lg => 24,
  };
}
