import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizon_ui/horizon_ui.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: HorizonThemes.classic(),
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  testWidgets('AnimatedNumber reaches target value', (tester) async {
    await tester.pumpWidget(const _Harness(AnimatedNumber(value: 42)));
    await tester.pumpAndSettle();
    expect(find.text('42'), findsOneWidget);
  });

  testWidgets('HorizonLineChart paints without error', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const SizedBox(
          width: 300,
          child: HorizonLineChart(
            points: [
              HorizonChartPoint(label: 'A', value: 1),
              HorizonChartPoint(label: 'B', value: 3),
              HorizonChartPoint(label: 'C', value: 2),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(HorizonLineChart), findsOneWidget);
  });

  testWidgets('HorizonCircularGauge shows value', (tester) async {
    await tester.pumpWidget(
      _wrap(const HorizonCircularGauge(value: 80, label: 'Score')),
    );
    await tester.pumpAndSettle();
    expect(find.text('80'), findsOneWidget);
    expect(find.text('Score'), findsOneWidget);
  });

  testWidgets('HorizonBarChart renders labels', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const SizedBox(
          width: 320,
          height: 180,
          child: HorizonBarChart(
            points: [
              HorizonChartPoint(label: 'Mon', value: 4),
              HorizonChartPoint(label: 'Tue', value: 7),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Mon'), findsOneWidget);
    expect(find.text('Tue'), findsOneWidget);
  });

  testWidgets('HorizonResponsiveScaffold shows bottom nav when compact', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(
      MaterialApp(
        theme: HorizonThemes.cyber(),
        home: HorizonResponsiveScaffold(
          destinations: const [
            HorizonDestination(label: 'Home', icon: Icons.home),
            HorizonDestination(label: 'Map', icon: Icons.map),
          ],
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          body: const Text('Body'),
        ),
      ),
    );
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Body'), findsOneWidget);
  });

  testWidgets('HorizonTimeline lists events', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const HorizonTimeline(
          events: [
            HorizonTimelineEvent(time: '06:00', title: 'Dawn patrol'),
            HorizonTimelineEvent(time: '12:00', title: 'High tide'),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dawn patrol'), findsOneWidget);
    expect(find.text('High tide'), findsOneWidget);
  });
}

class _Harness extends StatelessWidget {
  const _Harness(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) => _wrap(child);
}
