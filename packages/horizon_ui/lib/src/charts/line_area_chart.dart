import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../animations/floating_transitions.dart';
import '../extensions/horizon_context.dart';
import 'chart_data.dart';

/// Single-series line chart with optional draw-in animation.
class HorizonLineChart extends StatelessWidget {
  const HorizonLineChart({
    super.key,
    required this.points,
    this.height = 160,
    this.lineColor,
    this.showDots = true,
    this.semanticLabel,
  });

  final List<HorizonChartPoint> points;
  final double height;
  final Color? lineColor;
  final bool showDots;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color color = lineColor ?? context.horizon.colors.primary;
    final Color grid = context.horizon.colors.border.withValues(alpha: 0.65);

    return Semantics(
      label: semanticLabel ?? 'Line chart',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            height: height,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                points: points,
                progress: progress,
                lineColor: color,
                gridColor: grid,
                showDots: showDots,
                fill: false,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Area chart (filled under the line).
class HorizonAreaChart extends StatelessWidget {
  const HorizonAreaChart({
    super.key,
    required this.points,
    this.height = 160,
    this.lineColor,
    this.fillColor,
    this.semanticLabel,
  });

  final List<HorizonChartPoint> points;
  final double height;
  final Color? lineColor;
  final Color? fillColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color color = lineColor ?? context.horizon.colors.primary;
    final Color fill = fillColor ?? color.withValues(alpha: 0.22);
    final Color grid = context.horizon.colors.border.withValues(alpha: 0.65);

    return Semantics(
      label: semanticLabel ?? 'Area chart',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            height: height,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                points: points,
                progress: progress,
                lineColor: color,
                gridColor: grid,
                fillColor: fill,
                showDots: false,
                fill: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.points,
    required this.progress,
    required this.lineColor,
    required this.gridColor,
    required this.showDots,
    required this.fill,
    this.fillColor,
  });

  final List<HorizonChartPoint> points;
  final double progress;
  final Color lineColor;
  final Color gridColor;
  final Color? fillColor;
  final bool showDots;
  final bool fill;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }

    final double minV = chartMin(points.map((HorizonChartPoint p) => p.value));
    final double maxV = chartMax(points.map((HorizonChartPoint p) => p.value));
    final double range = (maxV - minV).abs() < 0.001 ? 1 : maxV - minV;
    const double pad = 8;

    Offset pointAt(int i) {
      final double x =
          pad +
          (size.width - pad * 2) *
              (points.length == 1 ? 0.5 : i / (points.length - 1));
      final double y =
          size.height -
          pad -
          ((points[i].value - minV) / range) * (size.height - pad * 2);
      return Offset(x, y);
    }

    final Paint gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (int i = 0; i < 3; i++) {
      final double y = pad + (size.height - pad * 2) * i / 2;
      canvas.drawLine(Offset(pad, y), Offset(size.width - pad, y), gridPaint);
    }

    final Path path = Path()..moveTo(pointAt(0).dx, pointAt(0).dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(pointAt(i).dx, pointAt(i).dy);
    }

    final List<PathMetric> metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) {
      return;
    }
    final PathMetric metric = metrics.first;

    final Path drawn = metric.extractPath(0, metric.length * progress);

    if (fill && fillColor != null && progress > 0) {
      final Path fillPath = Path.from(drawn)
        ..lineTo(
          pointAt(
            (points.length * progress).ceil().clamp(0, points.length - 1),
          ).dx,
          size.height - pad,
        )
        ..lineTo(pointAt(0).dx, size.height - pad)
        ..close();
      canvas.drawPath(
        fillPath,
        Paint()..color = fillColor!.withValues(alpha: 0.22 * progress),
      );
    }

    canvas.drawPath(
      drawn,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (showDots) {
      final int visible = math.max(1, (points.length * progress).ceil());
      final Paint dot = Paint()..color = lineColor;
      for (int i = 0; i < visible && i < points.length; i++) {
        canvas.drawCircle(pointAt(i), 3.5, dot);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.points != points ||
      oldDelegate.lineColor != lineColor;
}
