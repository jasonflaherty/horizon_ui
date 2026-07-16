import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import 'horizon_motion.dart';

/// Rotating radar sweep over a grid — Cyber / HUD aesthetic.
class RadarSweep extends StatefulWidget {
  const RadarSweep({super.key, this.size = 160, this.color, this.gridColor});

  final double size;
  final Color? color;
  final Color? gridColor;

  @override
  State<RadarSweep> createState() => _RadarSweepState();
}

class _RadarSweepState extends State<RadarSweep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Duration duration = HorizonMotion.slow(context) * 6;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat();
    } else {
      _controller
        ..stop()
        ..value = 0.15;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color sweep = widget.color ?? context.horizon.colors.glow;
    final Color grid =
        widget.gridColor ??
        context.horizon.colors.border.withValues(alpha: 0.5);

    return Semantics(
      label: 'Radar sweep',
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: _RadarPainter(
                progress: _controller.value,
                sweepColor: sweep,
                gridColor: grid,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.progress,
    required this.sweepColor,
    required this.gridColor,
  });

  final double progress;
  final Color sweepColor;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = math.min(size.width, size.height) / 2;

    final Paint gridPaint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * i / 3, gridPaint);
    }
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      gridPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      gridPaint,
    );

    final double angle = progress * math.pi * 2 - math.pi / 2;
    final Paint sweepPaint = Paint()
      ..shader = SweepGradient(
        startAngle: angle - 0.9,
        endAngle: angle,
        colors: [
          sweepColor.withValues(alpha: 0),
          sweepColor.withValues(alpha: 0.55),
        ],
        transform: GradientRotation(angle - 0.9),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, sweepPaint);

    final Paint beam = Paint()
      ..color = sweepColor
      ..strokeWidth = 2;
    canvas.drawLine(
      center,
      Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      ),
      beam,
    );
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.sweepColor != sweepColor ||
      oldDelegate.gridColor != gridColor;
}

/// Expanding circular wave ripples from center.
class WaveRipple extends StatefulWidget {
  const WaveRipple({
    super.key,
    this.size = 120,
    this.color,
    this.waveCount = 3,
    this.child,
  });

  final double size;
  final Color? color;
  final int waveCount;
  final Widget? child;

  @override
  State<WaveRipple> createState() => _WaveRippleState();
}

class _WaveRippleState extends State<WaveRipple>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Duration duration = HorizonMotion.slow(context) * 4;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat();
    } else {
      _controller
        ..stop()
        ..value = 0.4;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color ?? context.horizon.colors.primary;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: _WaveRipplePainter(
              progress: _controller.value,
              color: color,
              waveCount: widget.waveCount,
            ),
            child: Center(child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _WaveRipplePainter extends CustomPainter {
  _WaveRipplePainter({
    required this.progress,
    required this.color,
    required this.waveCount,
  });

  final double progress;
  final Color color;
  final int waveCount;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double maxR = math.min(size.width, size.height) / 2;

    for (int i = 0; i < waveCount; i++) {
      final double t = (progress + i / waveCount) % 1.0;
      final Paint paint = Paint()
        ..color = color.withValues(alpha: (1 - t) * 0.45)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawCircle(center, maxR * t, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveRipplePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
