---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Time.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Time.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Time

## Overview

The Time module provides functionality for dealing with times and dates.

There are two main concepts used by Monkey C when working with time: the Moment and Duration. A Moment is a single point in time, while a Duration is a span of time. Moments and Durations can be used together for time calculations in the following ways:

```
  Expression           Method               Result    Notes
  ---------------------------------------------------------------------------
  Moment + Moment      -                    -         Invalid
  Moment + Duration    Moment.add()         Moment    A later Moment
  Moment - Moment      Moment.subtract()    Duration  The span between Moments
  Moment - Duration    Moment.subtract()    Moment    An earlier Moment

  Duration + Duration  Duration.add()       Duration  A longer Duration
  Duration + Moment    Duration.add()       Moment    A later Moment
  Duration - Duration  Duration.subtract()  Duration  A shorter Duration
  Duration - Moment    -                    -         Invalid
```

Dates and times are generally represented in UTC time from the UNIX epoch, with the exception of the Gregorian Moment, which are created relative to the current local time.

Date and time formatting in Monkey C is relatively open-ended, providing some formatting constants for short, medium, and long formatting (long and medium formatting are currently equivalent).

```
  Constant          Seconds  Minutes  Hours  Day of Week  Day  Month  Year
  ---------------------------------------------------------------------------
  FORMAT_SHORT   |  0        0        0      4            1    3      2017
  FORMAT_MEDIUM  |  0        0        0      Wed          1    Mar    2017
  FORMAT_LONG    |  0        0        0      Wed          1    Mar    2017
```

## See Also:

- UTC Time
- UNIX Time

**Example:**
Formatting and printing a date

```
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
var dateString = Lang.format(
    "$1$:$2$:$3$ $4$ $5$ $6$ $7$",
    [
        today.hour,
        today.min,
        today.sec,
        today.day_of_week,
        today.day,
        today.month,
        today.year
    ]
);
System.println(dateString); // e.g. "16:28:32 Wed 1 Mar 2017"
```

**Example:**
Creating a Moment representing May 16, 2003

```
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
var options = {
    :year   => 2003,
    :month  => 5,
    :day    => 16,
    :hour   => 6    // UTC offset, in this case for CST
};
var birthday = Gregorian.moment(options);
```

**Since:** API Level 1.0.0

## Modules Under Namespace

**Modules:** Time.Gregorian

## Classes Under Namespace

**Classes:** Duration, LocalMoment, Moment, RealTimeClockNotValidException

## Constant Summary

### DateFormat

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| FORMAT_SHORT | 0 | API Level 1.0.0 | Short formatting is a numerical representation of date/time. |
| FORMAT_MEDIUM | 1 | API Level 1.0.0 | Medium formatting is a mix of Numbers and Strings depending on which function is called. If formatted as a String, the result is an abbreviated form of the time or date. |
| FORMAT_LONG | 2 | API Level 1.0.0 | Long formatting is a mix of Numbers and Strings depending on which function is called. If formatted as a String, the result is an abbreviated form of the time or date. |

### CurrentTime

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CURRENT_TIME_DEFAULT | 0 | API Level 3.0.10 | The default system clock, which may be user-modified. |
| CURRENT_TIME_GPS | 1 | API Level 3.0.10 | The clock time based on your current GPS location if a GPS signal is available. |
| CURRENT_TIME_RTC | 2 | API Level 3.0.10 | The system's real-time clock that cannot be overridden by user settings, and can only be updated by trusted sources such as GPS. |

## Instance Method Summary
- **getCurrentTime**(options as { :currentTimeType as Time.CurrentTime }) as Time.Moment Get a Moment for the current time based on the specified source.
- **now**() as Time.Moment Get a Moment for the current time.
- **today**() as Time.Moment Get a Moment for midnight today.

## Instance Method Details

### `getCurrentTime(options as { :currentTimeType as Time.CurrentTime }) as Time.Moment`

Get a Moment for the current time based on the specified source.

This method behaves the same as Time.now(), but accepts an `options` argument that allows the time source to be selected.

**Parameters:**
- options — (Lang.Dictionary) — Clock options :currentTimeType — (Time.CurrentTime) — A Time.CURRENT_TIME_* value, which defaults to Time.CURRENT_TIME_DEFAULT if no time type is provided

**See Also:**

- Time.now()

**Since:** API Level 3.0.10

**Throws:**
- (Time.RealTimeClockNotValidException) — Thrown if Time.CURRENT_TIME_RTC is passed as an option and the real-time clock value is not valid, i.e. synced with trusted source such as GPS.

### `now() as Time.Moment`

Get a Moment for the current time.

**Example:**
Using now() on December 31, 1989 at 5:00 pm CST

```
using Toybox.Time;
var now = new Time.Moment(Time.now().value()); // UNIX epoch 631148400
```

**Returns:**
- Time.Moment — A Moment representing the current moment in time.

**See Also:**

- UTC Time
- UNIX Time

**Since:** API Level 1.0.0

### `today() as Time.Moment`

Get a Moment for midnight today.

**Example:**
Using today() on December 31, 1989 at 5:00 pm CST

```
using Toybox.Time;
var now = new Time.Moment(Time.today().value()); // UNIX epoch 631087200
```

**Returns:**
- Time.Moment — A Moment representing the the beginning of the current day.

**See Also:**

- UTC Time
- UNIX Time

**Since:** API Level 1.0.0
