---
source: https://developer.garmin.com/connect-iq/core-topics/mobile-sdk-for-android/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Mobile_SDK_for_Android.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Mobile SDK for Android

The Mobile SDK allows you to create companion applications that run on a user's phone and interact with your application on their wearable device. This allows for a more feature rich user experience where doing certain tasks on the wearable device might be tedious or resource intensive.

## Adding the Mobile SDK to a project

The Mobile SDK is publicly available on Maven Central at ConnectIQ Companion App SDK. To include the AAR to your project add the following line to your build.gradle file

```
   implementation "com.garmin.connectiq:ciq-companion-app-sdk:<latest_version>@aar"
```

## Additional Requirements

In order for your companion application to communicate with a Connect IQ device the user must also install Garmin Connect Mobile onto their phone. All communication for companion applications running on Android goes through a Garmin Connect Mobile service to reach the device. When initializing the SDK with a wireless connection type this requirement is checked and initialization will fail if Garmin Connect Mobile is not installed. If true is passed to the auto UI parameter of initialize, a message is displayed to the user that they need to either install or upgrade Garmin Connect Mobile and provides them a way to go directly to the application in the Google Play Store. See `Displaying a UI message automatically when initialization fails` for more information.

## Interacting with the SDK

All interactions between the companion application and the Connect IQ application are done via the `ConnectIQ` class. To use this class you must first obtain an instance of the class and then initialize it.

```
  ConnectIQ connectIQ = ConnectIQ.getInstance(ConnectIQ.IQConnectType.<protocol>);
```

`ConnectIQ.IQConnectType` provides two options:

- WIRELESS - For communicating with the Connect IQ simulator or real device via BLE. This is the default.
- TETHERED - For communicating with the Connect IQ simulator over the Android Debug Bridge.

## Initializing the SDK

Initializing the SDK is an asynchronous process and requires a `ConnectIQListener` to handle returned states of the SDK. You must wait for the `onSdkReady()` call to be made before calling any additional API methods. Doing so beforehand will result in an `InvalidStateException`.

```
connectIQ.initialize(context, true, new ConnectIQListener() {

    // Called when the SDK has been successfully initialized
    @Override
    public void onSdkReady() {

        // Do any post initialization setup.
    }

    // Called when the SDK has been shut down

    @Override
    public void onSdkShutDown() {

        // Take care of any post shutdown requirements
    }

    // Called when initialization fails.
    @Override
    public void onInitializationError(IQSdkErrorStatus status) {

        // A failure has occurred during initialization. Inspect
        // the IQSdkErrorStatus value for more information regarding
        // the failure.
    }

});
```

## Displaying a UI message automatically when initialization fails

If initialization fails due to Garmin Connect Mobile not being installed on the user's phone or if it needs to be upgraded, a message can be displayed prompting the user to take action. You can tell the SDK to display this message automatically by passing true as the second parameter to the `initialize()` method. By default, the UI will display a dialog message to the user asking them to take action. The strings that make up the dialogs are by default English only strings. These strings are fully customizable by simply adding some predefined strings to your projects `strings.xml` file.

### Customizable Strings

- `install_needed_title` --- Dialog title for when Garmin Connect Mobile needs to be installed.
- `install_needed_message` --- Dialog message for when Garmin Connect Mobile needs to be installed.
- `install_needed_yes` --- Button text for user to confirm they want to visit the Google Play Store to install Garmin Connect Mobile.
- `install_needed_cancel` --- Button text for user to cancel the dialog and not install Garmin Connect Mobile.
- `upgrade_needed_title` --- Dialog title for when Garmin Connect Mobile needs to be upgraded to a version that supports the SDK.
- `upgrade_needed_message` --- Dialog message for when Garmin Connect Mobile needs to be upgraded to a version that supports the SDK.
- `upgrade_needed_yes` --- Button text for user to confirm they want to visit the Google Play Store to upgrade Garmin Connect Mobile.
- `upgrade_needed_cancel` --- Button text for a user to cancel the dialog and not upgrade Garmin Connect Mobile.

## Working with Devices

### Finding Connect IQ-compatible Devices

Before you can interact with a Connect IQ device, you must obtain a reference to an `IQDevice` object instance representing it. This is done by one of two methods.

`getKnownDevices()` will return a list of any Connect IQ device that has been paired within Garmin Connect Mobile. These devices may or may not be connected at the time the API is called.

```
List<IQDevice> paired = connectIQ.getKnownDevices();

if (paired != null && paired.size() > 0) {
    // get the status of the devices
    for (IQDevice device : paired) {
        IQDeviceStatus status = connectIQ.getStatus(device);
        if (status == IQDeviceStatus.CONNECTED) {
            // Work with the device
        }
    }
}
```

`getConnectedDevices()` will return a list of currently connected devices. Because these devices could become disconnected at any time, it is good practice to register to receive a notification when the device connects or disconnects. See the next section for more information.

```
List<IQDevice> devices = connectIQ.getConnectedDevices();

if (devices != null && devices.size() > 0) {

    // Work with devices.
}
```

### Listening for Device Events

You can request to be notified when the status of a device changes by calling `registerForDeviceEvents(IQDevice, IQDeviceEventListener)`. Once registered any device status change will call the `IQDeviceEventListener.onDeviceStatusChanged()` with the new status. When you no longer need to receive updates for a device, you should call `unregisterForDeviceEvents(IQDevice)` to release any associated resources.

```
// Register to receive status updates
connectIQ.registerForDeviceEvents(device, new IQDeviceEventListener() {

    @Override
    public void onDeviceStatusChanged(IQDevice device, IQDeviceStatus newStatus) {

        // Handle new status
    }
});

// Get the current status
IQDeviceStatus current = device.getStatus();

// Unregister when we no longer need status updates
connectIQ.unregisterForDeviceEvents(device);
```

#### Possible Device statuses

- `CONNECTED` --- The device is connected and can be communicated with.
- `NOT_CONNECTED` --- The device is paired with Garmin Connect Mobile but is not currently connected and cannot be communicated with.
- `NOT_PAIRED` --- The device is not paired with Garmin Connect Mobile and cannot be communicated with.

## Working with Apps

### Obtaining an Instance of IQApp

Apps are represented in the Mobile SDK as instances of the `IQApp` class. While you can create an `IQApp` instance on your own, it is recommended to obtain a fully populated `IQApp` instance via the `getApplicationInfo()` method. You can determine if your Connect IQ application is installed on the user's device by passing the Applications UUID, the `IQDevice`, and an `IQApplicationInfoListener` into a `getApplicationInfo()` call. `IQApplicationInfoListener.onApplicationInfoReceived( IQApp )` will be called if the application is installed on the watch, and `IQApplicationInfoListener.onApplicationNotInstalled( String )` if the app does not exist on the watch. `onApplicationInfoReceived` will be called with an IQApp object that can be inspected via the `getStatus()` method to determine the status of your application on the device. If the status is `INSTALLED`, the version number will also be populated so you can determine if the user has the latest version of your application.

```
connectIQ.getApplicationInfo(MY_APPLICATION_ID, device, new IQApplicationInfoListener() {
    @Override
    public void onApplicationInfoReceived( IQApp app ) {
        if (app != null) {
            if (app.getStatus() == INSTALLED) {
                if (app.getVersion() < MY_CURRENT_VERSION) {
                    // Prompt the user to upgrade
                }
            }
        }
    }
    @Override
    public void onAPplicationNotInstalled( String applicationId ) {
        // Prompt user with information
        AlertDialog.Builder dialog = new AlertDialog.Builder( this );
        dialog.setTitle( "Missing Application" );
        dialog.setMessage( "Corresponding IQ application not installed" );
        dialog.setPositiveButton( android.R.string.ok, null ); dialog.create().show();
    }
});
```

#### Possible Application Statuses

- INSTALLED --- The application is installed on the device and the version information has been populated.
- NOT_INSTALLED --- The application is not currently installed on the device but is supported.
- NOT_SUPPORTED --- The application is not installed on the device and is not supported by the device.

### Opening an App on the Device

You may wish to prompt the user to open a Connect IQ application on their device. To do this you can use the `openApplication` API. A response from the device will be returned to your `IQOpenApplicationListener`.

```
connectIQ.openApplication(device, app, new IQOpenApplicationListener() {

    @Override
    public void onOpenApplicationResponse(IQDevice device, IQApp app, IQOpenApplicationStatus status) {
        // Handle the response here
    }

});
```

#### Possible Open Application Statuses

- PROMPT_SHOWN_ON_DEVICE
- PROMPT_NOT_SHOWN_ON_DEVICE
- APP_IS_NOT_INSTALLED
- APP_IS_ALREADY_RUNNING
- UNKNOWN_FAILURE

### Opening the Connect IQ store

If the user does not have your applications installed (status of `NOT_INSTALLED`), or needs to upgrade to the latest version, you can open the Connect IQ store directly to your application. Simply call `openStore()` passing in a String containing the public UUID associated with your application in the store. Note, this will not work if you are using the TETHERED connection option.

```
connectIQ.openStore( MY_STORE_ID );
```

## Sending Messages

You can send messages to your Connect IQ application on a connected device using any of the Java equivalent Monkey C data types (see *Supported Data Types* table below). Calling `sendMessage()` will deliver the message to your applications mailbox.

```
List<Object> message = new ArrayList<String>() {"hello pi", 3.14159};

connectIQ.sendMessage(device, app, message, new IQSendMessageListener() {

    @Override
    public void onMessageStatus( IQDevice device, IQApp app, IQMessageStatus status ) {
        Toast.makeText( this, status.name(), Toast.LENGTH_LONG ).show();
        if (status != IQMessageStatus.SUCCESS) {
            // Evalute status for cause of the failure
        }
    }
});
```

## Receiving Messages

In order to receive data messages from a Connect IQ application, you must first register to receive application events. Once registered via `registerForAppEvents()`, when a new message arrives from the Connect IQ application, it will be delivered to the `onMessageReceived()` method of the listener passed when registering. When you no longer wish to receive incoming messages, you should call `unregisterForAppEvents()` to release any associated resources.

A companion app may register to receive messages from multiple apps across many devices. However, multiple companion apps cannot be registered to receive messages from the same ConnectIQ application. The SDK will override any previous registrations with each call to `registerForAppEvents()`.

```
// Register to receive messages from our application
connectIQ.registerForAppEvents(device, app, new IQApplicationEventListener() {

    @Override
    public void onMessageReceived(IQDevice device, IQApp app, List<Object> messageData, IQMessageStatus status) {
        // First inspect the status to make sure this
        // was a SUCCESS. If not then the status will indicate why there
        // was an issue receiving the message from the Connect IQ application.
        if (status == IQMessageStatus.SUCCESS) {
            // Handle the message.
        }
    }
});

// unregister when we no longer care about messages coming from our app.
connectIQ.unregisterForAppEvents(device, app);
```

## Supported Data Types

| Java Data Type | Monkey C Type | Notes |
| --- | --- | --- |
| int, Integer | Integer |  |
| long, Long | Integer, Long | If the value of the long is small enough to be represented as an integer, it will be converted to save space. |
| float, Float | Float |  |
| double, Double | Float, Double | If the value of the double is within 5 matching significant fractional digits of the nearest float, it will be converted to a float to save space. |
| boolean, Boolean | Boolean |  |
| char | Char |  |
| String | String |  |
| List<?> | Array | List must contain only supported data types. If the list contains unsupported data types, an exception will be thrown. |
| Map | Dictionary | Map keys and values must be supported data types. If the map contains unsupported data types, an exception will be thrown. |
