---
source: https://developer.garmin.com/connect-iq/connect-iq-basics/welcome-to-the-jungle/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Connect_IQ_Basics/Welcome_to_the_Jungle.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Welcome to Connect IQ

Connect IQ combines three W's:

- **Wear** - Garmin devices don't live on a desk or in a pocket. Rather, they are worn on wrists or mounted to bicycles to help our users beat yesterday. Garmin's experience in power management, activity tracking and ANT or ANT+ sensors means our users will spend more time using the products and less time charging them.
- **Where** - Location awareness is at the center of our products. While they are still highly functional devices even when not paired with a smart phone, initiating this pairing process will unlock a world of new features and functions for your Garmin device.
- **Ware** - Garmin's new Connect IQ app system allows for developers to extend their apps into Garmin's wearable ecosystem.

Connect IQ products provide the best of what Garmin has to offer like beautiful design, location awareness, and efficient power management with the Connect IQ app system. Using the Connect IQ SDK, developers can create apps for Connect IQ devices and distribute them via the Connect IQ Store.

Connect IQ apps are created in Monkey C, an object-oriented language designed for easy app development. The goal of Monkey C is to simplify the app building process, letting developers focus more on the customer and less on resource constraints. It uses reference counting to automatically clean up memory, freeing you from focusing on memory management. In addition, the resource compiler helps you import fonts and images to easily convert them between devices. If you've worked with dynamic languages in the past like Java™, PHP, Ruby or Python™, Monkey C should be very familiar.

## Devices and APIs

The problem of *API fragmentation* is a challenge for app developers. If a developer takes advantage of new APIs, newer devices with less customer penetration may be targeted. If only established APIs are used, apps may not take advantage of new capabilities.

Garmin devices each have some differences you'll need to account for: round screens versus square screens, touch screens versus buttons, and a different array of sensors depending on the device purpose. While the Java philosophy of "write once run anywhere" is a notable goal, creating a universal API that crosses every Garmin device would inevitably become a lowest common denominator API.

Rather than attempting to abstract away differences in devices, Connect IQ APIs are tailored to the devices they run on. If a device has a magnetometer, the device should have available the Magnetometer API. If two devices each have a magnetometer, the API should be the same between them. If a device does not have a magnetometer, it will not provide that API.

To see the Connect IQ compatible devices and their capabilities go to the Device Reference section .

## System versus API Level

Connect IQ uses two versions 1: the *API level* and the *system number*.

The *API level* is a three number (`major.minor.micro`) version that dictates the *potential* APIs that a device supports. As stated above, not every device supports every API, but if a product is at or below an API level it is guaranteed to not support an API.

The *system number* is a single digit number that is associated with a minimum API level. The system number communicates the set of devices that meet the minimum API level.

Products running the latest system are most likely to get API updates and bug fixes. Products not running the latest system may receive updates when necessary.

## The Tao of Connect IQ

There is a rhyme and reason behind Monkey C to make it easier for developers to support the Garmin ecosystem of products:

1. **The developer chooses what devices to support**Connect IQ apps can run across multiple devices, but the intended devices are up to the developer. Not every device will be aimed at the markets the developer wants to target or provide the experience the developer wants to provide. The developer should not be forced to support devices they don't want to.
2. **The developer tools should help developers support multiple devices**The developer tools lessen the weight of supporting multiple devices. The Resource Compiler hides device specific palettes and orientations from the developer. It also allows per device override of resources, allowing different images, fonts, and page layouts to be specified in the resources XML. The simulator needs to expose only the APIs a particular device supports so the developer can test device support.
3. **Similar devices should have similar APIs**Not all devices will be equal, but there is often commonality between them. Two different watches may have different display technologies, but they both support bitmaps, fonts, user events, ANT/ANT+, and BLE. A developer writing a sports app should not have to completely rewrite their app to support multiple devices.
4. **At runtime, the developer can ask what the system 'has'**Connect IQ applications are dynamically linked to the system. If an app makes a reference to an API that does not exist on a particular system, the app will fail at runtime when the app references the API, not at load time like C++. This allows an app to avoid making the call by taking advantage of the '`has`' operator.

## Overview

| Section | Description |
| --- | --- |
| Getting Started | Step by step instructions for installing the Connect IQ tools |
| Your First App | Create your first watch face using Connect IQ |
| App Types | Learn about the watch face app type and what must be taken into consideration |

1 Experienced Connect IQ developers reading this may be wondering if we are attempting to make fetch happen, and the answer is yes. You have to admit that it is pretty fetch.
