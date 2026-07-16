import 'package:flutter/material.dart';

import '../../extensions/horizon_context.dart';

/// Numeric score badge (condition / rating).
class ScoreBadge extends StatelessWidget {
  const ScoreBadge({
    super.key,
    required this.score,
    this.max = 100,
    this.semanticLabel,
  });

  final int score;
  final int max;
  final String? semanticLabel;

  Color _color(BuildContext context) {
    final tokens = context.horizon;
    final double pct = max == 0 ? 0 : score / max;
    if (pct >= 0.8) {
      return tokens.colors.success;
    }
    if (pct >= 0.5) {
      return tokens.colors.warning;
    }
    return tokens.colors.danger;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color color = _color(context);

    return Semantics(
      label: semanticLabel ?? 'Score $score',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.x3,
          vertical: tokens.spacing.x1,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(tokens.radius.pill),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Text(
          '$score',
          style: tokens.typography.numeric.copyWith(color: color, fontSize: 16),
        ),
      ),
    );
  }
}

/// Compact status pill (Open / Closed / Caution, etc.).
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.tone = HorizonStatusTone.neutral,
    this.semanticLabel,
  });

  final String label;
  final HorizonStatusTone tone;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color color = switch (tone) {
      HorizonStatusTone.positive => tokens.colors.success,
      HorizonStatusTone.warning => tokens.colors.warning,
      HorizonStatusTone.negative => tokens.colors.danger,
      HorizonStatusTone.neutral => tokens.colors.secondary,
      HorizonStatusTone.info => tokens.colors.primary,
    };

    return Semantics(
      label: semanticLabel ?? label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.x3,
          vertical: tokens.spacing.x1,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(tokens.radius.pill),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Text(
          label.toUpperCase(),
          style: tokens.typography.label.copyWith(
            color: color,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

enum HorizonStatusTone { neutral, info, positive, warning, negative }

/// Trend indicator chip (↑ / ↓ / steady with delta).
class TrendChip extends StatelessWidget {
  const TrendChip({
    super.key,
    required this.label,
    this.direction = HorizonTrendDirection.flat,
    this.semanticLabel,
  });

  final String label;
  final HorizonTrendDirection direction;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final (IconData icon, Color color) = switch (direction) {
      HorizonTrendDirection.up => (Icons.trending_up, tokens.colors.success),
      HorizonTrendDirection.down => (Icons.trending_down, tokens.colors.danger),
      HorizonTrendDirection.flat => (
        Icons.trending_flat,
        tokens.colors.secondary,
      ),
    };

    return Semantics(
      label: semanticLabel ?? label,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.x2,
          vertical: tokens.spacing.x1,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(tokens.radius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(width: tokens.spacing.x1),
            Text(label, style: tokens.typography.label.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

enum HorizonTrendDirection { up, down, flat }

/// Compact metric tile for dashboards.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.onTap,
    this.semanticLabel,
  });

  final String label;
  final String value;
  final String? unit;
  final IconData? icon;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    final Widget content = Padding(
      padding: EdgeInsets.all(tokens.spacing.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14, color: tokens.colors.primary),
                SizedBox(width: tokens.spacing.x1),
              ],
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: tokens.typography.label.copyWith(
                    color: tokens.colors.resolvedOnSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: tokens.spacing.x1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: tokens.typography.numeric),
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

    return Semantics(
      button: onTap != null,
      label: semanticLabel ?? '$label $value${unit ?? ''}',
      child: Material(
        color: tokens.colors.surface,
        borderRadius: BorderRadius.circular(tokens.radius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(tokens.radius.md),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(tokens.radius.md),
              border: Border.all(color: tokens.colors.border),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}

/// Unit toggle (ft / m, kt / mph, etc.).
class UnitSelector extends StatelessWidget {
  const UnitSelector({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.semanticLabel,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    return Semantics(
      label: semanticLabel ?? 'Unit selector',
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: tokens.colors.resolvedSurfaceVariant.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(tokens.radius.pill),
          border: Border.all(color: tokens.colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < options.length; i++)
              GestureDetector(
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: tokens.motion.fast,
                  padding: EdgeInsets.symmetric(
                    horizontal: tokens.spacing.x3,
                    vertical: tokens.spacing.x1,
                  ),
                  decoration: BoxDecoration(
                    color: i == selectedIndex
                        ? tokens.colors.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(tokens.radius.pill),
                  ),
                  child: Text(
                    options[i],
                    style: tokens.typography.label.copyWith(
                      color: i == selectedIndex
                          ? tokens.colors.onPrimary
                          : tokens.colors.onSurface,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Outdoor spot header with name, region, and optional status.
class SpotHeader extends StatelessWidget {
  const SpotHeader({
    super.key,
    required this.name,
    this.region,
    this.status,
    this.trailing,
    this.semanticLabel,
  });

  final String name;
  final String? region;
  final Widget? status;
  final Widget? trailing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    return Semantics(
      header: true,
      label: semanticLabel ?? name,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: tokens.typography.headline),
                if (region != null) ...[
                  SizedBox(height: tokens.spacing.x1),
                  Text(
                    region!,
                    style: tokens.typography.body.copyWith(
                      color: tokens.colors.resolvedOnSurfaceVariant,
                    ),
                  ),
                ],
                if (status != null) ...[
                  SizedBox(height: tokens.spacing.x2),
                  status!,
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Condition chip for surf/snow/weather tags.
class ConditionChip extends StatelessWidget {
  const ConditionChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onSelected,
    this.semanticLabel,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    return FilterChip(
      avatar: icon == null
          ? null
          : Icon(
              icon,
              size: 16,
              color: selected ? tokens.colors.onPrimary : tokens.colors.primary,
            ),
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: tokens.colors.primary,
      checkmarkColor: tokens.colors.onPrimary,
      labelStyle: tokens.typography.label.copyWith(
        color: selected ? tokens.colors.onPrimary : tokens.colors.onSurface,
      ),
      side: BorderSide(color: tokens.colors.border),
      backgroundColor: tokens.colors.surface,
    );
  }
}

/// Day-part forecast strip (AM / Noon / PM / Night).
class DayPartStrip extends StatelessWidget {
  const DayPartStrip({super.key, required this.parts, this.semanticLabel});

  final List<HorizonDayPart> parts;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    return Semantics(
      label: semanticLabel ?? 'Day part forecast',
      child: Row(
        children: [
          for (int i = 0; i < parts.length; i++) ...[
            if (i > 0) SizedBox(width: tokens.spacing.x2),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(tokens.spacing.x3),
                decoration: BoxDecoration(
                  color: tokens.colors.surface,
                  borderRadius: BorderRadius.circular(tokens.radius.md),
                  border: Border.all(color: tokens.colors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      parts[i].label,
                      style: tokens.typography.label.copyWith(
                        color: tokens.colors.resolvedOnSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: tokens.spacing.x2),
                    if (parts[i].icon != null)
                      Icon(parts[i].icon, color: tokens.colors.primary),
                    SizedBox(height: tokens.spacing.x1),
                    Text(
                      parts[i].value,
                      style: tokens.typography.numeric.copyWith(fontSize: 16),
                    ),
                    if (parts[i].detail != null)
                      Text(
                        parts[i].detail!,
                        style: tokens.typography.label.copyWith(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

@immutable
class HorizonDayPart {
  const HorizonDayPart({
    required this.label,
    required this.value,
    this.detail,
    this.icon,
  });

  final String label;
  final String value;
  final String? detail;
  final IconData? icon;
}
