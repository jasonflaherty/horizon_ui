import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../animations/floating_transitions.dart';
import '../extensions/horizon_context.dart';
import 'chart_data.dart';

/// Tide-style sinusoidal / series height chart with water fill.
class HorizonTideChart extends StatelessWidget {
  const HorizonTideChart({
    super.key,
    required this.points,
    this.height = 140,
    this.waterColor,
    this.lineColor,
    this.semanticLabel,
  });

  final List<HorizonChartPoint> points;
  final double height;
  final Color? waterColor;
  final Color? lineColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color water =
        waterColor ?? context.horizon.colors.primary.withValues(alpha: 0.35);
    final Color line = lineColor ?? context.horizon.colors.accent;
    final Color grid = context.horizon.colors.border.withValues(alpha: 0.35);

    return Semantics(
      label: semanticLabel ?? 'Tide chart',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            height: height,
            width: double.infinity,
            child: CustomPaint(
              painter: _TidePainter(
                points: points,
                progress: progress,
                waterColor: water,
                lineColor: line,
                gridColor: grid,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TidePainter extends CustomPainter {
  _TidePainter({
    required this.points,
    required this.progress,
    required this.waterColor,
    required this.lineColor,
    required this.gridColor,
  });

  final List<HorizonChartPoint> points;
  final double progress;
  final Color waterColor;
  final Color lineColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }

    final double minV = chartMin(points.map((HorizonChartPoint p) => p.value));
    final double maxV = chartMax(points.map((HorizonChartPoint p) => p.value));
    final double range = (maxV - minV).abs() < 0.001 ? 1 : maxV - minV;
    final int count = math.max(2, (points.length * progress).ceil());

    Offset at(int i) {
      final int idx = i.clamp(0, points.length - 1);
      final double x = size.width * idx / (points.length - 1);
      final double y =
          size.height -
          ((points[idx].value - minV) / range) * (size.height * 0.85) -
          size.height * 0.05;
      return Offset(x, y);
    }

    final Paint mid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      mid,
    );

    final Path line = Path()..moveTo(at(0).dx, at(0).dy);
    for (int i = 1; i < count; i++) {
      final Offset p0 = at(i - 1);
      final Offset p1 = at(i);
      final Offset c = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      line.quadraticBezierTo(p0.dx, p0.dy, c.dx, c.dy);
    }
    line.lineTo(at(count - 1).dx, at(count - 1).dy);

    final Path fill = Path.from(line)
      ..lineTo(at(count - 1).dx, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fill, Paint()..color = waterColor);
    canvas.drawPath(
      line,
      Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _TidePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.points != points;
}

/// Horizontal timeline of labeled events.
class HorizonTimeline extends StatelessWidget {
  const HorizonTimeline({super.key, required this.events, this.semanticLabel});

  final List<HorizonTimelineEvent> events;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'Timeline',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          final int visible = math.max(1, (events.length * progress).ceil());
          return Column(
            children: [
              for (int i = 0; i < visible && i < events.length; i++)
                _TimelineRow(
                  event: events[i],
                  isLast: i == events.length - 1 || i == visible - 1,
                ),
            ],
          );
        },
      ),
    );
  }
}

@immutable
class HorizonTimelineEvent {
  const HorizonTimelineEvent({
    required this.time,
    required this.title,
    this.detail,
    this.tone,
  });

  final String time;
  final String title;
  final String? detail;
  final Color? tone;
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.event, required this.isLast});

  final HorizonTimelineEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color accent = event.tone ?? tokens.colors.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Text(event.time, style: horizonChartAnnotationStyle(tokens)),
          ),
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: tokens.colors.border,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: tokens.spacing.x3),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: tokens.spacing.x4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: tokens.typography.title),
                  if (event.detail != null) ...[
                    SizedBox(height: tokens.spacing.x1),
                    Text(
                      event.detail!,
                      style: tokens.typography.body.copyWith(
                        color: tokens.colors.resolvedOnSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
