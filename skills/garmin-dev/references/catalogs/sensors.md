# Sensor Catalog — Connect IQ Watch Faces

A wearer-priority cut of what a Connect IQ watch face can read, plus what Garmin tracks but **does not** expose to the Watch Face API.

> **Verification scope:** Verified against **Instinct 3 AMOLED 50mm** with SDK 9.1.0. Other devices may expose more or fewer metrics — see [How to verify per device](#how-to-verify-per-device) below.

For full API signatures, units, and field types, see the per-module references in [../connect-iq-docs/reference/api/](../connect-iq-docs/reference/api/). This page is the **wearer-priority overview** + the **walled-garden list** — Garmin docs are organized by Toybox module, not by what a watch face wants to surface.

## Tier 1 — Body & User (physiological + identity)

The most personal data — fitness, recovery, identity.

- **Heart Rate** (live + history) — `SensorHistory.getHeartRateHistory`, `ActivityMonitor.getHeartRateHistory` ([sensor-history](../connect-iq-docs/reference/api/sensor-history.md), [activity-monitor](../connect-iq-docs/reference/api/activity-monitor.md))
- **Body Battery** (0–100) — `SensorHistory.getBodyBatteryHistory`
- **Stress** (0–100) — `SensorHistory.getStressHistory` (history) / `ActivityMonitor.getInfo().stressScore` (rolling 30s)
- **Pulse Ox** (%) — `SensorHistory.getOxygenSaturationHistory`
- **Respiration Rate** (br/min) — `ActivityMonitor.getInfo().respirationRate`
- **Body Temperature** (skin, °C) — `SensorHistory.getTemperatureHistory`
- **Recovery Time** (hours) — `ActivityMonitor.getInfo().timeToRecovery`
- **User profile** — Age (derived from `birthYear`), Gender, Height, Weight, VO2 Max (Running + Cycling), HR Zones, FTP, Power Zones, Step Lengths → `UserProfile.getProfile()`, `UserProfile.getHeartRateZones()` ([user-profile](../connect-iq-docs/reference/api/user-profile.md))

## Tier 2 — Activity (today / this week)

All under `ActivityMonitor.getInfo()` ([activity-monitor](../connect-iq-docs/reference/api/activity-monitor.md)). Resets at device-local midnight unless noted.

- **Steps + Step Goal** — `.steps`, `.stepGoal`
- **Calories** (kcal) — `.calories`
- **Distance** — `.distance` (centimeters — divide by 100 for meters)
- **Floors** — `.floorsClimbed`, `.floorsClimbedGoal`, `.floorsDescended`, `.metersClimbed`, `.metersDescended`
- **Active Minutes** (day + week + goal) — `.activeMinutesDay.total`, `.activeMinutesWeek.total`, `.activeMinutesWeekGoal`
- **Move Bar** (0–5) — `.moveBarLevel`

## Tier 3 — Device & Environment

- **Battery** %, days remaining, charging state, solar (solar models only) → `System.getSystemStats()` ([system](../connect-iq-docs/reference/api/system.md))
- **Notifications**, alarms, BT connection, 24h flag → `System.getDeviceSettings()`
- **Elevation** (m) — `SensorHistory.getElevationHistory`
- **Pressure** (Pa) — `SensorHistory.getPressureHistory`
- **Weather** — `Toybox.Weather` (needs phone sync; separate module, not cached here)

## Currently-recording activity

`Toybox.Activity.getActivityInfo()` returns null on a watch face when no activity is being recorded — usually useless for ambient display. Use `ActivityMonitor` for all-day data. During recording: `.currentHeartRate`, `.currentSpeed`, `.currentCadence`, etc.

## ❌ NOT Available — Garmin "walled garden"

Tracked by firmware + visible in the Garmin Connect app, but **not exposed to the Connect IQ Watch Face API** on the verified device. **Re-check per device** — see below.

| Missing metric | Tier | Verification | Workaround |
|----------------|------|--------------|------------|
| HRV Status / Last Night | Body | Only `LANGUAGE_HRV` symbol (Croatian locale, unrelated) — no sensor symbol | Use **Body Battery** (Garmin computes from HRV + stress + sleep + activity) |
| Training Load / Acute Load | Body | No symbol | Use **Stress** + **Recovery Time** as related signals |
| Training Status | Body | No symbol | — |
| Training Readiness | Body | No symbol | Use **Body Battery** as proxy |
| Sleep Score | Body | Only `Background.getSleepEventRegistered` (event API, no score) | — |
| Sleep Duration | Body | Same — only event registration, no duration | — |

Re-check on SDK upgrades; Garmin may expose these later.

## How to verify per device

List installed devices in your SDK:

```powershell
# Windows
Get-ChildItem "$env:APPDATA\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-*\Devices" |
    ForEach-Object Name
```

```bash
# macOS
ls "$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks/"connectiq-sdk-mac-*/Devices

# Linux
ls "$HOME/.Garmin/ConnectIQ/Sdks/"connectiq-sdk-lin-*/Devices
```

For a given device, the API surface lives in:

```
<sdk-root>/Devices/<device-id>/<device-id>.api.debug.xml
```

Grep for a sensor symbol there to confirm availability (or absence — useful for adding entries to the walled-garden list above).

## Permissions

- **SensorHistory** → `<iq:uses-permission id="SensorHistory"/>` — required for any `SensorHistory.get*History` call.
- **UserProfile** → `<iq:uses-permission id="UserProfile"/>` — required for `UserProfile.getProfile()` and `getHeartRateZones`.
- Battery / notifications / BT / device settings / `ActivityMonitor`: no permission needed.

Add the required permissions to **your** `manifest.xml` if you call any of the gated APIs.

## Gotchas (project-observed)

1. **Distance is centimeters** — `.distance / 100` for meters.
2. **Weight is grams** — `.weight / 1000` for kg.
3. **Every `ActivityMonitor.Info` field can be null** — always guard.
4. **`birthYear` can be 0** — treat as "not set".
5. **`SensorHistory.get<X>History()` returns an iterator (not null) on supported devices** — but `iterator.next()` returns null when no samples yet.
6. **`HeartRateSample.heartRate` uses 255 (`INVALID_HR_SAMPLE`) as sentinel**, not null.
7. **Background sleep API** detects when sleep starts / ends but does NOT give sleep score or duration.

## Appendix: example label mapping (vital-core)

> Reference only. vital-core uses an "RPG-themed" label scheme — your project will have its own. Centralize it in a single source-of-truth module (e.g. `source/Metric.mc`) rather than scattering across views.

| Garmin name | vital-core label |
|---|---|
| Heart Rate | HR |
| Body Battery | ENRG |
| Stress | STRS |
| Recovery Time | RECOV |
| Age | LVL / AGE |
| Steps | EXP / STEPS |
| Calories | CAL |
| Active Minutes (week) | ACTIVITY |
| Battery % | CORE |
| Notifications | NOTIF |
| BT | BT |
| Altitude | ALT |
