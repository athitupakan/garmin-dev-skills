# Garmin Connect IQ Simulator — Data Injection Reference

How to feed real-looking sensor data into the simulator while developing a watch face or device app. Garmin docs cover the API but not the sim UI in one place, so this is a practical menu-by-menu cheat sheet verified against SDK 9.1.0. A concrete project label mapping is in the Worked example at the end.

## Launch

- `run.ps1` opens sim + builds + pushes
- Or `simulator.exe` standalone → drag `bin/<project>.prg` in
- Stays open across builds; re-push with `push.ps1`

## Menu structure (SDK 9.1.0)

### File
- **Open** — load a `.prg`
- **Open FIT** — load `.fit` file; sim replays HR / steps / distance / pace / calories in real time (best for testing live-tracking apps; watch face mostly sees the steady-state values)

### Settings (static state — change once, sim holds value)

**User Profile** — drives `UserProfile.getProfile().*`
- Birth Year (derive age via current year)
- Gender, Weight, Height, Activity Class
- VO2 Max (Running) — also feeds some derived metrics
- VO2 Max (Cycling)
- Resting HR — common HR sparkline floor

**System** — drives `System.getSystemStats()` + `getDeviceSettings()`
- Battery %
- Battery in Days
- Charging (bool)
- Time / Time Zone
- Notification Count
- Alarm Count
- BT / Wi-Fi / Tether connection → `DeviceSettings.connectionInfo`

**Activity Monitor** — drives `ActivityMonitor.getInfo()`
- Steps + Step Goal
- Calories
- Floors Climbed + Goal
- Active Minutes Day / Week + Weekly Goal
- Distance (cm, ÷100 for m)
- Stress Score (rolling) — fallback when SensorHistory is empty
- Respiration Rate
- Time To Recovery
- Move Bar Level (0-5)

**Sensors** — drives `Toybox.Sensor` + `SensorHistory`
- Heart Rate (live)
- Heart Rate History — inject sample array for sparkline
- HR Zones (per sport)
- Stress History
- Body Battery
- Pulse Ox (SpO2)
- Temperature (skin)
- Elevation
- Barometric Pressure

### Simulation (events — trigger and observe)
- **Always On Display** toggle → tests `drawAod()` path
- **Pair / Disconnect** → toggles BT state for `BT.connected()`
- **Set Notifications** → push notification events
- **Set Sleep Phase** → sleep state (proxies for recovery metrics)
- **Wrist gesture / Wake / Sleep** → enter/exit AOD via lifecycle

## Per-metric quick lookup

| Metric | API source | Sim path |
|--------|------------|----------|
| Time / Date | `Time.now()` | Settings → Time |
| Age | `UserProfile.getProfile().birthYear` (derive) | Settings → User Profile → Birth Year |
| HR (live + history) | `SensorHistory.getHeartRateHistory` | Settings → Sensors → HR / HR History |
| HR max | `UserProfile.getHeartRateZones`[5] | Settings → Sensors → HR Zones |
| Stress (history) | `SensorHistory.getStressHistory` | Settings → Sensors → Stress History |
| Body Battery | `SensorHistory.getBodyBatteryHistory` | Settings → Sensors → Body Battery |
| Steps | `ActivityMonitor.getInfo().steps/.stepGoal` | Settings → Activity Monitor → Steps / Goal |
| Active minutes | `.activeMinutesWeek.total/.activeMinutesWeekGoal` | Settings → Activity Monitor → Active Minutes |
| Calories | `.calories` (BMR + activity combined) | Settings → Activity Monitor → Calories |
| Time to recovery | `.timeToRecovery` | Settings → Activity Monitor → Recovery |
| Floors | `.floorsClimbed/.floorsClimbedGoal` | Settings → Activity Monitor → Floors |
| Battery % | `System.getSystemStats().battery` | Settings → Set Battery Status → Battery Percentage |
| Battery days | `.batteryInDays` | Settings → Set Battery Status → Days Remaining |
| Charging | `.charging` | Settings → Set Battery Status → Battery Charging [ ] |
| Notifications | `DeviceSettings.notificationCount` | Settings → System → Notification Count |
| BT connection | `DeviceSettings.connectionInfo` | Simulation → Pair / Disconnect |
| Altitude | `SensorHistory.getElevationHistory` | Settings → Sensors → Elevation |

## FIT replay (live data)

1. Record a real activity on a Garmin (or grab a sample `.fit` from Garmin Connect export)
2. Sim → File → Open FIT
3. Sim plays back samples in real time — HR rises/falls, steps increment, calories accumulate
4. Watch face's per-second `onUpdate` sees the changing values naturally
5. Pause / scrub controls usually in the sim toolbar

Best for testing:
- HR sparkline scrolling
- Stress history bars updating
- Animation behavior under value changes
- Status color thresholds

## AOD testing

- Sim → Simulation → Always On Display → On
- TIME drops to 1-per-minute updates; `onUpdate()` runs `drawAod()`
- Burn-in protection visible only by hovering long enough for the jitter to shift (every minute)
- Sim AOD renders BRIGHTER than the actual device (real AMOLED dims hardware); colors that look fine in sim may be invisible on-wrist → always verify AOD on real device after color/size changes

## Gotchas

- **Battery % change may not refresh** until you close/re-open the `.prg` — sim caches some system stats per-process
- **FIT replay only feeds Activity-recording samples** — `SensorHistory.*` may still return null for older history windows until enough sim time elapses
- **HR Zones default** to (49, 100, 130, 150, 165, 184) on a fresh sim profile — set Resting HR / Activity Class for realistic zone[5] = maxHR
- **Notification count** persists across sim restarts; clear via Settings → System → Notification Count = 0
- **AOD test on real device** is non-negotiable — sim's brightness halving for AOD is approximate at best

## Local SDK docs

Verbose but searchable on disk — `<sdk-root>/doc/docs/Core_Topics/`. The SDK root depends on OS:
```
Windows:  %APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-*\doc\docs\Core_Topics\
macOS:    ~/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-*/doc/docs/Core_Topics/
Linux:    ~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-*/doc/docs/Core_Topics/
```
- `Sensors.html` — Sensor API + FIT data
- `Quantifying_the_User.html` — UserProfile, ActivityMonitor
- `Properties_and_App_Settings.html` — sim settings panel
- `Debugging.html` — `println`, `mdd`, breakpoints (not sim data)
- `Activity_Recording.html` — FIT file context

## Online (when SDK doesn't cover)

- [Programmer's Guide TOC](https://developer.garmin.com/downloads/connect-iq/resources/programmers-guide/toc.md) — section index
- [Reference Guides](https://developer.garmin.com/connect-iq/reference-guides/) — supplementary topics
- [Connect IQ SDK landing](https://developer.garmin.com/connect-iq/)

## Worked example: Vital Core tile mapping

vital-core uses an "RPG-themed" label scheme. The table below maps Garmin's universal metric names (above) to vital-core's on-face labels — useful only as a concrete illustration of how one project might bind APIs to its own UI elements. Your project will have its own labels.

| Garmin metric | vital-core label / placement |
|---|---|
| Birth Year (age) | `LVL` crown |
| Body Battery | `ENRG` arc |
| Stress (history) | `STRESS` bars |
| Battery % | `BATTERY` bottom tile |
| Battery in Days | `BD1` days subtext (Phase 2) |
| Altitude | `BD2` altitude tile |
| Notifications | `NOTIFICATIONS` tile |
| BT connection | `BT` tile |
| HR max suffix | rendered as `/180` after current HR |
| Body / Activity / Device tiers | `CORE` block grouping |

Centralize this mapping in a single source-of-truth module (e.g. `source/Metric.mc`) rather than scattering across views — when you change a tile name, only one file needs editing.

## Cross-reference

- Sensor catalog (which API for which metric): [../catalogs/sensors.md](../catalogs/sensors.md)
- Per-module API deep-dives: [../connect-iq-docs/reference/api/](../connect-iq-docs/reference/api/)
