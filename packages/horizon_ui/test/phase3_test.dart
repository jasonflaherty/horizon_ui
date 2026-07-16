import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? HorizonThemes.classic(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  test('alpine / forest / aurora / minimal expose extensions', () {
    for (final ThemeData theme in <ThemeData>[
      HorizonThemes.alpine(),
      HorizonThemes.alpineDark(),
      HorizonThemes.forest(),
      HorizonThemes.forestDark(),
      HorizonThemes.aurora(),
      HorizonThemes.auroraLight(),
      HorizonThemes.minimal(),
      HorizonThemes.minimalDark(),
    ]) {
      expect(theme.extension<HorizonThemeExtension>(), isNotNull);
    }
  });

  testWidgets('ScoreBadge and StatusPill render', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScoreBadge(score: 88),
            SizedBox(width: 8),
            StatusPill(label: 'Open', tone: HorizonStatusTone.positive),
          ],
        ),
      ),
    );
    expect(find.text('88'), findsOneWidget);
    expect(find.text('OPEN'), findsOneWidget);
  });

  testWidgets('UnitSelector changes selection', (tester) async {
    var index = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: HorizonThemes.forest(),
        home: Scaffold(
          body: Center(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return UnitSelector(
                  options: const ['ft', 'm'],
                  selectedIndex: index,
                  onChanged: (int i) => setState(() => index = i),
                );
              },
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('m'));
    await tester.pump();
    expect(index, 1);
  });

  testWidgets('ForecastMarker shows label and score', (tester) async {
    await tester.pumpWidget(
      _wrap(
        theme: HorizonThemes.aurora(),
        const ForecastMarker(label: 'Jaws', score: 95, selected: true),
      ),
    );
    expect(find.text('Jaws'), findsOneWidget);
    expect(find.text('95'), findsOneWidget);
  });

  testWidgets('HeatMapOverlay and WindParticles build', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const Column(
          children: [
            HeatMapOverlay(
              rows: 2,
              columns: 3,
              cells: [0.1, 0.5, 0.9, 0.2, 0.6, 0.4],
              height: 80,
            ),
            WindParticles(height: 60, particleCount: 8),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(HeatMapOverlay), findsOneWidget);
    expect(find.byType(WindParticles), findsOneWidget);
  });

  testWidgets('SpotHeader and DayPartStrip render', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const Column(
          children: [
            SpotHeader(
              name: 'Mavericks',
              region: 'Half Moon Bay, CA',
              status: StatusPill(
                label: 'Caution',
                tone: HorizonStatusTone.warning,
              ),
            ),
            SizedBox(height: 12),
            DayPartStrip(
              parts: [
                HorizonDayPart(label: 'AM', value: '6ft', icon: Icons.wb_sunny),
                HorizonDayPart(
                  label: 'PM',
                  value: '8ft',
                  icon: Icons.nights_stay,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    expect(find.text('Mavericks'), findsOneWidget);
    expect(find.text('6ft'), findsOneWidget);
  });
}
