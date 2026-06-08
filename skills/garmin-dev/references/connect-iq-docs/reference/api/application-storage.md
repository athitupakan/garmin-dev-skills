---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Application/Storage.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Application/Storage.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Application.Storage

## Overview

The Storage module provides persistent storage to applications.

Storage provides access to persistent disk storage.

**Since:** API Level 2.4.0

## Typedef Summary
- **KeyType** as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char
- **ValueType** as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char or Lang.ByteArray or Graphics.BitmapReference or WatchUi.BitmapResource or WatchUi.AnimationResource or BluetoothLowEnergy.ScanResult or Complications.Id or WatchFaceConfig.Id or Lang.Array or Lang.Dictionary or **Null**

## Instance Method Summary
- **clearValues**() as **Void** Clear the object store for the application.
- **deleteValue**(key as Storage.KeyType) as **Void** Delete the given key from the object store.
- **getValue**(key as Storage.KeyType) as Storage.ValueType Get the data associated with a given key from the object store.
- **setValue**(key as Storage.KeyType, value as Storage.ValueType) as **Void** Store the given data in the object.

## Typedef Details

### `KeyType as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char`

**Since:** API Level 2.4.0

### `ValueType as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char or Lang.ByteArray or Graphics.BitmapReference or WatchUi.BitmapResource or WatchUi.AnimationResource or BluetoothLowEnergy.ScanResult or Complications.Id or WatchFaceConfig.Id or Lang.Array or Lang.Dictionary or Null`

**Since:** API Level 2.4.0

## Instance Method Details

### `clearValues() as Void`

Clear the object store for the application.

**Since:** API Level 2.4.0

**Throws:**
- (Application.ObjectStoreAccessException) — Thrown if called from a background process on device that does not have ConnectIQ 3.2.0 support.

### `deleteValue(key as Storage.KeyType) as Void`

Delete the given key from the object store.

**Parameters:**
- key — (Storage.KeyType) — The key to delete

**See Also:**

- setValue()

**Since:** API Level 2.4.0

**Throws:**
- (Lang.UnexpectedTypeException) — Thrown if key is a disallowed data type
- (Application.ObjectStoreAccessException) — Thrown if called from a background process on device that does not have ConnectIQ 3.2.0 support

### `getValue(key as Storage.KeyType) as Storage.ValueType`

Get the data associated with a given key from the object store.

Values must first be set with setValue() before they are can be obtained with `getValue`.

Note:

Symbols can change from build to build and are not to be used for for Keys or Values

**Parameters:**
- key — (Storage.KeyType) — The key of the value to retrieve from the object store

**Returns:**
- Storage.ValueType — The content associated with the key, or `null` if the key is not in the object store

**See Also:**

- setValue()
- Toybox.Background

**Since:** API Level 2.4.0

**Throws:**
- (Lang.UnexpectedTypeException) — Thrown if key is a disallowed data type

### `setValue(key as Storage.KeyType, value as Storage.ValueType) as Void`

Store the given data in the object.

Support for storing object types has been expanded over time.

- BitmapResource (Since 3.0.0)
- AnimationResource (Since 3.0.8)
- ScanResult (Since 3.2.0)
- Complications.Id (Since 4.2.0)
- WatchFaceConfig.Id (Since 5.1.0)

There is a limit on the size of the Object Store that can vary between devices. If you reach this limit, the value will not be saved and an exception will be thrown. Also, values are limited to 32 KB in size.

Note:

Symbols can change from build to build and are not to be used for for Keys or Values

**Parameters:**
- key — (Storage.KeyType) — The key used to store and retrieve the value from the object store (cannot be a Symbol)
- value — (Storage.ValueType) — The value to put into the object store

**Example:**
```
using Toybox.Application.Storage;

Storage.setValue("number", 2);               // set value for "number" key
Storage.setValue("float", 3.14);             // set value for "float" key
Storage.setValue("string", "Hello World!");  // set value for "string" key
Storage.setValue("boolean", true);           // set value for "boolean" key

var int = Storage.getValue("number");          // get value for "number" key
var float = Storage.getValue("float");         // get value for "float" key
var string = Storage.getValue("string");       // get value for "string" key
var boolean = Storage.getValue("boolean");     // get value for "boolean" key
```

**See Also:**

- getValue()
- Toybox.Background
- Core Topics - Persisting Data

**Since:** API Level 2.4.0

**Throws:**
- (Lang.UnexpectedTypeException) — Thrown if key is a disallowed data type
- (Lang.StorageFullException) — Thrown if there is not enough remaining space in the Object Store for the given key and value
- (Application.ObjectStoreAccessException) — Thrown if called from a background process on device that does not have ConnectIQ 3.2.0 support. Data can always be passed to the foreground process from a background process with Background.exit().
