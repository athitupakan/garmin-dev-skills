---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Lang.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Lang.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Lang

## Overview

The Lang module contains Monkey C language basic types, and provides a method for formatting Strings.

**Since:** API Level 1.0.0

## Classes Under Namespace

**Classes:** Array, Boolean, ByteArray, Char, Dictionary, Double, Exception, Float, InvalidOptionsException, InvalidValueException, Long, Method, Number, Object, OperationNotAllowedException, ResourceId, SerializationException, StorageFullException, String, Symbol, SymbolNotAllowedException, UnexpectedTypeException, ValueOutOfBoundsException, WeakReference

## Constant Summary

### NumberFormat

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| NUMBER_FORMAT_FLOAT | 0 | API Level 3.1.0 | IEEE 754 Single Precision Float Value (32-bits) |
| NUMBER_FORMAT_SINT16 | 1 | API Level 3.1.0 | Signed 16-bit Integer Value |
| NUMBER_FORMAT_SINT32 | 2 | API Level 3.1.0 | Signed 32-bit Integer Value |
| NUMBER_FORMAT_SINT8 | 3 | API Level 3.1.0 | Signed 8-bit Integer Value |
| NUMBER_FORMAT_UINT16 | 4 | API Level 3.1.0 | Unsigned 16-bit Integer Value |
| NUMBER_FORMAT_UINT32 | 5 | API Level 3.1.0 | Unsigned 32-bit Integer Value |
| NUMBER_FORMAT_UINT8 | 6 | API Level 3.1.0 | Unsigned 8-bit Integer Value |

### Endian

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| ENDIAN_LITTLE | 0 | API Level 3.1.0 |  |
| ENDIAN_BIG | 1 | API Level 3.1.0 |  |

## Typedef Summary
- **Comparable** as interface { function compareTo(other as Lang.Object) as Lang.Number; } Comparable defines an ordering between an object and others.
- **Comparator** as interface { function compare(a as Lang.Object, b as Lang.Object) as Lang.Number; } Comparator defines an ordering between objects.
- **Decimal** as Lang.Float or Lang.Double
- **Integer** as Lang.Number or Lang.Long
- **Numeric** as Lang.Number or Lang.Float or Lang.Long or Lang.Double

## Instance Method Summary
- **format**(format as Lang.String, parameters as Lang.Array) as Lang.String Create a formatted String by substituting the given parameters into the given format at the corresponding locations.

## Typedef Details

### `Comparable as interface {function compareTo(other as Lang.Object) as Lang.Number;}`

Comparable defines an ordering between an object and others.

Comparator can be use to specify an ordering between an object and others.

**Since:** API Level 5.0.0

### `Comparator as interface {function compare(a as Lang.Object, b as Lang.Object) as Lang.Number;}`

Comparator defines an ordering between objects.

Comparator can be use to specify an ordering between objects.

**Since:** API Level 5.0.0

### `Decimal as Lang.Float or Lang.Double`

**Since:** API Level 1.0.0

### `Integer as Lang.Number or Lang.Long`

**Since:** API Level 1.0.0

### `Numeric as Lang.Number or Lang.Float or Lang.Long or Lang.Double`

**Since:** API Level 1.0.0

## Instance Method Details

### `format(format as Lang.String, parameters as Lang.Array) as Lang.String`

Create a formatted String by substituting the given parameters into the given format at the corresponding locations.

**Parameters:**
- format — (Lang.String) — A string using $1$, $2$, $3$... as substitution identifiers
- parameters — (Lang.Array) — The Array of content to substitute into the formatted String

**Example:**
```
// Set the 'myString' variable to "Your next meeting is at 2:30 on Sep 4 in room 6820."
using Toybox.Lang
var myFormat = "Your next meeting is at $1$:$2$ on $3$ $4$ in room $5$.";
var myParams = [2, 30, "Sep", 4, "6820"];
var myString = Lang.format(myFormat, myParams);
```

**Returns:**
- Lang.String — A new String with the substituted content

**Since:** API Level 1.0.0
