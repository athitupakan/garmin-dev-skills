---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Weather.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Weather.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Weather

## Overview

The Weather module provides functionality for accessing information related to the current weather.

**Since:** API Level 3.2.0

_Supported on 118 devices._

## Classes Under Namespace

**Classes:** CurrentConditions, DailyForecast, HourlyForecast

## Constant Summary

### Condition

**Since:** API Level 3.2.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONDITION_CLEAR | 0 | API Level 3.2.0 | Clear |
| CONDITION_PARTLY_CLOUDY | 1 | API Level 3.2.0 | Partly cloudy |
| CONDITION_MOSTLY_CLOUDY | 2 | API Level 3.2.0 | Mostly cloudy |
| CONDITION_RAIN | 3 | API Level 3.2.0 | Rain |
| CONDITION_SNOW | 4 | API Level 3.2.0 | Snow |
| CONDITION_WINDY | 5 | API Level 3.2.0 | Windy |
| CONDITION_THUNDERSTORMS | 6 | API Level 3.2.0 | Thunderstorms |
| CONDITION_WINTRY_MIX | 7 | API Level 3.2.0 | Wintry mix |
| CONDITION_FOG | 8 | API Level 3.2.0 | Fog |
| CONDITION_HAZY | 9 | API Level 3.2.0 | Hazy |
| CONDITION_HAIL | 10 | API Level 3.2.0 | Hail |
| CONDITION_SCATTERED_SHOWERS | 11 | API Level 3.2.0 | Scattered showers |
| CONDITION_SCATTERED_THUNDERSTORMS | 12 | API Level 3.2.0 | Scattered thunderstorms |
| CONDITION_UNKNOWN_PRECIPITATION | 13 | API Level 3.2.0 | Unknown precipitation |
| CONDITION_LIGHT_RAIN | 14 | API Level 3.2.0 | Light rain |
| CONDITION_HEAVY_RAIN | 15 | API Level 3.2.0 | Heavy rain |
| CONDITION_LIGHT_SNOW | 16 | API Level 3.2.0 | Light snow |
| CONDITION_HEAVY_SNOW | 17 | API Level 3.2.0 | Heavy snow |
| CONDITION_LIGHT_RAIN_SNOW | 18 | API Level 3.2.0 | Light rain snow |
| CONDITION_HEAVY_RAIN_SNOW | 19 | API Level 3.2.0 | Heavy rain snow |
| CONDITION_CLOUDY | 20 | API Level 3.2.0 | Cloudy |
| CONDITION_RAIN_SNOW | 21 | API Level 3.2.0 | Rain snow |
| CONDITION_PARTLY_CLEAR | 22 | API Level 3.2.0 | Partly clear |
| CONDITION_MOSTLY_CLEAR | 23 | API Level 3.2.0 | Mostly clear |
| CONDITION_LIGHT_SHOWERS | 24 | API Level 3.2.0 | Light showers |
| CONDITION_SHOWERS | 25 | API Level 3.2.0 | Showers |
| CONDITION_HEAVY_SHOWERS | 26 | API Level 3.2.0 | Heavy showers |
| CONDITION_CHANCE_OF_SHOWERS | 27 | API Level 3.2.0 | Chance of showers |
| CONDITION_CHANCE_OF_THUNDERSTORMS | 28 | API Level 3.2.0 | Chance of thunderstorms |
| CONDITION_MIST | 29 | API Level 3.2.0 | Mist |
| CONDITION_DUST | 30 | API Level 3.2.0 | Dust |
| CONDITION_DRIZZLE | 31 | API Level 3.2.0 | Drizzle |
| CONDITION_TORNADO | 32 | API Level 3.2.0 | Tornado |
| CONDITION_SMOKE | 33 | API Level 3.2.0 | Smoke |
| CONDITION_ICE | 34 | API Level 3.2.0 | Ice |
| CONDITION_SAND | 35 | API Level 3.2.0 | Sand |
| CONDITION_SQUALL | 36 | API Level 3.2.0 | Squall |
| CONDITION_SANDSTORM | 37 | API Level 3.2.0 | Sandstorm |
| CONDITION_VOLCANIC_ASH | 38 | API Level 3.2.0 | Volcanic ash |
| CONDITION_HAZE | 39 | API Level 3.2.0 | Haze |
| CONDITION_FAIR | 40 | API Level 3.2.0 | Fair |
| CONDITION_HURRICANE | 41 | API Level 3.2.0 | Hurricane |
| CONDITION_TROPICAL_STORM | 42 | API Level 3.2.0 | Tropical storm |
| CONDITION_CHANCE_OF_SNOW | 43 | API Level 3.2.0 | Chance of snow |
| CONDITION_CHANCE_OF_RAIN_SNOW | 44 | API Level 3.2.0 | Chance of rain snow |
| CONDITION_CLOUDY_CHANCE_OF_RAIN | 45 | API Level 3.2.0 | Cloudy chance of rain |
| CONDITION_CLOUDY_CHANCE_OF_SNOW | 46 | API Level 3.2.0 | Cloudy chance of snow |
| CONDITION_CLOUDY_CHANCE_OF_RAIN_SNOW | 47 | API Level 3.2.0 | Cloudy chance of rain snow |
| CONDITION_FLURRIES | 48 | API Level 3.2.0 | Flurries |
| CONDITION_FREEZING_RAIN | 49 | API Level 3.2.0 | Freezing rain |
| CONDITION_SLEET | 50 | API Level 3.2.0 | Sleet |
| CONDITION_ICE_SNOW | 51 | API Level 3.2.0 | Ice snow |
| CONDITION_THIN_CLOUDS | 52 | API Level 3.2.0 | Thin clouds |
| CONDITION_UNKNOWN | 53 | API Level 3.2.0 | Unknown |

## Instance Method Summary
- **getCurrentConditions**() as Weather.CurrentConditions or **Null** Get the most recently cached weather conditions.
- **getDailyForecast**() as Lang.Array or **Null** Get the daily forecast.
- **getHourlyForecast**() as Lang.Array or **Null** Get the hourly forecast.
- **getSunrise**(location as Position.Location, date as Time.Moment) as Time.Moment or **Null** Get sunrise time for the provided location and date.
- **getSunset**(location as Position.Location, date as Time.Moment) as Time.Moment or **Null** Get sunrise time for the provided location and date.

## Instance Method Details

### `getCurrentConditions() as Weather.CurrentConditions or Null`

Get the most recently cached weather conditions

**Returns:**
- Weather.CurrentConditions — or `null` if no data is available

**Since:** API Level 3.2.0

### `getDailyForecast() as Lang.Array or Null`

Get the daily forecast

**Returns:**
- Weather.DailyForecast — An array of daily forecasts or `null` if no data is available

**Since:** API Level 3.2.0

### `getHourlyForecast() as Lang.Array or Null`

Get the hourly forecast

**Returns:**
- Weather.HourlyForecast — An array of hourly forecasts or `null` if no data is available

**Since:** API Level 3.2.0

### `getSunrise(location as Position.Location, date as Time.Moment) as Time.Moment or Null`

Get sunrise time for the provided location and date

**Parameters:**
- location — (Position.Location) — Location to get the sunrise information
- date — (Time.Moment) — date to get the sunrise information

_Supported on 116 devices._

**Returns:**
- Time.Moment — Sunrise time as moment or `null` if no sunrise time is available

**Since:** API Level 3.3.0

### `getSunset(location as Position.Location, date as Time.Moment) as Time.Moment or Null`

Get sunrise time for the provided location and date

**Parameters:**
- location — (Position.Location) — Location to get the sunset information
- date — (Time.Moment) — date to get the sunset information

_Supported on 116 devices._

**Returns:**
- Time.Moment — Sunset time as moment or `null` if no sunset time is available.

**Since:** API Level 3.3.0


---

# Class: Toybox.Weather.CurrentConditions

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Weather.CurrentConditions

## Overview

Represents the most recently cached weather conditions.

**Since:** API Level 3.2.0

## Instance Member Summary
- **cloudCover** as Lang.Number or **Null** The cloud cover [0-100%].
- **condition** as Lang.Number or **Null** The current weather condition.
- **dewPoint** as Lang.Float or **Null** The dew point in Celsius.
- **feelsLikeTemperature** as Lang.Float or **Null** The wind chill or heat index, in Celsius.
- **highTemperature** as Lang.Numeric or **Null** The forecasted high temperature for the day in Celsius.
- **lowTemperature** as Lang.Numeric or **Null** The forecasted low temperature for the day in Celsius.
- **observationLocationName** as Lang.String or **Null** deprecated Textual description of the observation location.
- **observationLocationPosition** as Position.Location or **Null** Location where the conditions were observed.
- **observationTime** as Time.Moment or **Null** UTC time the conditions were observed.
- **precipitationChance** as Lang.Number or **Null** The chance of precipitation [0-100%].
- **pressure** as Lang.Float or **Null** The air pressure in Pascals (Pa).
- **relativeHumidity** as Lang.Number or **Null** The relative humidity [0-100%].
- **temperature** as Lang.Numeric or **Null** The current temperature in Celsius.
- **uvIndex** as Lang.Float or **Null** The UV index [0-10].
- **visibility** as Lang.Float or **Null** The visibility distance in meters.
- **windBearing** as Lang.Number or **Null** The wind bearing in degrees.
- **windSpeed** as Lang.Float or **Null** The current wind speed in meters per second.

## Instance Attribute Details

### `var cloudCover as Lang.Number or Null` The cloud cover [0-100%] **Since:** API Level 5.1.0 **Returns:** - Lang.Number — or `null`

### `var condition as Lang.Number or Null` The current weather condition **Since:** API Level 3.2.0 **Returns:** - Lang.Number — a Weather.CONDITION_* value

### `var dewPoint as Lang.Float or Null` The dew point in Celsius **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var feelsLikeTemperature as Lang.Float or Null` The wind chill or heat index, in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Float — or `null`

### `var highTemperature as Lang.Numeric or Null` The forecasted high temperature for the day in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var lowTemperature as Lang.Numeric or Null` The forecasted low temperature for the day in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var observationLocationName as Lang.String or Null` **This has been deprecated** This value may be removed after System 11. Textual description of the observation location. If the app does not have the position permission or the underlying weather provider does not provide a location name, this will be `null`. **Since:** API Level 3.2.0 **Returns:** - Lang.String — or `null`.

### `var observationLocationPosition as Position.Location or Null` Location where the conditions were observed. If the app does not have the position permission then this will be `null`. **Since:** API Level 3.2.0 **Returns:** - Position.Location — or `null`

### `var observationTime as Time.Moment or Null` UTC time the conditions were observed **Since:** API Level 3.2.0 **Returns:** - Time.Moment

### `var precipitationChance as Lang.Number or Null` The chance of precipitation [0-100%] **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var pressure as Lang.Float or Null` The air pressure in Pascals (Pa) **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var relativeHumidity as Lang.Number or Null` The relative humidity [0-100%] **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var temperature as Lang.Numeric or Null` The current temperature in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var uvIndex as Lang.Float or Null` The UV index [0-10] **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var visibility as Lang.Float or Null` The visibility distance in meters **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var windBearing as Lang.Number or Null` The wind bearing in degrees. North = 0, East = 90, South = 180, West = 270 **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var windSpeed as Lang.Float or Null` The current wind speed in meters per second **Since:** API Level 3.2.0 **Returns:** - Lang.Float — or `null`


---

# Class: Toybox.Weather.HourlyForecast

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Weather.HourlyForecast

## Overview

Represents the forecast for a given hour

**Since:** API Level 3.2.0

## Instance Member Summary
- **cloudCover** as Lang.Number or **Null** The cloud cover [0-100%].
- **condition** as Weather.Condition or **Null** The weather condition.
- **dewPoint** as Lang.Float or **Null** The dew point in Celsius.
- **forecastTime** as Time.Moment or **Null** The time the forecast is valid in UTC time.
- **precipitationChance** as Lang.Number or **Null** The chance of precipitation [0-100%].
- **relativeHumidity** as Lang.Number or **Null** The relative humidity [0-100%].
- **temperature** as Lang.Numeric or **Null** The current temperature in Celsius.
- **uvIndex** as Lang.Float or **Null** The UV index [0-10].
- **windBearing** as Lang.Number or **Null** The wind bearing in degrees.
- **windSpeed** as Lang.Float or **Null** The current wind speed in meters per second.

## Instance Attribute Details

### `var cloudCover as Lang.Number or Null` The cloud cover [0-100%] **Since:** API Level 5.1.0 **Returns:** - Lang.Number — or `null`

### `var condition as Weather.Condition or Null` The weather condition **Since:** API Level 3.2.0 **Returns:** - Weather.Condition — a Weather.CONDITION_* value

### `var dewPoint as Lang.Float or Null` The dew point in Celsius **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var forecastTime as Time.Moment or Null` The time the forecast is valid in UTC time **Since:** API Level 3.2.0 **Returns:** - Time.Moment

### `var precipitationChance as Lang.Number or Null` The chance of precipitation [0-100%] **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var relativeHumidity as Lang.Number or Null` The relative humidity [0-100%] **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var temperature as Lang.Numeric or Null` The current temperature in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var uvIndex as Lang.Float or Null` The UV index [0-10] **Since:** API Level 5.1.0 **Returns:** - Lang.Float — or `null`

### `var windBearing as Lang.Number or Null` The wind bearing in degrees. North = 0, East = 90, South = 180, West = 270 **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`

### `var windSpeed as Lang.Float or Null` The current wind speed in meters per second **Since:** API Level 3.2.0 **Returns:** - Lang.Float — or `null`


---

# Class: Toybox.Weather.DailyForecast

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Weather.DailyForecast

## Overview

Represents the forecast for a given day.

**Since:** API Level 3.2.0

## Instance Member Summary
- **condition** as Weather.Condition or **Null** The weather condition.
- **forecastTime** as Time.Moment or **Null** The time the forecast is valid in UTC time.
- **highTemperature** as Lang.Numeric or **Null** The high temperature in Celsius.
- **lowTemperature** as Lang.Numeric or **Null** The low temperature in Celsius.
- **precipitationChance** as Lang.Number or **Null** The chance of precipitation [0-100%].

## Instance Attribute Details

### `var condition as Weather.Condition or Null` The weather condition **Since:** API Level 3.2.0 **Returns:** - Weather.Condition — a Weather.CONDITION_* value

### `var forecastTime as Time.Moment or Null` The time the forecast is valid in UTC time **Since:** API Level 3.2.0 **Returns:** - Time.Moment

### `var highTemperature as Lang.Numeric or Null` The high temperature in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var lowTemperature as Lang.Numeric or Null` The low temperature in Celsius **Since:** API Level 3.2.0 **Returns:** - Lang.Numeric — or `null`

### `var precipitationChance as Lang.Number or Null` The chance of precipitation [0-100%] **Since:** API Level 3.2.0 **Returns:** - Lang.Number — or `null`
