import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../animations/floating_transitions.dart';
import '../extensions/horizon_context.dart';
import 'chart_data.dart';

/// Radar / spider chart for multi-axis scores (0–1 normalized recommended).
class HorizonRadarChart extends StatelessWidget {
  const HorizonRadarChart({
    super.key,
    required this.points,
    this.size = 200,
    this.fillColor,
    this.strokeColor,
    this.semanticLabel,
  });

  final List<HorizonChartPoint> points;
  final double size;
  final Color? fillColor;
  final Color? strokeColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color stroke = strokeColor ?? context.horizon.colors.primary;
    final Color fill = fillColor ?? stroke.withValues(alpha: 0.25);
    final Color grid = context.horizon.colors.border.withValues(alpha: 0.5);
    final TextStyle labelStyle = context.horizon.typography.label.copyWith(
      color: context.horizon.colors.resolvedOnSurfaceVariant,
      fontSize: 10,
    );

    return Semantics(
      label: semanticLabel ?? 'Radar chart',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _RadarChartPainter(
                points: points,
                progress: progress,
                strokeColor: stroke,
                fillColor: fill,
                gridColor: grid,
                labelStyle: labelStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  _RadarChartPainter({
    required this.points,
    required this.progress,
    required this.strokeColor,
    required this.fillColor,
    required this.gridColor,
    required this.labelStyle,
  });

  final List<HorizonChartPoint> points;
  final double progress;
  final Color strokeColor;
  final Color fillColor;
  final Color gridColor;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 3) {
      return;
    }

    final Offset center = size.center(Offset.zero);
    final double radius = math.min(size.width, size.height) * 0.35;
    final int n = points.length;
    final double maxV = chartMax(
      points.map((HorizonChartPoint p) => p.value),
      fallback: 1,
    );

    Offset vertex(int i, double scale) {
      final double angle = -math.pi / 2 + (2 * math.pi * i / n);
      return Offset(
        center.dx + math.cos(angle) * radius * scale,
        center.dy + math.sin(angle) * radius * scale,
      );
    }

    final Paint gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int ring = 1; ring <= 3; ring++) {
      final Path ringPath = Path();
      for (int i = 0; i < n; i++) {
        final Offset p = vertex(i, ring / 3);
        if (i == 0) {
          ringPath.moveTo(p.dx, p.dy);
        } else {
          ringPath.lineTo(p.dx, p.dy);
        }
      }
      ringPath.close();
      canvas.drawPath(ringPath, gridPaint);
    }

    final Path data = Path();
    for (int i = 0; i < n; i++) {
      final double scale =
          ((points[i].value / (maxV == 0 ? 1 : maxV)) * progress).clamp(
            0.0,
            1.0,
          );
      final Offset p = vertex(i, scale);
      if (i == 0) {
        data.moveTo(p.dx, p.dy);
      } else {
        data.lineTo(p.dx, p.dy);
      }
    }
    data.close();

    canvas.drawPath(data, Paint()..color = fillColor);
    canvas.drawPath(
      data,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < n; i++) {
      final Offset tip = vertex(i, 1.2);
      tp.text = TextSpan(text: points[i].label, style: labelStyle);
      tp.layout();
      tp.paint(canvas, tip - Offset(tp.width / 2, tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.points != points;
}
