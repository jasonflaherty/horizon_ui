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
            WidgetbookTheme(name: 'Alpine', data: HorizonThemes.alpine()),
            WidgetbookTheme(name: 'Forest', data: HorizonThemes.forest()),
            WidgetbookTheme(name: 'Aurora', data: HorizonThemes.aurora()),
            WidgetbookTheme(name: 'Minimal', data: HorizonThemes.minimal()),
            WidgetbookTheme(name: 'Mono', data: HorizonThemes.mono()),
            WidgetbookTheme(name: 'Mono Dark', data: HorizonThemes.monoDark()),
            WidgetbookTheme(name: 'Calm', data: HorizonThemes.calm()),
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
        WidgetbookFolder(
          name: 'Maps',
          children: [
            WidgetbookComponent(
              name: 'ForecastMarker',
              useCases: [
                WidgetbookUseCase(
                  name: 'Selected',
                  builder: (context) => const Center(
                    child: ForecastMarker(
                      label: 'Jaws',
                      score: 95,
                      selected: true,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'WindParticles',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(16),
                    child: WindParticles(height: 140),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Chrome',
          children: [
            WidgetbookComponent(
              name: 'HorizonAppBar',
              useCases: [
                WidgetbookUseCase(
                  name: 'Glass',
                  builder: (context) => Scaffold(
                    appBar: const HorizonAppBar(
                      title: Text('Spots'),
                      glass: true,
                      automaticallyImplyLeading: false,
                    ),
                    body: const Center(child: Text('Body')),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonNavigationBar',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Scaffold(
                    body: const Center(child: Text('Body')),
                    bottomNavigationBar: HorizonNavigationBar(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      destinations: const [
                        NavigationDestination(
                          icon: Icon(Icons.map),
                          label: 'Map',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.waves),
                          label: 'Surf',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Outdoor',
          children: [
            WidgetbookComponent(
              name: 'SpotHeader',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: SpotHeader(
                      name: 'Mavericks',
                      region: 'Half Moon Bay, CA',
                      status: StatusPill(
                        label: 'Caution',
                        tone: HorizonStatusTone.warning,
                      ),
                      trailing: ScoreBadge(score: 88),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Horizon Next',
          children: [
            WidgetbookComponent(
              name: 'LiquidGlass',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: LiquidGlass(
                      child: Text(
                        'Liquid glass surface',
                        style: context.horizon.typography.body,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonInsightStrip',
              useCases: [
                WidgetbookUseCase(
                  name: 'Best window',
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: HorizonInsightStrip(
                      message: 'Best window: 6–8am · offshore 8kt',
                      icon: HorizonIcons.sun,
                      actionLabel: 'View',
                      onAction: () {},
                      onDismiss: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonBentoGrid',
              useCases: [
                WidgetbookUseCase(
                  name: 'Forecast home',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HorizonBentoGrid(
                      cells: [
                        HorizonBentoCell(
                          columnSpan: 2,
                          child: MetricTile(
                            label: 'Primary',
                            value: '6.2',
                            unit: 'ft',
                            icon: HorizonIcons.swell,
                          ),
                        ),
                        HorizonBentoCell(
                          child: MetricTile(
                            label: 'Wind',
                            value: '8',
                            unit: 'kt',
                            icon: HorizonIcons.wind,
                          ),
                        ),
                        HorizonBentoCell(
                          child: MetricTile(
                            label: 'Tide',
                            value: '2.1',
                            unit: 'ft',
                            icon: HorizonIcons.tide,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonDisclose',
              useCases: [
                WidgetbookUseCase(
                  name: 'Collapsed',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HorizonDisclose(
                      title: 'Secondary metrics',
                      subtitle: 'Tap to reveal',
                      child: Text('Tide lag and local pressure.'),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonSearchBar',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Padding(
                    padding: EdgeInsets.all(24),
                    child: HorizonSearchBar(hintText: 'Search spots'),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'HorizonDock',
              useCases: [
                WidgetbookUseCase(
                  name: 'Thumb dock',
                  builder: (context) => SizedBox(
                    height: 160,
                    child: Stack(
                      children: [
                        HorizonDock(
                          children: [
                            HorizonVoiceAffordance(onPressed: () {}),
                            HorizonIconButton(
                              icon: HorizonIcons.mapPin,
                              tooltip: 'Pin',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
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
