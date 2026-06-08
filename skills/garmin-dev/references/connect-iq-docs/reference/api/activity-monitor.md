---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/ActivityMonitor.html
fetched: 2026-05-24
sdk: 9.1.0
---

# Toybox.ActivityMonitor

All-day activity totals (steps, calories, floors, active minutes, stress, …) plus a heart-rate sample iterator. **Different from `Toybox.Activity`** which is the currently-recording session and is usually `null` on a watch face.

API Level 1.0.0+. No permission required.

## Core functions

### `getInfo() → ActivityMonitor.Info`
Returns a snapshot of today's activity totals. **The object is never `null` itself, but every field on it may be `null` — always null-check fields before use.** Data resets at device-local midnight unless noted.

```monkey-c
var info = ActivityMonitor.getInfo();
var s = info.steps;
var g = info.stepGoal;
if (s != null && g != null && g > 0) { ... }
```

### `getHeartRateHistory(period, newestFirst) → ActivityMonitor.HeartRateIterator`
Heart-rate samples since the last power cycle.

| Param | Type | Meaning |
|-------|------|---------|
| `period` | `Time.Duration` \| `Number` \| `Null` | `null` = all history. `Duration` = samples within that window. `Number` = the last N samples. |
| `newestFirst` | `Boolean` | `true` = newest first; `false` = oldest first. |

API 1.2.1+.

### `getHistory() → Array<ActivityMonitor.History>`
Up to 7 day-summary objects (most recent first). Rarely used in watch faces.

## ActivityMonitor.Info — key fields

Every field is nullable. Snapshot is current day from midnight unless noted.

| Field | Type | Notes |
|-------|------|-------|
| `steps` | `Number?` | Step count today |
| `stepGoal` | `Number?` | Today's step goal |
| `calories` | `Number?` | kcal burned today |
| `distance` | `Number?` | Distance in **centimeters** (not meters) |
| `floorsClimbed` | `Number?` | Floors today (API 2.1.0+) |
| `floorsClimbedGoal` | `Number?` | Floor goal |
| `floorsDescended` | `Number?` | |
| `metersClimbed` | `Float?` | Vertical distance climbed (m) |
| `metersDescended` | `Float?` | |
| `activeMinutesDay` | `ActiveMinutes?` | Today's active minutes (object — see below) |
| `activeMinutesWeek` | `ActiveMinutes?` | Week-to-date |
| `activeMinutesWeekGoal` | `Number?` | Week goal |
| `moveBarLevel` | `Number?` | 0 (`MOVE_BAR_LEVEL_MIN`) – 5 (`MOVE_BAR_LEVEL_MAX`) |
| `respirationRate` | `Number?` | Breaths per minute |
| `stressScore` | `Number?` | 30-second rolling stress (0–100) |
| `timeToRecovery` | `Number?` | Hours until recovered from last activity |
| `pushes` / `pushGoal` / `pushDistance` | `Number?` | Wheelchair mode only |

### ActivityMonitor.ActiveMinutes

```
var am = info.activeMinutesDay;
am.moderate   as Number  // moderate intensity minutes
am.vigorous   as Number  // vigorous intensity minutes (count double in `total`)
am.total      as Number  // = moderate + 2 * vigorous
```

## ActivityMonitor.HeartRateIterator

Standard iterator: `.next() → HeartRateSample?` returns `null` at end.

```monkey-c
var iter = ActivityMonitor.getHeartRateHistory(30, false);  // last 30 samples, oldest first
var s = iter.next();
while (s != null) {
    if (s.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
        // use s.heartRate (Number, bpm)
    }
    s = iter.next();
}
```

Also exposes:
- `getMin() → HeartRateSample?` — min in the iterator window
- `getMax() → HeartRateSample?` — max in the iterator window

### HeartRateSample

| Field | Type | Notes |
|-------|------|-------|
| `heartRate` | `Number` | bpm; compare against `ActivityMonitor.INVALID_HR_SAMPLE` (255) before using |
| `when` | `Time.Moment` | Sample timestamp |

## Constants

| Const | Value | Use |
|-------|-------|-----|
| `INVALID_HR_SAMPLE` | 255 | Sentinel for HR readings that failed |
| `MOVE_BAR_LEVEL_MIN` | 0 | |
| `MOVE_BAR_LEVEL_MAX` | 5 | |

## Watch-face patterns

### Steps progress (current vs goal)
```monkey-c
function stepsProgress() as Float? {
    var info = ActivityMonitor.getInfo();
    var s = info.steps;
    var g = info.stepGoal;
    if (s == null || g == null || g == 0) { return null; }
    var p = s.toFloat() / g.toFloat();
    return p > 1.0 ? 1.0 : p;
}
```

### Sparkline of recent HR
```monkey-c
function recentHr(n as Number) as Array<Number>? {
    var iter = ActivityMonitor.getHeartRateHistory(n, false);  // oldest first
    var out = new Array<Number>[n];
    var i = 0;
    var s = iter.next();
    while (s != null && i < n) {
        if (s.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
            out[i] = s.heartRate;
            i += 1;
        }
        s = iter.next();
    }
    if (i < 2) { return null; }
    if (i == n) { return out; }
    var trimmed = new Array<Number>[i];
    for (var k = 0; k < i; k += 1) { trimmed[k] = out[k]; }
    return trimmed;
}
```

## Gotchas

1. **`distance` is centimeters** — divide by 100 for metres, by 100000 for km.
2. **`getInfo()` itself is not null** but every field is. Per the official doc: "If the value is not available, an error indicating that the symbol was not found will be thrown" — wrap field reads carefully, especially for newer-API fields (`floorsClimbed` etc.) on older devices.
3. **HR samples can be invalid** — always check against `INVALID_HR_SAMPLE` (255), not against `null`.
4. **History only goes back to last power cycle** — fresh boot = empty iterator.
5. **`isSleepMode` is deprecated** — don't rely on it.
