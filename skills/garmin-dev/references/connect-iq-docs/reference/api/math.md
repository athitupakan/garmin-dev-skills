---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Math.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Math.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Math

## Overview

The Math Module provides various math methods available for use by Apps.

**Example:**
Prints the circumference of a circle.

```
using Toybox.System;
using Toybox.Math;
var r = 5;
var circumference = (2 * Math.PI * r);

System.println(circumference);
```

**Example:**
Prints the area of a square with Math.pow via direct call.

```
using Toybox.System;
using Toybox.Math;

System.println(Math.pow(10, 2));
```

**Example:**
Solves for c using the Pythagorean Theorem and multiple Math API methods.

```
using Toybox.System;
using Toybox.Math;
var a = 2;
var b = 3;
var c = Math.sqrt((Math.pow(a, 2) + Math.pow(b, 2)));

System.println(c);
```

**Since:** API Level 1.0.0

## Classes Under Namespace

**Classes:** Filter, FirFilter, IirFilter

## Constant Summary

### Constant Variables

| Type | Name | Value | Since | Description |
| --- | --- | --- | --- | --- |
| Type | E | 2.7182818284590452354 | API Level 1.0.0 | 32-bit floating point representation of E |
| Type | PI | 3.14159265358979323846 | API Level 1.0.0 | 32-bit floating point representation of PI |

## Instance Method Summary
- **acos**(x as Lang.Numeric) as Lang.Decimal Get the arc cosine of an angle.
- **asin**(x as Lang.Numeric) as Lang.Decimal Get the arc sine of an angle.
- **atan**(x as Lang.Numeric) as Lang.Decimal Get the arc tangent of an angle.
- **atan2**(y as Lang.Numeric, x as Lang.Numeric) as Lang.Decimal Get the arc tangent of y/x in radians.
- **ceil**(x as Lang.Numeric) as Lang.Numeric Compute the ceiling of a value.
- **cos**(x as Lang.Numeric) as Lang.Decimal Get the cosine of an angle.
- **floor**(x as Lang.Numeric) as Lang.Numeric Compute the floor of a value.
- **ln**(x as Lang.Numeric) as Lang.Decimal Get natural logarithm of a value.
- **log**(x as Lang.Numeric, base as Lang.Numeric) as Lang.Decimal Get logarithm of a value using the specified base.
- **mean**(data as Lang.Array) as Lang.Double Get the arithmetic mean (average) of an array of data.
- **mode**(data as Lang.Array) as Lang.Object Get the most common value found in an array of data.
- **pow**(x as Lang.Numeric, y as Lang.Numeric) as Lang.Decimal Calculate x to the power of y.
- **rand**() as Lang.Number Returns a pseudo-random Number.
- **round**(x as Lang.Numeric) as Lang.Numeric Round a value.
- **sin**(x as Lang.Numeric) as Lang.Decimal Get the sine of an angle.
- **sqrt**(x as Lang.Numeric) as Lang.Decimal Calculate the square root of a value.
- **srand**(seed as Lang.Number) as **Void** Seed the random number generator.
- **stdev**(data as Lang.Array, xbar as Lang.Double or **Null**) as Lang.Double Get the standard deviation of a sample of population data.
- **tan**(x as Lang.Numeric) as Lang.Decimal Get the tangent of an angle.
- **toDegrees**(x as Lang.Numeric) as Lang.Decimal Convert an angle from radians to degrees.
- **toRadians**(x as Lang.Numeric) as Lang.Decimal Convert an angle from degrees to radians.
- **variance**(data as Lang.Array, xbar as Lang.Numeric or **Null**) as Lang.Double Get the sample variance of an array of data.

## Instance Method Details

### `acos(x as Lang.Numeric) as Lang.Decimal`

Get the arc cosine of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The cosine value

**Returns:**
- Lang.Float, Lang.Double — The interval [0..PI] in radians, or `NaN` if invalid Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `asin(x as Lang.Numeric) as Lang.Decimal`

Get the arc sine of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The sine value

**Returns:**
- Lang.Float, Lang.Double — The interval [-PI/2..PI/2] in radians, or `NaN` if invalid Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `atan(x as Lang.Numeric) as Lang.Decimal`

Get the arc tangent of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The tangent value

**Returns:**
- Lang.Float, Lang.Double — The interval [-PI/2..PI/2] in radians, or `NaN` if invalid Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `atan2(y as Lang.Numeric, x as Lang.Numeric) as Lang.Decimal`

Get the arc tangent of y/x in radians.

**Parameters:**
- y — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The proportion of the y coordinate
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The proportion of the x coordinate

**Returns:**
- Lang.Float, Lang.Double — The principal arc tangent of y/x, in the interval [-PI..PI] radians, or `NaN` if invalid Float if both inputs are Number or Float
- Double if either input is Long or Double

**Since:** API Level 1.3.0

### `ceil(x as Lang.Numeric) as Lang.Numeric`

Compute the ceiling of a value.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — A numeric value

**Returns:**
- Lang.Number, Lang.Float, Lang.Long, Lang.Double — The smallest integer greater than or equal to x Return type matches the input parameter type

**Since:** API Level 1.3.0

### `cos(x as Lang.Numeric) as Lang.Decimal`

Get the cosine of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The angle in radians

**Returns:**
- Lang.Float, Lang.Double — The cosine value of x in radians Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `floor(x as Lang.Numeric) as Lang.Numeric`

Compute the floor of a value.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — A numeric value

**Returns:**
- Lang.Number, Lang.Float, Lang.Long, Lang.Double — The largest integer less than or equal to x Return type matches the input parameter type

**Since:** API Level 1.3.0

### `ln(x as Lang.Numeric) as Lang.Decimal`

Get natural logarithm of a value

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The value for which to get the logarithm

**Returns:**
- Lang.Float, Lang.Double — natural logarithm of x Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 2.3.0

### `log(x as Lang.Numeric, base as Lang.Numeric) as Lang.Decimal`

Get logarithm of a value using the specified base

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The value for which to get the logarithm
- base — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The base value.

**Returns:**
- Lang.Float, Lang.Double — specified base logarithm of x Float if both inputs are Number or Float
- Double if either input is Long or Double

**Since:** API Level 1.0.0

### `mean(data as Lang.Array) as Lang.Double`

Get the arithmetic mean (average) of an array of data.

**Parameters:**
- data — (Lang.Array) — An array of Number, Float, Long, or Double values

**Returns:**
- Lang.Double — The arithmetic mean of the values in data

**Since:** API Level 3.1.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if the provided data array is empty.

### `mode(data as Lang.Array) as Lang.Object`

Get the most common value found in an array of data.

**Parameters:**
- data — (Lang.Array) — An array of Objects

**Returns:**
- Lang.Object — The most frequently occurring value in data.

**Since:** API Level 3.1.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if there is no most frequently occurring value or the passed in value array is empty

### `pow(x as Lang.Numeric, y as Lang.Numeric) as Lang.Decimal`

Calculate x to the power of y.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — Base
- y — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — Exponent

**Returns:**
- Lang.Float, Lang.Double — x to the power of y Float if both inputs are Number or Float
- Double if either input is Long or Double

**Since:** API Level 1.0.0

### `rand() as Lang.Number`

Returns a pseudo-random Number. Use the srand() function to seed the random number generator.

**Returns:**
- Lang.Number — Non-negative random number

**Since:** API Level 1.0.0

### `round(x as Lang.Numeric) as Lang.Numeric`

Round a value.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — A numeric value

**Returns:**
- Lang.Number, Lang.Float, Lang.Long, Lang.Double — The closest integer to x. Decimal values >= .5 will be rounded up Return type matches the input parameter type

**Since:** API Level 1.3.0

### `sin(x as Lang.Numeric) as Lang.Decimal`

Get the sine of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The angle in radians

**Returns:**
- Lang.Float, Lang.Double — The sine value of x in radians Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `sqrt(x as Lang.Numeric) as Lang.Decimal`

Calculate the square root of a value.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The value for which to get the square root

**Returns:**
- Lang.Float, Lang.Double — The square root of x, or `NaN` if invalid Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.0.0

### `srand(seed as Lang.Number) as Void`

Seed the random number generator.

Note:

srand() does not return any value.

**Parameters:**
- seed — (Lang.Number) — The value used for seeding rand()

**Since:** API Level 1.0.0

### `stdev(data as Lang.Array, xbar as Lang.Double or Null) as Lang.Double`

Get the standard deviation of a sample of population data.

**Parameters:**
- data — (Lang.Array) — An array of Number, Float, Long, or Double values with at least two elements.
- xbar — (Lang.Double) — The mean, if known. Otherwise, pass `null` and the mean of data will be calculated.

**Returns:**
- Lang.Double — The standard deviation of the samples

**Since:** API Level 3.1.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if the provided data array has fewer than two elements.

### `tan(x as Lang.Numeric) as Lang.Decimal`

Get the tangent of an angle.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The angle in radians

**Returns:**
- Lang.Float, Lang.Double — The tangent value of x in radians Toybox::Lang::Float if input is Toybox::Lang::Number or Toybox::Lang::Float Toybox::Lang::Double if input is Toybox::Lang::Long or Toybox::Lang::Double

**Since:** API Level 1.0.0

### `toDegrees(x as Lang.Numeric) as Lang.Decimal`

Convert an angle from radians to degrees.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The angle in radians

**Returns:**
- Lang.Float, Lang.Double — The angle of x in degrees Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.3.0

### `toRadians(x as Lang.Numeric) as Lang.Decimal`

Convert an angle from degrees to radians.

**Parameters:**
- x — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The angle in degrees

**Returns:**
- Lang.Float, Lang.Double — The angle of x in radians Float if input is Number or Float
- Double if input is Long or Double

**Since:** API Level 1.3.0

### `variance(data as Lang.Array, xbar as Lang.Numeric or Null) as Lang.Double`

Get the sample variance of an array of data.

Returns the sample variance with Bessel's correction.

**Parameters:**
- data — (Lang.Array) — An array of Number, Float, Long, or Double values with at least two elements.
- xbar — (Lang.Number, Lang.Float, Lang.Long, Lang.Double) — The mean, if known. Otherwise, pass `null` and the mean of data will be calculated.

**Returns:**
- Lang.Double — The variance of the samples

**Since:** API Level 3.1.0

**Throws:**
- (Lang.InvalidValueException) — Thrown if the provided data array has fewer than two elements.
