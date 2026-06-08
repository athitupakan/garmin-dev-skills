# Toybox API Reference Cache

Local cache of Garmin Connect IQ Toybox API docs we've actually used or expect to use soon.

**Source:** SDK install `doc/Toybox/<Module>.html` (canonical web mirror: <https://developer.garmin.com/connect-iq/api-docs/>)
**Cached against SDK:** 9.1.0
**Last refresh:** curated 2026-05-24 · mirror batch 2026-05-30

**Bucket index:** [../index.md](../index.md) (sdk/api) · **Full portal sitemap:** [../../index.md](../../index.md)

Two kinds of file here — **read the frontmatter** to tell them apart:
- **Hand-curated** (no `generated:` line) — condensed, annotated with project-observed gotchas that contradict the official docs. Trust these for behavior.
- **Auto-converted mirror** (`generated:` line present) — faithful full conversion of the SDK HTML via `htmlmd.js`. Complete, but no project gotchas layered in yet.

## Hand-curated modules

| File | Module | Why cached |
|------|--------|------------|
| [graphics-dc.md](graphics-dc.md) | `Toybox.Graphics.Dc` | All drawing — setColor, drawText, drawArc, drawRectangle, ... |
| [time-gregorian.md](time-gregorian.md) | `Toybox.Time.Gregorian` | Date/time formatting in HEADER + TIME |
| [activity.md](activity.md) | `Toybox.Activity` | Currently-recording session info (rarely non-null on watch face) |
| [activity-monitor.md](activity-monitor.md) | `Toybox.ActivityMonitor` | All-day totals (steps, calories, HR history) — used by Arc.mc, HR.mc |
| [sensor-history.md](sensor-history.md) | `Toybox.SensorHistory` | Body Battery, Stress, HRV — used by Arc.mc, HR.mc |
| [sensor.md](sensor.md) | `Toybox.Sensor` | Real-time sensor events (alt to SensorHistory for live HR) |
| [user-profile.md](user-profile.md) | `Toybox.UserProfile` | Age, HR zones, weight — used by Crown.mc |
| [application-properties.md](application-properties.md) | `Toybox.Application.Properties` | Settings exposed via companion app (future) |
| [system.md](system.md) | `Toybox.System` | Clock, battery %, device settings |
| [watch-face.md](watch-face.md) | `Toybox.WatchUi.WatchFace` | Lifecycle methods + AOD power mode |

## Auto-converted mirror modules

Full faithful conversions added in the 2026-05-30 batch. Includes nested classes (e.g. `Weather.CurrentConditions` fields, `Timer.Timer` methods, `Position.Location`/`Info`).

| File | Module | Covers |
|------|--------|--------|
| [weather.md](weather.md) | `Toybox.Weather` (+ CurrentConditions, Hourly/DailyForecast) | Current conditions + forecast fields, units, since-levels |
| [position.md](position.md) | `Toybox.Position` (+ Location, Info) | GPS lock state, lat/lng formats, accuracy |
| [application-storage.md](application-storage.md) | `Toybox.Application.Storage` | Free-form key/value app state (cousin of Properties) |
| [watchui.md](watchui.md) | `Toybox.WatchUi` | Views, layouts, input delegates, drawables, menus |
| [lang.md](lang.md) | `Toybox.Lang` | Core types, Object, exceptions, method() |
| [math.md](math.md) | `Toybox.Math` | Trig, rounding, constants, PRNG |
| [attention.md](attention.md) | `Toybox.Attention` | Tones, vibrate, backlight |
| [complications.md](complications.md) | `Toybox.Complications` | Watch-face complication publish/subscribe |
| [fit-contributor.md](fit-contributor.md) | `Toybox.FitContributor` | Write custom fields into recorded FIT files |
| [communications.md](communications.md) | `Toybox.Communications` | makeWebRequest, JSON/HTTP, phone messaging |
| [timer.md](timer.md) | `Toybox.Timer` (+ Timer class) | One-shot / repeating callbacks |
| [time.md](time.md) | `Toybox.Time` | Moment, Duration, now() (Gregorian formatting is in time-gregorian.md) |

## Not yet cached — convert when needed

Every other `Toybox.*` module ships in the SDK at `doc/Toybox/<Module>.html`. Notable ones not yet pulled: `Graphics` (module root; `Dc` is cached), `Media`, `BluetoothLowEnergy`, `Ant`/`AntPlus`, `Background`, `Cryptography`, `Authentication`, `Notifications`, `StringUtil`, `PersistedContent`. Run the converter (below) on any of them.

## How to refresh

These pages are generated from the **SDK install**, not the website — the online API docs are JS-rendered and unreadable via WebFetch. Source HTML:

```
%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-<build>\doc\Toybox\<Module>.html
```

Use the bundled converter — see [../../_refresh/README.md](../../_refresh/README.md). Run from the `connect-iq-docs/` folder:

```
node _refresh/htmlmd.js <path-to-Module.html>     # prints markdown to stdout
node _refresh/convert.js                            # batch-regenerates the mirror set
```

For **hand-curated** files, don't overwrite blindly — re-read the new SDK HTML and fold real changes in by hand so the project gotchas survive. The `source:` URL in each file's frontmatter is the canonical web reference.

## Known doc errors / observed behavior

- **Gregorian.Info `month` / `day_of_week`** — doc says they are always `String`, but in SDK 9.1.0 with `Time.FORMAT_SHORT` they return `Number` (1-based). With `FORMAT_MEDIUM` they return `String`. See `time-gregorian.md` for our working pattern.
- **`Dc.drawArc` degree params** — typed `Number` (Integer). Passing `Float` silently truncates — destroys sub-degree precision in segmented rings. Always use integer math.
