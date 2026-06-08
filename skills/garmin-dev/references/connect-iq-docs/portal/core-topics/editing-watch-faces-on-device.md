---
source: https://developer.garmin.com/connect-iq/core-topics/editing-watch-faces-on-device/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Editing_Watch_Faces_On_Device.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Watch Face Configurations

*Since API level 5.1.0*

The fēnix 8 and newer wearables have an on-device watch face editor. The watch face editor allows users to take the one of the product faces, configure it and save the configuration as a new face in their watch face list. You can add support for the native watch face editor using the watch face configuration API. Watch face configurations have four primary variables:

- *Styles* - A watch face is allowed to have stylistic variations, such as different font configurations or watch hands.
- *Data* - Watch faces may have multiple complications. Each complication can be configured independently.
- *Data Color* - Watch faces can define multiple selectable color options. Data colors allow the user to pick a color for data.
- *Accent Color* – Watch faces are allowed a color as a configurable accent.

The user is allowed to create up to four configurations of a Connect IQ watch face on the device.

## Defining a Configuration

You can define the options of your watch face configuration in resources:

```
    <watchface-config>

        <styles>
            <style id="0" label="@Strings.AppName" default="true"/>
        </styles>

        <data>
            <complication id="1">
                <type default="true">Complications.COMPLICATION_TYPE_STEPS</type>
                <type>Complications.COMPLICATION_TYPE_HEART_RATE</type>
                <type>Complications.COMPLICATION_TYPE_CURRENT_WEATHER</type>
            </complication>

            <complication id="2">
                <type default="true">Complications.COMPLICATION_TYPE_HEART_RATE</type>
                <type>Complications.COMPLICATION_TYPE_STEPS</type>
                <type>Complications.COMPLICATION_TYPE_CURRENT_WEATHER</type>
            </complication>

            <complication id="3" allowAny="true" />
        </data>

        <dataColors>
            <color label="@Strings.aqua">0x00FFFF</color>
            <color label="@Strings.yellow">0xFFFF00</color>
            <color default="true">0xFFFFFF</color>
            <color>Graphics.COLOR_BLUE</color>
            <color label="@Strings.orange">Graphics.COLOR_ORANGE</color>
        </dataColors>

        <accentColors allowAny="true"/>

    </watchface-config>
```

Here are the options:

| Tag | Attribute | Type | Description |
| --- | --- | --- | --- |
| `style` | `id` | Number | Numerical identifier for the style. |
| `style` | `label` | String identifier | Label name for the style. |
| `style` | `default` | Boolean | Optional field to indicate which style is the user default. |
| `complication` | `id` | Number | Numerical identifier for the complication. |
| `complication` | `allowAny` | Boolean | Optional. Specifies that the given complication accepts any system-supported complication, including Connect IQ complications. |
| `type` | `default` | Boolean | Optional argument to identify that a type of complication is supported. The element value should be a Complication identifier. If allowAny is used, this should not be provided. |
| `dataColors` | `allowAny` | Boolean | Optional attribute. Specifies that the data colors allow for any system-supported color to be specified. If this is not specified, then color elements should be provided. |
| `color` | `label` | String identifier | Translatable name for the color. |
| `color` | `default` | Boolean | Optional. Marks this color as the user’s default. |
| `accentColors` | `allowAny` | Boolean | Optional attribute. Specifies that the accent colors allow for any system-supported color to be specified. If this is not specified, then color elements should be provided. |

## Reading the Watch Face Configuration

When running on a device that supports the native watch face editor, you can get the active configuration by calling WatchFaceConfig.getSettings() with a parameter of null. From here, you can read the style, complication color, accent color and complications defined by the user by using the native editor.

## Interfacing with the Watch Face Editor

When a watch face is edited in the native watch face editor, it’s launched in an editing mode. You can detect this by checking the options in AppBase.onStart(). When operating in editing mode, you can use the following methods to interface with the watch face editor:

| Method | Usage | API level |
| --- | --- | --- |
| WatchFaceDelegate.onTap() | Allows you to map a screen press to an editable element. If the user clicks on an editable complication, use WatchFaceDelegate.setSelectedComplication() to indicate which complication was selected. | 5.1.0 |
| WatchFaceDelegate.getComplicationDrawable() | Allows you to provide a drawable that illustrates a selected complication. The system will animate this drawable inside the editor. | 5.1.0 |
| WatchFaceDelegate.onWatchFaceConfigEdited() | Called when the user edits an element of the watch face configuration. Make sure the updated configuration is represented the next time View.onUpdate() is called. | 5.1.0 |
