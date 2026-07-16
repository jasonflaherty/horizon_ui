import 'package:flutter/material.dart';

import '../extensions/horizon_context.dart';

/// Destination used by Horizon navigation scaffolds.
@immutable
class HorizonDestination {
  const HorizonDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
}

/// Themed Material scaffold with Horizon background tokens.
class HorizonAppScaffold extends StatelessWidget {
  const HorizonAppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.horizon.colors.background,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }
}

/// Breakpoint-aware scaffold: rail on wide, bottom nav on compact.
class HorizonResponsiveScaffold extends StatelessWidget {
  const HorizonResponsiveScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.breakpoint = 840,
    this.title,
  });

  final List<HorizonDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final double breakpoint;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.sizeOf(context).width >= breakpoint;
    final tokens = context.horizon;

    if (wide) {
      return HorizonAppScaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.all,
              backgroundColor: tokens.colors.surface,
              destinations: [
                for (final HorizonDestination d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon ?? d.icon),
                    label: Text(d.label),
                  ),
              ],
            ),
            VerticalDivider(width: 1, color: tokens.colors.border),
            Expanded(child: body),
          ],
        ),
      );
    }

    return HorizonAppScaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          for (final HorizonDestination d in destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon ?? d.icon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

/// Master-detail split view for tablets / desktop.
class HorizonSplitView extends StatelessWidget {
  const HorizonSplitView({
    super.key,
    required this.primary,
    required this.secondary,
    this.primaryWidth = 320,
    this.breakpoint = 700,
    this.showSecondaryOnCompact = false,
  });

  final Widget primary;
  final Widget secondary;
  final double primaryWidth;
  final double breakpoint;
  final bool showSecondaryOnCompact;

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.sizeOf(context).width >= breakpoint;
    final tokens = context.horizon;

    if (!wide) {
      return showSecondaryOnCompact ? secondary : primary;
    }

    return Row(
      children: [
        SizedBox(
          width: primaryWidth,
          child: Material(color: tokens.colors.surface, child: primary),
        ),
        VerticalDivider(width: 1, color: tokens.colors.border),
        Expanded(child: secondary),
      ],
    );
  }
}

/// Adaptive top-level navigation: NavigationBar / Rail / Drawer by width.
class HorizonAdaptiveNavigation extends StatelessWidget {
  const HorizonAdaptiveNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.compactBreakpoint = 600,
    this.mediumBreakpoint = 1000,
  });

  final List<HorizonDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final double compactBreakpoint;
  final double mediumBreakpoint;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final tokens = context.horizon;

    if (width >= mediumBreakpoint) {
      return HorizonAppScaffold(
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        body: Row(
          children: [
            NavigationDrawer(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    tokens.spacing.x5,
                    tokens.spacing.x5,
                    tokens.spacing.x5,
                    tokens.spacing.x3,
                  ),
                  child: Text('Horizon', style: tokens.typography.title),
                ),
                for (final HorizonDestination d in destinations)
                  NavigationDrawerDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon ?? d.icon),
                    label: Text(d.label),
                  ),
              ],
            ),
            Expanded(child: body),
          ],
        ),
      );
    }

    if (width >= compactBreakpoint) {
      return HorizonResponsiveScaffold(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        body: body,
        appBar: appBar,
        floatingActionButton: floatingActionButton,
        breakpoint: 0,
      );
    }

    return HorizonResponsiveScaffold(
      destinations: destinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      breakpoint: double.infinity,
    );
  }
}
