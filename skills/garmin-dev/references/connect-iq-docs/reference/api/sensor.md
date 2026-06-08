---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Sensor.html
fetched: 2026-05-24
sdk: 9.1.0
---

# Toybox.Sensor

Real-time sensor events (HR, accel, temp, …). **Different from `SensorHistory`** — `SensorHistory` returns past samples on demand; `Sensor` pushes live updates via a callback.

API Level 1.0.0+. **Requires `<iq:uses-permission id="Sensor"/>` in manifest.xml.**

## When NOT to use on a watch face

A watch face's `onUpdate()` is called once a minute (or every second during partial updates). For HR display, **`SensorHistory.getHeartRateHistory`** or **`ActivityMonitor.getHeartRateHistory`** are usually enough — pull on demand.

Use `Sensor` only when you need:
- Sub-second freshness (a moving HR sparkline that animates between minute ticks)
- Multi-sensor sync (paired ANT+ peripherals, BLE pulse oximeter, etc.)

## Core functions

### `setEnabledSensors(sensors as Array<SensorType>) → Array<SensorType>`
Turn on the sensors you want events from. Pass empty array to disable all. Returns the array of sensors that were actually enabled (subset of what you requested).

### `enableSensorEvents(listener as Method(info as Sensor.Info) → Void)`
Register a callback. The runtime calls `listener(info)` every ~1 second with the current `Sensor.Info`.

```monkey-c
function initialize() {
    Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    Sensor.enableSensorEvents(method(:onSensor));
}

function onSensor(info as Sensor.Info) as Void {
    var hr = info.heartRate;   // Number? — null if no reading
    // ... update view state ...
}
```

Call `enableSensorEvents(null)` to stop.

### `getInfo() → Sensor.Info`
Single-shot snapshot (alternative to the listener pattern).

### `enableSensorType(t) → Boolean` / `disableSensorType(t) → Boolean`
Toggle one sensor at a time without rebuilding the enabled set.

### `getRegisteredSensors(type as SensorType?) → SensorInfoIterator`
List paired sensors. `null` = all types.

## Sensor.Info — key fields

| Field | Type | Notes |
|-------|------|-------|
| `heartRate` | `Number?` | bpm |
| `cadence` | `Number?` | rpm/spm |
| `power` | `Number?` | watts |
| `speed` | `Float?` | m/s |
| `temperature` | `Float?` | °C |
| `altitude` | `Float?` | m |
| `pressure` | `Float?` | Pa (millibars × 100) |
| `heading` | `Float?` | rad |
| `accel` | `[x, y, z]` | mg |

## Constants — RemoteSensorType (ANT+/BLE)

| Name | Value | API |
|------|-------|-----|
| `SENSOR_BIKESPEED` | 0 | 1.0.0 |
| `SENSOR_BIKECADENCE` | 1 | 1.0.0 |
| `SENSOR_BIKEPOWER` | 2 | 1.0.0 |
| `SENSOR_FOOTPOD` | 3 | 1.0.0 |
| `SENSOR_HEARTRATE` | 4 | 1.0.0 |
| `SENSOR_TEMPERATURE` | 5 | 1.0.0 |
| `SENSOR_GENERIC` | 9 | 5.1.0 |

## Constants — OnboardSensorType

| Name | Value | API |
|------|-------|-----|
| `SENSOR_PULSE_OXIMETRY` | 6 | 3.2.0 |
| `SENSOR_ONBOARD_PULSE_OXIMETRY` | 7 | 3.2.0 |
| `SENSOR_ONBOARD_HEARTRATE` | 8 | 3.2.0 |

## Constants — SensorTechnology

| Name | Value | Meaning |
|------|-------|---------|
| `SENSOR_TECHNOLOGY_ANT` | 0 | ANT+ peripheral |
| `SENSOR_TECHNOLOGY_BLE` | 1 | Bluetooth LE |
| `SENSOR_TECHNOLOGY_ONBOARD` | 2 | Built into the watch |

## Gotchas

1. **Watch face cost** — every sensor running is battery drain. Disable in `onHide()`/`onEnterSleep()` and re-enable in `onShow()`/`onExitSleep()`.
2. **`enableSensorEvents` callback runs in UI context** — keep work short; don't block.
3. **Onboard HR is its own type** — `SENSOR_ONBOARD_HEARTRATE` (8), not the same as the remote `SENSOR_HEARTRATE` (4). For watch face HR you almost always want the onboard one OR just use `SensorHistory`.
4. **High-frequency capture (accel/gyro at sample rate)** uses `registerSensorDataListener` instead — different API, returns batched `SensorData` chunks.
