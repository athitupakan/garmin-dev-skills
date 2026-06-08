# Core Topics (§9)

Garmin's conceptual guides — the docs developers actually read while building. Converted from the
SDK's `doc/docs/Core_Topics/` (44 articles). Part of the 📄 **portal** bucket; all auto-converted
mirrors (see the `generated:` frontmatter).

**Cached against SDK:** 9.1.0 · batch 2026-05-30

## App Fundamentals
- [manifest-and-permissions.md](manifest-and-permissions.md) — `manifest.xml`, products, permissions
- [application-and-system-modules.md](application-and-system-modules.md) — AppBase, entry points
- [persisting-data.md](persisting-data.md) — Storage vs Properties vs object store
- [backgrounding.md](backgrounding.md) — background services, temporal/event triggers
- [glances.md](glances.md) — glance views
- [properties-and-app-settings.md](properties-and-app-settings.md) — settings exposed via the phone app
- [intents.md](intents.md) — app-to-app intents
- [notifications.md](notifications.md) — notifications
- [build-configuration.md](build-configuration.md) — build flags, excludes, typecheck levels
- [security.md](security.md) — app security model

## User Interface
- [user-interface.md](user-interface.md) — View/Delegate, WatchUi basics
- [layouts.md](layouts.md) — XML layouts
- [graphics.md](graphics.md) — drawing model (API detail in [reference/api/graphics-dc.md](../../reference/api/graphics-dc.md))
- [input-handling.md](input-handling.md) — buttons, touch, gestures
- [native-controls.md](native-controls.md) — pickers, menus, number pickers
- [resources.md](resources.md) — strings, fonts, bitmaps, drawables
- [monkey-style.md](monkey-style.md) — UI personality / styling
- [getting-the-users-attention.md](getting-the-users-attention.md) — tones, vibrate, backlight
- [editing-watch-faces-on-device.md](editing-watch-faces-on-device.md) — on-device watch-face settings

## Network & Communication
- [https.md](https.md) — `makeWebRequest`, JSON/HTTP
- [authenticated-web-services.md](authenticated-web-services.md) — OAuth
- [communicating-with-mobile-apps.md](communicating-with-mobile-apps.md) — phone app messaging
- [downloading-content.md](downloading-content.md) — content sync
- [mobile-sdk-for-android.md](mobile-sdk-for-android.md) — Android companion SDK
- [mobile-sdk-for-ios.md](mobile-sdk-for-ios.md) — iOS companion SDK

## Sensors & Hardware
- [ant-and-ant-plus.md](ant-and-ant-plus.md) — ANT / ANT+ sensors
- [bluetooth-low-energy.md](bluetooth-low-energy.md) — BLE
- [pairing-wireless-devices.md](pairing-wireless-devices.md) — pairing flow
- [sensors.md](sensors.md) — onboard sensors (catalog in [catalogs/sensors.md](../../../catalogs/sensors.md))
- [positioning.md](positioning.md) — GPS / location (API in [reference/api/position.md](../../reference/api/position.md))

## Activities & Health
- [activity-recording.md](activity-recording.md) — recording FIT sessions
- [activity-control.md](activity-control.md) — start/stop/lap control
- [activity-prompts.md](activity-prompts.md) — activity prompts
- [quantifying-the-user.md](quantifying-the-user.md) — all-day health metrics
- [complications.md](complications.md) — watch-face complications (API in [reference/api/complications.md](../../reference/api/complications.md))

## Development Tools
- [shareable-libraries.md](shareable-libraries.md) — monkey barrels
- [debugging.md](debugging.md) — debugger, logging
- [unit-testing.md](unit-testing.md) — `(:test)` unit tests
- [exception-reporting-tool.md](exception-reporting-tool.md) — CIQ exception reports
- [profiling.md](profiling.md) — memory/performance profiling

## Publishing
- [publishing-to-the-store.md](publishing-to-the-store.md) — store submission (see also [submit-an-app.md](../submit-an-app.md))
- [beta-apps.md](beta-apps.md) — beta channel
- [trial-apps.md](trial-apps.md) — trial / freemium
- [requesting-reviews.md](requesting-reviews.md) — prompting for reviews

**Refresh:** `node ../../_refresh/convert.js` · **Portal index:** [../index.md](../index.md) · **Full sitemap:** [../../index.md](../../index.md)
