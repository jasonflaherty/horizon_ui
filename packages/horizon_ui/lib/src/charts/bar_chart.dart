import 'package:flutter/material.dart';

import '../animations/floating_transitions.dart';
import '../extensions/horizon_context.dart';
import 'chart_data.dart';

/// Vertical bar chart.
class HorizonBarChart extends StatelessWidget {
  const HorizonBarChart({
    super.key,
    required this.points,
    this.height = 160,
    this.barColor,
    this.semanticLabel,
  });

  final List<HorizonChartPoint> points;
  final double height;
  final Color? barColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color color = barColor ?? context.horizon.colors.primary;
    final tokens = context.horizon;

    return Semantics(
      label: semanticLabel ?? 'Bar chart',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          final double maxV = chartMax(
            points.map((HorizonChartPoint p) => p.value),
            fallback: 1,
          );
          return SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < points.length; i++) ...[
                  if (i > 0) SizedBox(width: tokens.spacing.x2),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: maxV == 0
                                  ? 0
                                  : (points[i].value / maxV) * progress,
                              widthFactor: 1,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(tokens.radius.sm),
                                  ),
                                  boxShadow: tokens.elevation.raised,
                                ),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: tokens.spacing.x2),
                        Text(
                          points[i].label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tokens.typography.label.copyWith(
                            color: tokens.colors.resolvedOnSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
