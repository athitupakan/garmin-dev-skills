---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi/WatchFace.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.WatchUi.WatchFace

Specialized `View` for watch face apps. Adds power-state notifications for active vs AOD modes.

## Class hierarchy

```
Toybox.Lang.Object
  └── Toybox.WatchUi.View
      └── Toybox.WatchUi.WatchFace
```

The app's initial view **must** extend `WatchFace`.

## Lifecycle methods

| Method | When called | Use for |
|--------|-------------|---------|
| `initialize()` | Constructor — once on view creation | One-time setup. Call `WatchFace.initialize()` parent. |
| `onLayout(dc)` | Once after init, when screen size is known | Compute layout regions; load resources. Don't draw — `dc.getWidth/Height` are valid here. |
| `onShow()` | View brought to foreground | Wake timers, reset state. |
| `onUpdate(dc)` | High-power: every second. Low-power: once per minute. | All drawing. |
| `onHide()` | View backgrounded | Pause timers, free resources. |
| `onEnterSleep()` | ~10 s after high-power begins (no recent gesture) | Stop animations/timers; prepare for once-per-minute redraws. |
| `onExitSleep()` | Gesture detected from low power | Restart timers/animations for once-per-second drawing. |
| `onPartialUpdate(dc)` | Every second during low-power, **only if device supports it** | AOD updates within power budget. Must call `dc.setClip()` to limit redraw area. |
| `onSettingsChanged()` | App Properties changed via Connect IQ Settings | Re-read settings; `WatchUi.requestUpdate()`. |

## High-power vs low-power

| State | `onUpdate` | `onPartialUpdate` | Animations | Timers |
|-------|-----------|-------------------|-----------|--------|
| **High-power** | Every 1 second | Not called | OK | OK |
| **Low-power (AOD)** | Once per minute (top of minute) | Each second for 59 s (if supported) | Not allowed | Not allowed |

## AOD (Always-On Display) considerations

- `onPartialUpdate(dc)` is called once per second in low-power mode.
- **Must call `dc.setClip(x, y, w, h)` first** to limit redraw area — otherwise full-screen redraw triggers `onPowerBudgetExceeded` on the delegate.
- Keep partial-update content minimal — seconds, simple indicator dot, etc.
- `System.println` in `onPartialUpdate` works on simulator only — not on real device.

## Power budget

- If `onPartialUpdate` exceeds the device's per-second power budget, `WatchFaceDelegate.onPowerBudgetExceeded(powerInfo)` is called.
- Device disables `onPartialUpdate` for the app after repeated breaches.

## Settings change

For Connect IQ Settings UI integration: override `onSettingsChanged()`, read updated `Application.Properties`, then call `WatchUi.requestUpdate()` to force a redraw.

## Our project's WatchFace use

- Currently no `onPartialUpdate` — full redraw every minute in AOD.
- Future: when adding AOD-specific layout, override `onPartialUpdate` with clip + minimal draw.
- All drawing happens in `onUpdate(dc)`; `onLayout` only does region computation.
