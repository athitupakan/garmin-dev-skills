---
source: https://developer.garmin.com/connect-iq/core-topics/getting-the-users-attention/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Getting_the_Users_Attention.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Getting the User's Attention

Your app may need to request the user's attention at certain times. Connect IQ offers ways to do this via the Toybox.Attention module. The Toybox.Attention module provides access to the vibration motor, tone generator, screen backlight and flashlight.

| API | Description | API Level |
| --- | --- | --- |
| Attention.backlight() | Controls the display backlight | 1.0.0 |
| Attention.setFlashlightMode() | Controls the display backlight | 1.0.0 |
| Attention.playTone() | Plays a tone using the tone generator | 1.0.0 |
| Attention.vibrate() | Uses the vibration motor | 1.0.0 |

## Backlight

The backlight behavior for Garmin devices depends on the display technology. *Reflective* displays like memory-in-pixel (MIP) typically keep the backlight off to conserve power. The user has options to have the backlight enable for different actions like button touches and gestures. These will be handled automatically by the system based on the user settings.

*Emissive* displays like AMOLED are not backlit, but instead typically draw power to light every pixel. The brightness of the display can vary from a low brightness of an "always on" mode to full brightness when the user has gestured. The user can choose their brightness settings for the device, and the system will obey them automatically.

The Attention.backlight() API allows the developer to enable the screen backlight. On API 3.2.0 and above, the backlight brightness can be provided as a value between 0.0 and 1.0, and below API 3.2 the brightness can be set to `true` or `false`.

Note that keeping an AMOLED display on for extended periods at full brightness can damage the display. If the system detects the developer is attempting to do this, an exception will be thrown. The backlight, especially on AMOLED devices, should not be used as a flashlight. In these cases, you can use the flashlight API.

## Flashlight

The fēnix® 7X was the first device to have an on-device flashlight. The on-device flashlight can support different modes including:

- Off, on or blink patterns
- Different brightness levels
- Different colors

The Attention.setFlashlightMode() API allows the developer to control the device flashlight:

```
    function setFlashlightMode(mode as FlashlightMode, options as {
        :color as FlashlightColor,
        :brightness as Number or FlashlightBrightness, // 0 to 100 or special value
        :strobeMode as FlashlightStrobeMode,
        :strobeSpeed as FlashlightStrobeSpeed,
    }?) as FlashlightResult
```

The `mode` is an enum of the following possibilities:

| Value | Description | API Level |
| --- | --- | --- |
| `FLASHLIGHT_MODE_OFF`odule) | Turns the flashlight off | 4.2.0 |
| `FLASHLIGHT_MODE_ON`odule) | Turns the flashlight on | 4.2.0 |
| `FLASHLIGHT_MODE_STROBE`odule) | Sets the flashlight to strobe. Use the `:strobeMode` and `:strobeSpeed` options to configure the strobe. | 4.2.0 |

The `:color` option accepts `FLASHLIGHT_COLOR_WHITE`odule), `FLASHLIGHT_COLOR_GREEN`odule), or `FLASHLIGHT_COLOR_RED`odule). Not every device supports every color. Use Attention.hasFlashlightColor() to check if a color is supported.

The `:brightness` option accepts the following values:

| Value | Description | API Level |
| --- | --- | --- |
| 0 to 100 | Sets the brightness from 0 to 100 percent | 4.2.0 |
| `FLASHLIGHT_BRIGHTNESS_LOW`odule) | Sets the brightness to the device low setting | 4.2.0 |
| `FLASHLIGHT_BRIGHTNESS_MEDIUM`odule) | Sets the brightness to the device medium setting | 4.2.0 |
| `FLASHLIGHT_BRIGHTNESS_HIGH`odule) | Sets the brightness to the device high setting | 4.2.0 |

The `:strobeMode` can be set to the following:1

| Value | Description | API Level |
| --- | --- | --- |
| `FLASHLIGHT_STROBE_MODE_BLINK`odule) | Sets the strobe to a `-- -- -- --` pattern | 4.2.0 |
| `FLASHLIGHT_STROBE_MODE_PULSE`odule) | Sets the strobe to a `=-_ =-_ =-_ =-_` pattern2 | 4.2.0 |
| `FLASHLIGHT_STROBE_MODE_BLITZ`odule) | Sets the strobe to a `... ... ...` pattern | 4.2.0 |

The `:strobeSpeed` can be set to the following:

| Value | Description | API Level |
| --- | --- | --- |
| `FLASHLIGHT_STROBE_SPEED_SLOW`odule) | Uses a slow strobe mode | 4.2.0 |
| `FLASHLIGHT_STROBE_SPEED_MEDIUM`odule) | Uses a medium strobe mode | 4.2.0 |
| `FLASHLIGHT_STROBE_SPEED_FAST`odule) | Uses a fast strobe mode | 4.2.0 |

The Attention.setFlashlightMode() API returns the following based on the input:

| Value | Description | API Level |
| --- | --- | --- |
| `FLASHLIGHT_RESULT_SUCCESS`odule) | Flashlight mode was set successfully | 4.2.0 |
| `FLASHLIGHT_RESULT_INVALID_COLOR`odule) | Flashlight mode could not be set because an invalid color was specified | 4.2.0 |
| `FLASHLIGHT_RESULT_INVALID_BRIGHTNESS`odule) | Flashlight mode could not be set because the brightness is not supported | 4.2.0 |
| `FLASHLIGHT_RESULT_MODE`odule) | Flashlight mode could not be set because the mode is not supported | 4.2.0 |
| `FLASHLIGHT_RESULT_SPEED`odule) | Flashlight mode could not be set because the strobe speed is not supported | 4.2.0 |
| `FLASHLIGHT_RESULT_FAILURE`odule) | Flashlight mode could not be set | 4.2.0 |

## Tones

Garmin devices often use audible tones for different events. The Attention.playTone() API provides access to the tone generator:

```
    function playTone(options as Tone or {
            :toneProfile as Array<ToneProfile>,
            :repeatCount as Number
        }) as Void
```

To play a system tone, you can pass one of the odule) enum values. If you want to play a custom tone, you can pass an array of Attention.ToneProfile objects to the `:toneProfile` option. The Attention.ToneProfile allows you to set a frequency and duration for each note.

## Vibration

The vibration motor can be used to inform the user that an event that needs their attention is occurring. You can engage the vibration motor with the Attention.vibrate() API:

```
function vibrate(vibeProfiles as Array<VibeProfile>) as Void
```

You pass the Attention.vibrate() API a set of Attention.ToneProfile objects. Each Attention.ToneProfile contains a duty cycle and a duration. The device will go through each Attention.ToneProfile in order, adjusting the duty cycle for the specified durations.

1 `FLASHLIGHT_STROBE_MODE_FUNKADELIC` may come in a future update.

2 Could also be defined as `☀🔆🌥 ☀🔆🌥 ☀🔆🌥`.
