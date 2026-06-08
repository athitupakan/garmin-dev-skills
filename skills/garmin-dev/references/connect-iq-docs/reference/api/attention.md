---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Attention.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Attention.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Attention

## Overview

The Attention module provides the ability to play pre-defined sounds, methods for managing vibration, and control of the back light.

Not all devices fully support this module, so `has` checks are recommended. For example, the vivoactive does not have a tone generator and will trigger an error if an app attempts to play sounds.

**Since:** API Level 1.0.0

**App Types and Runtime Contexts:**

- Audio Content Provider
- Data Field
- Glance
- Watch App
- Widget

## Classes Under Namespace

**Classes:** BacklightOnTooLongException, ToneProfile, VibeProfile

## Constant Summary

### Tone

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| TONE_KEY | 0 | API Level 1.0.0 | Indicates that a key was pressed |
| TONE_START | 1 | API Level 1.0.0 | Indicates that an activity has started |
| TONE_STOP | 2 | API Level 1.0.0 | Indicates that an activity has stopped |
| TONE_MSG | 3 | API Level 1.0.0 | Indicates that a message is available |
| TONE_ALERT_HI | 4 | API Level 1.0.0 | An alert ending with a high note |
| TONE_ALERT_LO | 5 | API Level 1.0.0 | An alert ending with a low note |
| TONE_LOUD_BEEP | 6 | API Level 1.0.0 | A loud beep |
| TONE_INTERVAL_ALERT | 7 | API Level 1.0.0 | Indicates a change in interval |
| TONE_ALARM | 8 | API Level 1.0.0 | Indicates an alarm has triggered |
| TONE_RESET | 9 | API Level 1.0.0 | Indicates that the activity was reset |
| TONE_LAP | 10 | API Level 1.0.0 | Indicates that the user has completed a lap |
| TONE_CANARY | 11 | API Level 1.0.0 | An annoying sound to get the users attention |
| TONE_TIME_ALERT | 12 | API Level 1.0.0 | An alert that a time threshold has been met |
| TONE_DISTANCE_ALERT | 13 | API Level 1.0.0 | An alert that a distance threshold has been met |
| TONE_FAILURE | 14 | API Level 1.0.0 | Indicates that the activity was a failure |
| TONE_SUCCESS | 15 | API Level 1.0.0 | Indicates that the activity was a success |
| TONE_POWER | 16 | API Level 1.0.0 | The power on tone |
| TONE_LOW_BATTERY | 17 | API Level 1.0.0 | Indicates that the device has low battery power |
| TONE_ERROR | 18 | API Level 1.0.0 | Indicates an error occurred |

### FlashlightMode

Flashlight modes

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_MODE_OFF | 0 | API Level 3.4.3 |  |
| FLASHLIGHT_MODE_ON | 1 | API Level 3.4.3 |  |
| FLASHLIGHT_MODE_STROBE | 2 | API Level 3.4.3 |  |

### FlashlightColor

Flashlight colors

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_COLOR_WHITE | 0xFFFFFF | API Level 3.4.3 |  |
| FLASHLIGHT_COLOR_GREEN | 0x00FF00 | API Level 3.4.3 |  |
| FLASHLIGHT_COLOR_RED | 0xFF0000 | API Level 3.4.3 |  |

### FlashlightBrightness

Flashlight brightness

Constants map to device-specific brightness levels

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_BRIGHTNESS_LOW | 255 | API Level 3.4.3 |  |
| FLASHLIGHT_BRIGHTNESS_MEDIUM | 254 | API Level 3.4.3 |  |
| FLASHLIGHT_BRIGHTNESS_HIGH | 253 | API Level 3.4.3 |  |

### FlashlightStrobeMode

Flashlight strobe modes

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_STROBE_MODE_BLINK | 0 | API Level 3.4.3 |  |
| FLASHLIGHT_STROBE_MODE_PULSE | 1 | API Level 3.4.3 |  |
| FLASHLIGHT_STROBE_MODE_BEACON | 2 | API Level 3.4.3 |  |
| FLASHLIGHT_STROBE_MODE_BLITZ | 3 | API Level 3.4.3 |  |

### FlashlightStrobeSpeed

Flashlight strobe speeds

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_STROBE_SPEED_SLOW | 0 | API Level 3.4.3 |  |
| FLASHLIGHT_STROBE_SPEED_MEDIUM | 1 | API Level 3.4.3 |  |
| FLASHLIGHT_STROBE_SPEED_FAST | 2 | API Level 3.4.3 |  |

### FlashlightResult

Flashlight result codes

**Since:** API Level 3.4.3

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FLASHLIGHT_RESULT_SUCCESS | 0 | API Level 3.4.3 |  |
| FLASHLIGHT_RESULT_INVALID_COLOR | 1 | API Level 3.4.3 |  |
| FLASHLIGHT_RESULT_INVALID_BRIGHTNESS | 2 | API Level 3.4.3 |  |
| FLASHLIGHT_RESULT_INVALID_MODE | 3 | API Level 3.4.3 |  |
| FLASHLIGHT_RESULT_INVALID_SPEED | 4 | API Level 3.4.3 |  |
| FLASHLIGHT_RESULT_FAILURE | 5 | API Level 3.4.3 |  |

## Instance Method Summary
- **backlight**(setting as Lang.Boolean or Lang.Float) as **Void** Control the display backlight.
- **hasFlashlightColor**(color as Attention.FlashlightColor) as Lang.Boolean Determine if a given flashlight color is supported by this device.
- **playTone**(options as Attention.Tone or { :toneProfile as Lang.Array, :repeatCount as Lang.Number }) as **Void** Play a tone.
- **setFlashlightMode**(mode as Attention.FlashlightMode, options as { :color as Attention.FlashlightColor, :brightness as Lang.Number or Attention.FlashlightBrightness, :strobeMode as Attention.FlashlightStrobeMode, :strobeSpeed as Attention.FlashlightStrobeSpeed } or **Null**) as Attention.FlashlightResult
- **vibrate**(vibeProfiles as Lang.Array) as **Void** Engage the vibration motor.

## Instance Method Details

### `backlight(setting as Lang.Boolean or Lang.Float) as Void`

Control the display backlight.

The backlight will always respect the backlight timeout settings on the device. Behavior of this feature may also change depending on device settings. For example, if a device is set to activate the back light with key presses, the backlight will toggle on with key presses even if the app is written to turn off the back light with a key press.

On products that use a gesture enabled display, calling this API will suppress the gesture detection for the period that the backlight is on. Calling this repeatedly can hold the display on, but if the product has burn in protection an exception will be thrown if you attempt to keep the display enabled for too long (e.g. over 1 minute).

Note:

Passing a Float is only supported with ConnectIQ 3.2.1 and later.

**Parameters:**
- setting — (Lang.Boolean, Lang.Float) — If `setting` is a Boolean, `false` will disable the backlight and `true` will enable the backlight at the system backlight level.
- If `setting` is a Float, the value 0.0 will disable the backlight and values greater than 0.0 and less than or equal to 1.0 will enable the backlight at the specified brightness.

_Supported on 161 devices._

**Since:** API Level 1.0.0

**Throws:**
- BacklightOnTooLongException On products with burn in protection, this exception is thrown if the backlight is held on for too long continuously
- InvalidOptionsException If the Float value is outside the valid range.

### `hasFlashlightColor(color as Attention.FlashlightColor) as Lang.Boolean`

Determine if a given flashlight color is supported by this device

**Parameters:**
- color — (Attention.FlashlightColor) — Color to check

_Supported on 27 devices._

**Returns:**
- Returns true if the given color is supported, otherwise false.

**Since:** API Level 3.4.3

**Throws:**
- (Lang.OperationNotAllowedException) — Raised if called from an app type other than watch-app.

### `playTone(options as Attention.Tone or { :toneProfile as Lang.Array, :repeatCount as Lang.Number }) as Void`

Play a tone.

Note:

Passing an options Dictionary is only supported with ConnectIQ 3.1.0 and later.

**Parameters:**
- options — (Attention.Tone, Lang.Dictionary) — A TONE_* value or Dictionary of options. :toneProfile — (Lang.Array) — Array containing at least one ToneProfile object to be played in sequence.
- :repeatCount — (Lang.Number) — Number of times to repeat the given tone sequence.

**Example:**
```
using Toybox.Attention;

// Play a predefined tone
if (Attention has :playTone) {
   Attention.playTone(Attention.TONE_LOUD_BEEP);
}

// Use an array of ToneProfile objects to build and play a custom tone
if (Attention has :ToneProfile) {
    var toneProfile =
    [
        new Attention.ToneProfile( 2500, 250),
        new Attention.ToneProfile( 5000, 250),
        new Attention.ToneProfile(10000, 250),
        new Attention.ToneProfile( 5000, 250),
        new Attention.ToneProfile( 2500, 250),
    ];
    Attention.playTone({:toneProfile=>toneProfile});
   }
```

_Supported on 138 devices._

**Since:** API Level 1.0.0

**Throws:**
- (Lang.InvalidOptionsException) — Thrown if passing an options hash with invalid values when using new ToneProfile objects

### `setFlashlightMode(mode as Attention.FlashlightMode, options as { :color as Attention.FlashlightColor, :brightness as Lang.Number or Attention.FlashlightBrightness, :strobeMode as Attention.FlashlightStrobeMode, :strobeSpeed as Attention.FlashlightStrobeSpeed } or Null) as Attention.FlashlightResult`

**Parameters:**
- mode — (Attention.FlashlightMode)
- options — (Lang.Dictionary) — Flashlight mode options :color — (Attention.FlashlightColor) — Color of flashlight. Default is FLASHLIGHT_COLOR_WHITE.
- :strobeMode — (Attention.FlashlightStrobeMode) — Mode of strobe. Default is FLASHLIGHT_STROBE_MODE_BLINK.
- :strobeSpeed — (Attention.FlashlightStrobeSpeed) — Speed of strobe. Default is FLASHLIGHT_STROBE_SPEED_MEDIUM.
- :brightness — (Lang.Number, Attention.FlashlightBrightness) — Intensity of the flashlight. Default is FLASHLIGHT_BRIGHTNESS_MEDIUM.

_Supported on 27 devices._

**Returns:**
- Attention.FlashlightResult — A FlashlightResult value indicating the operation status.

**Since:** API Level 3.4.3

**Throws:**
- (Lang.OperationNotAllowedException) — Raised if called from an app type other than watch-app.

### `vibrate(vibeProfiles as Lang.Array) as Void`

Engage the vibration motor.

The vibrate method takes an Array containing at least one VibeProfile object, up to a maximum of 8, and runs them in sequence.

Note:

Forerunner devices do not support vibration patterns. Vibration may still be used, but the vibration will always run at the same duty cycle.

**Parameters:**
- vibeProfiles — (Lang.Array) — An Array of VibeProfile objects

**Example:**
Vibrate in an on/off pattern

```
if (Attention has :vibrate) {
    vibeData =
    [
        new Attention.VibeProfile(50, 2000), // On for two seconds
        new Attention.VibeProfile(0, 2000),  // Off for two seconds
        new Attention.VibeProfile(50, 2000), // On for two seconds
        new Attention.VibeProfile(0, 2000),  // Off for two seconds
        new Attention.VibeProfile(50, 2000)  // on for two seconds
    ];
}
Attention.vibrate(vibeData);
```

_Supported on 136 devices._

**See Also:**

- Toybox.Attention.VibeProfile

**Since:** API Level 1.0.0
