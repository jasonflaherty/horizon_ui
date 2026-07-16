import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import '../tokens/tokens.dart';
import '../widgets/surfaces/liquid_glass.dart';

/// Module contract for adaptive / anticipatory home layouts.
@immutable
class HorizonModule {
  const HorizonModule({
    required this.id,
    required this.builder,
    this.priority = 0,
    this.when,
  });

  final String id;
  final int priority;
  final WidgetBuilder builder;

  /// Optional predicate; return false to hide the module.
  final bool Function(BuildContext context)? when;
}

/// Reorders modules by descending [HorizonModule.priority] (app-supplied ranking).
class HorizonAdaptiveModuleGrid extends StatelessWidget {
  const HorizonAdaptiveModuleGrid({
    super.key,
    required this.modules,
    this.columns = 1,
    this.spacing,
    this.semanticLabel,
  });

  final List<HorizonModule> modules;
  final int columns;
  final double? spacing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final double gap = spacing ?? tokens.spacing.x3;

    final List<HorizonModule> visible =
        modules
            .where((HorizonModule m) => m.when?.call(context) ?? true)
            .toList()
          ..sort(
            (HorizonModule a, HorizonModule b) =>
                b.priority.compareTo(a.priority),
          );

    if (columns <= 1) {
      return Semantics(
        label: semanticLabel ?? 'Adaptive modules',
        child: Column(
          children: [
            for (int i = 0; i < visible.length; i++) ...[
              if (i > 0) SizedBox(height: gap),
              visible[i].builder(context),
            ],
          ],
        ),
      );
    }

    return Semantics(
      label: semanticLabel ?? 'Adaptive modules',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double cellW =
              (constraints.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final HorizonModule m in visible)
                SizedBox(width: cellW, child: m.builder(context)),
            ],
          );
        },
      ),
    );
  }
}

/// Ambient insight strip — suggestions without a chat orb.
class HorizonInsightStrip extends StatelessWidget {
  const HorizonInsightStrip({
    super.key,
    required this.message,
    this.icon,
    this.onDismiss,
    this.onAction,
    this.actionLabel,
    this.semanticLabel,
  });

  final String message;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final VoidCallback? onAction;
  final String? actionLabel;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Semantics(
      liveRegion: true,
      label: semanticLabel ?? message,
      child: LiquidGlass(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.x4,
          vertical: tokens.spacing.x3,
        ),
        child: Row(
          children: [
            Icon(
              icon ?? Icons.auto_awesome,
              color: tokens.colors.accent,
              size: 20,
            ),
            SizedBox(width: tokens.spacing.x3),
            Expanded(
              child: Text(
                message,
                style: tokens.typography.body.copyWith(
                  color: tokens.colors.onSurface,
                ),
              ),
            ),
            if (onAction != null && actionLabel != null)
              TextButton(onPressed: onAction, child: Text(actionLabel!)),
            if (onDismiss != null)
              IconButton(
                tooltip: 'Dismiss',
                onPressed: onDismiss,
                icon: Icon(
                  Icons.close,
                  size: 18,
                  color: tokens.colors.resolvedOnSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Voice affordance — apps plug their own STT behind [onPressed].
class HorizonVoiceAffordance extends StatelessWidget {
  const HorizonVoiceAffordance({
    super.key,
    required this.onPressed,
    this.active = false,
    this.tooltip = 'Voice',
    this.semanticLabel,
  });

  final VoidCallback onPressed;
  final bool active;
  final String tooltip;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    final Color color = active ? tokens.colors.accent : tokens.colors.primary;

    return Semantics(
      button: true,
      label: semanticLabel ?? tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: color.withValues(alpha: 0.15),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(active ? Icons.mic : Icons.mic_none, color: color),
            ),
          ),
        ),
      ),
    );
  }
}
