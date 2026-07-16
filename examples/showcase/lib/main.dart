import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizon_ui/horizon_ui.dart';

enum ShowcaseThemeId {
  classic,
  luxuryCoastal,
  cyber,
  alpine,
  forest,
  aurora,
  minimal,
}

extension ShowcaseThemeIdX on ShowcaseThemeId {
  String get label => switch (this) {
    ShowcaseThemeId.classic => 'Classic',
    ShowcaseThemeId.luxuryCoastal => 'Luxury Coastal',
    ShowcaseThemeId.cyber => 'Cyber Surf',
    ShowcaseThemeId.alpine => 'Alpine',
    ShowcaseThemeId.forest => 'Forest',
    ShowcaseThemeId.aurora => 'Aurora',
    ShowcaseThemeId.minimal => 'Minimal',
  };

  ThemeData themeData({required bool dark}) => switch (this) {
    ShowcaseThemeId.classic =>
      dark ? HorizonThemes.classicDark() : HorizonThemes.classic(),
    ShowcaseThemeId.luxuryCoastal =>
      dark ? HorizonThemes.luxuryCoastalDark() : HorizonThemes.luxuryCoastal(),
    ShowcaseThemeId.cyber =>
      dark ? HorizonThemes.cyberDark() : HorizonThemes.cyberLight(),
    ShowcaseThemeId.alpine =>
      dark ? HorizonThemes.alpineDark() : HorizonThemes.alpine(),
    ShowcaseThemeId.forest =>
      dark ? HorizonThemes.forestDark() : HorizonThemes.forest(),
    ShowcaseThemeId.aurora =>
      dark ? HorizonThemes.auroraDark() : HorizonThemes.auroraLight(),
    ShowcaseThemeId.minimal =>
      dark ? HorizonThemes.minimalDark() : HorizonThemes.minimal(),
  };
}

void main() {
  runApp(const ShowcaseApp());
}

class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  ShowcaseThemeId _themeId = ShowcaseThemeId.cyber;
  bool _dark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizon UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: _themeId.themeData(dark: _dark),
      home: ShowcaseHome(
        themeId: _themeId,
        dark: _dark,
        onThemeChanged: (ShowcaseThemeId id) => setState(() => _themeId = id),
        onDarkChanged: (bool dark) => setState(() => _dark = dark),
      ),
    );
  }
}

class ShowcaseHome extends StatelessWidget {
  const ShowcaseHome({
    super.key,
    required this.themeId,
    required this.dark,
    required this.onThemeChanged,
    required this.onDarkChanged,
  });

  final ShowcaseThemeId themeId;
  final bool dark;
  final ValueChanged<ShowcaseThemeId> onThemeChanged;
  final ValueChanged<bool> onDarkChanged;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Scaffold(
      backgroundColor: tokens.colors.background,
      floatingActionButton: HorizonFab(
        icon: Icons.add,
        label: 'Log session',
        onPressed: () {},
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  tokens.spacing.x5,
                  tokens.spacing.x5,
                  tokens.spacing.x5,
                  tokens.spacing.x3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Horizon UI', style: tokens.typography.display),
                    SizedBox(height: tokens.spacing.x2),
                    Text(
                      'Phases 1–3 — themes, components, charts, maps, and outdoor widgets.',
                      style: tokens.typography.body.copyWith(
                        color: tokens.colors.resolvedOnSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Theme',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: tokens.spacing.x2,
                      runSpacing: tokens.spacing.x2,
                      children: [
                        for (final ShowcaseThemeId id in ShowcaseThemeId.values)
                          ChoiceChip(
                            label: Text(id.label),
                            selected: themeId == id,
                            onSelected: (_) => onThemeChanged(id),
                          ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.x3),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Dark mode', style: tokens.typography.title),
                      subtitle: Text(
                        dark ? 'Using dark tokens' : 'Using light tokens',
                        style: tokens.typography.body.copyWith(
                          color: tokens.colors.resolvedOnSurfaceVariant,
                        ),
                      ),
                      value: dark,
                      onChanged: onDarkChanged,
                    ),
                    SizedBox(height: tokens.spacing.x2),
                    _ColorSwatchRow(tokens: tokens),
                    SizedBox(height: tokens.spacing.x3),
                    const _CodeDropdown(
                      code: '''
MaterialApp(
  theme: HorizonThemes.cyber(),
  darkTheme: HorizonThemes.cyberDark(),
  home: const MyHomePage(),
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Buttons',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _WidgetDemo(
                      preview: Wrap(
                        spacing: tokens.spacing.x3,
                        runSpacing: tokens.spacing.x3,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          HorizonFilledButton(
                            label: 'Filled',
                            icon: Icons.waves,
                            onPressed: () {},
                          ),
                          HorizonGlassButton(label: 'Glass', onPressed: () {}),
                          HorizonGlowButton(
                            label: 'Glow',
                            icon: Icons.radar,
                            onPressed: () {},
                          ),
                          HorizonIconButton(
                            icon: Icons.settings,
                            tooltip: 'Settings',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      code: '''
HorizonFilledButton(
  label: 'Filled',
  icon: Icons.waves,
  onPressed: () {},
);

HorizonGlassButton(
  label: 'Glass',
  onPressed: () {},
);

HorizonGlowButton(
  label: 'Glow',
  icon: Icons.radar,
  onPressed: () {},
);

HorizonIconButton(
  icon: Icons.settings,
  tooltip: 'Settings',
  onPressed: () {},
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sizes', style: tokens.typography.label),
                          SizedBox(height: tokens.spacing.x2),
                          Wrap(
                            spacing: tokens.spacing.x2,
                            runSpacing: tokens.spacing.x2,
                            children: [
                              for (final HorizonButtonSize size
                                  in HorizonButtonSize.values)
                                HorizonFilledButton(
                                  label: size.name.toUpperCase(),
                                  size: size,
                                  onPressed: () {},
                                ),
                            ],
                          ),
                          SizedBox(height: tokens.spacing.x3),
                          const HorizonFilledButton(
                            label: 'Loading',
                            loading: true,
                            onPressed: null,
                          ),
                        ],
                      ),
                      code: '''
HorizonFilledButton(
  label: 'SM',
  size: HorizonButtonSize.sm,
  onPressed: () {},
);

HorizonFilledButton(
  label: 'Loading',
  loading: true,
  onPressed: null,
);

HorizonFab(
  icon: Icons.add,
  label: 'Log session',
  onPressed: () {},
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Cards',
                child: Column(
                  children: [
                    _WidgetDemo(
                      preview: const ForecastCard(
                        title: 'Crescent City',
                        score: 92,
                        waveHeight: 8.4,
                        swellPeriod: 14,
                        trend: '↑',
                      ),
                      code: '''
ForecastCard(
  title: 'Crescent City',
  score: 92,
  waveHeight: 8.4,
  swellPeriod: 14,
  trend: '↑',
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: const HeroCard(
                        title: 'North Pacific',
                        subtitle: 'Long-period swell filling in overnight',
                      ),
                      code: '''
HeroCard(
  title: 'North Pacific',
  subtitle: 'Long-period swell filling in overnight',
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: const Row(
                        children: [
                          Expanded(
                            child: MetricCard(
                              label: 'Wind',
                              value: '18',
                              unit: 'kt',
                              trend: '+2',
                              icon: Icons.air,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: MetricCard(
                              label: 'Tide',
                              value: '4.2',
                              unit: 'ft',
                              trend: '↓',
                              icon: Icons.water,
                            ),
                          ),
                        ],
                      ),
                      code: '''
MetricCard(
  label: 'Wind',
  value: '18',
  unit: 'kt',
  trend: '+2',
  icon: Icons.air,
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: const GlassCard(
                        child: Text(
                          'GlassCard — frosted surface for overlays and HUD panels.',
                        ),
                      ),
                      code: '''
GlassCard(
  child: Text('Frosted surface'),
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: const Column(
                        children: [
                          AlertCard(
                            title: 'High surf advisory',
                            message: 'Breakers 12–15 ft near exposed reefs.',
                            tone: HorizonAlertTone.warning,
                          ),
                          SizedBox(height: 12),
                          AlertCard(
                            title: 'Conditions improving',
                            message: 'Offshore winds expected by late morning.',
                            tone: HorizonAlertTone.success,
                          ),
                          SizedBox(height: 12),
                          AlertCard(
                            title: 'Small craft warning',
                            message: 'Gale-force squalls possible after dusk.',
                            tone: HorizonAlertTone.danger,
                          ),
                        ],
                      ),
                      code: '''
AlertCard(
  title: 'High surf advisory',
  message: 'Breakers 12–15 ft near exposed reefs.',
  tone: HorizonAlertTone.warning,
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Charts',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _WidgetDemo(
                      preview: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Line / Area', style: tokens.typography.label),
                          SizedBox(height: tokens.spacing.x2),
                          GlassCard(
                            child: HorizonAreaChart(
                              height: 140,
                              points: const [
                                HorizonChartPoint(label: '6', value: 2.1),
                                HorizonChartPoint(label: '9', value: 3.4),
                                HorizonChartPoint(label: '12', value: 5.2),
                                HorizonChartPoint(label: '15', value: 4.1),
                                HorizonChartPoint(label: '18', value: 6.0),
                                HorizonChartPoint(label: '21', value: 4.8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      code: '''
HorizonAreaChart(
  height: 140,
  points: const [
    HorizonChartPoint(label: '6', value: 2.1),
    HorizonChartPoint(label: '9', value: 3.4),
    HorizonChartPoint(label: '12', value: 5.2),
  ],
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bars', style: tokens.typography.label),
                          SizedBox(height: tokens.spacing.x2),
                          GlassCard(
                            child: SizedBox(
                              height: 150,
                              child: HorizonBarChart(
                                points: const [
                                  HorizonChartPoint(label: 'Mon', value: 4),
                                  HorizonChartPoint(label: 'Tue', value: 7),
                                  HorizonChartPoint(label: 'Wed', value: 5),
                                  HorizonChartPoint(label: 'Thu', value: 8),
                                  HorizonChartPoint(label: 'Fri', value: 6),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      code: '''
HorizonBarChart(
  points: const [
    HorizonChartPoint(label: 'Mon', value: 4),
    HorizonChartPoint(label: 'Tue', value: 7),
    HorizonChartPoint(label: 'Wed', value: 5),
  ],
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tide', style: tokens.typography.label),
                          SizedBox(height: tokens.spacing.x2),
                          GlassCard(
                            child: HorizonTideChart(
                              points: const [
                                HorizonChartPoint(label: '00', value: 1.2),
                                HorizonChartPoint(label: '04', value: 3.8),
                                HorizonChartPoint(label: '08', value: 2.1),
                                HorizonChartPoint(label: '12', value: 4.5),
                                HorizonChartPoint(label: '16', value: 1.9),
                                HorizonChartPoint(label: '20', value: 3.2),
                              ],
                            ),
                          ),
                        ],
                      ),
                      code: '''
HorizonTideChart(
  points: const [
    HorizonChartPoint(label: '00', value: 1.2),
    HorizonChartPoint(label: '04', value: 3.8),
    HorizonChartPoint(label: '08', value: 2.1),
  ],
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: GlassCard(
                        child: Center(
                          child: HorizonRadarChart(
                            size: 160,
                            points: const [
                              HorizonChartPoint(label: 'Size', value: 0.9),
                              HorizonChartPoint(label: 'Wind', value: 0.7),
                              HorizonChartPoint(label: 'Tide', value: 0.5),
                              HorizonChartPoint(label: 'Period', value: 0.85),
                              HorizonChartPoint(label: 'Crowd', value: 0.4),
                            ],
                          ),
                        ),
                      ),
                      code: '''
HorizonRadarChart(
  size: 160,
  points: const [
    HorizonChartPoint(label: 'Size', value: 0.9),
    HorizonChartPoint(label: 'Wind', value: 0.7),
    HorizonChartPoint(label: 'Tide', value: 0.5),
  ],
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: GlassCard(
                        child: HorizonTimeline(
                          events: const [
                            HorizonTimelineEvent(
                              time: '06:10',
                              title: 'Dawn patrol',
                              detail: 'Light offshore, clean faces',
                            ),
                            HorizonTimelineEvent(
                              time: '11:40',
                              title: 'High tide',
                              detail: 'Push onto the inside reef',
                            ),
                            HorizonTimelineEvent(
                              time: '17:20',
                              title: 'Evening glass-off',
                            ),
                          ],
                        ),
                      ),
                      code: '''
HorizonTimeline(
  events: const [
    HorizonTimelineEvent(
      time: '06:10',
      title: 'Dawn patrol',
      detail: 'Light offshore, clean faces',
    ),
    HorizonTimelineEvent(
      time: '11:40',
      title: 'High tide',
    ),
  ],
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Gauges',
                child: Column(
                  children: [
                    _WidgetDemo(
                      preview: Row(
                        children: [
                          Expanded(
                            child: GlassCard(
                              child: Center(
                                child: HorizonCircularGauge(
                                  value: 92,
                                  label: 'Score',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: tokens.spacing.x3),
                          Expanded(
                            child: GlassCard(
                              child: Center(
                                child: HorizonCompass(headingDegrees: 42),
                              ),
                            ),
                          ),
                        ],
                      ),
                      code: '''
HorizonCircularGauge(
  value: 92,
  label: 'Score',
);

HorizonCompass(headingDegrees: 42);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Row(
                        children: [
                          Expanded(
                            child: GlassCard(
                              child: Center(
                                child: HorizonSwellRose(
                                  primaryDegrees: 250,
                                  primaryHeight: 0.9,
                                  secondaryDegrees: 200,
                                  secondaryHeight: 0.45,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: tokens.spacing.x3),
                          Expanded(
                            child: GlassCard(
                              child: HorizonLinearGauge(
                                label: 'Wind',
                                value: 18,
                                max: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      code: '''
HorizonSwellRose(
  primaryDegrees: 250,
  primaryHeight: 0.9,
  secondaryDegrees: 200,
  secondaryHeight: 0.45,
);

HorizonLinearGauge(
  label: 'Wind',
  value: 18,
  max: 40,
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Motion',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _WidgetDemo(
                      preview: Row(
                        children: [
                          AnimatedNumber(
                            value: 8.4,
                            decimalPlaces: 1,
                            suffix: ' ft',
                            style: tokens.typography.display,
                          ),
                          const Spacer(),
                          HorizonPulse(
                            child: Icon(
                              Icons.circle,
                              color: tokens.colors.success,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      code: '''
AnimatedNumber(
  value: 8.4,
  decimalPlaces: 1,
  suffix: ' ft',
);

HorizonPulse(
  child: Icon(Icons.circle, color: Colors.green),
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HorizonShimmer(width: double.infinity, height: 14),
                          SizedBox(height: tokens.spacing.x2),
                          HorizonShimmer(width: 180, height: 14),
                        ],
                      ),
                      code: '''
HorizonShimmer(width: double.infinity, height: 14);
HorizonShimmer(width: 180, height: 14);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RadarSweep(size: 110),
                          WaveRipple(
                            size: 110,
                            child: Icon(
                              Icons.place,
                              color: tokens.colors.primary,
                            ),
                          ),
                          FloatingCard(
                            child: GlassCard(
                              padding: EdgeInsets.all(tokens.spacing.x3),
                              child: Text(
                                'Float',
                                style: tokens.typography.label,
                              ),
                            ),
                          ),
                        ],
                      ),
                      code: '''
RadarSweep(size: 110);

WaveRipple(
  size: 110,
  child: Icon(Icons.place),
);

FloatingCard(
  child: GlassCard(child: Text('Float')),
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Maps',
                child: Column(
                  children: [
                    _WidgetDemo(
                      preview: GlassCard(
                        child: SizedBox(
                          height: 160,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              WindParticles(height: 160, directionDegrees: 240),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ForecastMarker(
                                    label: 'South',
                                    score: 74,
                                    onTap: () {},
                                  ),
                                  ForecastMarker(
                                    label: 'Jaws',
                                    score: 95,
                                    selected: true,
                                    onTap: () {},
                                  ),
                                  SelectionRing(
                                    child: Icon(
                                      Icons.sailing,
                                      color: tokens.colors.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      code: '''
ForecastMarker(
  label: 'Jaws',
  score: 95,
  selected: true,
  onTap: () {},
);

AnimatedHalo(size: 56);
SelectionRing(child: Icon(Icons.sailing));
WindParticles(directionDegrees: 240);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: GlassCard(
                        child: HeatMapOverlay(
                          height: 120,
                          rows: 4,
                          columns: 8,
                          cells: [for (int i = 0; i < 32; i++) (i % 8) / 7],
                        ),
                      ),
                      code: '''
HeatMapOverlay(
  rows: 4,
  columns: 8,
  cells: [/* 0.0–1.0 intensities */],
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Outdoor',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _WidgetDemo(
                      preview: SpotHeader(
                        name: 'Mavericks',
                        region: 'Half Moon Bay, CA',
                        status: const StatusPill(
                          label: 'Caution',
                          tone: HorizonStatusTone.warning,
                        ),
                        trailing: const ScoreBadge(score: 88),
                      ),
                      code: '''
SpotHeader(
  name: 'Mavericks',
  region: 'Half Moon Bay, CA',
  status: StatusPill(
    label: 'Caution',
    tone: HorizonStatusTone.warning,
  ),
  trailing: ScoreBadge(score: 88),
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Wrap(
                        spacing: tokens.spacing.x2,
                        runSpacing: tokens.spacing.x2,
                        children: [
                          const ScoreBadge(score: 92),
                          const StatusPill(
                            label: 'Open',
                            tone: HorizonStatusTone.positive,
                          ),
                          const TrendChip(
                            label: '+1.2 ft',
                            direction: HorizonTrendDirection.up,
                          ),
                          TrendChip(
                            label: 'Steady',
                            direction: HorizonTrendDirection.flat,
                          ),
                          ConditionChip(
                            label: 'Offshore',
                            icon: Icons.air,
                            selected: true,
                            onSelected: (_) {},
                          ),
                          ConditionChip(
                            label: 'Long period',
                            icon: Icons.waves,
                            onSelected: (_) {},
                          ),
                        ],
                      ),
                      code: '''
ScoreBadge(score: 92);
StatusPill(label: 'Open', tone: HorizonStatusTone.positive);
TrendChip(label: '+1.2 ft', direction: HorizonTrendDirection.up);
ConditionChip(label: 'Offshore', icon: Icons.air, selected: true);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: Row(
                        children: [
                          Expanded(
                            child: MetricTile(
                              label: 'Period',
                              value: '14',
                              unit: 's',
                              icon: Icons.timelapse,
                            ),
                          ),
                          SizedBox(width: tokens.spacing.x2),
                          Expanded(
                            child: MetricTile(
                              label: 'Wind',
                              value: '8',
                              unit: 'kt',
                              icon: Icons.air,
                            ),
                          ),
                        ],
                      ),
                      code: '''
MetricTile(
  label: 'Period',
  value: '14',
  unit: 's',
  icon: Icons.timelapse,
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: const _UnitSelectorDemo(),
                      code: '''
UnitSelector(
  options: ['ft', 'm'],
  selectedIndex: 0,
  onChanged: (index) {},
);''',
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    _WidgetDemo(
                      preview: DayPartStrip(
                        parts: const [
                          HorizonDayPart(
                            label: 'AM',
                            value: '6 ft',
                            detail: 'Clean',
                            icon: Icons.wb_twilight,
                          ),
                          HorizonDayPart(
                            label: 'Noon',
                            value: '7 ft',
                            detail: 'Peak',
                            icon: Icons.wb_sunny,
                          ),
                          HorizonDayPart(
                            label: 'PM',
                            value: '5 ft',
                            detail: 'Drop',
                            icon: Icons.nights_stay,
                          ),
                        ],
                      ),
                      code: '''
DayPartStrip(
  parts: [
    HorizonDayPart(label: 'AM', value: '6 ft', icon: Icons.wb_twilight),
    HorizonDayPart(label: 'Noon', value: '7 ft', icon: Icons.wb_sunny),
    HorizonDayPart(label: 'PM', value: '5 ft', icon: Icons.nights_stay),
  ],
);''',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Typography',
                child: _WidgetDemo(
                  preview: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Display', style: tokens.typography.display),
                      Text('Headline', style: tokens.typography.headline),
                      Text('Title', style: tokens.typography.title),
                      Text(
                        'Body — readable copy for forecasts.',
                        style: tokens.typography.body,
                      ),
                      Text('LABEL', style: tokens.typography.label),
                      Text('8.4  14  92', style: tokens.typography.numeric),
                    ],
                  ),
                  code: '''
Text('Display', style: context.horizon.typography.display);
Text('Headline', style: context.horizon.typography.headline);
Text('Title', style: context.horizon.typography.title);
Text('Body', style: context.horizon.typography.body);
Text('LABEL', style: context.horizon.typography.label);
Text('8.4', style: context.horizon.typography.numeric);''',
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: tokens.spacing.x16)),
          ],
        ),
      ),
    );
  }
}

/// Preview + expandable copyable code sample.
class _WidgetDemo extends StatelessWidget {
  const _WidgetDemo({required this.preview, required this.code});

  final Widget preview;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        preview,
        SizedBox(height: context.horizon.spacing.x2),
        _CodeDropdown(code: code),
      ],
    );
  }
}

class _CodeDropdown extends StatelessWidget {
  const _CodeDropdown({required this.code});

  final String code;

  String get _trimmed => code.trim();

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _trimmed));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: tokens.colors.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(tokens.radius.md),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: tokens.spacing.x3),
          childrenPadding: EdgeInsets.fromLTRB(
            tokens.spacing.x3,
            0,
            tokens.spacing.x3,
            tokens.spacing.x3,
          ),
          title: Text('Code', style: tokens.typography.label),
          subtitle: Text(
            'Tap to expand sample',
            style: tokens.typography.body.copyWith(
              fontSize: 11,
              color: tokens.colors.resolvedOnSurfaceVariant,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _copy(context),
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copy'),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(tokens.spacing.x3),
              decoration: BoxDecoration(
                color: tokens.colors.background.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(tokens.radius.sm),
                border: Border.all(color: tokens.colors.border),
              ),
              child: SelectableText(
                _trimmed,
                style: tokens.typography.body.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final HorizonTokens tokens = context.horizon;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        tokens.spacing.x5,
        tokens.spacing.x4,
        tokens.spacing.x5,
        tokens.spacing.x2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: tokens.typography.headline),
          SizedBox(height: tokens.spacing.x4),
          child,
        ],
      ),
    );
  }
}

class _UnitSelectorDemo extends StatefulWidget {
  const _UnitSelectorDemo();

  @override
  State<_UnitSelectorDemo> createState() => _UnitSelectorDemoState();
}

class _UnitSelectorDemoState extends State<_UnitSelectorDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return UnitSelector(
      options: const ['ft', 'm'],
      selectedIndex: _index,
      onChanged: (int i) => setState(() => _index = i),
    );
  }
}

class _ColorSwatchRow extends StatelessWidget {
  const _ColorSwatchRow({required this.tokens});

  final HorizonTokens tokens;

  @override
  Widget build(BuildContext context) {
    final List<(String, Color)> swatches = [
      ('Primary', tokens.colors.primary),
      ('Secondary', tokens.colors.secondary),
      ('Accent', tokens.colors.accent),
      ('Success', tokens.colors.success),
      ('Warning', tokens.colors.warning),
      ('Danger', tokens.colors.danger),
      ('Glow', tokens.colors.glow),
    ];

    return Wrap(
      spacing: tokens.spacing.x2,
      runSpacing: tokens.spacing.x2,
      children: [
        for (final (String name, Color color) in swatches)
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(tokens.radius.sm),
                  border: Border.all(color: tokens.colors.border),
                ),
              ),
              SizedBox(height: tokens.spacing.x1),
              Text(name, style: tokens.typography.label.copyWith(fontSize: 10)),
            ],
          ),
      ],
    );
  }
}
