import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../extensions/horizon_context.dart';
import '../tokens/tokens.dart';

/// Content-first scaffold that collapses chrome while scrolling.
class HorizonContentScaffold extends StatefulWidget {
  const HorizonContentScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.collapseOffset = 48,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final double collapseOffset;

  @override
  State<HorizonContentScaffold> createState() => _HorizonContentScaffoldState();
}

class _HorizonContentScaffoldState extends State<HorizonContentScaffold> {
  bool _chromeVisible = true;

  bool _onScroll(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.reverse && _chromeVisible) {
      setState(() => _chromeVisible = false);
    } else if (notification.direction == ScrollDirection.forward &&
        !_chromeVisible) {
      setState(() => _chromeVisible = true);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Scaffold(
      backgroundColor: tokens.colors.background,
      appBar: widget.appBar == null
          ? null
          : PreferredSize(
              preferredSize: widget.appBar!.preferredSize,
              child: AnimatedOpacity(
                opacity: _chromeVisible ? 1 : 0,
                duration: tokens.motion.fast,
                curve: tokens.motion.human,
                child: IgnorePointer(
                  ignoring: !_chromeVisible,
                  child: widget.appBar,
                ),
              ),
            ),
      floatingActionButton: widget.floatingActionButton == null
          ? null
          : AnimatedScale(
              scale: _chromeVisible ? 1 : 0.85,
              duration: tokens.motion.fast,
              child: AnimatedOpacity(
                opacity: _chromeVisible ? 1 : 0.35,
                duration: tokens.motion.fast,
                child: widget.floatingActionButton,
              ),
            ),
      bottomNavigationBar: widget.bottomNavigationBar == null
          ? null
          : AnimatedSlide(
              offset: _chromeVisible ? Offset.zero : const Offset(0, 1),
              duration: tokens.motion.medium,
              curve: tokens.motion.human,
              child: widget.bottomNavigationBar,
            ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: _onScroll,
        child: widget.body,
      ),
    );
  }
}

/// Thumb-aware dock for quick actions (defaults to bottom-right / right-hand).
class HorizonDock extends StatelessWidget {
  const HorizonDock({
    super.key,
    required this.children,
    this.leftHanded = false,
    this.semanticLabel,
  });

  final List<Widget> children;
  final bool leftHanded;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      label: semanticLabel ?? 'Quick actions dock',
      child: Align(
        alignment: leftHanded ? Alignment.bottomLeft : Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(tokens.spacing.x4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tokens.colors.surface.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(tokens.radius.pill),
              border: Border.all(color: tokens.colors.border),
              boxShadow: tokens.elevation.floating,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: tokens.spacing.x2,
                vertical: tokens.spacing.x2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < children.length; i++) ...[
                    if (i > 0) SizedBox(width: tokens.spacing.x1),
                    children[i],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
