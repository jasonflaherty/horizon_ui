import 'package:flutter/material.dart';

import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';

/// Token-styled search field.
class HorizonSearchBar extends StatelessWidget {
  const HorizonSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      textField: true,
      label: semanticLabel ?? hintText,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: tokens.typography.body,
        cursorColor: tokens.colors.primary,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: tokens.typography.body.copyWith(
            color: tokens.colors.resolvedOnSurfaceVariant,
          ),
          prefixIcon: Icon(Icons.search, color: tokens.colors.primary),
          suffixIcon: onClear == null
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  onPressed: onClear,
                  icon: Icon(
                    Icons.close,
                    color: tokens.colors.resolvedOnSurfaceVariant,
                  ),
                ),
          filled: true,
          fillColor: tokens.colors.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.x4,
            vertical: tokens.spacing.x3,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.pill),
            borderSide: BorderSide(color: tokens.colors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.pill),
            borderSide: BorderSide(color: tokens.colors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tokens.radius.pill),
            borderSide: BorderSide(color: tokens.colors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}

/// Segmented control built on Horizon tokens.
class HorizonSegmentedControl<T> extends StatelessWidget {
  const HorizonSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.semanticLabel,
  });

  final List<ButtonSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      label: semanticLabel ?? 'Segmented control',
      child: SegmentedButton<T>(
        segments: segments,
        selected: <T>{selected},
        onSelectionChanged: (Set<T> next) {
          if (next.isNotEmpty) {
            onChanged(next.first);
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return tokens.colors.primary;
            }
            return tokens.colors.surface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return tokens.colors.onPrimary;
            }
            return tokens.colors.onSurface;
          }),
          side: WidgetStatePropertyAll(BorderSide(color: tokens.colors.border)),
        ),
      ),
    );
  }
}

/// Token-styled slider.
class HorizonSlider extends StatelessWidget {
  const HorizonSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.label,
    this.semanticLabel,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      slider: true,
      label: semanticLabel ?? label,
      value: value.toStringAsFixed(1),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: tokens.colors.primary,
          inactiveTrackColor: tokens.colors.border,
          thumbColor: tokens.colors.accent,
          overlayColor: tokens.colors.primary.withValues(alpha: 0.12),
        ),
        child: Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
