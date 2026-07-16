import 'dart:ui';

import 'package:flutter/material.dart';

import '../../animations/horizon_motion.dart';
import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';
import 'button_size.dart';

/// Primary filled action button.
class HorizonFilledButton extends StatelessWidget {
  const HorizonFilledButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.size = HorizonButtonSize.md,
    this.loading = false,
    this.expanded = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final HorizonButtonSize size;
  final bool loading;
  final bool expanded;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final bool enabled = onPressed != null && !loading;

    final Widget child = _ButtonLabel(
      label: label,
      icon: icon,
      size: size,
      loading: loading,
      foreground: tokens.colors.onPrimary,
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height,
          minWidth: expanded ? double.infinity : 0,
        ),
        child: Material(
          color: enabled
              ? tokens.colors.primary
              : tokens.colors.primary.withValues(alpha: 0.38),
          borderRadius: BorderRadius.circular(tokens.radius.md),
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(tokens.radius.md),
            child: Padding(
              padding: size.padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

/// Frosted glass button.
class HorizonGlassButton extends StatelessWidget {
  const HorizonGlassButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.size = HorizonButtonSize.md,
    this.loading = false,
    this.expanded = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final HorizonButtonSize size;
  final bool loading;
  final bool expanded;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final bool enabled = onPressed != null && !loading;
    final BorderRadius radius = BorderRadius.circular(tokens.radius.md);

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height,
          minWidth: expanded ? double.infinity : 0,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: tokens.elevation.glassBlur / 2,
              sigmaY: tokens.elevation.glassBlur / 2,
            ),
            child: Material(
              color: tokens.colors.surface.withValues(
                alpha: tokens.elevation.glassOpacity,
              ),
              child: InkWell(
                onTap: enabled ? onPressed : null,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(
                      color: tokens.colors.border.withValues(alpha: 0.7),
                    ),
                  ),
                  child: Padding(
                    padding: size.padding,
                    child: Center(
                      child: _ButtonLabel(
                        label: label,
                        icon: icon,
                        size: size,
                        loading: loading,
                        foreground: enabled
                            ? tokens.colors.onSurface
                            : tokens.colors.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glow-accented button (subtle emphasis under Classic; neon under Cyber).
class HorizonGlowButton extends StatefulWidget {
  const HorizonGlowButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.size = HorizonButtonSize.md,
    this.loading = false,
    this.expanded = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final HorizonButtonSize size;
  final bool loading;
  final bool expanded;
  final String? semanticLabel;

  @override
  State<HorizonGlowButton> createState() => _HorizonGlowButtonState();
}

class _HorizonGlowButtonState extends State<HorizonGlowButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulse;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (HorizonMotion.shouldAnimate(context)) {
      _pulse ??= AnimationController(
        vsync: this,
        duration: context.horizon.motion.slow,
      )..repeat(reverse: true);
    } else {
      _pulse?.stop();
    }
  }

  @override
  void dispose() {
    _pulse?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final bool enabled = widget.onPressed != null && !widget.loading;
    final AnimationController? pulse = _pulse;

    final Widget button = AnimatedBuilder(
      animation: pulse ?? const AlwaysStoppedAnimation<double>(1),
      builder: (BuildContext context, Widget? child) {
        final double glowAlpha = pulse == null
            ? 0.35
            : 0.25 + pulse.value * 0.25;
        return Material(
          color: tokens.colors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(tokens.radius.md),
          child: InkWell(
            onTap: enabled ? widget.onPressed : null,
            borderRadius: BorderRadius.circular(tokens.radius.md),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(tokens.radius.md),
                border: Border.all(color: tokens.colors.glow, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: tokens.colors.glow.withValues(alpha: glowAlpha),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: child,
            ),
          ),
        );
      },
      child: Padding(
        padding: widget.size.padding,
        child: Center(
          child: _ButtonLabel(
            label: widget.label,
            icon: widget.icon,
            size: widget.size,
            loading: widget.loading,
            foreground: enabled
                ? tokens.colors.glow
                : tokens.colors.glow.withValues(alpha: 0.38),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.semanticLabel ?? widget.label,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.size.height,
          minWidth: widget.expanded ? double.infinity : 0,
        ),
        child: button,
      ),
    );
  }
}

/// Compact icon-only button.
class HorizonIconButton extends StatelessWidget {
  const HorizonIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = HorizonButtonSize.md,
    this.tooltip,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final HorizonButtonSize size;
  final String? tooltip;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final bool enabled = onPressed != null;
    final double dim = size.height;

    Widget button = Material(
      color: tokens.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius.md),
        side: BorderSide(color: tokens.colors.border),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(tokens.radius.md),
        child: SizedBox(
          width: dim,
          height: dim,
          child: Icon(
            icon,
            size: size.iconSize,
            color: enabled
                ? tokens.colors.onSurface
                : tokens.colors.onSurface.withValues(alpha: 0.38),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel ?? tooltip,
      child: button,
    );
  }
}

/// Floating action button styled with Horizon tokens.
class HorizonFab extends StatelessWidget {
  const HorizonFab({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final bool enabled = onPressed != null;

    final Widget content = label == null
        ? Icon(icon, color: tokens.colors.onPrimary)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: tokens.colors.onPrimary),
              SizedBox(width: tokens.spacing.x2),
              Text(
                label!,
                style: tokens.typography.label.copyWith(
                  color: tokens.colors.onPrimary,
                ),
              ),
            ],
          );

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel ?? label,
      child: Material(
        color: tokens.colors.primary,
        elevation: 0,
        shadowColor: tokens.colors.glow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            label == null ? tokens.radius.pill : tokens.radius.lg,
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            label == null ? tokens.radius.pill : tokens.radius.lg,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                label == null ? tokens.radius.pill : tokens.radius.lg,
              ),
              boxShadow: tokens.elevation.floating,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: label == null
                    ? tokens.spacing.x4
                    : tokens.spacing.x5,
                vertical: tokens.spacing.x4,
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonLabel extends StatelessWidget {
  const _ButtonLabel({
    required this.label,
    required this.size,
    required this.loading,
    required this.foreground,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final HorizonButtonSize size;
  final bool loading;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    if (loading) {
      return SizedBox(
        width: size.iconSize,
        height: size.iconSize,
        child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
      );
    }

    final TextStyle style = tokens.typography.label.copyWith(
      color: foreground,
      fontSize: size == HorizonButtonSize.sm
          ? 12
          : size == HorizonButtonSize.lg
          ? 15
          : 13,
    );

    if (icon == null) {
      return Text(label, style: style);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size.iconSize, color: foreground),
        SizedBox(width: tokens.spacing.x2),
        Text(label, style: style),
      ],
    );
  }
}
