import 'package:flutter/material.dart';
import 'package:horizon_ui/horizon_ui.dart';

enum ShowcaseThemeId { classic, luxuryCoastal, cyber }

extension ShowcaseThemeIdX on ShowcaseThemeId {
  String get label => switch (this) {
    ShowcaseThemeId.classic => 'Classic',
    ShowcaseThemeId.luxuryCoastal => 'Luxury Coastal',
    ShowcaseThemeId.cyber => 'Cyber Surf',
  };

  ThemeData themeData({required bool dark}) => switch (this) {
    ShowcaseThemeId.classic =>
      dark ? HorizonThemes.classicDark() : HorizonThemes.classic(),
    ShowcaseThemeId.luxuryCoastal =>
      dark ? HorizonThemes.luxuryCoastalDark() : HorizonThemes.luxuryCoastal(),
    ShowcaseThemeId.cyber =>
      dark ? HorizonThemes.cyberDark() : HorizonThemes.cyberLight(),
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
                      'Phases 1–2 — themes, components, charts, gauges, and motion.',
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
                    Wrap(
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
                    SizedBox(height: tokens.spacing.x4),
                    Text('Sizes', style: tokens.typography.label),
                    SizedBox(height: tokens.spacing.x2),
                    Wrap(
                      spacing: tokens.spacing.x2,
                      runSpacing: tokens.spacing.x2,
                      crossAxisAlignment: WrapCrossAlignment.center,
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
              ),
            ),
            const SliverToBoxAdapter(
              child: _Section(
                title: 'Cards',
                child: Column(
                  children: [
                    ForecastCard(
                      title: 'Crescent City',
                      score: 92,
                      waveHeight: 8.4,
                      swellPeriod: 14,
                      trend: '↑',
                    ),
                    SizedBox(height: 16),
                    HeroCard(
                      title: 'North Pacific',
                      subtitle: 'Long-period swell filling in overnight',
                    ),
                    SizedBox(height: 16),
                    Row(
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
                    SizedBox(height: 16),
                    GlassCard(
                      child: Text(
                        'GlassCard — frosted surface for overlays and HUD panels.',
                      ),
                    ),
                    SizedBox(height: 16),
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
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Charts',
                child: Column(
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
                    SizedBox(height: tokens.spacing.x4),
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
                    SizedBox(height: tokens.spacing.x4),
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
                    SizedBox(height: tokens.spacing.x4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GlassCard(
                            child: Center(
                              child: HorizonRadarChart(
                                size: 160,
                                points: const [
                                  HorizonChartPoint(label: 'Size', value: 0.9),
                                  HorizonChartPoint(label: 'Wind', value: 0.7),
                                  HorizonChartPoint(label: 'Tide', value: 0.5),
                                  HorizonChartPoint(
                                    label: 'Period',
                                    value: 0.85,
                                  ),
                                  HorizonChartPoint(label: 'Crowd', value: 0.4),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing.x4),
                    GlassCard(
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
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Gauges',
                child: Column(
                  children: [
                    Row(
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
                    SizedBox(height: tokens.spacing.x3),
                    Row(
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
                    Row(
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
                    SizedBox(height: tokens.spacing.x4),
                    HorizonShimmer(width: double.infinity, height: 14),
                    SizedBox(height: tokens.spacing.x2),
                    HorizonShimmer(width: 180, height: 14),
                    SizedBox(height: tokens.spacing.x4),
                    Row(
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
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _Section(
                title: 'Typography',
                child: Column(
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
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: tokens.spacing.x16)),
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
