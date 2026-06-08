---
source: https://developer.garmin.com/connect-iq/core-topics/sensors/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Sensors.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Sensors

The Toybox.Sensor module allows the app to enable and receive information from Garmin ANT+ sensors. To receive information, a listener method must be assigned and the sensors enabled:

```
function initialize() {
    Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
    Sensor.enableSensorEvents( method( :onSensor ) );
}

function onSensor(sensorInfo as Sensor.Info) as Void {
    System.println( "Heart Rate: " + sensorInfo.heartRate );
}
```

Sensor information is packaged in the Sensor.Info object:

| Sensor Type | API | Units | API Level |
| --- | --- | --- | --- |
| Accelerometer | Info.accel | Array of x,y,z values in millig-units. | 1.2.0 |
| Altitude | Info.altitude | Altitude above mean sea level in meters (m). | 1.0.0 |
| Cadence | Info.cadence | Revolutions per minute (rpm). | 1.0.0 |
| Heading | Info.heading | True north in radians. | 1.0.0 |
| Heart Rate | Info.heartRate | Beats per minute (bpm). | 1.0.0 |
| Magnetometer | Info.mag | Array of x,y,z values in milliGauss. | 1.2.0 |
| Oxygen Saturation | Info.oxygenSaturation | The current oxygen saturation in percent (%). | 3.2.0 |
| Power | Info.power | Watts. | 1.0.0 |
| Pressure | Info.pressure | The barometric pressure in Pascals.1 | 1.0.0 |
| Temperature | Info.temperature | Degrees Celsius (C). | 1.0.0 |

The simulator can simulate sensor data via the *Simulation* menu by selecting *Fit Data* > *Simulate Data*. This generates valid but random values that can be read in via the sensor interface. For more accurate simulation, the simulator can play back a FIT file and feed the input into the Toybox.Sensor module. To do this, select *Simulation* > *Fit Data* > *Playback File* and choose a FIT file from the dialog.

For more, see the `AccelMag` and `Sensor` sample apps distributed with the SDK.

## High Frequency Data

*Since API level 2.3.0*

The Toybox.Sensor module contains the ability to fetch samples of accelerometer data for a defined period of time with a certain frequency. This feature enables developers to implement their own custom motion detection algorithms within a Connect IQ application.

Accelerometer data can be obtained by registering a sensor data listener, which provides sampling parameters as well as a user-defined callback method that will be executed when new data is available. Sensor data requests are managed via the following Toybox.Sensor module methods and classes:

| Class or Function | Purpose | API Level |
| --- | --- | --- |
| Sensor.SensorData | Wrapper for high frequency sensor data | 2.3.0 |
| Sensor.AccelerometerData | Wrapper for accelerometer information | 2.3.0 |
| Sensor.GyroscopeData | Wrapper for gyroscope information | 3.3.0 |
| Sensor.MagnetometerData | Wrapper for magnetometer information | 3.3.0 |
| Sensor.registerSensorDataListener() | Register a callback to fetch data from various sensors | 2.3.0 |
| Sensor.unregisterSensorDataListener() | Deregister a previously registered data request | 2.3.0 |
| Sensor.getMaxSampleRate() | Get the maximum sample rate supported by the system | 2.3.0 |

Calling Sensor.registerSensorDataListener() will enable your application to receive accelerometer data via the callback that you provide. The type and amount of data provided is configured via the options dictionary parameter, which supports the following fields:

| Option | Description |
| --- | --- |
| `:period` | A Lang.Number representing the period of time to request samples in seconds. Maximum is 4 seconds. |
| `:sampleRate` | A Lang.Number representing the samples per second in Hz. Use Sensor.getMaxSampleRate() to determine what the system can support. |
| `:accelerometer` | Options for the accelerometer (see below) |
| `:heartBeatIntervals` | Options for beat to beat intervals (see below) |
| `:gyroscope` | Options for beat to beat intervals (see below) |
| `:magnetometer` | Options for beat to beat intervals (see below) |

The `:accelerometer`, `:heartBeatIntervals`, `:gyroscope`, and `:magnetometer` options allow the following:

| Option | Applicable To | Description |
| --- | --- | --- |
| `:enabled` | `:accelerometer`, `:heartBeatIntervals`, `:gyroscope`, `:magnetometer` | Set to `true` to enable the sensor |
| `:sampleRate` | `:accelerometer`, `:gyroscope`, `:magnetometer` | A Lang.Number representing the samples per second in Hz. Use `getMaxSampleRate()` to determine what the system can support. |
| `:includePower` | `:accelerometer` | Requests that the power array be computed. Default false |
| `:includePitch` | `:accelerometer` | Requests that pitch array be computed. Default false |
| `:includeRoll` | `:accelerometer` | Requests that roll array be computed. Default false |

Additionally, you must provide a callback method that accepts a single parameter, which is invoked by the system when new data is available. This method is passed a Sensor.SensorData object populated with the requested sensor data. Note that only a single sensor data request can be active at any given time, so if you wish to submit a request while an existing one is active, you must first call Sensor.unregisterSensorDataListener(). After Sensor.registerSensorDataListener() is called, the callback that you provided will be invoked whenever a new set of samples are available. For example, if you request four seconds worth of data at 25Hz, the callback will be invoked every 100 samples taken.

A simplified usage example can be found below:

```
using Toybox.Sensor;

class MyAccelHistoryClass
{
    private var _samplesX = null;
    private var _samplesY = null;
    private var _samplesZ = null;

    // Initializes the view and registers for accelerometer data
    public function enableAccel() as Void {
        var maxSampleRate = Sensor.getMaxSampleRate();

         // initialize accelerometer to request the maximum amount of data possible
        var options = {:period => 4000, :sampleRate => maxSampleRate, :enableAccelerometer => true};
        try {
            Sensor.registerSensorDataListener(method(:accelHistoryCallback), options);
        }
        catch(e) {
            System.println(e.getErrorMessage());
        }
    }

    // Prints acclerometer data that is recevied from the system
    public function accelHistoryCallback(sensorData as SensorData) as Void {
        _samplesX = sensorData.accelerometerData.x;
        _samplesY = sensorData.accelerometerData.y;
        _samplesZ = sensorData.accelerometerData.z;

        System.println("Raw samples, X axis: " + _samplesX);
        System.println("Raw samples, Y axis: " + _samplesY);
        System.println("Raw samples, Z axis: " + _samplesZ);
    }

    public function disableAccel() as Void {
        Sensor.unregisterSensorDataListener();
    }
}
```

For more, see the `PitchCounter` sample app distributed with the SDK.

### Filtering Accelerometer Data

When processing accelerometer data, you may wish to apply filters to the raw sensor input that your application receives. IIR and FIR filter objects are provided to aid the developer in sample filtering. The following new objects have been added to the Math module:

| Class | Purpose | API Level |
| --- | --- | --- |
| Math.FirFilter | Create a FIR filter that can be applied to a sample array | 2.3.0 |
| Math.IirFilter | Create a IIR filter that can be applied to a sample array | 2.3.0 |

Each filter class requires coefficients to be provided, which is done via the dictionary parameter. The options supported by each filter class are as follows:

**FIR Filter**

| Option | Description |
| --- | --- |
| `:coefficients` | An array of float values that specify the filter coefficients. This can also be a resource ID referring to an embedded JSON resource that defines the array of values. |
| `:gain` | A float value that specifies a multiplier to be applied to the coefficients. |

**IIR Filter**

| Option | Description |
| --- | --- |
| `:coefficientList1` | An array of float values that specify the filter coefficients. This can also be a resource ID referring to an embedded JSON resource that defines the array of values. |
| `:coefficientList2` | An array of float values that specify the filter coefficients. This can also be a resource ID referring to an embedded JSON resource that defines the array of values. |
| `:gain` | A float value that specifies a multiplier to be applied to the coefficients. |

Once the filter object has been constructed, the apply function can be called, passing in an array of samples, and an array containing the filtered results will be returned.

A simplified usage example can be found below (for a more detailed sample see the `PitchCounter` sample app distributed with the SDK).

```
using Toybox.Sensor;

class MyAccelHistoryClass
{
    hidden var mFilter = null;
    hidden var mSamplesX = null;
    hidden var mSamplesY = null;
    hidden var mSamplesZ = null;

    function initialize() {
        mFilter = new Sensor.FirFilter({:coefficients=>[0.22,0.12,0.55], :gain=>1.2);
    }
    // Initializes the view and registers for accelerometer data
    function enableAccel() {
        var maxSampleRate = Sensor.getMaxSampleRate();

         // initialize accelerometer to request the maximum amount of data possible
        var options = {:period => 4000, :sampleRate => maxSampleRate, :enableAccelerometer => true};
        try {
            Sensor.registerSensorDataListener(method(:accelHistoryCallback), options);
        }
        catch(e) {
            System.println(e.getErrorMessage());
        }
    }

    // Prints acclerometer data that is recevied from the system
    function accelHistoryCallback(sensorData) {
        mSamplesX = mFilter.apply(sensorData.accelerometerData.x);
        mSamplesY = sensorData.accelerometerData.y;
        mSamplesZ = sensorData.accelerometerData.z;

        Toybox.System.println("Filtered samples, X axis: " + mSamplesX);
        Toybox.System.println("Raw samples, Y axis: " + mSamplesY);
        Toybox.System.println("Raw samples, Z axis: " + mSamplesZ);
    }

    function disableAccel() {
        Sensor.unregisterSensorDataListener();
    }
}
```

### Logging Accelerometer Data

Accelerometer data can also be logged by the device, and can be played back in the simulator for testing applications that use the Accelerometer Data feature. Logging accelerometer data is done by passing a SensorLogging.SensorLogger object to a FIT recording session.

The SensorLogging.SensorLogger object with the same options provided to the Sensor.registerSensorDataListener() method. However, the logger will always record at a standard rate for consumption by the simulator.

A simplified usage example can be found below (for a more detailed sample see the `samples/PitchCounter` sample app distributed with the SDK).

```
import Toybox.SensorLogging;

class LoggingController {
    private var _logger as SensorLogger;
    private var _session as Session;

    public function initialize() {
        _logger = new SensorLogging.SensorLogger({:enableAccelerometer => true});
        _session = Fit.createSession({:name=>"mySession", :sport=>Fit.SPORT_GENERIC, :sensorLogger => mLogger});
    }

    public function startLogging() {
        _session.start();
    }

    public function stopLogging() {
        _session.stop();
    }

    public function saveLogging() {
        _session.save();
    }
}
```

## Weather

*Since API level 3.2.0*

Many Garmin devices have access to current weather conditions that are updated every 15 minutes. This information requires that the device has access to a data connection, primarily via a paired smartphone. Weather information is not available in all areas of the world.

Connect IQ provides the following ways to access this information:

| Function | Purpose | API Level |
| --- | --- | --- |
| Weather.getCurrentConditions() | Get the most recently cached weather conditions | 3.2.0 |
| Weather.getDailyForecast() | Get the daily forecast | 3.2.0 |
| Weather.getHourlyForecast() | Get the hourly forecast | 3.2.0 |
| Weather.getSunrise() | Get the sunrise for a given location | 3.3.0 |
| Weather.getSunset() | Get the sunset for a given location | 3.3.0 |

Be aware that the user is allowed to choose a specific location for weather updates besides their current location. You cannot assume that the weather conditions returned are the weather conditions for your current location.

1 Not to be confused with the Pedropascals used as a measure of "cool". This author measures 20 picoPedropascals.
