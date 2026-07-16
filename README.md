# Horizon UI

Open-source Flutter design system for data-rich outdoor applications
(surf, snow, weather, hiking, marine, hunting, aviation, fishing).

**Beautiful by default · Themeable · Accessible · Animation-first · Material 3**

## Install

```yaml
dependencies:
  horizon_ui:
    path: packages/horizon_ui   # or pub.dev version when published
```

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

## Themes (Phase 1)

| Theme | API |
|-------|-----|
| Classic Material | `HorizonThemes.classic()` / `classicDark()` |
| Luxury Coastal | `HorizonThemes.luxuryCoastal()` / `luxuryCoastalDark()` |
| Cyber Surf | `HorizonThemes.cyber()` / `cyberDark()` |

Alpine, Forest, Aurora, and Minimal are reserved for later phases.

## Components

### Phase 1
- **Buttons:** Filled, Glass, Glow, Icon, FAB
- **Cards:** Glass, Hero, Metric, Forecast, Alert

### Phase 2
- **Charts:** Line, Area, Bar, Radar, Tide, Timeline
- **Gauges:** Circular, Linear, Compass, SwellRose
- **Navigation:** AppScaffold, ResponsiveScaffold, SplitView, AdaptiveNavigation
- **Motion:** AnimatedNumber, Pulse, Shimmer, RadarSweep, WaveRipple, FloatingCard, page transitions

## Examples

**Showcase app** — simple app with theme switcher and every Phase 1 component:

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
3. Maps and outdoor-specific widgets
4. Docs site and community themes

## License

MIT
