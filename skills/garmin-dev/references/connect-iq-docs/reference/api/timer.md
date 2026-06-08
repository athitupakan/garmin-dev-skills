---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Timer.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Timer.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Timer

## Overview

The Timer module allows access to a Timer object.

This Timer can be used to run code at some point in the future or at a regular interval.

**Since:** API Level 1.0.0

**App Types and Runtime Contexts:**

- Audio Content Provider
- Glance
- Watch App
- Watch Face
- Widget

## Classes Under Namespace

**Classes:** Timer


---

# Class: Toybox.Timer.Timer

- **Inherits:**
 : Toybox.Lang.Object - Toybox.Lang.Object - Toybox.Timer.Timer

## Overview

A Timer object will invoke a callback function after a specified number of milliseconds.

There are two types of timers: one-shot or repeating. A one-shot Timer will only run once after the Timer expires, while a repeating Timer will invoke the callback function every n milliseconds until stop() is called. If a repeating Timer fails to run before its next execution time, then any missed executions will be skipped.

The number of available timers (default 3) and the minimum time value (default 50 ms) depends on the host system. An error will occur if too many timers are set.

**Example:**
Create a counter that increments by one each second

```
using Toybox.Timer;
var myCount =  0;

function timerCallback() {
    myCount += 1;
    Ui.requestUpdate();
}

function onLayout(dc) {
    var myTimer = new Timer.Timer();
    myTimer.start(method(:timerCallback), 1000, true);
}
```

**Since:** API Level 1.0.0

## Instance Method Summary
- **start**(callback as Lang.Method() as **Void**, time as Lang.Number, repeat as Lang.Boolean) as **Void** Start the Timer.
- **stop**() as **Void** Stops the Timer from running.

## Instance Method Details

### `start(callback as Lang.Method() as Void, time as Lang.Number, repeat as Lang.Boolean) as Void`

Start the Timer.

Note:

Will cause an app crash if called from a watch face app while in low power mode

**Parameters:**
- callback — (Lang.Method) — A function to call after the Timer completes
- time — (Lang.Number) — The number of milliseconds to wait before invoking callback
- repeat — (Lang.Boolean) — Set to `true` to have the Timer repeat until stop() is called

**Since:** API Level 1.0.0

### `stop() as Void`

Stops the Timer from running.

This only needs to be called for repeating timers. A Timer can be started again by calling start().

**Since:** API Level 1.0.0
