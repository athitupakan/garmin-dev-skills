---
source: https://developer.garmin.com/connect-iq/core-topics/ant-and-ant-plus/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Ant_and_Ant_Plus.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# ANT and ANT+

The Sensor module of Connect IQ gives developers access to the built-in and paired sensors of the device. Connect IQ also provides access to the available ANT channels as well. This allows developers to communicate with sensors not supported by Garmin. Using the FIT recording system those metrics can be recorded to the Activity file and uploaded to Garmin Connect.

Learn more about ANT and ANT+ at thisisant.com

| API | Purpose | API Level |
| --- | --- | --- |
| Toybox.Ant | Provides access to generic ANT channels. These allow direct communication between your app and an ANT device | 1.0.0 |
| Toybox.AntPlus | Allows access to ANT devices paired with the device. | 2.2.0 |

## Generic ANT Channels

Connect IQ provides a low level interface for communication with ANT and ANT+ sensors. With this interface, an ANT channel can be created to send and receive ANT packets.

With an ANT USB dongle you can use Connect IQ ANT APIs in the Connect IQ Simulator. Note that Garmin Express will block access to the ANT USB dongle if it is running, so make sure to shut down Garmin Express when using the ANT USB dongle with the Connect IQ simulator.

### Using ANT stick in Linux

In order to use ANT stick in Linux the usb device should be accessible to the simulator. A udev rule must be installed in the system for the ANT stick to populate with non-root privileges.

Find the vendor and product id for the ANT stick

```
$ lsusb
```

Identify the ANT stick in the list and its vendor and product id. example:

```
Bus 001 Device 009: ID 0fcf:1009 Dynastream Innovations, Inc. ANTUSB-m Stick
```

Create a udev rule for this device

```
$ sudo touch /etc/udev/rules.d/50-connectiq-usbant.rules
$ sudo nano /etc/udev/rules.d/50-connectiq-usbant.rules
```

Then add the line below to the file and save the changes: CTRL-x

```
ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0fcf", ATTRS{idProduct}=="1009", MODE="664", GROUP="plugdev"
```

Restart the udev service and plug the ANT stick

```
$ sudo /etc/init.d/udev restart
```

Add yourself to the 'plugdev' group

```
$ sudo usermod -a -G plugdev <userName>
```

## Communicating with a Tempe Sensor

The Environment Profile is supported by sensors like the Garmin tempe™ wireless environment sensor and makes it possible to read the minimum, maximum and current temperature.

We can initialize an ANT channel to a tempe sensor with the following:

```
    // Constructor
    function initialize() {
        // Get the channel
        chanAssign = new Ant.ChannelAssignment(
            Ant.CHANNEL_TYPE_RX_NOT_TX,
            Ant.NETWORK_PLUS);
        GenericChannel.initialize(method(:onMessage), chanAssign);

        // Set the configuration
        deviceCfg = new Ant.DeviceConfig( {
            :deviceNumber => 0,                 //Wildcard our search
            :deviceType => DEVICE_TYPE,
            :transmissionType => 0,
            :messagePeriod => PERIOD,
            :radioFrequency => 57,              //Ant+ Frequency
            :searchTimeoutLowPriority => 10,    //Timeout in 25s
            :searchTimeoutHighPriority => 2,    //Timeout in 5s
            :searchThreshold => 0} );           //Pair to all transmitting sensors
        GenericChannel.setDeviceConfig(deviceCfg);

        data = new TempeData();
        searching = true;
    }
```

This code sets up the ANT channel assignment and sets device config and passes them to the base Ant.GenericChannel class. The device config is set to wildcard search to find any environment sensor. The initializer also sets up the `onMessage` callback to handle incoming packets.

```
    // Handle incoming information
    function onMessage(msg as Message) {
        // Parse the payload
        var payload = msg.getPayload();

        if( Ant.MSG_ID_BROADCAST_DATA == msg.messageId ) {
            if( TempeDataPage.PAGE_NUMBER == (payload[0].toNumber() & 0xFF) ) {
                // Were we searching?
                if(searching) {
                    searching = false;

                    // Update our device configuration primarily to see
                    // the device number of the sensor we paired to
                    deviceCfg = GenericChannel.getDeviceConfig();
                }
                var dp = new TempeDataPage();
                dp.parse( msg.getPayload(), data );
                tempDataAvailable = true;
                // Check if the data has changed and we need to update the ui
                if( pastEventCount != data.eventCount ) {
                    pastEventCount = data.eventCount;
                }
            }
        } // end broadcast data

        else if( Ant.MSG_ID_CHANNEL_RESPONSE_EVENT == msg.messageId ) {
            if( Ant.MSG_ID_RF_EVENT == (payload[0] & 0xFF) ) {
                if( Ant.MSG_CODE_EVENT_CHANNEL_CLOSED == (payload[1] & 0xFF) ) {
                    open();
                }
                else if( Ant.MSG_CODE_EVENT_RX_FAIL_GO_TO_SEARCH  == (payload[1] & 0xFF) ) {
                    searching = true;
                }
            }
            else{
                //It is a channel response.
            }
        } // end channel response event

    } // end on message
```

The callback handles pairing with a nearby sensor, and handing incoming packets.

The MO2Display sample provides a sample application that implements the Muscle Oxygen ANT profile. The ANT Generic interface is not available to watch faces. Low and high priority search timeout for sensors differs from the basic ANT radio specification to allow for interoperation with native ANT behavior on devices. These are limited to a maximum timeout of 30 seconds and 5 seconds respectively.

## Burst Data

*Since API level 2.2.0*

Burst data transmission provides a mechanism for large amounts of data to be sent between devices over an ANT Generic Channel. Developers are notified through a listener of the success/failure of burst transmit/receive events. Burst data transmission is limited to up to 8Kb of data at a time.

Common use cases for this include passkey authentication or sending/receiving configuration data between devices.

The `GenericChannelBurst` sample provides a demonstration of transmitting and receiving burst data.

## ANT+ Profiles

*Since API level 2.2.0*

The Toybox.AntPlus module allows access to information about ANT+ sensors that are paired to a user's device without requiring you to set up and manage the ANT channel yourself. All management of ANT+ sensors such as adding, removing, enabling, disabling, and calibrating is managed by the user via the device's regular sensor menus.

An extension of a sensor-specific listener is passed into the constructor for a sensor-specific extension of AntPlus.Device. If there is a sensor of the given type paired to the user's device, information about that sensor can be retrieved using the sensor-specific getters, or through the common data getters such as Device.getBatteryStatus(). `null` can be passed in as the identifier for sensor types (like most) that do not support multi-components.

Callbacks in the AntPlus.DeviceListener and extensions of it will be called automatically if a sensor of the given type is paired and the corresponding information is updated via ANT. For example, DeviceListener.onDeviceStateUpdate() will be called if a sensor's ANT channel goes from connected to searching, or if the user switches the sensor ID of a given type that their device is connected to. Callbacks like will be called when new pieces of information about a power sensor are received via ANT.

Certain ANT+ sensors, such as bike lights, have special callbacks. For example, the callback should be used to understand the light network's state rather than DeviceListener.onDeviceStateUpdate(). The AntPlus.LightNetwork class will allow you to make changes to bike light modes, given there are bike lights paired to the user's device and a light network is fully formed.

Not all ANT+ profiles provisioned by Monkey C will be supported by every Connect IQ-compatible device.
