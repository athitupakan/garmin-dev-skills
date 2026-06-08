---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/Properties.html
fetched: 2026-05-24
sdk: 9.1.0
---

# Toybox.Application.Properties

Persistent settings exposed via `resources/settings/properties.xml` + `settings.xml`. Read/write key-value pairs from the watch face; the user edits them in the Connect IQ companion app.

API Level 2.4.0+. No special permission required.

## Why we'd use this

CLAUDE.md note: theme/layout constants currently live as `const` in source. When we want the user to swap them (e.g., pick which sensor the Crown shows, toggle 12/24h time), we'd:

1. Declare the property in `resources/settings/properties.xml`
2. Add a Settings UI hint in `resources/settings/settings.xml`
3. Replace the `const` with a function that calls `Properties.getValue(...)`

## Core functions

### `getValue(key as String) → ValueType`
Read a setting. **Throws** `InvalidKeyException` if the key isn't declared in `properties.xml`. Always wrap in try/catch or guarantee the key exists.

```monkey-c
import Toybox.Application.Properties;

var use24h = false;
try {
    use24h = Properties.getValue("Use24HourTime") as Boolean;
} catch (e instanceof Properties.InvalidKeyException) {
    // key not defined — fall back to default
}
```

### `setValue(key as String, value as ValueType) → Void`
Write a setting. **Cannot be called from background processes** (only from foreground app/widget/watch face).

### `ValueType`
Allowed property types:
- `Number` — integer
- `Float` / `Double` — decimal
- `Long` — 64-bit int
- `String`
- `Boolean`
- `Array<ValueType>` — nested arrays allowed

## Resource files

### `resources/settings/properties.xml`
Declares the key + default value.

```xml
<properties>
    <property id="Use24HourTime" type="boolean">true</property>
    <property id="CrownMode" type="number">0</property>
    <property id="AccentColor" type="string">0x00FF00</property>
</properties>
```

### `resources/settings/settings.xml`
Declares the UI control the user sees in Connect IQ mobile app.

```xml
<settings>
    <setting propertyKey="@Properties.Use24HourTime"
             title="@Strings.Use24HourTimeTitle">
        <settingConfig type="boolean"/>
    </setting>
    <setting propertyKey="@Properties.CrownMode"
             title="@Strings.CrownModeTitle">
        <settingConfig type="list">
            <listEntry value="0">@Strings.CrownModeAge</listEntry>
            <listEntry value="1">@Strings.CrownModeVo2</listEntry>
        </settingConfig>
    </setting>
</settings>
```

## App lifecycle

When a setting changes, `App.onSettingsChanged()` fires:

```monkey-c
class MyApp extends Application.AppBase {
    function onSettingsChanged() {
        // re-read properties + invalidate the view
        WatchUi.requestUpdate();
    }
}
```

## Gotchas

1. **`getValue` throws if key isn't declared** — declaring keys is part of the property contract; reading an undeclared key is a programmer error, not a missing-data condition.
2. **Background can read but not write** — `setValue` from a background context throws.
3. **`Storage` is the cousin** — `Toybox.Application.Storage` is for free-form app state (no UI hint, no companion edit). Properties = user-facing settings; Storage = app-internal state.
4. **Numbers vs Longs** — `<property type="number">` is 32-bit; for 64-bit timestamps use `<property type="long">`.
