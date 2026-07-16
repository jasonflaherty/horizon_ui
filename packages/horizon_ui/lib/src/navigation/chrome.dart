import 'dart:ui';

import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';
import '../tokens/tokens.dart';

/// Horizon-styled [AppBar] that follows [AppBarTheme] from [HorizonThemes].
class HorizonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HorizonAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.glass = false,
    this.toolbarHeight,
    this.semanticLabel,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;

  /// Frosted glass bar using backdrop blur (best over imagery / maps).
  final bool glass;
  final double? toolbarHeight;
  final String? semanticLabel;

  @override
  Size get preferredSize {
    final double height = toolbarHeight ?? kToolbarHeight;
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(height + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    final AppBar bar = AppBar(
      title: title,
      leading: leading,
      actions: actions,
      bottom: bottom,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      toolbarHeight: toolbarHeight,
      backgroundColor: glass ? Colors.transparent : null,
      elevation: glass ? 0 : null,
      scrolledUnderElevation: glass ? 0 : null,
      flexibleSpace: glass
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: tokens.elevation.glassBlur / 2,
                  sigmaY: tokens.elevation.glassBlur / 2,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: tokens.colors.surface.withValues(
                      alpha: tokens.elevation.glassOpacity.clamp(0.35, 0.85),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.lerp(
                          tokens.colors.border,
                          Colors.white,
                          tokens.elevation.specular * 0.5,
                        )!.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            )
          : null,
    );

    if (semanticLabel == null) {
      return bar;
    }
    return Semantics(container: true, label: semanticLabel, child: bar);
  }
}

/// Convenience wrapper around themed Material [NavigationBar].
class HorizonNavigationBar extends StatelessWidget {
  const HorizonNavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.height,
    this.semanticLabel,
  });

  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final double? height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Widget bar = NavigationBar(
      destinations: destinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      height: height,
    );
    if (semanticLabel == null) {
      return bar;
    }
    return Semantics(label: semanticLabel, child: bar);
  }
}

/// Themed [PopupMenuButton] using Horizon menu chrome.
class HorizonPopupMenuButton<T> extends StatelessWidget {
  const HorizonPopupMenuButton({
    super.key,
    required this.itemBuilder,
    this.onSelected,
    this.icon,
    this.tooltip,
    this.child,
    this.semanticLabel,
  });

  final PopupMenuItemBuilder<T> itemBuilder;
  final ValueChanged<T>? onSelected;
  final Widget? icon;
  final String? tooltip;
  final Widget? child;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      icon: icon,
      tooltip: tooltip ?? semanticLabel,
      child: child,
    );
  }
}
