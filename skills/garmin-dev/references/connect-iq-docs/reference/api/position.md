---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Position.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Position.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Position

## Overview

The Position module provides an interface for location information and positioning sensors.

This module also provides two sets of constants:

- **GEO:** Used to specify the Location formatting.
- **QUALITY:** Represents the GPS fix quality when the Location information was calculated

**Example:**
```
using Toybox.Position;
using Toybox.System;
Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
function onPosition(info) {
    var myLocation = info.position.toDegrees();
    System.println("Latitude: " + myLocation[0]); // e.g. 38.856147
    System.println("Longitude: " + myLocation[1]); // e.g -94.800953
}
```

**Since:** API Level 1.0.0

## Classes Under Namespace

**Classes:** Info, Location

## Constant Summary

### Constellation

 **This has been deprecated**

This enum may be removed after System 10.

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONSTELLATION_GPS | 0 | API Level 3.2.0 | Use the GPS satellite constellation |
| CONSTELLATION_GLONASS | 1 | API Level 3.2.0 | Use the GLONASS satellite constellation |
| CONSTELLATION_GALILEO | 2 | API Level 3.2.0 | Use the GALILEO satellite constellation |

### Configuration

Configuration values for known GNSS configurations

**Since:** API Level 3.3.6

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONFIGURATION_GPS | 1 | API Level 3.3.6 | GPS L1 |
| CONFIGURATION_GPS_GLONASS | 2 | API Level 3.3.6 | GPS L1 and GLONASS |
| CONFIGURATION_GPS_GALILEO | 3 | API Level 3.3.6 | GPS L1 and GALILEO L1 |
| CONFIGURATION_GPS_BEIDOU | 4 | API Level 3.3.6 | GPS L1 and BEIDOU L1 |
| CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1 | 5 | API Level 3.3.6 | GPS L1, GLONASS, GALILEO L1, BEIDOU L1 This option is supported by System 6 devices like fenix7 and edge1040 |
| CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5 | 6 | API Level 3.3.6 | GPS L1, GPS L5, GLONASS, GALILEO L1A, GALILEO L5, BEIDOU L1, BEIDOU L5 Referred to as Multi-GNSS Multi-band on Edge 1040. This option is supported by System 6 devices like fenix7 and edge1040 |
| CONFIGURATION_SAT_IQ | 255 | API Level 3.3.6 | AutoGNSS (SatIQ™) |

### CoordinateFormat

**Since:** API Level 1.0.0

| Name | Value | Since | Description | See Also |
| --- | --- | --- | --- | --- |
| GEO_DEG | 0 | API Level 1.0.0 | The decimal degree format: ddd.dddddd (e.g. 38.278652) | Decimal Degrees |
| GEO_DM | 1 | API Level 1.0.0 | The degrees/decimal minutes format: dddmm.mmm (e.g 38 27.865') |  |
| GEO_DMS | 2 | API Level 1.0.0 | degrees/minutes/seconds (DMS) format: ddd mm ss (e.g. 38 27' 8") |  |
| GEO_MGRS | 3 | API Level 1.0.0 | Military Grid Reference System, or MGRS (e.g. 4QFJ12345678) | Military Grid Reference System |

### Quality

**Since:** API Level 1.0.0

| Name | Value | Since | Description | See Also |
| --- | --- | --- | --- | --- |
| QUALITY_NOT_AVAILABLE | 0 | API Level 1.0.0 | GPS is not available |  |
| QUALITY_LAST_KNOWN | 1 | API Level 1.0.0 | The Location is based on the last known GPS fix. |  |
| QUALITY_POOR | 2 | API Level 1.0.0 | The Location was calculated with a poor GPS fix. Only a 2-D GPS fix is available, likely due to a limited number of tracked satellites. |  |
| QUALITY_USABLE | 3 | API Level 1.0.0 | The Location was calculated with a usable GPS fix. A 3-D GPS fix is available, with marginal HDOP (horizontal dilution of precision) | Dilution of Precision |
| QUALITY_GOOD | 4 | API Level 1.0.0 | The Location was calculated with a good GPS fix. A 3-D GPS fix is available, with good-to-excellent HDOP (horizontal dilution of precision). | Dilution of Precision |

### LocationAcquisitionType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| LOCATION_ONE_SHOT | 0 | API Level 1.0.0 | Enables a one-time Location acquisition |
| LOCATION_CONTINUOUS | 1 | API Level 1.0.0 | Enables continuous Location tracking |
| LOCATION_DISABLE | 2 | API Level 1.0.0 | Disables Location tracking |

### PositioningMode

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| POSITIONING_MODE_NORMAL | 0 | API Level 3.2.0 | Standard positioning mode used by default for fitness activities |
| POSITIONING_MODE_AVIATION | 1 | API Level 3.2.0 | Enable special mode for aviation use-cases that require support for higher altitudes. |

## Instance Method Summary
- **createBoundingBox**(locations as Lang.Array) as [ Position.Location, Position.Location ] or **Null** Create a bounding box from an array of Location objects.
- **enableLocationEvents**(options as { :acquisitionType as Position.LocationAcquisitionType, :constellations as Lang.Array, :configuration as Position.Configuration, :mode as Position.PositioningMode } or Position.LocationAcquisitionType, listener as **Null** or Lang.Method(loc as Position.Info) as **Void**) as **Void** Request a Location event.
- **getInfo**() as Position.Info Get the current Position.Info.
- **hasConfigurationSupport**(config as Position.Configuration) as Lang.Boolean Determines if the device supports a requested GPS configuration.
- **parse**(string as Lang.String, format as Position.CoordinateFormat) as Position.Location Convert a String to a Location object.

## Instance Method Details

### `createBoundingBox(locations as Lang.Array) as [ Position.Location, Position.Location ] or Null`

Create a bounding box from an array of Location objects.

**Parameters:**
- locations — (Lang.Array) — Array of Location objects.

**Returns:**
- Lang.Array — Array of Location objects that specify the bounds of the input array or `null` if the the input array is empty. The first element describes the top left corner, the second describes the bottom right.

**Since:** API Level 3.0.3

### `enableLocationEvents(options as { :acquisitionType as Position.LocationAcquisitionType, :constellations as Lang.Array, :configuration as Position.Configuration, :mode as Position.PositioningMode } or Position.LocationAcquisitionType, listener as Null or Lang.Method(loc as Position.Info) as Void) as Void`

Request a Location event.

Using this API requires enabling the Positioning Permission. Only Device Apps and Widgets may use this API.

Note:

Passing an options Dictionary is only supported with ConnectIQ 3.2.0 and later.

Note:

Passing the `:configuration` option is only supported with ConnectIQ 3.3.6 or later.

Note:

Multitasking: Location events will be disabled when app enters inacitve state, and re-enabled when is active again. These state changes are denoted by calls to AppBase.onActive() and AppBase.onInactive().

**Parameters:**
- options — (Lang.Number, Lang.Dictionary) — A LOCATION_* value or Toybox::Lang::Dictionary of options. :acquisitionType — (Position.LocationAcquisitionType) — A LOCATION_* enum value indicating the position acquisition type to use.
- :constellations — (Lang.Array) — An array of CONSTELLATION_* enum values specifying what constellations to enable. If not provided, CONSTELLATION_GPS will be used by default.
- :configuration — (Position.Configuration) — A CONFIGURATION_* value specifying what configuration to enable. Only available with ConnectIQ 3.3.6 and later.
- :mode — (Position.PositioningMode) — a POSITIONING_MODE_* value specifying the mode to use. If `null` POSITIONING_MODE_NORMAL will be used by default.

listener

 —

(
Lang.Method
)

 —

A reference to a listener method:

- Called when location updates are received
- Receives a Position.Info object

**Example:**
```
using Toybox.Position;

var options = {
    :acquisitionType => Position.LOCATION_CONTINUOUS
};

if (Position has :POSITIONING_MODE_AVIATION) {
    options[:mode] = Position.POSITIONING_MODE_AVIATION;
}

if (Position has :hasConfigurationSupport) {
    if (Position has :CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5) &&
       (Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5)) {
        options[:configuration] = Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5;
    } else if (Position has :CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1) &&
       (Position.hasConfigurationSupport(Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1)) {
        options[:configuration] = Position.CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1;
    } else if (Position has :CONFIGURATION_GPS) &&
       (Position.hasConfigurationSupport(Position.CONFIGURATION_GPS)) {
        options[:configuration] = Position.CONFIGURATION_GPS;
    }
} else if (Position has :CONSTELLATION_GLONASS) {
    // this can fail with InvalidValueException if combination is not supported by device
    options[:constellations] = [ Position.CONSTELLATION_GPS, Position.CONSTELLATION_GLONASS ];
} else {
    options = Position.LOCATION_CONTINUOUS;
}

// Continuous location updates using selected options
Position.enableLocationEvents(options, method(:onPosition));

function onPosition(info) {
    var myLocation = info.position.toDegrees();
}
```

_Supported on 162 devices._

**Since:** API Level 1.0.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if :acquisitionType is invalid, if a specific CONSTELLATION_* value is not supported by a device, or if an invalid combination of constellation values are specified.

### `getInfo() as Position.Info`

Get the current Position.Info.

Using this API requires enabling the Positioning Permission. This is useful for retrieving the current position info either on demand or periodically within a Timer.

**Example:**
Get position info once per second

```
using Toybox.Position;
using Toybox.System;
using Toybox.Timer;
var dataTimer = new Timer.Timer();
dataTimer.start(method(:timerCallback), 1000, true); // A one-second timer
function timerCallback() {
    var positionInfo = Position.getInfo();
    if (positionInfo has :altitude && positionInfo.altitude != null) {
        var altitude = positionInfo.altitude;
        System.println("Altitude: " + altitude);
    }
}
```

_Supported on 162 devices._

**Returns:**
- Position.Info

**Since:** API Level 1.0.0

### `hasConfigurationSupport(config as Position.Configuration) as Lang.Boolean`

Determines if the device supports a requested GPS configuration

**Parameters:**
- config — (Position.Configuration) — A CONFIGURATION_* enum value specifying what configuration to enable. Only available with ConnectIQ 3.3.6 and later.

_Supported on 111 devices._

**Since:** API Level 3.3.6

### `parse(string as Lang.String, format as Position.CoordinateFormat) as Position.Location`

Convert a String to a Location object.

The input String must be in one of the four formats described by the Position.GEO_* constants.

**Parameters:**
- string — (Lang.String) — The String to parse
- format — (Position.CoordinateFormat) — A Position.GEO_* value

**Example:**
```
using Toybox.Position;
using Toybox.System;
var locString = "38.856147, -94.800953";
var myLocation = Position.parse(locString, Position.GEO_DEG);
System.println(myLocation.toRadians()); // [0.678168, -1.654589]
```

**Returns:**
- Position.Location — A Location object representing the position described by the input String

**Since:** API Level 1.0.0


---

# Class: Toybox.Position.Location

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Position.Location

## Overview

The Location object represents a specific position.

Location objects provide methods for retrieving position coordinates in various formats.

**Since:** API Level 1.0.0

## Instance Method Summary
- **getProjectedLocation**(angle as Lang.Numeric, distance as Lang.Numeric) as Position.Location Get a Location object that is offset from the current position by a given distance and angle.
- **initialize**(options as { :latitude as Lang.Numeric, :longitude as Lang.Numeric, :format as Lang.Symbol }) Constructor Create a Location based on a set of coordinates.
- **toDegrees**() as [ Lang.Double, Lang.Double ] Get a Location object's coordinates in degrees.
- **toGeoString**(format as Position.CoordinateFormat) as Lang.String Get a String representation a Location object's coordinates.
- **toRadians**() as [ Lang.Double, Lang.Double ] Get a location object's coordinates in radians.

## Instance Method Details

### `getProjectedLocation(angle as Lang.Numeric, distance as Lang.Numeric) as Position.Location`

Get a Location object that is offset from the current position by a given distance and angle.

**Parameters:**
- angle — (Lang.Float) — The angle in radians from north.
- distance — (Lang.Float) — The distance from the current position in meters (m).

**Returns:**
- Position.Location — The projected location.

**Since:** API Level 3.0.0

### `initialize(options as { :latitude as Lang.Numeric, :longitude as Lang.Numeric, :format as Lang.Symbol })`

Constructor Create a Location based on a set of coordinates.

**Parameters:**
- options — (Lang.Array) — An Array of options :latitude — (Lang.Number) — The latitude
- :longitude — (Lang.Number) — The longitude
- :format — (Lang.Symbol) — The format of the provided latitude and longitude as one of three possible values: :degrees
- :radians
- :semicircles

**Example:**
```
using Toybox.Position;
var myLocation = new Position.Location(
    {
        :latitude => 38.856147,
        :longitude => -94.800953,
        :format => :degrees
    }
);
```

**Since:** API Level 1.0.0

### `toDegrees() as [ Lang.Double, Lang.Double ]`

Get a Location object's coordinates in degrees.

**Example:**
```
using Toybox.Position;
using Toybox.System;
Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));

function onPosition(info) {
    var myLocation = info.position.toDegrees();
    System.println(myLocation[0]); // latitude (e.g. 38.856147)
    System.println(myLocation[1]); // longitude (e.g -94.800953)
}
```

**Returns:**
- Lang.Array — An Array containing the latitude and longitude as Doubles in a degree format

**Since:** API Level 1.0.0

### `toGeoString(format as Position.CoordinateFormat) as Lang.String`

Get a String representation a Location object's coordinates.

**Parameters:**
- format — (Position.CoordinateFormat) — A Position.GEO_* value

**Example:**
```
using Toybox.Position;
using Toybox.System;
var myLocation = new Position.Location(
    {
        :latitude => 38.856147,
        :longitude => -94.800953,
        :format => :degrees
    }
);
var locString = myLocation.toGeoString(Position.GEO_DMS); // N 38 51'22.13" W 94 45' 3.44"
```

**Returns:**
- Lang.String — A formatted coordinate String in the specified format

**Since:** API Level 1.0.0

### `toRadians() as [ Lang.Double, Lang.Double ]`

Get a location object's coordinates in radians.

**Example:**
```
using Toybox.Position;
using Toybox.System;
Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));

function onPosition(info) {
    var myLocation = info.position.toRadians();
    System.println(myLocation[0]); // latitude (e.g. 0.678197)
    System.println(myLocation[1]); // longitude (e.g -1.654588)
}
```

**Returns:**
- Lang.Array — An Array containing latitude and longitude as Doubles in a radian format

**Since:** API Level 1.0.0


---

# Class: Toybox.Position.Info

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Position.Info

## Overview

The Position.Info class contains all of the information provided by the positioning system.

Position Info can be retrieved on every call of onUpdate() or it can be obtained on demand. Fields in this class may return `null` so should be checked for `null` values prior to use.

**Since:** API Level 1.0.0

_Supported on 162 devices._

## Instance Member Summary
- **accuracy** as Position.Quality The positional accuracy.
- **altitude** as Lang.Float or **Null** The elevation above mean sea level in meters (m).
- **heading** as Lang.Float or **Null** The true north referenced heading in radians.
- **position** as Position.Location or **Null** The latitude and longitude of the position.
- **speed** as Lang.Float or **Null** The horizontal speed in meters per second (mps).
- **when** as Time.Moment or **Null** The GPS time stamp of the obtained Location fix.

## Instance Attribute Details

### `var accuracy as Position.Quality` The positional accuracy. This is given as one of the following values: good, usable, poor, or not available, which corresponds with the Position.QUALITY_* constants. This cannot be `null`. **Since:** API Level 1.0.0 **Returns:** - Position.Quality — A Position.QUALITY_* value

### `var altitude as Lang.Float or Null` The elevation above mean sea level in meters (m). Elevation is obtained from the GPS. If no GPS is present, then no valid elevation will be returned. **Since:** API Level 1.0.0 **See Also:** - Meters above sea level **Returns:** - Lang.Float

### `var heading as Lang.Float or Null` The true north referenced heading in radians. This provides the direction of travel when moving. If supported by the device, it provides compass orientation when stopped. **Since:** API Level 1.0.0 **Returns:** - Lang.Float

### `var position as Position.Location or Null` The latitude and longitude of the position. If no GPS is available or is between GPS fix intervals (typically 1 second), the position is propagated (i.e. dead-reckoned) using the last known heading and last known speed. After a short period of time, the position will cease to be propagated to avoid excessive accumulation of position errors. **Since:** API Level 1.0.0 **Returns:** - Position.Location

### `var speed as Lang.Float or Null` The horizontal speed in meters per second (mps). Speed is derived from the most accurate source in the following order: 1. GPS 2. Foot pod 3. Accelerometer **Since:** API Level 1.0.0 **Returns:** - Lang.Float

### `var when as Time.Moment or Null` The GPS time stamp of the obtained Location fix. **Since:** API Level 1.0.0 **Returns:** - Time.Moment
