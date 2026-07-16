# horizon_ui

Flutter design system for data-rich outdoor apps — surf, snow, weather,
hiking, marine, hunting, aviation, and fishing.

**Beautiful by default · Themeable · Accessible · Animation-first · Material 3**

## Install

Git (tagged release):

```yaml
dependencies:
  horizon_ui:
    git:
      url: https://github.com/jasonflaherty/horizon_ui.git
      ref: v0.4.1
      path: packages/horizon_ui
```

Or pin `ref: main` for the latest tip. Path dependency works for local monorepo
development.

Requires Flutter **≥ 3.32** and Dart **≥ 3.10**.

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:horizon_ui/horizon_ui.dart';

MaterialApp(
  theme: HorizonThemes.luxuryCoastalDark(),
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
| Classic | `HorizonThemes.classic()` / `classicDark()` |
| Luxury Coastal | `HorizonThemes.luxuryCoastal()` / `luxuryCoastalDark()` |
| Cyber | `HorizonThemes.cyber()` / `cyberDark()` |
| Alpine | `HorizonThemes.alpine()` / `alpineDark()` |
| Forest | `HorizonThemes.forest()` / `forestDark()` |
| Aurora | `HorizonThemes.aurora()` / `auroraLight()` |
| Minimal | `HorizonThemes.minimal()` / `minimalDark()` |
| Calm | `HorizonThemes.calm()` / `calmLight()` |

Luxury Coastal and Cyber use deep liquid-glass elevation (blur, optical rim,
translucent surfaces).

## Liquid glass

```dart
// Static glass — no animated sheen
LiquidGlass(enableRefraction: false, child: ...)

// Tune sheen (speed 1 = default; 0.5 = half as fast)
LiquidGlass(
  sheenStrength: 0.12,
  sheenSpeed: 0.7,
  child: ...,
)

// Same knobs on GlassCard
GlassCard(enableRefraction: false, child: ...)
```

Sheen also respects system reduced-motion (`HorizonMotion.shouldAnimate`).

## Components (highlights)

- **Buttons / cards:** Filled, Glass, Glow, FAB; Glass, Hero, Metric, Forecast, Alert
- **Charts / gauges:** Line, Area, Bar, Radar, Tide; Circular, Compass, SwellRose
- **Outdoor:** ScoreBadge, SpotHeader, DayPartStrip, ConditionChip, …
- **Maps overlays:** ForecastMarker, HeatMapOverlay, WindParticles, …
- **Horizon Next:** LiquidGlass, BentoGrid, Disclose, SearchBar, SegmentedControl,
  Slider, AdaptiveModuleGrid, InsightStrip, ContentScaffold, Dock, HorizonIcons

## Examples

From the [repository](https://github.com/jasonflaherty/horizon_ui):

```bash
dart pub get
melos bootstrap
cd examples/showcase && flutter run
cd examples/gallery && flutter run -d chrome
```

## License

MIT — see [LICENSE](LICENSE).
