---
source: https://developer.garmin.com/connect-iq/core-topics/manifest-and-permissions/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Manifest_and_Permissions.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Manifest File and Permissions

All the sections of the `manifest.xml` can be edited in the Monkey C Extension manifest editor. The *Edit as XML* option will allow you access to the underlying definitions.

## Application Attributes

The `application` element has a number of important attributes. The `id` field is a 128-bit UUID identifier. Unique identifiers can be generated with the UUID Generator or with standard tools.

The `entry` attribute must specify the Application.AppBase object for your application.

The `name` and `launcherIcon` attributes must specify a resource ID that is defined in the app resources. The `name` must reference a `string` entry in your strings resources, and the `launcherIcon` must reference a bitmap resource. See the Resources for more information. Note that the icon resource should not be re-used within your application; use a duplicate resource if you want to use the icon within the app.

If you specify a `launcherIcon`, the system will resource compiler will auto size the resource to match the product icon size. If a `launcherIcon` isn't specified, a default icon will be compiled into the application.

The `type` field specifies what kind of application you are developing. Currently, Connect IQ supports five types of apps:

1. `watchface`
2. `datafield`
3. `widget`
4. `watch-app`
5. `audio-content-provider-app`

The app type specified in the manifest file determines where your app appears on the device and which APIs the app can use.

The `minApiLevel` field specifies the minimum Connect IQ API level that your app is compatible with. It serves to prevent you from targeting incompatible devices. The Monkey C extension allows you to select a minimum API level when creating a new app or editing the properties of an existing one. The micro version is written out to the manifest at version 1 (1.2.1 for example), but only the major and minor versions are considered when determining device support.

Every application must include an Application.AppBase object, which serves as the entry point for your application. The Monkey C extension will generate an Application.AppBase object when a project is created.

An Application.AppBase object should override AppBase.getInitialView() to provide the view object to initially push. An array must be returned with either a view and a delegate, or just a one element array with the WatchUi.View object:

```
return [ new MyView(), new MyDelegate() ];
```

## Products

Garmin makes a wide variety of products for many use cases, and Monkey C makes it easy to write for all our Connect IQ compatible devices. Monkey C asks the developer which Connect IQ devices they choose to support because it is impossible to know whether a future product may be incompatible with your app. As new Connect IQ compatible products appear on the market, the simulator will be updated to support them so developers can decide whether to support them.

Products supported by an app are listed in the `products` block of the manifest file:

```
<iq:products>
    <iq:product id="round-watch"/>
</iq:products>
```

### Supported Activities

*Since API level 5.2.0*

On devices with API level 5.2, data fields have a post-install flow that lets the user associate them with activities. If you want to filter the list of activities, you can include an activity filter in the manifest.

```
<!--
            Activity Filtering for post install.

            Set an activity filter for outdoor running activities
        -->
        <iq:activityFilter>
            <iq:activity sport="Toybox.Activity.SPORT_RUNNING" subsport="Toybox.Activity.SUB_SPORT_GENERIC" />
            <iq:activity sport="Toybox.Activity.SPORT_RUNNING" subsport="Toybox.Activity.SUB_SPORT_TRAIL" />
            <iq:activity sport="Toybox.Activity.SPORT_RUNNING" subsport="Toybox.Activity.SUB_SPORT_TRACK" />

        </iq:activityFilter>
```

This will build a filter based on FIT sport and sub-sport identifiers. If the sub-sport is not provided, the filter will cover all sports. You can use the direct FIT identifier rather than the and constants. Here are some examples you can use:

| Activity | Sport | Sub-Sport |
| --- | --- | --- |
| Running (All) |  | None |
| Trail Running |  |  |
| Track Running |  |  |
| Treadmill Running |  |  |
| Indoor Running |  |  |
| Cycling (All) |  | None |
| Mountain Biking |  |  |
| Gravel Biking |  |  |
| Indoor Cycling |  |  |

## Permissions

Certain modules expose personal information about the user or expose communication to the internet. To use these modules, permission must be requested from the user at the time of installation. To request permission, the module name must be added to the permissions list of the manifest file.

More modules may be added to this list as modules are added to the API. To request permission, use the following syntax in the manifest file:

```
<iq:permissions>
    <iq:uses-permission id="Sensor"/>
</iq:permissions>
```

The following permissions are available:

| Permission | Applicable Modules | API Level | Watch Face | Data Field | Widget | App | Audio Content Provider |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Ant | Toybox.Ant | 1.0.0 |  | x | x | x | x |
| Background | Toybox.Background | 2.3.0 | x | x | x | x | x |
| BluetoothLowEnergy | Toybox.BluetoothLowEnergy | 3.1.0 |  | x | x | x | x |
| Communications | Toybox.Communications, Toybox.Authentication | 1.0.0 | x1 | x2 | x | x | x |
| ComplicationProvider | Toybox.Complications | 4.1.0 |  |  |  | x | x |
| ComplicationSubscriber | Toybox.Complications | 4.1.0 | x |  |  |  |  |
| Data Field Alert | WatchUi.DataFieldAlert | 3.2.0 |  | x |  |  |  |
| Fit | Toybox.ActivityRecording, Toybox.FitContributor | 1.0.0 |  |  |  | x |  |
| PersistedContent | Toybox.PersistedContent | 2.2.0 |  |  | x | x | x |
| Positioning | Position.getInfo(), Position.enableLocationEvents() | 1.0.0 | x3 | x4 | x | x | x5 |
| Sensor | Toybox.Sensor | 1.0.0 |  | x | x | x | x |
| SensorHistory | Toybox.SensorHistory | 2.1.0 |  |  | x | x | x |
| SensorLogging | Toybox.SensorLogging | 2.3.0 |  |  |  |  |  |
| UserProfile | Toybox.UserProfile | 1.0.0 | x | x | x | x | x |

Some products provide separation between activities and apps. If your app has the `Fit` permission, it will show in the Activities list.

## Languages

Connect IQ apps can be localized across over 30 languages, and the languages your app support can impact what regions of the world your app is available in. In the manifest you can declare the languages your app supports, which will be used when exporting your application to the store. See Resources for more information.

## Dependencies

If your app links to other libraries, they must be declared in the manifest:

```
<iq:barrels>
    <iq:depends name="Barcode" version="2.0.0"/>
</iq:barrels>
```

The options for each barrel are as follows:

| Option | Type | Value |
| --- | --- | --- |
| `name` | `string` | The declared namespace Module name for the monkey barrel. |
| `version` | `a.b.c.d` (Optional) | The declared version number for the monkey barrel. |

`a`, `b` and `c` must be numbers. `d` is an optional alpha-numeric string of `A-Z`, `a-z`, `0-9`, and `_`.

If a version is specified, the build system will enforce that library version being used. These rules can be modified with the following options:

| Format | Meaning | Example | Valid Version | Invalid Version |
| --- | --- | --- | --- | --- |
| Exact | An application links to a specific version of a library | `version="1.2.3"` | Version `1.2.3` | Any other version |
| Greater or Equal | An application links to a library that matches or exceeds the version. | `version=">=1.2.3"` | Version `1.2.3` or greater. | Versions `1.2.2` or less. |
| Pessimistic | The application links to a library with a matching major and minor version, but the micro version must match or be greater than the specified version. | `version="~>1.2.3"` | Versions `1.2.3`, `1.2.4`, `1.2.5`, etc. | Versions `1.2.2`, `1.3.1`, etc. |
| Whatever | The version of the link library will not be enforced at build time. | No version attribute specified. | Any | N/A |

The version can be prefixed with `>=` to indicate a minimum supported version.

See Shareable Libraries for more information.

1 Communication requires the background permission to be enabled, but Authentication does not

2 Communication requires the background permission to be enabled, but Authentication does not

3 Only widgets and apps are allowed to call Position.enableLocationEvents()

4 Only widgets and apps are allowed to call Position.enableLocationEvents()

5 Only widgets and apps are allowed to call Position.enableLocationEvents()
