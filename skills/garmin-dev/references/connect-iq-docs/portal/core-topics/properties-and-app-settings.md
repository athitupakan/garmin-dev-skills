---
source: https://developer.garmin.com/connect-iq/core-topics/properties-and-app-settings/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Properties_and_App_Settings.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Properties and Settings

The app settings framework enables app developers to present options to end users for their apps within Garmin Connect and Garmin Express. This will allow app customization and setup, especially for watch faces and data fields, that have no way to receive user input on Garmin devices.

## Properties

An app property is a key and value that is built into the app at compile time. Properties are defined in application resources, and follow the rules of resource overrides.

```
<properties>
    <property id="appVersion" type="string">1.0.0</property>
</properties>
```

The `id` is a string identifier. The `type` must be one of the following:

| Value | Notes |
| --- | --- |
| `number`, `long`, `float`, `double` | Numeric values |
| `boolean` | Boolean value |
| `string` | String value |
| `array` | Array values cannot be initialized in properties, but defaults can be programmed in app settings |

When your app is installed the properties are initialized to the values programmed into resources. The property values can be fetched and modified via the following APIs:

| API | Notes | API Level |
| --- | --- | --- |
| AppBase.getProperty() | Get a property by its name | 1.0.0 |
| AppBase.setProperty() | Modify a property value | 1.0.0 |
| Properties.getValue() | Get a property by its name | 2.4.0 |
| Properties.setValue() | Modify a property value | 2.4.0 |

## Settings

App settings allow the user to modify app properties using their mobile device. The app settings can be modified in the Connect IQ Store app, the Garmin Connect app, or Garmin Express.

An app setting is composed of a property and an associated setting. The property is used to store the underlying setting value. The setting is used to describe how the property should displayed to the end user. You can define a property as a default value and not define an associated setting but you cannot define a setting without tying it to a property.

Settings are also defined as a resource. Use the `` tag to define a setting.

```
<settings>

    <setting propertyKey="@Properties.appVersion" title="@Strings.AppVersionTitle">
        <settingConfig type="alphaNumeric" readonly="true" />
    </setting>

    <setting propertyKey="@Properties.myString" title="@Strings.MyStringTitle" prompt="@Strings.MyStringPrompt">
        <settingConfig type="list">
            <listEntry value="0">@Strings.HelloWorld</listEntry>
            <listEntry value="1">@Strings.Ackbar</listEntry>
            <listEntry value="2">@Strings.Garmin</listEntry>
        </settingConfig>
    </setting>

    <setting propertyKey="@Properties.myNumber" title="@Strings.MyNumberTitle" prompt="@Strings.MyNumberPrompt">
        <settingConfig type="numeric" errorMessage="@Strings.MyNumberError" />
    </setting>

    <setting propertyKey="@Properties.screenSleep" title="@Strings.ScreenSleepTitle">
        <settingConfig type="boolean" />
    </setting>

    <setting propertyKey="@Properties.username" title="@Strings.UsernameTitle">
        <settingConfig type="alphaNumeric" required="true" />
    </setting>

</settings>
```

The table below shows all of the valid attributes for a setting.

| Attribute | Value | Notes |
| --- | --- | --- |
| `propertyKey` | The key of the property that this setting will manage. An error will be thrown at compile time if the property key can't be found. | Required |
| `title` | The title to display in Garmin Connect Mobile/Garmin Express when displaying the list of settings/value of the setting. This must reference a string resource ID. | Required |
| `prompt` | The message to display when prompting the user to set the value. This must reference a string resource ID. | Optional. Some settings will not display a prompt even if it's provided (for example, `readonly` or `boolean` settings displayed as an on/off switch). |
| `helpUrl` | A URL to a web page which will provide help for the user. **This has been deprecated.** | Optional |
| `maxLength` | The maximum number of elements allowed in an array setting | Optional |

A ``, a child element of a ``, provides additional details about the setting. The valid attributes are given in the table below.

| Attribute | Value | Valid Values | Notes |
| --- | --- | --- | --- |
| `type` | The display type of the setting. | `list`, `boolean`, `numeric`, `alphaNumeric`, `phone`, `email`, `url`, `date` or `password` | A value of `list` will require child `` elements to define the options which should be available within the list. |
| `readonly` | If the setting is read only or not. This attribute is valid for all types except `list` and `password`. | `true` or `false` | Optional. Defaults to `false`. |
| `required` | If the field is required. | `true` or `false` | Optional. Defaults to `false`. |
| `min` | The minimum value to allow. | An integer value | Optional. Only valid for a `type` value of `numeric` or `date`. |
| `max` | The maximum value to allow. | An integer value | Optional. Only valid for a `type` value of `numeric` or `date`. |
| `maxLength` | The maximum allowed value length. | An integer value | Optional. Only valid for settings whose associated property's type is `string`. |
| `errorMessage` | An error message to display if the value a user enters isn't valid based on the `type`, `min`, `max` and `maxLength` values. | A reference to a string resource. |  |
| `id` | In array settings, an identifier that is used to mark a field inside the object setting. | A string identifier | This is only used with array settings |

`` types are only valid for certain property types:

| Property Type | Valid `settingsConfig` Types |
| --- | --- |
| `string` | `alphaNumeric`, `phone`, `email`, `url`, `password` |
| `number` | `list`, `numeric`, `date` |
| `float` | `numeric` |
| `long` | `numeric` |
| `double` | `numeric` |
| `boolean` | `boolean` |

The `` element is defined in the table below. Its value must be a reference to a string resource.

| Attribute | Value | Notes |
| --- | --- | --- |
| `value` | The value to save if this item is selected by the user. | The type of the value should match the property it's being saved to. If it doesn't match a compile time error is thrown. |

See the Object Store and Application Properties on how to read these value at runtime.

### Groups

The `` tag allows settings to be grouped together. This lets you visually separate related settings from non-related ones. A group contains the settings it groups together. A group is not allowed to contain a group.

Here is a simple example of a group definition:

```
<settings>
    <group id="groupName" title="@Strings.group1Title" description="@Strings.group1Description">
        <setting propertyKey="@Properties.number_prop" title="@Strings.number_title">
            <settingConfig type="numeric" />
        </setting>

        <setting propertyKey="@Properties.long_prop" title="@Strings.long_title">
            <settingConfig type="numeric" />
        </setting>
    </group>
</settings>
```

Here are the options for groups:

| Attribute | Values | Notes |
| --- | --- | --- |
| `id` | String | Identifier for the group |
| `title` | String | Title for the group. This is shown as a list item in mobile. |
| `description` | String | Description text for the group. This should describe the context of the group of settings |
| `enableIfTrue` | Property identifier | Allows a group to be disabled if a `boolean` setting is not checked. This allows for settings to appear if the user enables a feature. |

### Array Settings

There are times when it can be helpful to allow the user to manipulate one or more related items. For example, let's say that your app can support more than one kind of activity type, and each activity type has a different set of heart rate zones. The user may only have two or three activity types, but your app supports 50 different ones.

Array settings allow you to define a set of settings that are added and removed as a group. This allows the user to create a variable list (up to a maximum size) of objects that can be read at runtime.

To create a variable list, the property referenced must be of type `array`. The setting definition is then a set of settings:

```
<setting propertyKey="@Properties.ActivityHrZones" title="Activities" maxLength="4">

    <setting title="@Strings.activityType" type="number">
        <settingConfig id="activityType" type="list">
            <listEntry value="0">@Strings.Running</listEntry>
            <listEntry value="1">@Strings.Cycling</listEntry>
            <listEntry value="2">@Strings.Swimming</listEntry>
        </settingConfig>
    </setting>
    <setting title="@Strings.Zone1">
       <settingConfig id="zone1" type="number"/>
    </setting>
    <setting title="@Strings.Zone2">
       <settingConfig id="zone2" type="number"/>
    </setting>
    <setting title="@Strings.Zone3">
       <settingConfig id="zone3" type="number"/>
    </setting>
    <setting title="@Strings.Zone4">
       <settingConfig id="zone4" type="number"/>
    </setting>
    <setting title="@Strings.Zone5">
       <settingConfig id="zone5" type="number"/>
    </setting>

    <!-- The defaults is where you program the initial values -->
    <defaults>
        <entry>
            <default id=”activityType”>0</default>
            <default id="zone1">89</default>
            <default id="zone2">109</default>
            <default id="zone3">125</default>
            <default id="zone3">144</default>
            <default id="zone5">160</default>
        </entry>
    </defaults>
</setting>
```

When you query the property, it will be an array of Lang.Dictionary objects, with each `id` key associated with the value. You can use `maxLength` to set an upper bound to the number of elements. Each `settingConfig` must have an `id` field.

The `` tag allows you to program the initial value when your app is first installed. Each `` tag must reference the identifier with the `id` attribute.

## Changing Settings Within Garmin Connect Mobile/Garmin Express

End users will be able to view the settings you define within the Garmin Connect or Garmin Express UI. When app settings are changed while an app is running the AppBase.onSettingsChanged() function is called. Apps can override this function and update accordingly. When dealing with date type settings that are set by Garmin Express or Garmin Connect, one should note that times are stored in UTC and that Gregorian.utcInfo() should be used in place of Gregorian.info() when working with such values to prevent unnecessary local time conversion.

## Testing App Settings

An app settings editor tool is available within the Connect IQ simulator. Go to *File > Edit Persistent Storage > Edit Application.Properties data*. This tool will allow you to view the defined settings for a project, select values for each setting and send them to the simulator for testing.

## On Device Watch Face and Data Field Settings

*Since API level 3.2.0*

Device applications, widgets, and audio content providers all accept user input that allow them to implement on-device settings in the app. Watch faces and data fields are not allowed to accept input or push views that would allow on device configuration.

If you want to provide an on-device settings user interface for your watch face or data field, you can implement AppBase.getSettingsView(). AppBase.getSettingsView() functions similarly to AppBase.getInitialView() where you return a WatchUi.View and WatchUi.InputDelegate pair that can serve as the initial view.

Watch face configuration is available to the user in the system Watch Face menu. Data field configuration is available from the activity menu.
