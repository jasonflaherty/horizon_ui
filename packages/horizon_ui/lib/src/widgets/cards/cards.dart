import 'package:flutter/material.dart';

import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';
import '../surfaces/liquid_glass.dart';

/// Frosted / liquid glass container (uses liquid elevation tokens).
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      padding: padding,
      onTap: onTap,
      semanticLabel: semanticLabel,
      child: child,
    );
  }
}

/// Large hero surface with optional background image and overlay content.
class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.title,
    this.subtitle,
    this.background,
    this.height = 200,
    this.onTap,
    this.semanticLabel,
  });

  final String title;
  final String? subtitle;
  final ImageProvider? background;
  final double height;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final BorderRadius radius = BorderRadius.circular(tokens.radius.xl);

    return Semantics(
      container: true,
      label: semanticLabel ?? title,
      button: onTap != null,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            height: height,
            decoration: BoxDecoration(
              borderRadius: radius,
              image: background == null
                  ? null
                  : DecorationImage(image: background!, fit: BoxFit.cover),
              gradient: background == null
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [tokens.colors.primary, tokens.colors.accent],
                    )
                  : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        tokens.colors.background.withValues(alpha: 0.75),
                      ],
                    ),
              boxShadow: tokens.elevation.floating,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing.x5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tokens.typography.headline.copyWith(
                        color: tokens.colors.onPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: tokens.spacing.x1),
                      Text(
                        subtitle!,
                        style: tokens.typography.body.copyWith(
                          color: tokens.colors.onPrimary.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact metric display.
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.trend,
    this.icon,
    this.onTap,
    this.semanticLabel,
  });

  final String label;
  final String value;
  final String? unit;
  final String? trend;
  final IconData? icon;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return GlassCard(
      onTap: onTap,
      semanticLabel: semanticLabel ?? '$label $value${unit ?? ''}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: tokens.colors.primary),
                SizedBox(width: tokens.spacing.x2),
              ],
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: tokens.typography.label.copyWith(
                    color: tokens.colors.resolvedOnSurfaceVariant,
                  ),
                ),
              ),
              if (trend != null)
                Text(
                  trend!,
                  style: tokens.typography.label.copyWith(
                    color: tokens.colors.success,
                  ),
                ),
            ],
          ),
          SizedBox(height: tokens.spacing.x2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: tokens.typography.numeric.copyWith(
                    color: tokens.colors.onSurface,
                  ),
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: tokens.spacing.x1),
                Text(
                  unit!,
                  style: tokens.typography.body.copyWith(
                    color: tokens.colors.resolvedOnSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Outdoor forecast summary card matching the public API example.
class ForecastCard extends StatelessWidget {
  const ForecastCard({
    super.key,
    required this.title,
    required this.score,
    required this.waveHeight,
    required this.swellPeriod,
    this.waveHeightUnit = 'ft',
    this.swellPeriodUnit = 's',
    this.trend,
    this.onTap,
    this.semanticLabel,
  });

  final String title;
  final int score;
  final double waveHeight;
  final double swellPeriod;
  final String waveHeightUnit;
  final String swellPeriodUnit;
  final String? trend;
  final VoidCallback? onTap;
  final String? semanticLabel;

  Color _scoreColor(HorizonTokens tokens) {
    if (score >= 80) {
      return tokens.colors.success;
    }
    if (score >= 50) {
      return tokens.colors.warning;
    }
    return tokens.colors.danger;
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final Color scoreColor = _scoreColor(tokens);

    return GlassCard(
      onTap: onTap,
      semanticLabel:
          semanticLabel ??
          '$title, score $score, wave height $waveHeight $waveHeightUnit, '
              'swell period $swellPeriod $swellPeriodUnit',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: tokens.typography.title.copyWith(
                    color: tokens.colors.onSurface,
                  ),
                ),
              ),
              _ScoreBadge(score: score, color: scoreColor, tokens: tokens),
            ],
          ),
          SizedBox(height: tokens.spacing.x4),
          Row(
            children: [
              Expanded(
                child: _ForecastMetric(
                  label: 'Wave',
                  value: waveHeight.toStringAsFixed(1),
                  unit: waveHeightUnit,
                  tokens: tokens,
                ),
              ),
              SizedBox(width: tokens.spacing.x4),
              Expanded(
                child: _ForecastMetric(
                  label: 'Period',
                  value: swellPeriod.toStringAsFixed(0),
                  unit: swellPeriodUnit,
                  tokens: tokens,
                ),
              ),
              if (trend != null) ...[
                SizedBox(width: tokens.spacing.x4),
                Text(
                  trend!,
                  style: tokens.typography.label.copyWith(
                    color: tokens.colors.accent,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({
    required this.score,
    required this.color,
    required this.tokens,
  });

  final int score;
  final Color color;
  final HorizonTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.x3,
        vertical: tokens.spacing.x1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(tokens.radius.pill),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        '$score',
        style: tokens.typography.numeric.copyWith(color: color, fontSize: 16),
      ),
    );
  }
}

class _ForecastMetric extends StatelessWidget {
  const _ForecastMetric({
    required this.label,
    required this.value,
    required this.unit,
    required this.tokens,
  });

  final String label;
  final String value;
  final String unit;
  final HorizonTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: tokens.typography.label.copyWith(
            color: tokens.colors.resolvedOnSurfaceVariant,
          ),
        ),
        SizedBox(height: tokens.spacing.x1),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: tokens.typography.numeric.copyWith(
                color: tokens.colors.onSurface,
              ),
            ),
            SizedBox(width: tokens.spacing.x1),
            Text(
              unit,
              style: tokens.typography.body.copyWith(
                color: tokens.colors.resolvedOnSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Alert / warning callout card.
enum HorizonAlertTone { info, success, warning, danger }

class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.title,
    required this.message,
    this.tone = HorizonAlertTone.info,
    this.icon,
    this.onDismiss,
    this.semanticLabel,
  });

  final String title;
  final String message;
  final HorizonAlertTone tone;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final String? semanticLabel;

  (Color, Color, IconData) _tone(HorizonTokens tokens) {
    return switch (tone) {
      HorizonAlertTone.info => (
        tokens.colors.primary,
        tokens.colors.onPrimary,
        Icons.info_outline,
      ),
      HorizonAlertTone.success => (
        tokens.colors.success,
        tokens.colors.onSuccess,
        Icons.check_circle_outline,
      ),
      HorizonAlertTone.warning => (
        tokens.colors.warning,
        tokens.colors.onWarning,
        Icons.warning_amber_outlined,
      ),
      HorizonAlertTone.danger => (
        tokens.colors.danger,
        tokens.colors.onDanger,
        Icons.error_outline,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final (Color accent, Color _, IconData defaultIcon) = _tone(tokens);
    final BorderRadius radius = BorderRadius.circular(tokens.radius.lg);

    return Semantics(
      container: true,
      liveRegion: true,
      label: semanticLabel ?? '$title. $message',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: radius,
          border: Border.all(color: accent.withValues(alpha: 0.55)),
        ),
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing.x4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon ?? defaultIcon, color: accent, size: 22),
              SizedBox(width: tokens.spacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: tokens.typography.title.copyWith(color: accent),
                    ),
                    SizedBox(height: tokens.spacing.x1),
                    Text(
                      message,
                      style: tokens.typography.body.copyWith(
                        color: tokens.colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  onPressed: onDismiss,
                  tooltip: 'Dismiss',
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: tokens.colors.resolvedOnSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
