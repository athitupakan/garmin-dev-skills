---
source: https://developer.garmin.com/connect-iq/core-topics/complications/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Complications.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Complications

Garmin devices collect numerous data points as users wear them. Many of these data points can be summarized and displayed on the watch face as a complication. The Connect IQ SDK offers multiple APIs to access user metrics, and has expanded the offerings with every release.

The Toybox.Complications module consolidates the specific metrics typically displayed by Garmin devices into a unified interface. This unified interface gives the developer access to the information typically shown on the watch face for the developer. The complications are exposed using a publish/subscribe model.

In addition, device app and audio content provider developers can now publish up to four complications using this new framework. Complications have public, protected, and private visibility levels with the system.

Finally, Face It will also be a consumer of Connect IQ complications. This allows developers to create information that can be published on Face It watch faces.

## Publishers and Subscribers

At the heart of the complications system is a publisher/subscriber system. The system publishes complication data for subscribers to consume. Connect IQ device apps and audio content providers can publish complication data, but only watch faces can subscribe to complication information.

### Complication Objects

Data is published as a Complications.Complication object. The complication object exposes the following information:

| Identifier | Description | API Level |
| --- | --- | --- |
| Complication.complicationId | A unique identifier for the type of data being published of type Complications.Id | 4.2.0 |
| Complication.longLabel | A textual name for the complication. The long label is intended for display in a configuration menu. | 4.2.0 |
| Complication.ranges | An optional array of numeric values. Ranges allow breakdowns of sets of values that can be integrated into the display. | 4.2.0 |
| Complication.shortLabel | A five-character string intended to summarize your complication as a radial complication. | 4.2.0 |
| Complication.unit | The units to use with the value. If this is `null` then the unit shouldn't be displayed. If this is a `UNIT` identifier, the `value` is expected to be in a specific unit for conversion. If the `unit` is a string, the `value` should be interpreted without conversion. | `4.2.0` |
| Complication.value | A string or numeric value describing the value to be displayed to the user | `4.2.0` |

You can query additional information with these accessors:

| Method | Description | API Level |
| --- | --- | --- |
| Complication.getIcon() | For Connect IQ complications, query the icon provided by the app | 4.2.0 |
| Complication.getType() | For native complications, returns the `COMPLICATION_TYPE`. Will return `COMPLICATION_TYPE_INVALID` for Connect IQ complications. | 4.2.0 |

### Units

Complications are allowed to publish information in units that are configurable by the user in their system settings. When receiving complication values, it is the subscriber's role to convert the value to the metric specified in system settings.

Units should be expected to be published as the following:

| Unit | Expected Value |
| --- | --- |
| `Complications.UNIT_DISTANCE` | Meters |
| `Complications.UNIT_ELEVATION` | Meters |
| `Complications.UNIT_HEIGHT` | Meters |
| `Complications.UNIT_SPEED` | Meters per second |
| `Complications.UNIT_TEMPERATURE` | Degrees Celsius |
| `Complications.UNIT_WEIGHT` | Grams |

## Subscribing to Complications

To subscribe to a complication you need to add the `ComplicationSubscriber` permission to your manifest file. Subscribing to Complications requires the . You can use Complications.getComplications() to query the all complications supported by the system. You can also query a native complication directly by constructing a explicitly:

```
var complication = Complications.getComplication(
    new Id(Complications.COMPLICATION_TYPE_CALORIES)
);
```

This only works for native complications. Once you have the complication id, you can persist the id in storage for later use.

You can use Complications.registerComplicationChangeCallback() to subscribe to multiple complication values. All subscriptions are terminated when your app shuts down and must be re-done when your app is launched. When you subscribe, you register a callback to be called when the value updates:

```
function onStart(params as Dictionary) as Void {
    // Retrieve persisted Complication ID
    mComplicationId = Storage.getValue(COMPLICATION_ID_KEY);

    // Register a callback for receiving
    // updates on complication information
    Complications.registerComplicationChangeCallback(
        self.method(:onComplicationChanged));

    // Liking and subscribing
    Complications.subscribeToUpdates(mComplicationId);
}
```

In your callback, you can then query the updated information and process it:

```
function onComplicationChanged(
    complicationId as Complication.Id) as Void {
    // Identify the complication being updated
    if (complicationId == mComplicationId) {
        // Get the complication information
        try {
            var data = Complications.getComplication(
                complicationId);
            // Handle the application processing
            updateData(complicationId, data);
        } catch (e instanceof ComplicationNotFoundException) {
            handleComplicationRemoval(complicationId);
        }
    }
}
```

If the complication is no longer available, for example the user has uninstalled the publishing app, the system will throw a Complications.ComplicationNotFoundException. You should trap this exception and handle it within your app. If a publishing app is uninstalled, the system will send an event to your `ComplicationChangeCallback` and automatically unsubscribe your app from any subscribed complications.

When wheelchair mode is enabled, `COMPLICATION_TYPE_STEPS` and `COMPLICATION_TYPE_FLOORS_CLIMBED` are replaced with `COMPLICATION_TYPE_WHEELCHAIR_PUSHES`.

### Hold to Launch

Some Connect IQ products have a feature where pressing and holding on a complication launches the associated app. You can add this functionality to your watch face by implementing the WatchFaceDelegate.onPress() method:

```
function onPress(clickEvent as ClickEvent) as Boolean {
    if ((mComplicationId != null) &&
         isClickInside(clickEvent, mBoundingBox)) {

        // launch the app that published the
        // complication
        try {
            Complications.exitTo(mComplicationId);
            return true;
        } catch (e instanceof AppNotInstalledException) {
            // fall through
        }
    }

    return false;
}
```

If your complication publisher is launched via hold to launch, the `state` dictionary parameter of your will have the option `:launchedFromComplication` set to the complication id that triggered the launch.

## Publishing Complications

If you are developing a device or audio content provider apps, you can publish up to four complications to the framework. To publish a complication you need to add the `ComplicationPublisher` permission to your manifest file.

### Resources

To publish a complication, you have to define each complication in your resources:

```
<complications>
    <complication id="0" access="public"
                  longLabel="@Strings.myLongLabel"
                  shortLabel="@Strings.myShortLabel"
                  icon="@Drawables.MyComplication"
                  glancePreview="true">
        <faceIt defaultText="@Strings.complicationName" />
        <range>
            <value>0</value>
            <value>24</value>
            <value>33</value>
            <value>41</value>
            <value>50</value>
            <value>53</value>
        </range>
    </complication>
</complications>
```

The `complication` element has the following attributes:

| Attribute | Description | Required | API Level |
| --- | --- | --- | --- |
| `id` | Numerical identifier from 0 - 255. Keep this value stable across versions. Changing this value between versions will impact apps consuming your complication when your app updates. | Yes | 4.2.0 |
| `access` | `public`, `protected`, or `private` | Yes | 4.2.0 |
| `longLabel` | A descriptive title for your complication value. | Yes | 4.2.0 |
| `shortLabel` | A short string for apps that are displaying your complication as a radial complication. | No | 4.2.0 |
| `icon` | A resource identifier for the icon you want to associate with this complication. The specified resource must be an `svg` if your access is `public` or `protected`. The icon cannot be changed at runtime. | Yes | 4.2.0 |
| `glancePreview` | A Boolean value. When users place your glance into a glance folder, you can identify one of your complications to be used as the preview value. Only one of your complications can be demarked as a preview. | No | 4.2.0 |

Using the `access` attribute, you can control if your complications are visible to just apps with your developer key, all apps, and Face It or all of the above:

| Access | Your Apps | Face It | All Apps |
| --- | --- | --- | --- |
| `public` | X | X | X |
| `protected` | X | X |  |
| `private` | X |  |  |

The required `faceIt` element allows you to provide information for Face it:

| Attribute | Description | Required | API Level |
| --- | --- | --- | --- |
| `defaultText` | This will be shown in Face It as the name of the complication. | Yes | 4.2.0 |

The optional `range` element allows you to provide an ordered set of numeric values that define different ranges for your value.

## Publishing Values

Once your complication is defined, you can use the Complications.updateComplication() function to publish data:

```
var data = {
    // String, Number, Float, Long, Double, or null
    :value => newValue,

    // String
    :shortLabel => newShortLabel,

    // String or Complication.UNITS_* value
    :units => newUnits,

    // Array<Numeric> with at least 3 elements
    :ranges => newRanges,
}

// update complication
// 0 is the id of the complication
// from complications.xml
Complications.updateComplication(0, data);
```

## Face It Complications

Publishing a complication as `public` allows Face It to integrate your complication. It will always display your complication icon, and will use the following rules to display your complication value:

| If units are... | ...then value is expected to be... | ...and will be displayed as... |
| --- | --- | --- |
| `Complications.UNIT_*` type besides `Complications.UNIT_INVALID` | A numerical value | A numerical value converted from the default units defined for the unit type to the system units with the appropriate unit abbreviation. |
| String | A numerical value | A numerical value with the string units appended. |
| `Complications.UNIT_INVALID` or `null` | A numerical or string value | A numerical or string value will be displayed without conversion and without any units appended. |

Some best practices:

- Make sure your Face It icon is high contrast and will appear well in both light and dark mode in mobile.
- Use Latin characters (A-Z, a-z, 0-9) for published complication strings.
