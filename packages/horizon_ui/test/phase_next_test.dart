import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

Widget _wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? HorizonThemes.calm(),
    home: Scaffold(body: child),
  );
}

void main() {
  test('calm theme exposes calm density and liquid fields', () {
    final HorizonThemeExtension ext = HorizonThemes.calm()
        .extension<HorizonThemeExtension>()!;
    expect(ext.id, 'calm-dark');
    expect(ext.tokens.spacing.density, HorizonDensity.calm);
    expect(ext.tokens.elevation.refraction, greaterThan(0));
    expect(ext.tokens.motion.human, isA<Curve>());
  });

  testWidgets('HorizonSearchBar and SegmentedControl render', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Column(
          children: [
            const HorizonSearchBar(hintText: 'Spots'),
            HorizonSegmentedControl<String>(
              segments: const [
                ButtonSegment(value: 'ft', label: Text('ft')),
                ButtonSegment(value: 'm', label: Text('m')),
              ],
              selected: 'ft',
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
    expect(find.text('Spots'), findsOneWidget);
    expect(find.text('ft'), findsOneWidget);
  });

  testWidgets('HorizonDisclose expands child', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const HorizonDisclose(title: 'Details', child: Text('Hidden metrics')),
      ),
    );
    expect(find.text('Hidden metrics'), findsNothing);
    await tester.tap(find.text('Details'));
    await tester.pumpAndSettle();
    expect(find.text('Hidden metrics'), findsOneWidget);
  });

  testWidgets('HorizonAdaptiveModuleGrid sorts by priority', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HorizonAdaptiveModuleGrid(
          modules: [
            HorizonModule(
              id: 'low',
              priority: 1,
              builder: (_) => const Text('Low'),
            ),
            HorizonModule(
              id: 'high',
              priority: 10,
              builder: (_) => const Text('High'),
            ),
          ],
        ),
      ),
    );
    final Finder texts = find.byType(Text);
    expect(tester.widget<Text>(texts.at(0)).data, 'High');
    expect(tester.widget<Text>(texts.at(1)).data, 'Low');
  });

  testWidgets('HorizonInsightStrip shows message', (tester) async {
    await tester.pumpWidget(
      _wrap(
        HorizonInsightStrip(message: 'Best window: 6–8am', onDismiss: () {}),
      ),
    );
    expect(find.text('Best window: 6–8am'), findsOneWidget);
  });

  testWidgets('HorizonBentoGrid lays out cells', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const SizedBox(
          width: 400,
          child: HorizonBentoGrid(
            cells: [
              HorizonBentoCell(child: Text('A')),
              HorizonBentoCell(child: Text('B')),
            ],
          ),
        ),
      ),
    );
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });

  testWidgets('HorizonDock and VoiceAffordance build', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Stack(
          children: [
            HorizonDock(children: [HorizonVoiceAffordance(onPressed: () {})]),
          ],
        ),
      ),
    );
    expect(find.byType(HorizonVoiceAffordance), findsOneWidget);
  });
}
