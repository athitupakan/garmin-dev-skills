---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/FitContributor.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/FitContributor.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.FitContributor

## Overview

The FitContributor module allows Applications and Data Fields to record Field data into FIT files on the device's file system during an activity. This is useful for recording data that is not already calculated by the device, which can be synced to a service like Garmin Connect.

There are three FitContributor message types available:

- **MESG_TYPE_SESSION**: Session data is written once per recording session at the end of the recording, and is used for data that pertains to the entire session (e.g. average speed).

- **MESG_TYPE_LAP**: Lap data is written once for every lap in the session, and used for data that pertains to each lap (e.g. average lap speed).

- **MESG_TYPE_RECORD**: Depending on the device, record data is written once per second or when new data is available (Smart Recording), but is never written faster than once per second. This message type is used for instantaneous values (e.g. current speed).

Data type constants are also available for use with the createField() method.

## See Also:

- Session.createField()
- Learn more about the FIT format

**Example:**
Using a FitContributor Field in a SimpleDataField app

```
using Toybox.FitContributor;
using Toybox.WatchUi;
class BananasEarnedView extends WatchUi.SimpleDataField
{
    var bananasEarnedField = null;
    var totalBananas = 0.0;

    const CALORIES_PER_BANANA = 105.0;
    const BANANAS_FIELD_ID = 0;

    function initialize() {
        SimpleDataField.initialize();

        // Create the custom FIT data field we want to record.
        bananasEarnedField = createField(
            "bananas_earned",
            BANANAS_FIELD_ID,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>Fit.MESG_TYPE_RECORD, :units=>"B"}
        );

        bananasEarnedField.setData(0.0);
    }

    function compute(info) {
        if (info != null && info.calories != null) {
            // Calculate and set data to be written to the Field
            totalBananas = (info.calories / CALORIES_PER_BANANA).toFloat();
            bananasEarnedField.setData(totalBananas);
        }
        // Display the data on the screen of the device
        return totalBananas;
    }
}
```

**Since:** API Level 1.3.0

**App Types and Runtime Contexts:**

- Data Field
- Glance
- Watch App

_Supported on 160 devices._

**Requires Permission:**

- FitContributor

## Classes Under Namespace

**Classes:** Field

## Constant Summary

### MessageType

**Since:** API Level 1.3.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| MESG_TYPE_SESSION | 18 | API Level 1.3.0 | The message type for session messages. |
| MESG_TYPE_LAP | 19 | API Level 1.3.0 | The message type for lap messages. |
| MESG_TYPE_RECORD | 20 | API Level 1.3.0 | The message type for record messages. |

### DataType

**Since:** API Level 1.3.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| DATA_TYPE_SINT8 | 1 | API Level 1.3.0 |  |
| DATA_TYPE_UINT8 | 2 | API Level 1.3.0 |  |
| DATA_TYPE_SINT16 | 3 | API Level 1.3.0 |  |
| DATA_TYPE_UINT16 | 4 | API Level 1.3.0 |  |
| DATA_TYPE_SINT32 | 5 | API Level 1.3.0 |  |
| DATA_TYPE_UINT32 | 6 | API Level 1.3.0 |  |
| DATA_TYPE_STRING | 7 | API Level 1.3.0 |  |
| DATA_TYPE_FLOAT | 8 | API Level 1.3.0 |  |
| DATA_TYPE_DOUBLE | 9 | API Level 1.3.0 |  |
