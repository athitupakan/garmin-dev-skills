---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/SensorHistory.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.SensorHistory

Historical sensor samples for passive metrics. **Most relevant API for watch face data** (no active activity required).

API 2.1.0+. Requires `SensorHistory` permission in `manifest.xml`.

## Getter functions

All return `SensorHistoryIterator`. All accept an optional options dict (`{}` is fine).

| Function | Returns | Units | Notes |
|----------|---------|-------|-------|
| `getHeartRateHistory(options)` | iterator | bpm | History up to last power cycle |
| `getBodyBatteryHistory(options)` | iterator | 0–100 | API 3.3.0+; 0=drained, 100=rested. **ENERGY** in our project. |
| `getStressHistory(options)` | iterator | 0–100 | API 3.3.0+; higher = more stress. **LOAD** in our project. |
| `getOxygenSaturationHistory(options)` | iterator | % | API 3.2.0+ |
| `getElevationHistory(options)` | iterator | meters | From barometric sensor |
| `getPressureHistory(options)` | iterator | Pascals | Barometric |
| `getTemperatureHistory(options)` | iterator | °C | |

## Options dictionary

```monkey-c
{
    :period => null | Number | Time.Duration,
    :order  => null | SensorHistory.ORDER_NEWEST_FIRST | SensorHistory.ORDER_OLDEST_FIRST
}
```

- `:period`
  - `null` → entire available history
  - `Number` → last N samples
  - `Time.Duration` → samples from past duration
- `:order` (default `ORDER_NEWEST_FIRST`)
  - `ORDER_NEWEST_FIRST` (0) — most recent first
  - `ORDER_OLDEST_FIRST` (1)

## SensorHistoryIterator

| Method | Returns |
|--------|---------|
| `next() → SensorSample \| null` | Next sample, or `null` when exhausted |
| `getMin() → Number` | Min across all samples |
| `getMax() → Number` | Max across all samples |
| `getAverage() → Number` | Mean across all samples |

## SensorSample

| Field | Type | Meaning |
|-------|------|---------|
| `when` | `Time.Moment` | Timestamp |
| `data` | `Number` | Value in the metric's units |

## Watch face pattern — get latest value

```monkey-c
function getCurrentBodyBattery() as Number? {
    var iter = SensorHistory.getBodyBatteryHistory({ :period => 1 });
    if (iter == null) { return null; }     // sensor not supported
    var sample = iter.next();
    if (sample == null) { return null; }   // no data yet
    return sample.data;
}
```

## Watch face pattern — small graph (last N samples)

```monkey-c
var samples = [];
var iter = SensorHistory.getHeartRateHistory({ :period => 20, :order => SensorHistory.ORDER_OLDEST_FIRST });
if (iter != null) {
    var s = iter.next();
    while (s != null) {
        samples.add(s.data);
        s = iter.next();
    }
}
// `samples` is now last 20 HR readings, oldest first
```

## Gotchas

1. **Device support varies** — not every getter is implemented on every watch. To confirm before relying on a sensor, grep your device's `.api.debug.xml` (under `<sdk-root>/Devices/<device-id>/`) for the symbol, or fall back to a runtime null check on the iterator.
2. **Iterator may be `null`** — if the device doesn't support the sensor at all, the getter returns null.
3. **History limited to last power cycle** for most sensors (exceptions: body battery, stress, O₂ saturation persist).
4. **Sample interval is device-dependent** — don't assume a fixed period (e.g., 1 sample / minute).
5. **Requires permission** — add `<iq:permission id="SensorHistory"/>` to `manifest.xml` inside `<iq:permissions>`.
