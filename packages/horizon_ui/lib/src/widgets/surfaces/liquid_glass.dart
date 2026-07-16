import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../animations/horizon_motion.dart';
import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';

/// Liquid glass surface with refraction tint, specular rim, and optical depth.
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
    final double rim = tokens.elevation.rimIntensity;
    final double specular = tokens.elevation.specular;
    final double edge = tokens.elevation.edgeWidth;
    final Color glow = tokens.colors.glow;

    final List<BoxShadow> depthShadows = [
      ...tokens.elevation.raised,
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1 + rim * 0.12),
        blurRadius: 14 + rim * 18,
        offset: tokens.elevation.imperfectShadowOffset,
      ),
      if (rim > 0.4)
        BoxShadow(
          color: glow.withValues(alpha: 0.12 + rim * 0.18),
          blurRadius: 22 + rim * 20,
          spreadRadius: -2,
        ),
    ];

    final BorderRadius innerRadius = BorderRadius.circular(
      math.max(0, radius.topLeft.x - edge),
    );

    Widget content = DecoratedBox(
      decoration: BoxDecoration(borderRadius: radius, boxShadow: depthShadows),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.lerp(
                Colors.white,
                glow,
                rim * 0.35,
              )!.withValues(alpha: 0.25 + specular * 0.55),
              glow.withValues(alpha: 0.08 + rim * 0.22),
              Colors.white.withValues(alpha: 0.06 + specular * 0.12),
              Colors.black.withValues(alpha: 0.18 + rim * 0.2),
            ],
            stops: const [0, 0.28, 0.62, 1],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(edge),
          child: ClipRRect(
            borderRadius: innerRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: tokens.elevation.glassBlur,
                sigmaY: tokens.elevation.glassBlur,
              ),
              child: Stack(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: innerRadius,
                      color: tokens.colors.surface.withValues(
                        alpha: tokens.elevation.glassOpacity,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.lerp(
                            tokens.elevation.tint,
                            Colors.white,
                            0.25 * specular,
                          )!,
                          tokens.elevation.tint.withValues(alpha: 0.08),
                          tokens.colors.surface.withValues(
                            alpha: tokens.elevation.glassOpacity * 0.9,
                          ),
                          glow.withValues(alpha: 0.04 + rim * 0.06),
                        ],
                        stops: const [0, 0.35, 0.75, 1],
                      ),
                    ),
                    child: Padding(padding: resolvedPadding, child: child),
                  ),
                  // Inner top-edge catch light.
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: 1.5,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(
                                alpha: 0.35 + specular * 0.4,
                              ),
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
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
          ),
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
  late final Animation<double> _sheen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // Sine ease softens acceleration and the L↔R turnaround.
    _sheen = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ~30% slower than the original 8× slow cycle for a calmer wave.
    final Duration duration = Duration(
      microseconds:
          (HorizonMotion.slow(context).inMicroseconds * 10.4).round(),
    );
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
      animation: _sheen,
      builder: (BuildContext context, Widget? child) {
        final double t = _sheen.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.15 + t * 2.3, -0.85),
              end: Alignment(-0.15 + t * 2.3, 0.85),
              colors: [
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.05 * widget.strength * 4),
                Colors.white.withValues(alpha: 0.14 * widget.strength * 4),
                glowMid(widget.strength),
                Colors.white.withValues(alpha: 0.05 * widget.strength * 4),
                Colors.white.withValues(alpha: 0),
              ],
              stops: const [0, 0.28, 0.42, 0.5, 0.58, 1],
            ),
          ),
        );
      },
    );
  }

  static Color glowMid(double strength) =>
      Colors.white.withValues(alpha: 0.07 * strength * 3);
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
