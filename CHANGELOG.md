## 0.5.0

### Added

- Material chrome theming for AppBar, NavigationBar, bottom nav, rail, drawer, and menus
- `HorizonAppBar`, `HorizonNavigationBar`, `HorizonPopupMenuButton`
- Flat mono theme: `HorizonThemes.mono()` / `monoDark()`

## 0.4.1

### Changed

- Luxury Coastal and Cyber: deeper liquid-glass blur, optical rim lighting, translucent surfaces
- Calmer, sine-eased refraction sheen (~30% slower)
- Theme surfaces kept opaque for WCAG AA text contrast; glass transparency via elevation only
- Fixed light-theme semantic fills (warning/accent/success/secondary) below 4.5:1

### Added

- `LiquidGlass` / `GlassCard` sheen controls: `enableRefraction`, `sheenStrength`, `sheenSpeed`, `sheenDuration`
- Standalone package README suitable for pub.dev / git consumers
- Contrast regression test for all themes (WCAG AA 4.5:1)

## 0.4.0

### Added

- Calm theme (dark-first) with calm spacing density and human motion curves
- Liquid glass tokens + `LiquidGlass` / upgraded `GlassCard`
- `HorizonBentoGrid`, `HorizonDisclose`, `HorizonTexture`
- Inputs: `HorizonSearchBar`, `HorizonSegmentedControl`, `HorizonSlider`
- Adaptive: `HorizonModule`, `HorizonAdaptiveModuleGrid`, `HorizonInsightStrip`, `HorizonVoiceAffordance`
- Navigation: `HorizonContentScaffold`, `HorizonDock`, journey page transition
- Starter `HorizonIcons` outdoor aliases

## 0.3.0

### Added

- Themes: Alpine, Forest, Aurora, Minimal (light and dark)
- Maps: ForecastMarker, AnimatedHalo, SelectionRing, HeatMapOverlay, WindParticles
- Outdoor: ScoreBadge, StatusPill, TrendChip, MetricTile, UnitSelector, SpotHeader, ConditionChip, DayPartStrip

## 0.2.0

### Added

- Charts: line, area, bar, radar, tide, timeline
- Gauges: circular, linear, compass, swell rose
- Navigation: AppScaffold, ResponsiveScaffold, SplitView, AdaptiveNavigation
- Animations: count-up, pulse, shimmer, radar sweep, wave ripple, floating cards, page transitions, chart draw-in

## 0.1.0

### Added

- Design tokens (color, typography, spacing, radius, elevation, motion)
- Theme engine with Material 3 `ThemeExtension` bridge
- Themes: Classic, Luxury Coastal, Cyber Surf (light and dark)
- Buttons: Filled, Glass, Glow, Icon, FAB
- Cards: Glass, Hero, Metric, Forecast, Alert
- Widgetbook gallery example
- Melos workspace scripts for analyze, test, and format
