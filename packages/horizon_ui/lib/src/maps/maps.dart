import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../animations/horizon_motion.dart';
import '../extensions/horizon_context.dart';

/// Map pin for a forecast location with optional score badge.
class ForecastMarker extends StatelessWidget {
  const ForecastMarker({
    super.key,
    required this.label,
    this.score,
    this.selected = false,
    this.onTap,
    this.semanticLabel,
  });

  final String label;
  final int? score;
  final bool selected;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.horizon;
    final Color accent = selected
        ? tokens.colors.accent
        : tokens.colors.primary;

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: semanticLabel ?? '$label${score != null ? ', score $score' : ''}',
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (selected) AnimatedHalo(color: accent, size: 56),
                Icon(
                  Icons.location_on,
                  size: selected ? 40 : 34,
                  color: accent,
                ),
                if (score != null)
                  Positioned(
                    top: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: tokens.spacing.x1,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: tokens.colors.surface,
                        borderRadius: BorderRadius.circular(tokens.radius.pill),
                        border: Border.all(color: accent),
                      ),
                      child: Text(
                        '$score',
                        style: tokens.typography.label.copyWith(
                          fontSize: 9,
                          color: accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              label,
              style: tokens.typography.label.copyWith(
                color: tokens.colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Soft pulsing halo for map selection / activity.
class AnimatedHalo extends StatefulWidget {
  const AnimatedHalo({super.key, this.size = 64, this.color});

  final double size;
  final Color? color;

  @override
  State<AnimatedHalo> createState() => _AnimatedHaloState();
}

class _AnimatedHaloState extends State<AnimatedHalo>
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
    final Duration duration = HorizonMotion.slow(context) * 3;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat(reverse: true);
    } else {
      _controller
        ..stop()
        ..value = 0.6;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color ?? context.horizon.colors.glow;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value;
        return Container(
          width: widget.size * (0.85 + t * 0.2),
          height: widget.size * (0.85 + t * 0.2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12 + t * 0.18),
            border: Border.all(
              color: color.withValues(alpha: 0.35 + t * 0.35),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}

/// Selection ring drawn around a map focus point.
class SelectionRing extends StatelessWidget {
  const SelectionRing({super.key, this.size = 72, this.color, this.child});

  final double size;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Color ring = color ?? context.horizon.colors.accent;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SelectionRingPainter(color: ring),
        child: Center(child: child),
      ),
    );
  }
}

class _SelectionRingPainter extends CustomPainter {
  _SelectionRingPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = math.min(size.width, size.height) / 2 - 3;
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = color.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
    // Tick marks
    for (int i = 0; i < 4; i++) {
      final double a = i * math.pi / 2;
      final Offset outer = Offset(
        c.dx + math.cos(a) * r,
        c.dy + math.sin(a) * r,
      );
      final Offset inner = Offset(
        c.dx + math.cos(a) * (r - 8),
        c.dy + math.sin(a) * (r - 8),
      );
      canvas.drawLine(
        inner,
        outer,
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SelectionRingPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Simple heat-map style overlay from intensity samples (0–1).
class HeatMapOverlay extends StatelessWidget {
  const HeatMapOverlay({
    super.key,
    required this.cells,
    this.rows = 6,
    this.columns = 8,
    this.height = 140,
    this.semanticLabel,
  });

  /// Row-major intensities in 0–1.
  final List<double> cells;
  final int rows;
  final int columns;
  final double height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color cool = context.horizon.colors.primary;
    final Color hot = context.horizon.colors.danger;

    return Semantics(
      label: semanticLabel ?? 'Heat map overlay',
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          painter: _HeatMapPainter(
            cells: cells,
            rows: rows,
            columns: columns,
            cool: cool,
            hot: hot,
          ),
        ),
      ),
    );
  }
}

class _HeatMapPainter extends CustomPainter {
  _HeatMapPainter({
    required this.cells,
    required this.rows,
    required this.columns,
    required this.cool,
    required this.hot,
  });

  final List<double> cells;
  final int rows;
  final int columns;
  final Color cool;
  final Color hot;

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / columns;
    final double cellH = size.height / rows;
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        final int i = r * columns + c;
        final double t = i < cells.length ? cells[i].clamp(0.0, 1.0) : 0;
        final Color color = Color.lerp(
          cool,
          hot,
          t,
        )!.withValues(alpha: 0.35 + t * 0.45);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(c * cellW, r * cellH, cellW - 1, cellH - 1),
            const Radius.circular(2),
          ),
          Paint()..color = color,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HeatMapPainter oldDelegate) =>
      oldDelegate.cells != cells;
}

/// Animated wind particle field for map / HUD backgrounds.
class WindParticles extends StatefulWidget {
  const WindParticles({
    super.key,
    this.height = 120,
    this.particleCount = 28,
    this.directionDegrees = 270,
    this.color,
    this.semanticLabel,
  });

  final double height;
  final int particleCount;
  final double directionDegrees;
  final Color? color;
  final String? semanticLabel;

  @override
  State<WindParticles> createState() => _WindParticlesState();
}

class _WindParticlesState extends State<WindParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final math.Random _rng = math.Random(7);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _particles = List<_Particle>.generate(
      widget.particleCount,
      (_) => _Particle.random(_rng),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Duration duration = HorizonMotion.slow(context) * 8;
    if (HorizonMotion.shouldAnimate(context) && duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat();
    } else {
      _controller
        ..stop()
        ..value = 0.3;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color ?? context.horizon.colors.glow;

    return Semantics(
      label: widget.semanticLabel ?? 'Wind particles',
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: _WindPainter(
                particles: _particles,
                progress: _controller.value,
                directionDegrees: widget.directionDegrees,
                color: color,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Particle {
  _Particle({
    required this.x,
    required this.y,
    required this.length,
    required this.speed,
  });

  factory _Particle.random(math.Random rng) {
    return _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      length: 0.02 + rng.nextDouble() * 0.06,
      speed: 0.4 + rng.nextDouble() * 0.8,
    );
  }

  final double x;
  final double y;
  final double length;
  final double speed;
}

class _WindPainter extends CustomPainter {
  _WindPainter({
    required this.particles,
    required this.progress,
    required this.directionDegrees,
    required this.color,
  });

  final List<_Particle> particles;
  final double progress;
  final double directionDegrees;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double rad = directionDegrees * math.pi / 180;
    final double dx = math.cos(rad);
    final double dy = math.sin(rad);
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (final _Particle p in particles) {
      final double drift = (progress * p.speed) % 1.0;
      final double px = ((p.x + dx * drift) % 1.0) * size.width;
      final double py = ((p.y + dy * drift) % 1.0) * size.height;
      canvas.drawLine(
        Offset(px, py),
        Offset(
          px + dx * p.length * size.width,
          py + dy * p.length * size.width,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _WindPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
