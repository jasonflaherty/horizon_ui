import 'package:flutter/material.dart';
import 'package:horizon_ui/horizon_ui.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HorizonGalleryApp());
}

class HorizonGalleryApp extends StatelessWidget {
  const HorizonGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Classic', data: HorizonThemes.classic()),
            WidgetbookTheme(
              name: 'Classic Dark',
              data: HorizonThemes.classicDark(),
            ),
            WidgetbookTheme(
              name: 'Luxury Coastal',
              data: HorizonThemes.luxuryCoastal(),
            ),
            WidgetbookTheme(
              name: 'Luxury Coastal Dark',
              data: HorizonThemes.luxuryCoastalDark(),
            ),
            WidgetbookTheme(name: 'Cyber', data: HorizonThemes.cyber()),
            WidgetbookTheme(
              name: 'Cyber Light',
              data: HorizonThemes.cyberLight(),
            ),
          ],
        ),
        InspectorAddon(),
      ],
      directories: [
        WidgetbookFolder(
          name: 'Buttons',
          children: [
            WidgetbookComponent(
              name: 'HorizonFilledButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Center(
                    child: HorizonFilledButton(
                      label: 'Forecast',
                      icon: Icons.waves,
                      onPressed: () {},
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Loading',
                  builder: (context) => const Center(
                    child: HorizonFilledButton(
                      label: 'Loading',
                      loading: true,
                      onPressed: null,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonGlassButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => ColoredBox(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.35),
                    child: Center(
                      child: HorizonGlassButton(
                        label: 'Explore',
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonGlowButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Center(
                    child: HorizonGlowButton(
                      label: 'Scan',
                      icon: Icons.radar,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonIconButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Center(
                    child: HorizonIconButton(
                      icon: Icons.settings,
                      tooltip: 'Settings',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonFab',
              useCases: [
                WidgetbookUseCase(
                  name: 'Icon',
                  builder: (context) => Center(
                    child: HorizonFab(
                      icon: Icons.add,
                      semanticLabel: 'Add',
                      onPressed: () {},
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Extended',
                  builder: (context) => Center(
                    child: HorizonFab(
                      icon: Icons.map,
                      label: 'Map',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Cards',
          children: [
            WidgetbookComponent(
              name: 'ForecastCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Crescent City',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: ForecastCard(
                      title: 'Crescent City',
                      score: 92,
                      waveHeight: 8.4,
                      swellPeriod: 14,
                      trend: '↑',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'MetricCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Wind',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SizedBox(
                      width: 200,
                      child: MetricCard(
                        label: 'Wind',
                        value: '18',
                        unit: 'kt',
                        trend: '+2',
                        icon: Icons.air,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HeroCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HeroCard(
                      title: 'North Pacific',
                      subtitle: 'Long-period swell filling in',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'GlassCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: GlassCard(
                      child: Text(
                        'Glass surface',
                        style: context.horizon.typography.body,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'AlertCard',
              useCases: [
                WidgetbookUseCase(
                  name: 'Warning',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: AlertCard(
                      title: 'High surf advisory',
                      message: 'Breakers 12–15 ft near exposed reefs.',
                      tone: HorizonAlertTone.warning,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Charts',
          children: [
            WidgetbookComponent(
              name: 'HorizonAreaChart',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HorizonAreaChart(
                      points: [
                        HorizonChartPoint(label: 'a', value: 2),
                        HorizonChartPoint(label: 'b', value: 5),
                        HorizonChartPoint(label: 'c', value: 3),
                        HorizonChartPoint(label: 'd', value: 6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonBarChart',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SizedBox(
                      height: 160,
                      child: HorizonBarChart(
                        points: [
                          HorizonChartPoint(label: 'M', value: 4),
                          HorizonChartPoint(label: 'T', value: 7),
                          HorizonChartPoint(label: 'W', value: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Gauges',
          children: [
            WidgetbookComponent(
              name: 'HorizonCircularGauge',
              useCases: [
                WidgetbookUseCase(
                  name: 'Score',
                  builder: (context) => const Center(
                    child: HorizonCircularGauge(value: 92, label: 'Score'),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonCompass',
              useCases: [
                WidgetbookUseCase(
                  name: 'Heading',
                  builder: (context) =>
                      const Center(child: HorizonCompass(headingDegrees: 35)),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Motion',
          children: [
            WidgetbookComponent(
              name: 'RadarSweep',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Center(child: RadarSweep()),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'AnimatedNumber',
              useCases: [
                WidgetbookUseCase(
                  name: 'Wave height',
                  builder: (context) => const Center(
                    child: AnimatedNumber(
                      value: 8.4,
                      decimalPlaces: 1,
                      suffix: ' ft',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
