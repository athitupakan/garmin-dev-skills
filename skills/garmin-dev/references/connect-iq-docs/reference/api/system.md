---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/System.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.System

Clock, device settings, battery, memory, logging.

## Time

### `getClockTime() → System.ClockTime`
Current local clock time. Fields: `hour` (0–23), `min` (0–59), `sec` (0–59), `timeZoneOffset` (seconds from UTC), `dst` (Boolean).

```monkey-c
var ct = System.getClockTime();
// ct.hour, ct.min, ct.sec
```

For full date use `Gregorian.info(Time.now(), Time.FORMAT_SHORT)` instead — `ClockTime` has no date fields.

### `getTimer() → Number`
Milliseconds since device boot. Rolls over ~every 50 days.

## Device

### `getDeviceSettings() → System.DeviceSettings`

| Field | Type | Meaning |
|-------|------|---------|
| `screenWidth` | Number | Pixels |
| `screenHeight` | Number | Pixels |
| `screenShape` | constant | `SCREEN_SHAPE_ROUND`, `SCREEN_SHAPE_SEMI_ROUND`, `SCREEN_SHAPE_RECTANGLE`, `SCREEN_SHAPE_SEMI_OCTAGON` |
| `is24Hour` | Boolean | User's clock format preference |
| `systemLanguage` | constant | Current language |
| `phoneOperatingSystem` | constant | Connected phone OS |
| `notificationCount` | Number? | Pending phone notifications |
| `alarmCount` | Number? | Active alarms |
| `connectionInfo` | Dict? | Connection state per type |

## Stats

### `getSystemStats() → System.Stats`

| Field | Type | Meaning |
|-------|------|---------|
| `battery` | Float | Battery % (0.0–100.0) |
| `batteryInDays` | Float? | Estimated days remaining |
| `usedMemory` | Number | Bytes |
| `freeMemory` | Number | Bytes |
| `totalMemory` | Number | Bytes |
| `solarIntensity` | Number? | 0–100 if device has solar |
| `charging` | Boolean? | Currently charging |

## Display mode

### `getDisplayMode() → Number`
Current AMOLED/LCD display mode:
- `DISPLAY_MODE_HIGH_POWER` — full brightness, full-frequency updates
- `DISPLAY_MODE_LOW_POWER` — AOD-style dimmed
- `DISPLAY_MODE_OFF` — screen off

## Logging

| Method | Notes |
|--------|-------|
| `println(s)` | Log to console with newline. Visible via `monkeydo` stream. |
| `print(s)` | Log without newline. |

**Watch face caveat:** `println` inside `onPartialUpdate` works in **simulator only**, not on real device.

## Common watch face usage

```monkey-c
// Battery for CORE display
var stats = System.getSystemStats();
var batteryPct = stats.battery;                    // 82.0
var daysLeft = stats.batteryInDays;                // 5.3

// 24h preference
var is24h = System.getDeviceSettings().is24Hour;

// Screen shape — use at runtime when the same code targets multiple devices.
// Pin a constant per-device in your project's Layout module if you only target one.
var isRound = (System.getDeviceSettings().screenShape == System.SCREEN_SHAPE_ROUND);
```
