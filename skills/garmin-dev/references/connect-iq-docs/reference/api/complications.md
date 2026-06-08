---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Complications.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Complications.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Complications

## Overview

The Complications module allows apps to both subscribe to and publish complications. Complications are exposed via an iterator, or can be queried by identifier. Watch faces can register a callback and subscribe to multiple complications. Device apps and audio content providers can publish complication information.

**Since:** API Level 4.2.0

_Supported on 62 devices._

## Classes Under Namespace

**Classes:** Complication, ComplicationNotFoundException, Id, Iterator

## Constant Summary

### Unit

Units reported by a complication

**Since:** API Level 4.2.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| UNIT_INVALID | 0 | API Level 4.2.0 |  |
| UNIT_DISTANCE | 1 | API Level 4.2.0 | Complication is a distance; value is in meters |
| UNIT_ELEVATION | 2 | API Level 4.2.0 | Complication is a elevation; value is in meters |
| UNIT_HEIGHT | 3 | API Level 4.2.0 | Complication is a height; value is in meters |
| UNIT_SPEED | 4 | API Level 4.2.0 | Complication is a speed; value is in meters/second |
| UNIT_TEMPERATURE | 5 | API Level 4.2.0 | Complication is a temperature; value is in degrees Celsius |
| UNIT_WEIGHT | 6 | API Level 4.2.0 | Complication is a weight; value is in grams |

### Type

System build-in complication type

**Since:** API Level 4.2.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| COMPLICATION_TYPE_INVALID | 0 | API Level 4.2.0 | Invalid build-in complication type |
| COMPLICATION_TYPE_BATTERY | 1 | API Level 4.2.0 | Value is a non-negative Number percent 0 to 100 representing battery charge or `null` |
| COMPLICATION_TYPE_STEPS | 2 | API Level 4.2.0 | Value is a non-negative Number of steps for the current day, not available in wheelchair mode |
| COMPLICATION_TYPE_CALORIES | 3 | API Level 4.2.0 | Value is a non-negative Number of calories burned for the current day |
| COMPLICATION_TYPE_FLOORS_CLIMBED | 4 | API Level 4.2.0 | Value is a non-negative Number of floors climbed, not available in wheelchair mode |
| COMPLICATION_TYPE_INTENSITY_MINUTES | 5 | API Level 4.2.0 | Value is a non-negative Number of intensity minutes that resets weekly |
| COMPLICATION_TYPE_DATE | 6 | API Level 4.2.0 | Value is a String with the day of the month and the month e.g., 28 Mar |
| COMPLICATION_TYPE_WEEKDAY_MONTHDAY | 7 | API Level 4.2.0 | Value is a String with the day of the week and the day of the month e.g., Mon 28 |
| COMPLICATION_TYPE_CURRENT_WEATHER | 8 | API Level 4.2.0 | Value is a Weather.CONDITION_* for the current weather |
| COMPLICATION_TYPE_FORECAST_WEATHER_1DAY | 9 | API Level 4.2.0 | Value is a Weather.CONDITION_* for the forecast weather one day in the future |
| COMPLICATION_TYPE_FORECAST_WEATHER_2DAY | 10 | API Level 4.2.0 | Value is a Weather.CONDITION_* for the forecast weather two days in the future |
| COMPLICATION_TYPE_FORECAST_WEATHER_3DAY | 11 | API Level 4.2.0 | Value is a Weather.CONDITION_* for the forecast weather three days in the future |
| COMPLICATION_TYPE_CALENDAR_EVENTS | 12 | API Level 4.2.0 | Value is a String with the time of your next calendar event or `null` |
| COMPLICATION_TYPE_SUNRISE | 13 | API Level 4.2.0 | Value is a non-negative Number representing seconds since midnight local time of the sunrise or `null` |
| COMPLICATION_TYPE_SUNSET | 14 | API Level 4.2.0 | Value is a non-negative Number representing seconds since midnight local time of the sunset or `null` |
| COMPLICATION_TYPE_ALTITUDE | 15 | API Level 4.2.0 | Value is a Float of the current altitude in meters or `null`. Prior to ConnectIQ API version 5.1.0, the value was a Number. |
| COMPLICATION_TYPE_SEA_LEVEL_PRESSURE | 16 | API Level 4.2.0 | Value is a Float in pascals of the current pressure or `null` |
| COMPLICATION_TYPE_NOTIFICATION_COUNT | 17 | API Level 4.2.0 | Value is a non-negative Number of notifications or `null` |
| COMPLICATION_TYPE_HEART_RATE | 18 | API Level 4.2.0 | Value is a non-negative Number in beats per minute or `null` |
| COMPLICATION_TYPE_WEEKLY_RUN_DISTANCE | 19 | API Level 4.2.0 | Value is a Float of your weekly run distance in meters |
| COMPLICATION_TYPE_WEEKLY_BIKE_DISTANCE | 20 | API Level 4.2.0 | Value is a Float of your weekly bike distance in meters |
| COMPLICATION_TYPE_RECOVERY_TIME | 21 | API Level 4.2.0 | Value is a Number of minutes remaining in your recovery time |
| COMPLICATION_TYPE_STRESS | 22 | API Level 4.2.0 | Value is a Number representing your current stress level or `null` |
| COMPLICATION_TYPE_BODY_BATTERY | 23 | API Level 4.2.0 | Value is a Number representing your current body battery or `null` |
| COMPLICATION_TYPE_VO2MAX_RUN | 24 | API Level 4.2.0 | Value is a Number representing your running VO2 max or `null` |
| COMPLICATION_TYPE_VO2MAX_BIKE | 25 | API Level 4.2.0 | Value is a Number representing your cycling VO2 max or `null` |
| COMPLICATION_TYPE_TRAINING_STATUS | 26 | API Level 4.2.0 | Value is a String representing your training status |
| COMPLICATION_TYPE_RACE_PREDICTOR_5K | 27 | API Level 4.2.0 | Value is a Number representing your predicted 5K time in seconds |
| COMPLICATION_TYPE_RACE_PREDICTOR_10K | 28 | API Level 4.2.0 | Value is a Number representing your predicted 10k time in seconds |
| COMPLICATION_TYPE_RACE_PREDICTOR_HALF_MARATHON | 29 | API Level 4.2.0 | Value is a Number representing your predicted half marathon time in seconds |
| COMPLICATION_TYPE_RACE_PREDICTOR_MARATHON | 30 | API Level 4.2.0 | Value is a Number representing your predicted your marathon time in seconds |
| COMPLICATION_TYPE_RACE_PACE_PREDICTOR_5K | 31 | API Level 4.2.0 | Value is a Float representing your 5k pace in meters/second |
| COMPLICATION_TYPE_RACE_PACE_PREDICTOR_10K | 32 | API Level 4.2.0 | Value is a Float representing your 10k pace in meters/second |
| COMPLICATION_TYPE_RACE_PACE_PREDICTOR_HALF_MARATHON | 33 | API Level 4.2.0 | Value is a Float representing your half marathon pace in meters/second |
| COMPLICATION_TYPE_RACE_PACE_PREDICTOR_MARATHON | 34 | API Level 4.2.0 | Value is a Float representing your marathon pace in meters/second |
| COMPLICATION_TYPE_PULSE_OX | 35 | API Level 4.2.0 | Value is a non-negative Number as a percent from 0 to 100 representing your blood oxygen or `null` |
| COMPLICATION_TYPE_RESPIRATION_RATE | 36 | API Level 4.2.0 | Value is a non-negative Number representing your breaths per minute or `null` |
| COMPLICATION_TYPE_SOLAR_INPUT | 37 | API Level 4.2.0 | Value is a non-negative Number representing percent between 0 to 100 of solar charge or `null` |
| COMPLICATION_TYPE_CURRENT_TEMPERATURE | 38 | API Level 4.2.0 | Value is a Float representing temperature in degrees Celsius or `null`. Prior to ConnectIQ API version 5.0.0, the value was a Number. |
| COMPLICATION_TYPE_HIGH_LOW_TEMPERATURE | 39 | API Level 4.2.0 | Value is a String providing the high and low temperature values in a format similar to "H <high> / L <low>" |
| COMPLICATION_TYPE_WHEELCHAIR_PUSHES | 40 | API Level 4.2.3 | Value is a non-negative Number of pushes for the current day, only available in wheelchair mode |
| COMPLICATION_TYPE_LAST_GOLF_ROUND_SCORE | 41 | API Level 5.0.0 | Value is a String in the format "<LastRoundTotalScore>(<Offset>)" where Offset is "E" for even-par, a negative value for under par, or a positive value for over par |

## Typedef Summary
- **ComplicationChangedCallback** as Lang.Method(id as Complications.Id) as **Void** Callback for subscribers to be notified of complication updates.
- **Data** as { :shortLabel as Complications.Label, :value as Complications.Value, :unit as Complications.Unit or Lang.String, :ranges as Complications.Ranges }
- **Icon** as WatchUi.BitmapResource or Graphics.BitmapReference
- **Label** as Lang.String
- **RangeValue** as Lang.Number or Lang.Float or Lang.Long or Lang.Double
- **Ranges** as Lang.Array
- **Value** as Lang.String or Complications.RangeValue

## Instance Method Summary
- **exitTo**(id as Complications.Id) as **Void** Launches the app associated with the complication.
- **getComplication**(id as Complications.Id) as Complications.Complication Given a complication Id, get the complication.
- **getComplications**() as Complications.Iterator Provide an iterator over complication id that we have access to.
- **registerComplicationChangeCallback**(callback as Complications.ComplicationChangedCallback or **Null**) as **Void** Register callback for notifications of complication updates.
- **subscribeToUpdates**(id as Complications.Id) as Lang.Boolean Subscribes to complication.
- **unsubscribeFromAllUpdates**() as **Void** Unsubscribes from all subscribed complications.
- **unsubscribeFromUpdates**(id as Complications.Id) as **Void** Unsubscribes from complication.
- **updateComplication**(index as Lang.Number, data as Complications.Data) as **Void** Update the complication data Values not specified in `data` will not be updated from the last update or what is specified in the resource definition.

## Typedef Details

### `ComplicationChangedCallback as Lang.Method(id as Complications.Id) as Void`

Callback for subscribers to be notified of complication updates

**Since:** API Level 4.2.0

### `Data as { :shortLabel as Complications.Label, :value as Complications.Value, :unit as Complications.Unit or Lang.String, :ranges as Complications.Ranges }`

**Since:** API Level 4.2.0

### `Icon as WatchUi.BitmapResource or Graphics.BitmapReference`

**Since:** API Level 4.2.0

### `Label as Lang.String`

**Since:** API Level 4.2.0

### `RangeValue as Lang.Number or Lang.Float or Lang.Long or Lang.Double`

**Since:** API Level 4.2.0

### `Ranges as Lang.Array`

**Since:** API Level 4.2.0

### `Value as Lang.String or Complications.RangeValue`

**Since:** API Level 4.2.0

## Instance Method Details

### `exitTo(id as Complications.Id) as Void`

Launches the app associated with the complication

**Parameters:**
- id — (Complications.Id) — The complication Id to launch

_Supported on 58 devices._

**See Also:**

- Toybox.System.exitTo

**Since:** API Level 4.2.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if complication id is not a from a valid app

### `getComplication(id as Complications.Id) as Complications.Complication`

Given a complication Id, get the complication

**Parameters:**
- id — (Complications.Id) — Complication Id to fetch

**Returns:**
- Complications.Complication — Complication

**Since:** API Level 4.2.0

**Throws:**
- (Complications.ComplicationNotFoundException) — Thrown if the given complication is not found.

### `getComplications() as Complications.Iterator`

Provide an iterator over complication id that we have access to

**Returns:**
- Complications.Iterator — Iterator instance

**Since:** API Level 4.2.0

### `registerComplicationChangeCallback(callback as Complications.ComplicationChangedCallback or Null) as Void`

Register callback for notifications of complication updates

**Parameters:**
- callback — (Complications.ComplicationChangedCallback) — Callback to be invoked when complication is changed or becomes unavailable.

**Since:** API Level 4.2.0

### `subscribeToUpdates(id as Complications.Id) as Lang.Boolean`

Subscribes to complication. Information is sent to registered ComplicationChangedCallback method. Make sure you have registered your change callback.

**Returns:**
- Lang.Boolean — `true` if subscribed successfully, `false` if given complication could not be subscribed to

**See Also:**

- Toybox.Complications.registerComplicationChangeCallback

**Since:** API Level 4.2.0

**Throws:**
- (Lang.OperationNotAllowedException) — Thrown if too many active subscriptions
- (Complications.ComplicationNotFoundException) — Thrown if the given complication is not found.

### `unsubscribeFromAllUpdates() as Void`

Unsubscribes from all subscribed complications

**Since:** API Level 4.2.0

### `unsubscribeFromUpdates(id as Complications.Id) as Void`

Unsubscribes from complication

**Parameters:**
- id — (Complications.Id) — Complication Td to unsubscribe from

**Since:** API Level 4.2.0

### `updateComplication(index as Lang.Number, data as Complications.Data) as Void`

Update the complication data Values not specified in `data` will not be updated from the last update or what is specified in the resource definition.

**Parameters:**
- index — (Lang.Number) — Application complication to be updated
- data — (Complications.Data) — Updated values for the complication

**Since:** API Level 4.2.0

**Throws:**
- (Lang.OperationNotAllowedException) — Thrown if the id of the complication is not associated with this application
