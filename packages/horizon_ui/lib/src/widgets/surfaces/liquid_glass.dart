import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../animations/horizon_motion.dart';
import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';

/// Liquid glass surface with refraction tint, specular edge, and optical depth.
class LiquidGlass extends StatelessWidget {
  const LiquidGlass({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.semanticLabel,
    this.enableRefraction = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool enableRefraction;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final BorderRadius radius =
        borderRadius ?? BorderRadius.circular(tokens.radius.lg);
    final EdgeInsetsGeometry resolvedPadding =
        padding ?? EdgeInsets.all(tokens.spacing.x4);
    final bool animate =
        enableRefraction && HorizonMotion.shouldAnimate(context);

    Widget content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: tokens.elevation.glassBlur,
          sigmaY: tokens.elevation.glassBlur,
        ),
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: tokens.colors.surface.withValues(
                  alpha: tokens.elevation.glassOpacity,
                ),
                borderRadius: radius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    tokens.elevation.tint,
                    tokens.elevation.tint.withValues(alpha: 0.05),
                    tokens.colors.surface.withValues(
                      alpha: tokens.elevation.glassOpacity * 0.85,
                    ),
                  ],
                  stops: const [0, 0.45, 1],
                ),
                border: Border.all(
                  width: tokens.elevation.edgeWidth,
                  color: Color.lerp(
                    tokens.colors.border,
                    Colors.white,
                    tokens.elevation.specular,
                  )!.withValues(alpha: 0.55),
                ),
                boxShadow: [
                  ...tokens.elevation.raised,
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: tokens.elevation.imperfectShadowOffset,
                  ),
                ],
              ),
              child: Padding(padding: resolvedPadding, child: child),
            ),
            if (animate)
              Positioned.fill(
                child: IgnorePointer(
                  child: _RefractionSheen(
                    strength: tokens.elevation.refraction,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (onTap != null) {
      content = Material(
        type: MaterialType.transparency,
        child: InkWell(onTap: onTap, borderRadius: radius, child: content),
      );
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      button: onTap != null,
      excludeSemantics: semanticLabel != null,
      child: content,
    );
  }
}

class _RefractionSheen extends StatefulWidget {
  const _RefractionSheen({required this.strength});

  final double strength;

  @override
  State<_RefractionSheen> createState() => _RefractionSheenState();
}

class _RefractionSheenState extends State<_RefractionSheen>
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
    final Duration duration = HorizonMotion.slow(context) * 8;
    if (duration > Duration.zero) {
      _controller
        ..duration = duration
        ..repeat(reverse: true);
    } else {
      _controller.value = 0.3;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1 + t * 2, -1),
              end: Alignment(t * 2, 1),
              colors: [
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.12 * widget.strength * 4),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Optional soft grain overlay for anti-perfect surfaces.
class HorizonTexture extends StatelessWidget {
  const HorizonTexture({super.key, required this.child, this.opacity = 0.04});

  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _GrainPainter(opacity: opacity)),
          ),
        ),
      ],
    );
  }
}

class _GrainPainter extends CustomPainter {
  _GrainPainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final math.Random rng = math.Random(42);
    final Paint paint = Paint()
      ..color = Colors.white.withValues(alpha: opacity);
    for (int i = 0; i < 120; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
