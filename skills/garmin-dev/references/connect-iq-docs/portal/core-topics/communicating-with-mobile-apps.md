---
source: https://developer.garmin.com/connect-iq/core-topics/communicating-with-mobile-apps/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Communicating_with_Mobile_Apps.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Communicating with Mobile Apps

There are a few complications with device-to-phone communication. For example, the watch app may be killed during the time communication happens, or a phone app may try to send information while the app is not active. In order to simplify these cases for the developer, Monkey C does not expose a low-level interface, but instead exposes a very high-level approach: the API exposes a mailbox metaphor instead of using a socket metaphor. Messages are constructed as a parcel of information and sent back and forth between devices. Each app will have a mailbox where messages are received, and an event that fires when new messages arrive.

## Mobile SDK Downloads

The Connect IQ Mobile SDKs are released separately from the Connect IQ Developer SDK and is available for iOS and Android. There are several editions of the Mobile SDK available:

- Android BLE
- iOS BLE
- Android ADB

The Bluetooth low energy edition supports development of communication-enabled applications on an iOS or Android target device while the Android Debug Bridge (ADB) edition is used for testing with the Connect IQ Simulator.

More information on how to download the correct version for your mobile platform may be found on the Garmin Developer site and the Mobile SDK for Android and Mobile SDK for iOS sections.

## BLE Simulation Over Android Debug Bridge

When using the Connect IQ Simulator, it is possible to communicate with a companion app running on an Android device using Android Debug Bridge. This will simulate actual Bluetooth low energy speeds to better approximate performance of your application.

The Android Debug Bridge edition of the Android Mobile SDK and companion app is required to use Android Debug Bridge for testing. Here's how to enable the companion to communicate over Android Debug Bridge:

1. Connect the phone to the PC running the simulator via USB
2. Have USB debugging enabled on the Android handset
3. Obtain an instance of ConnectIQ using `getInstance( IQCommProtocol.ADB_SIMULATOR )`
4. Optionally call `setAdbPort( int port )` to set a specific port to use for communication (the default port is 7381)
5. Call `initialize()`

To allow the simulator to communicate over Android Debug Bridge, forward the TCP port to the Android device in a terminal or console:

```
adb forward tcp:7381 tcp:7381
```

Note that this command will need to be reissued for each connected Android device, or if a device is disconnected and re-connected.

Once your app is started on the phone, connect it to the simulator by clicking the *Connection* menu and selecting *Start* (CTRL-F1). The Connect IQ apps in the simulator will now be able to communicate with your device via the Communications APIs over Android Debug Bridge.
