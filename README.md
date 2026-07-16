# Horizon UI

Open-source Flutter design system for data-rich outdoor applications
(surf, snow, weather, hiking, marine, hunting, aviation, fishing).

**Beautiful by default · Themeable · Accessible · Animation-first · Material 3**

## Install

```yaml
dependencies:
  horizon_ui:
    git:
      url: https://github.com/jasonflaherty/horizon_ui.git
      ref: v0.4.1
      path: packages/horizon_ui
```

For local monorepo work, use a path dependency on `packages/horizon_ui`.

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:horizon_ui/horizon_ui.dart';

MaterialApp(
  theme: HorizonThemes.cyber(),
  darkTheme: HorizonThemes.cyberDark(),
  home: Scaffold(
    body: ForecastCard(
      title: 'Crescent City',
      score: 92,
      waveHeight: 8.4,
      swellPeriod: 14,
    ),
  ),
);
```

## Themes

| Theme | API |
|-------|-----|
| Classic Material | `HorizonThemes.classic()` / `classicDark()` |
| Luxury Coastal | `HorizonThemes.luxuryCoastal()` / `luxuryCoastalDark()` |
| Cyber Surf | `HorizonThemes.cyber()` / `cyberDark()` |
| Alpine | `HorizonThemes.alpine()` / `alpineDark()` |
| Forest | `HorizonThemes.forest()` / `forestDark()` |
| Aurora | `HorizonThemes.aurora()` / `auroraLight()` |
| Minimal | `HorizonThemes.minimal()` / `minimalDark()` |
| Mono | `HorizonThemes.mono()` / `monoDark()` |
| Calm | `HorizonThemes.calm()` / `calmLight()` |

## Components

### Phase 1
- **Buttons:** Filled, Glass, Glow, Icon, FAB
- **Cards:** Glass, Hero, Metric, Forecast, Alert

### Phase 2
- **Charts:** Line, Area, Bar, Radar, Tide, Timeline
- **Gauges:** Circular, Linear, Compass, SwellRose
- **Navigation:** AppScaffold, ResponsiveScaffold, SplitView, AdaptiveNavigation
- **Motion:** AnimatedNumber, Pulse, Shimmer, RadarSweep, WaveRipple, FloatingCard, page transitions

### Phase 3
- **Maps:** ForecastMarker, AnimatedHalo, SelectionRing, HeatMapOverlay, WindParticles
- **Outdoor:** ScoreBadge, StatusPill, TrendChip, MetricTile, UnitSelector, SpotHeader, ConditionChip, DayPartStrip

### Horizon Next (0.4)
- **Surfaces:** LiquidGlass, HorizonTexture
- **Layout:** BentoGrid, Disclose
- **Inputs:** SearchBar, SegmentedControl, Slider
- **Adaptive:** AdaptiveModuleGrid, InsightStrip, VoiceAffordance
- **Nav motion:** ContentScaffold, Dock, journey transition
- **Chrome (0.5):** AppBar / NavigationBar / menu themes; HorizonAppBar, HorizonNavigationBar, PopupMenuButton
- **Icons:** HorizonIcons starter set

## Examples

**Showcase app** — theme switcher (Calm default) with Phases 1–3 + Horizon Next and copyable code:

```bash
melos bootstrap
cd examples/showcase
flutter run -d android   # phone or emulator
flutter run -d ios       # Simulator or device
```

**Widgetbook gallery** — component catalog with addons:

```bash
cd examples/gallery && flutter run -d chrome
```

## Roadmap

1. ~~Tokens, themes, typography, buttons, cards~~
2. ~~Charts, gauges, navigation, animations~~
3. ~~Maps and outdoor-specific widgets~~
4. Docs site and community themes (lite notes in showcase; full site TBD)
5. ~~Horizon Next: liquid glass, calm UI, adaptive modules, inputs~~

## License

MIT
