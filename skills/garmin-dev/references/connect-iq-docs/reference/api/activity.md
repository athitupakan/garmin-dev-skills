---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.Activity

Information about the **currently recording activity session** (not all-day data — see `ActivityMonitor` for that).

## Core function

### `getActivityInfo() → Activity.Info | null`
Returns current activity info, or `null` if no activity is being recorded.

```monkey-c
var info = Activity.getActivityInfo();
if (info != null) {
    var hr = info.currentHeartRate;   // may still be null
    var dist = info.distance;
}
```

API 1.0.0+.

⚠️ **Returns `null` on a watch face when no activity is active.** Most of the time on a watch face this will be null. For all-day HR, use `ActivityMonitor.getHeartRateHistory` (real-time samples) or `SensorHistory.getHeartRateHistory` (history).

## Activity.Info — key fields

| Field | Type | Notes |
|-------|------|-------|
| `currentHeartRate` | `Number?` | bpm; `null` if sensor inactive or no contact |
| `averageHeartRate` | `Number?` | Avg over activity |
| `maxHeartRate` | `Number?` | Peak during activity |
| `distance` | `Float?` | Meters, total |
| `elapsedDistance` | `Float?` | Meters, active timer only |
| `calories` | `Number?` | kcal |
| `steps` | `Number?` | Step count for activity |
| `activeMinutes` | `Number?` | Active/moving seconds |
| `elapsedTime` | `Number?` | Milliseconds elapsed |
| `timerState` | `TIMER_STATE` constant | Off / Stopped / Paused / On |
| `sport` | `SPORT_*` constant | Running, Cycling, … (75+) |
| `subSport` | `SUB_SPORT_*` constant | Treadmill, Trail, … |
| `swimStrokeType` | `SWIM_STROKE_*` constant | Freestyle, IM, … |

Every field can be `null`. **Always null-check before use.**

## Constants

### Timer state
- `TIMER_STATE_OFF` (0)
- `TIMER_STATE_STOPPED` (1)
- `TIMER_STATE_PAUSED` (2) — Auto-Pause engaged
- `TIMER_STATE_ON` (3) — Recording

### Sports / SubSports
~75 sports; subsports for greater specificity (treadmill, road, trail, indoor cycling, etc.). Refer to docs when needed.

### Workout
- `WorkoutIntensity` — Active/Rest/Warmup/Cooldown/Recovery/Interval
- `WorkoutStepDurationType` — Time/Distance/HR/Power/Calories/Open
- `WorkoutStepTargetType` — Speed/HR/Cadence/Power/Grade/Resistance/Stroke

## Workout functions (App only — NOT for Data Fields)

- `getCurrentWorkoutStep() → WorkoutStepInfo | null`
- `getNextWorkoutStep() → WorkoutStepInfo | null`

Throws `Lang.OperationNotAllowedException` from Data Field context.

## Profile

### `getProfileInfo() → Activity.ProfileInfo`
User profile (weight, HR zones, etc.). Always returns object — never null. API 3.2.0+.

## Watch face usage gotchas

1. **`getActivityInfo()` is null most of the time** on a watch face — only useful if user starts an activity. For passive daily HR display, use `SensorHistory`/`ActivityMonitor`.
2. **Sensor-dependent fields null without contact** — HR returns null if watch isn't worn or sensor is off.
3. **Standalone app context required** — `getActivityInfo` doesn't work in Data Field context (use `compute()` instead).
