# Guide — Making a watch face / data field user-configurable

Three mechanisms let the user change a setting. They differ in **where** the user changes it and which devices support them. Pick by that — then wire it.

| Mechanism | Where the user changes it | Device support | Use when |
|---|---|---|---|
| **1. Watch Face Configurations** (`<watchface-config>`) | on the watch — Garmin's **system** editor (color wheel, Hands, complications) | fēnix 8+ / varies per device — verify (see tip) | you want the native editor UX (built-in color wheel, complication picker) |
| **2. App Settings** (`settings.xml` + Properties) | **phone** app (Garmin Connect / Express) only | all devices | the user configures from the phone |
| **3. On-device settings view** (`AppBase.getSettingsView()`) | on the watch — a **menu you build** (the "Customize" entry next to Apply) | all devices (API 3.2.0+) | you want an on-watch menu but the device lacks (or you don't need) the native editor |

Mechanisms **2 and 3 share the same Properties** — declare the property once, then let it be edited from the phone (2) and/or on the watch (3).

---

## 1. Watch Face Configurations (native on-device editor)

User edits Styles / Data (complications) / Data Color / Accent Color on the watch. Define the options in a `<watchface-config>` resource:

```xml
<watchface-config>
    <styles><style id="0" label="@Strings.AppName" default="true"/></styles>
    <data>
        <complication id="1">
            <type default="true">Complications.COMPLICATION_TYPE_STEPS</type>
            <type>Complications.COMPLICATION_TYPE_HEART_RATE</type>
        </complication>
    </data>
    <dataColors>
        <color default="true">0xFFFFFF</color>
        <color>Graphics.COLOR_BLUE</color>
    </dataColors>
    <accentColors allowAny="true"/>
</watchface-config>
```

Read the choices with `WatchFaceConfig.getSettings(null)` (returns a `Settings` with `.complicationColor` / `.accentColor` / `.styleId` / `.complicationSettings`); interface with the editor via `WatchFaceDelegate.onTap()` / `getComplicationDrawable()` / `onWatchFaceConfigEdited()`. Each section is optional — `<dataColors>` alone is valid. Full options table: [editing-watch-faces-on-device.md](../connect-iq-docs/portal/core-topics/editing-watch-faces-on-device.md).

- **Tip — support is per-device, check before building:** `grep WatchFaceConfig %APPDATA%/Garmin/ConnectIQ/Devices/<device>/<device>.api.debug.xml`. If it only appears inside documentation text (no `functionEntry`), the device's SDK definition doesn't expose the API — `getSettings` throws *Symbol Not Found* and `<watchface-config>` won't show on the watch. Use Mechanism 3 instead.
- **Tip:** guard the read with `if (Application has :WatchFaceConfig)` so the same build is safe on devices without it.

---

## 2. App Settings / Properties (configured from the phone)

**`resources/settings/properties.xml`** — declare each key + default:
```xml
<properties>
    <property id="DataColor" type="number">0x66FF55</property>  <!-- color as a packed number -->
    <property id="DataField1" type="number">0</property>         <!-- index of which metric a slot shows -->
</properties>
```

**`resources/settings/settings.xml`** — UI in Garmin Connect. **No native color picker** — offer a `list`:
```xml
<settings>
    <setting propertyKey="@Properties.DataColor" title="@Strings.DataColorTitle">
        <settingConfig type="list">
            <listEntry value="0xFF0000">@Strings.Red</listEntry>
            <listEntry value="0x00AAFF">@Strings.Blue</listEntry>
        </settingConfig>
    </setting>
</settings>
```

**`resources/strings/strings.xml`** — labels the `@Strings.*` point to (use `scope="settings"` to keep them out of runtime RAM).

**In code** — read the property, react to phone pushes:
```monkey-c
import Toybox.Application.Properties;
var color = 0x66FF55;
try { color = Properties.getValue("DataColor") as Number; } catch (e) {}

// AppBase — phone pushed new settings
function onSettingsChanged() { /* re-read + */ WatchUi.requestUpdate(); }
```

- **Tip:** metric/data-field options → [sensor catalog](../catalogs/sensors.md) for what's actually readable.

---

## 3. On-device settings view (`getSettingsView`) — an on-watch menu

A watch face's **main view** can't take input, but `AppBase.getSettingsView()` is the sanctioned exception: return a `[View, InputDelegate]` pair and the system adds a **settings entry to the Watch Face menu** on the device (API 3.2.0+, all devices). A `Menu2` is itself a `View`, so return it directly:

```monkey-c
// AppBase
function getSettingsView() as [Views] or [Views, InputDelegates] or Null {
    var menu = new WatchUi.Menu2({ :title => "Data Color" });
    menu.addItem(new WatchUi.MenuItem("Cyan", null, 0x33CFFF, null));   // id = the value
    menu.addItem(new WatchUi.MenuItem("Amber", null, 0xFFAA00, null));
    return [menu, new SettingsDelegate()];
}

class SettingsDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() { Menu2InputDelegate.initialize(); }
    function onSelect(item as WatchUi.MenuItem) as Void {
        Properties.setValue("DataColor", item.getId() as Number);  // same key as Mechanism 2
        WatchUi.requestUpdate();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}
```

- **Tip:** writing to a `Property` here does **not** fire `onSettingsChanged` (that's for phone pushes) — re-apply the value inline before `requestUpdate`.
- **Tip:** there's no system color wheel — build the chooser yourself (a `Menu2` list of presets is the simplest).

---

## Testing

Simulator → **File > Edit Persistent Storage > Edit Application.Properties** to set values and push them (covers Mechanisms 2 & 3). Then build → push → verify the render updates. (The on-device menu of Mechanism 3 is best confirmed on hardware.)

## Cross-reference

- Native on-device editor: [editing-watch-faces-on-device.md](../connect-iq-docs/portal/core-topics/editing-watch-faces-on-device.md)
- App Settings + `getSettingsView`: [properties-and-app-settings.md](../connect-iq-docs/portal/core-topics/properties-and-app-settings.md)
- Properties API + gotchas: [application-properties.md](../connect-iq-docs/reference/api/application-properties.md)
- Which metric for a data field: [sensor catalog](../catalogs/sensors.md)
