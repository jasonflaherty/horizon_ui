import 'package:flutter/material.dart';

import '../../extensions/horizon_context.dart';
import '../../tokens/tokens.dart';

/// Cell definition for [HorizonBentoGrid].
@immutable
class HorizonBentoCell {
  const HorizonBentoCell({
    required this.child,
    this.columnSpan = 1,
    this.rowSpan = 1,
  });

  final Widget child;
  final int columnSpan;
  final int rowSpan;
}

/// Responsive modular bento grid for forecast dashboards.
class HorizonBentoGrid extends StatelessWidget {
  const HorizonBentoGrid({
    super.key,
    required this.cells,
    this.columns = 2,
    this.spacing,
    this.semanticLabel,
  });

  final List<HorizonBentoCell> cells;
  final int columns;
  final double? spacing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final double gap = spacing ?? tokens.spacing.x3;
    final int cols = columns.clamp(1, 4);

    return Semantics(
      label: semanticLabel ?? 'Bento grid',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double cellW = (constraints.maxWidth - gap * (cols - 1)) / cols;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final HorizonBentoCell cell in cells)
                SizedBox(
                  width:
                      cellW * cell.columnSpan.clamp(1, cols) +
                      gap * (cell.columnSpan.clamp(1, cols) - 1),
                  child: cell.child,
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Progressive disclosure panel — secondary content expands in place.
class HorizonDisclose extends StatefulWidget {
  const HorizonDisclose({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.initiallyExpanded = false,
    this.semanticLabel,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final bool initiallyExpanded;
  final String? semanticLabel;

  @override
  State<HorizonDisclose> createState() => _HorizonDiscloseState();
}

class _HorizonDiscloseState extends State<HorizonDisclose> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      label: widget.semanticLabel ?? widget.title,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tokens.colors.surface,
          borderRadius: BorderRadius.circular(tokens.radius.lg),
          border: Border.all(color: tokens.colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              borderRadius: BorderRadius.circular(tokens.radius.lg),
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing.x4),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title, style: tokens.typography.title),
                          if (widget.subtitle != null) ...[
                            SizedBox(height: tokens.spacing.x1),
                            Text(
                              widget.subtitle!,
                              style: tokens.typography.body.copyWith(
                                color: tokens.colors.resolvedOnSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: tokens.motion.fast,
                      curve: tokens.motion.human,
                      child: Icon(
                        Icons.expand_more,
                        color: tokens.colors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: tokens.motion.medium,
              curve: tokens.motion.human,
              alignment: Alignment.topCenter,
              child: _expanded
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                        tokens.spacing.x4,
                        0,
                        tokens.spacing.x4,
                        tokens.spacing.x4,
                      ),
                      child: widget.child,
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
