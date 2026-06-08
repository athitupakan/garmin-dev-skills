---
source: https://developer.garmin.com/connect-iq/core-topics/bluetooth-low-energy/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Bluetooth_Low_Energy.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Getting Started with Connect IQ BLE Development

## Resources

When going through this guide, developers will want to keep a few things handy.

- **Connect IQ BLE API Documentation**Having the API Documentation close by will be critical (especially in the later steps of this document).
- **Nordic nRF52 DK**The Connect IQ team has built out the Connect IQ SDK tools to be compatible with the Nordic nRF52 DK Bluetooth 5 and Bluetooth mesh Development Kit for nRF52810.

- **Nordic Documentation Page**The Nordic Documentation has links to all of the resources needed to use the nRF52 DK.
- **nRF Connect For Desktop**The nRF Connect For Desktop application allows developers to flash new firmware to the board, monitor connections, etc. This software is necessary to program the board to work correctly with the Connect IQ simulator.
- **An up-to-date Connect IQ SDK**To use the BLE APIs, developers should be working with the current version of the Connect IQ SDK.
- **Firmware for the nRF52 DK**The memory layout of the nRF52 DK will need to be flashed to a different firmware for use with the Connect IQ SDK. The correct firmware for the development environment has been provided:nRF52 DK firmware
- nRF52840 Dongle firmware

## Windows

The drivers and applications needed to communicate with the nRF52 DK are all included in the installation of nRF Connect for Desktop for the Windows platform. Once this application is installed along with the necessary drivers, the nRF52 DK should be found by the nRF Connect for Desktop application.

At this point, proceed to the Using Nordic nRF Connect section.

## Mac

When using macOS, developers will need to manually install the JLink/JTrace USB drivers to communicate with the nRF52 DK board. To do so, download and install the Segger JLink installer package 6.22g for Mac.

Once this is completed, developers will need to install the nRF Connect for Desktop for Mac.

At this point, proceed to the Using Nordic nRF Connect section.

## Linux

When using Linux, developers will need to manually install the JLink/JTrace USB drivers to communicate with the nRF52 DK board. To do so, download and install using the appropriate Segger JLink installer for Linux:

- 32-bit: JLink_6.22g - 32
- 64-bit: JLink_6.22g - 64

Once this is completed developers will need to install the nRF Connect for Desktop for Linux.

## Using Nordic nRF Connect

The nRF Connect Desktop application will need to be installed. Please see the above sections for the appropriate links.

1. Once installed, launch the application. Click *Add/remove apps*:

1

## Finding The COM Port

Now that the board is properly communicating with the computer, it's time to figure out which port it's utilizing.

### Windows

Open up Device Manager and find your device under `Ports`.

It will look something like this:

The communications port is listed in parentheses. In the example above the communications port is `COM4`. Copy this to be used in a later step and proceed to Setting the COM Port.

### Mac

Open up a terminal and type:

```
ls /dev/tty.usbmodem*
```

then press `Tab`. This should list out the port information in the format `/dev/tty.usbmodem`. Copy this to be used in a later step and proceed to Setting the COM Port.

### Linux

Open up a terminal and type:

```
ls /dev/ttyACM*
```

then press `Tab`. This should list out the port information in the format `/dev/ttyACM`. Copy this to be used in a later step and proceed to Setting the COM Port.

### Setting the COM Port

At this point the nRF52 is properly communicating with the development environment and the com port information has been retrieved. The final step is to set the COM port in the Connect IQ Simulator.

1. Launch the simulator via Visual Studio Code or command line tools.
2. Select *Settings* > *BLE Settings*
3. In the dialog box, enter the COM port information from Finding the COM Port.

1. Click *OK*.

It's possible that developers might encounter an error. This is likely due to a failure to set the COM Port for the Connect IQ simulator. If an error occurs, then developers have a few things they can check.

1. **Double check the COM Port assignment:** Follow the steps for the correct environment to find and confirm the COM Port.
2. **Ensure there are no copy/paste errors:** Double check the information entered when setting the COM Port.

That's it! If all goes well, then the Connect IQ Simulator will use the nRF52 DK board BLE chipset to communicate with nearby BLE devices per the Connect IQ Bluetooth Low Energy APIs. For more information on the APIs, please refer to the API documentation and the `NordicThingy52` and `NordicThingy52CoinCollector` sample applications included in the Connect IQ SDK.

1 Developers may also check the _Auto read memory_ checkbox to have the device memory read automatically each time an action is taken.
