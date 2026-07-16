# Horizon UI Showcase

Simple example app that cycles through every Phase 1 theme and component.

```bash
cd examples/showcase
flutter pub get
```

## Android

```bash
flutter devices                  # confirm your phone/emulator
flutter run -d android
# or pick a device id, e.g.:
# flutter run -d 56111FDCH007XK
```

## iOS

```bash
# Simulator
open -a Simulator
flutter run -d ios

# Physical iPhone (USB, Developer Mode on, trust computer)
flutter run -d <device-id>
```

## Other

```bash
flutter run -d chrome
flutter run -d macos
```

Use the theme chips and dark-mode switch to compare Classic, Luxury Coastal,
and Cyber Surf.
