---
source: https://developer.garmin.com/connect-iq/core-topics/positioning/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Positioning.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Positioning

Monkey C provides access to the wearable's available sensors, which may include the GPS, altimeter, thermometer, and supported ANT sensors.

| API | Purpose | API Level |
| --- | --- | --- |
| Position.Location | Abstraction of a coordinate | 1.0.0 |
| Position.enableLocationEvents() | Allows enabling the GPS and receiving location update events to a callback.Requires the `Position` permission. | 1.0.0 |
| Position.getInfo() | Query the position information from the system | 1.0.0 |

## Location

A Position.Location is an abstraction of a coordinate. It exposes the ability to retrieve the coordinates in radians or decimal degrees and then provides a method to convert to coordinate formats supported by the Garmin system. The Toybox.Position module also exposes string parsing interface to convert from various coordinate formats to a Position.Location object.

## Location Events

To enable the GPS call the Position.enableLocationEvents() method. To register a position listener, use the Object.method() call to create a Lang.Method callback:

```
function onPosition( info as Position.Info ) as Void {
    Sys.println( "Position " + info.position.toGeoString( Position.GEO_DM ) );
}

function initializeListener() as Void {
    Position.enableLocationEvents( Position.LOCATION_CONTINUOUS, method( :onPosition ) );
}
```

All of the location information will be sent in an Position.Info object. You can also use Position.getInfo() to retrieve an Position.Info instance.

For more, see the `PositionSample` sample app distributed with the SDK.

### Multi-Band

There are times where you may want control over what positioning solution is used. The `:configuration` option of Position.enableLocationEvents() allows you to specify the which positioning solution you wish to use:

| Configuration | GPS Solution | API Level |
| --- | --- | --- |
| `CONFIGURATION_GPS` | GPS L1 | 3.3.6 |
| `CONFIGURATION_GPS_GLONAS` | GPS L1, GLONASS | 3.3.6 |
| `CONFIGURATION_GPS_GALILEO` | GPS L1, GALILEO L1 | 3.3.6 |
| `CONFIGURATION_GPS_BEIDOU` | GPS L1, BEIDOU L1 | 3.3.6 |
| `CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1` | GPS L1, GLONASS, GALILEO L1, BEIDOU L1 | 3.3.6 |
| `CONFIGURATION_GPS_GLONASS_GALILEO_BEIDOU_L1_L5` | GPS L1, GLONASS, GALILEO L1, BEIDOU L1, GPS L5, GALILEO L5, BEIDOU L5 | 3.3.6 |
| `CONFIGURATION_SAT_IQ` | Solution chosen dynamically for optimum power usage | 3.3.6 |

Not every device supports every GPS configuration. You can use Position.hasConfigurationSupport() to determine if the device supports a specific configuration.
