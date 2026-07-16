import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../animations/floating_transitions.dart';
import '../extensions/horizon_context.dart';

/// Circular progress / score gauge.
class HorizonCircularGauge extends StatelessWidget {
  const HorizonCircularGauge({
    super.key,
    required this.value,
    this.max = 100,
    this.size = 120,
    this.strokeWidth = 10,
    this.label,
    this.showValue = true,
    this.color,
    this.semanticLabel,
  });

  final double value;
  final double max;
  final double size;
  final double strokeWidth;
  final String? label;
  final bool showValue;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color accent = color ?? tokens.colors.primary;
    final Color track = tokens.colors.border.withValues(alpha: 0.35);
    final double pct = max == 0 ? 0 : (value / max).clamp(0.0, 1.0);

    return Semantics(
      label:
          semanticLabel ??
          '${label ?? 'Gauge'}: ${value.toStringAsFixed(0)} of ${max.toStringAsFixed(0)}',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _CircularGaugePainter(
                progress: pct * progress,
                color: accent,
                trackColor: track,
                strokeWidth: strokeWidth,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showValue)
                      Text(
                        (value * progress).round().toString(),
                        style: tokens.typography.numeric,
                      ),
                    if (label != null)
                      Text(
                        label!,
                        style: tokens.typography.label.copyWith(
                          color: tokens.colors.resolvedOnSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  _CircularGaugePainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = math.min(size.width, size.height) / 2 - strokeWidth;
    final Rect arc = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(
      arc,
      -math.pi * 0.75,
      math.pi * 1.5,
      false,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawArc(
      arc,
      -math.pi * 0.75,
      math.pi * 1.5 * progress,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Horizontal linear gauge / meter.
class HorizonLinearGauge extends StatelessWidget {
  const HorizonLinearGauge({
    super.key,
    required this.value,
    this.max = 100,
    this.height = 10,
    this.label,
    this.color,
    this.semanticLabel,
  });

  final double value;
  final double max;
  final double height;
  final String? label;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color accent = color ?? tokens.colors.primary;
    final double pct = max == 0 ? 0 : (value / max).clamp(0.0, 1.0);

    return Semantics(
      label:
          semanticLabel ??
          '${label ?? 'Meter'}: ${value.toStringAsFixed(0)} of ${max.toStringAsFixed(0)}',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(label!, style: tokens.typography.label),
                    ),
                    Text(
                      value.toStringAsFixed(0),
                      style: tokens.typography.numeric.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.x2),
              ],
              ClipRRect(
                borderRadius: BorderRadius.circular(tokens.radius.pill),
                child: SizedBox(
                  height: height,
                  child: Stack(
                    children: [
                      Container(
                        color: tokens.colors.border.withValues(alpha: 0.35),
                      ),
                      FractionallySizedBox(
                        widthFactor: pct * progress,
                        child: Container(color: accent),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Compass rose showing heading in degrees (0 = North).
class HorizonCompass extends StatelessWidget {
  const HorizonCompass({
    super.key,
    required this.headingDegrees,
    this.size = 140,
    this.semanticLabel,
  });

  final double headingDegrees;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color accent = tokens.colors.danger;
    final Color ring = tokens.colors.border;
    final Color glow = tokens.colors.glow;

    return Semantics(
      label:
          semanticLabel ?? 'Compass heading ${headingDegrees.round()} degrees',
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _CompassPainter(
            heading: headingDegrees,
            accent: accent,
            ring: ring,
            glow: glow,
            labelStyle: tokens.typography.label,
          ),
        ),
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  _CompassPainter({
    required this.heading,
    required this.accent,
    required this.ring,
    required this.glow,
    required this.labelStyle,
  });

  final double heading;
  final Color accent;
  final Color ring;
  final Color glow;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = math.min(size.width, size.height) / 2 - 8;

    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = ring
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    const List<String> dirs = ['N', 'E', 'S', 'W'];
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < 4; i++) {
      final double a = -math.pi / 2 + i * math.pi / 2;
      final Offset p = Offset(
        c.dx + math.cos(a) * (r - 16),
        c.dy + math.sin(a) * (r - 16),
      );
      tp.text = TextSpan(
        text: dirs[i],
        style: labelStyle.copyWith(
          color: i == 0 ? accent : ring,
          fontWeight: FontWeight.w700,
        ),
      );
      tp.layout();
      tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
    }

    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(heading * math.pi / 180);
    final Path needle = Path()
      ..moveTo(0, -r + 20)
      ..lineTo(8, 12)
      ..lineTo(0, 4)
      ..lineTo(-8, 12)
      ..close();
    canvas.drawPath(
      needle,
      Paint()
        ..color = accent
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(Offset.zero, 5, Paint()..color = glow);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) =>
      oldDelegate.heading != heading;
}

/// Swell direction rose (primary swell + optional secondary).
class HorizonSwellRose extends StatelessWidget {
  const HorizonSwellRose({
    super.key,
    required this.primaryDegrees,
    this.primaryHeight = 1,
    this.secondaryDegrees,
    this.secondaryHeight = 0.5,
    this.size = 140,
    this.semanticLabel,
  });

  final double primaryDegrees;
  final double primaryHeight;
  final double? secondaryDegrees;
  final double secondaryHeight;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;

    return Semantics(
      label:
          semanticLabel ??
          'Swell rose primary ${primaryDegrees.round()} degrees',
      child: ChartDrawAnimation(
        builder: (BuildContext context, double progress) {
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _SwellRosePainter(
                primaryDegrees: primaryDegrees,
                primaryHeight: primaryHeight * progress,
                secondaryDegrees: secondaryDegrees,
                secondaryHeight: secondaryHeight * progress,
                primaryColor: tokens.colors.primary,
                secondaryColor: tokens.colors.accent,
                ringColor: tokens.colors.border,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SwellRosePainter extends CustomPainter {
  _SwellRosePainter({
    required this.primaryDegrees,
    required this.primaryHeight,
    required this.secondaryDegrees,
    required this.secondaryHeight,
    required this.primaryColor,
    required this.secondaryColor,
    required this.ringColor,
  });

  final double primaryDegrees;
  final double primaryHeight;
  final double? secondaryDegrees;
  final double secondaryHeight;
  final Color primaryColor;
  final Color secondaryColor;
  final Color ringColor;

  void _petal(
    Canvas canvas,
    Offset c,
    double r,
    double degrees,
    double height,
    Color color,
  ) {
    final double a = (degrees - 90) * math.pi / 180;
    final double len = r * 0.85 * height.clamp(0.05, 1.0);
    final Offset tip = Offset(
      c.dx + math.cos(a) * len,
      c.dy + math.sin(a) * len,
    );
    final Offset left = Offset(
      c.dx + math.cos(a - 0.25) * len * 0.35,
      c.dy + math.sin(a - 0.25) * len * 0.35,
    );
    final Offset right = Offset(
      c.dx + math.cos(a + 0.25) * len * 0.35,
      c.dy + math.sin(a + 0.25) * len * 0.35,
    );
    final Path path = Path()
      ..moveTo(c.dx, c.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = color.withValues(alpha: 0.75));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = math.min(size.width, size.height) / 2 - 4;

    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    for (int i = 1; i <= 2; i++) {
      canvas.drawCircle(
        c,
        r * i / 3,
        Paint()
          ..color = ringColor.withValues(alpha: 0.4)
          ..style = PaintingStyle.stroke,
      );
    }

    if (secondaryDegrees != null) {
      _petal(canvas, c, r, secondaryDegrees!, secondaryHeight, secondaryColor);
    }
    _petal(canvas, c, r, primaryDegrees, primaryHeight, primaryColor);
    canvas.drawCircle(c, 4, Paint()..color = primaryColor);
  }

  @override
  bool shouldRepaint(covariant _SwellRosePainter oldDelegate) =>
      oldDelegate.primaryHeight != primaryHeight ||
      oldDelegate.primaryDegrees != primaryDegrees;
}
