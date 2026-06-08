---
source: https://developer.garmin.com/connect-iq/core-topics/pairing-wireless-devices/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Pairing_Wireless_Devices.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Sensor Pairing

*Since API level 5.1.0*

If your device application or data field communicates wirelessly with a sensor or peripheral using ANT, ANT plus or Bluetooth Low Energy (BLE), then you will need to implement a pairing process. Connect IQ allows you to implement a Sensor.SensorDelegate that allows you to have your device pair as part of the device’s sensor paring UI flow.

## Implementing a SensorDelegate

For the system to know that your device application or data field supports the native pairing flow, you will need your AppBase.getSensorDelegate() to return your implementation of your Sensor.SensorDelegate. In your delegate, your implementation of must return `true` to participate in a scan.

## Scanning for Your Device

When the user has the device scan for sensors, the system will start your app without a UI, request your sensor delegate and call your SensorDelegate.onScan(). During this time, you can begin scanning for ANT or BLE devices.

If your scan reveals any devices, populate a Sensor.SensorInfo with the information and call Sensor.notifyNewSensor() for each device you detect. When your scan is complete, call to inform the system that you are done scanning. Since other apps also may need to scan for devices, use a realistic timeout, and notify quickly if no devices are detected.

## Pairing a Device

The user will be presented with a list of devices to choose from. If a device associated with your app is selected, your Sensor.SensorDelegate will be re-instantiated, and the SensorDelegate.onPair() will be called with the Sensor.SensorInfo passed as a parameter. At this point, your app should do the necessary steps to pair the device. On ANT, this could be as simple as capturing the device id and persisting it, or with BLE it could involve persisting the ScanResult or establishing a bonded connection. Call Sensor.notifyPairComplete() to complete the process.

## Unpairing a Device

Once your device is paired, it can be managed in the device Sensors list. The user can request that the system unpair from a device, as well. When requested, your SensorDelegate.onUnpair() will be invoked. Do the necessary cleanup and call Sensor.notifyUnpairComplete() to complete the process.

## Pairing with Your Data Field or Application

If you add support for the native pairing flow, users will be prompted to pair with your sensor when the data field is installed. Applications typically want to pair devices as part of a setup flow. You can use `System.exitTo(new Intent("system://pairing", {}))` to exit the user to the native sensor scanning process.

## Testing in the Simulator

If you’d like to test your pairing code in the Connect IQ simulator, use the *Settings > Manage Sensors* option. Using the *Add* button will trigger your Sensor.SensorDelegate.

## Running app in sensor pairing mode from the Monkey C Extension

You can run and debug your pairing code in the Monkey C Extension by using the `Launch Native Pairing` command or run it with or without debugging via the `Run Native Pairing` launch configuration. For more information, see Running App in Sensor Pairing Mode.

## Running app in sensor pairing from the Command Line

You can use the `monkeydo` script in your SDK's bin directory with the `/n` flag(`-n` on Mac) to run the app in sensor pairing mode:

```
> monkeydo path\to\projects\bin\MyApp.prg device_id /n
```

For more information, see Basic Commands.

| API | Description | API Level |
| --- | --- | --- |
| AppBase.getSensorDelegate() | Returns the implementation of a sensor delegate. Implement this method to communicate your app supports the native pairing flow. | 5.1.0 |
| SensorDelegate.onScan() | Scan for devices supported by your app. | 5.1.0 |
| SensorDelegate.onPair() | Complete the pairing process for a specific device. | 5.1.0 |
| SensorDelegate.onUnpair() | Unpair a specific device from your app. | 5.1.0 |
|  | Tell the system your app has completed a scan. | 5.1.0 |
| Sensor.notifyPairComplete() | Tell the system your app has completed pairing a device | 5.1.0 |
| Sensor.notifyUnpairComplete() | Tell the system your app has completed unpairing a device | 5.1.0 |
