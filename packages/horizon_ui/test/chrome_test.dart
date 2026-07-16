import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

void main() {
  test('themes expose AppBar, NavigationBar, and menu chrome', () {
    final ThemeData theme = HorizonThemes.cyberDark();
    final HorizonTokens tokens = theme
        .extension<HorizonThemeExtension>()!
        .tokens;

    expect(theme.appBarTheme.backgroundColor, tokens.colors.surface);
    expect(theme.appBarTheme.foregroundColor, tokens.colors.onSurface);
    expect(theme.navigationBarTheme.backgroundColor, tokens.colors.surface);
    expect(theme.popupMenuTheme.color, tokens.colors.surface);
    expect(theme.menuTheme.style, isNotNull);
    expect(theme.navigationDrawerTheme.backgroundColor, tokens.colors.surface);
    expect(theme.drawerTheme.backgroundColor, tokens.colors.surface);
  });

  testWidgets('HorizonAppBar and NavigationBar render', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HorizonThemes.luxuryCoastalDark(),
        home: HorizonAppScaffold(
          appBar: const HorizonAppBar(title: Text('Spots'), glass: true),
          bottomNavigationBar: HorizonNavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            destinations: const [
              NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
              NavigationDestination(icon: Icon(Icons.waves), label: 'Surf'),
            ],
          ),
          body: const Center(child: Text('Body')),
        ),
      ),
    );

    expect(find.text('Spots'), findsOneWidget);
    expect(find.text('Map'), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
  });

  testWidgets('HorizonPopupMenuButton opens themed menu', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: HorizonThemes.calm(),
        home: Scaffold(
          body: HorizonPopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem(value: 'a', child: Text('Action A')),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Action A'), findsOneWidget);
  });
}
