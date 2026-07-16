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
  testWidgets('HorizonFilledButton invokes onPressed', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      _wrap(HorizonFilledButton(label: 'Go', onPressed: () => pressed = true)),
    );
    await tester.tap(find.text('Go'));
    expect(pressed, isTrue);
  });

  testWidgets('HorizonFilledButton loading shows progress', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const HorizonFilledButton(label: 'Go', onPressed: null, loading: true),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ForecastCard renders API fields under cyber theme', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        theme: HorizonThemes.cyber(),
        const ForecastCard(
          title: 'Crescent City',
          score: 92,
          waveHeight: 8.4,
          swellPeriod: 14,
        ),
      ),
    );
    expect(find.text('Crescent City'), findsOneWidget);
    expect(find.text('92'), findsOneWidget);
    expect(find.text('8.4'), findsOneWidget);
    expect(find.text('14'), findsOneWidget);
    expect(find.text('ft'), findsOneWidget);
    expect(find.text('s'), findsOneWidget);
  });

  testWidgets('MetricCard exposes semantic label', (tester) async {
    await tester.pumpWidget(
      _wrap(const MetricCard(label: 'Wind', value: '12', unit: 'kt')),
    );
    expect(find.bySemanticsLabel('Wind 12kt'), findsOneWidget);
  });

  testWidgets('AlertCard danger tone renders title and message', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        const AlertCard(
          title: 'Small craft',
          message: 'Gale warning in effect',
          tone: HorizonAlertTone.danger,
        ),
      ),
    );
    expect(find.text('Small craft'), findsOneWidget);
    expect(find.text('Gale warning in effect'), findsOneWidget);
  });

  testWidgets('Glow button respects reduced motion', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: _wrap(HorizonGlowButton(label: 'Scan', onPressed: () {})),
      ),
    );
    expect(find.text('Scan'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
  });
}
