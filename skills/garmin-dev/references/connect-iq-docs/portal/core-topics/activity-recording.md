---
source: https://developer.garmin.com/connect-iq/core-topics/activity-recording/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Activity_Recording.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Activity Recording

Imagine that you are trying to create a yoga app. You'd like the app to record heart rate and calories burned during your yoga workout, just like other Garmin apps. You'd also like the recording to be displayed on Garmin Connect. Monkey C allows for apps to start and stop recording of FIT files. Controlling the FIT file recording requires a few steps:

1. Enable the sensors to be recorded
2. Use ActivityRecording.createSession() to create a session object
3. Use the Session.start() method of the FIT session to begin recording. Data from the enabled sensors will be recorded into the FIT file.
4. Use Session.stop() to pause the recording
5. Use Session.save() to save the recording, or Session.discard() to delete the recording

The FIT file will sync with Garmin Connect. You can use the Garmin Connect Developer Program to process the FIT file from a web service.

For more, see the `RecordSample` sample app distributed with the SDK.

## Recording FIT Files

In addition to being able to play back existing FIT files, the simulator can also record files using data obtained via the *Simulation*>*Activity Data* menu option. To begin recording a session you must start the timer; this can be done by clicking the start button on the dialog, or by clicking the corresponding start button on the device you have selected. The following table describes the different options available for activity recording and provides instructions for how to access them via the dialog, or the device buttons (where available).

| Option | Dialog | Device Button | Notes |
| --- | --- | --- | --- |
| Start Activity | Start | Start Button | The device start button starts and stops an activity. |
| Stop Activity | Stop | Start Button | The device start button starts and stops an activity, and the *Start* button on the dialog is renamed to *Stop* when recording is active. |
| Lap Activity | Lap | Back Button | Records a lap record in the FIT file. Note this option is only available when FIT data simulation is enabled and activity recording is active. |
| Pause Activity | Pause | N/A | Pauses activity recording. Note this option is only available when FIT data simulation is enabled and activity recording is active. |
| Resume Activity | Resume | N/A | Resumes activity recording. Note this option is only available when FIT data simulation is enabled and activity recording is paused. |
| Complete Workout Step | Workout Step | N/A | Completes the current workout step. Note this option is only available when FIT data simulation is enabled and activity recording is active. |
| Move to Next Multisport | Next Multisport | N/A | Transitions to the next multisport leg. Note this option is only available when FIT data simulation is enabled and activity recording is active. |
| Select Split Type | Split Type | N/A | Selects the desired split type to be added to the current activity. Note this option is only available on devices with API level 5.2.2 and when recording is active. |
| Start Split | Start Split | N/A | Adds the selected split to the current activity. Note this option is only available on devices with API level 5.2.2 and when activity recording is active. |
| End Split | End Split | N/A | Ends the split in the current activity. Note this option is only available on devices with API level 5.2.2 and when the split is active. |
| Discard Activity | Discard | N/A | Discards the current recording and deletes the corresponding .fit file. Note this is only enabled if activity recording has been started and subsequently stopped. |
| Save Activity | Save | N/A | Saves the recorded activity into a .fit file and resets the timer state. Note this is only enabled if activity recording has been started and subsequently stopped. |

Note: the device simulator will not automatically start activity recording when a data field is being run. You must explicitly start and stop activity recording as described here.

## FIT Developer Fields

Now imagine you want to add a new metric - Namastes - to the Yoga app `namaste`. This metric will combine heart rate, accelerometer, and other sensor data into a single value, and does not have an analog in any Garmin recording metric. To do this we need the Toybox.FitContributor module, which allows you to add new metrics to a FIT recording and display it on Garmin Connect.

First, you must enable the Toybox.FitContributor permission in the manifest file (see the Manifest and Permissions section for more information). Next, you need to add your field definitions in your resources using the `fitContributions` block:

```
    <strings>
        <string id="namaste_label">Namastes</string>
        <string id="namaste_graph_label">Namastes</string>
        <string id="namaste_units">N(s)</string>
    </strings>
    <fitContributions>
        <fitField id="0" displayInChart="true" sortOrder = "0" precision="2"
        chartTitle="@Strings.namaste_graph_label" dataLabel="@Strings.namaste_label"
        unitLabel="@Strings.namaste_units" fillColor="#FF0000" />
    </fitContributions>
```

The `fitField` block has a number of configurable options:

| Attribute | Value | Notes |
| --- | --- | --- |
| `id` | A numeric value from 0 to 255 used to refer to your field | No duplicates within an app are allowed |
| `displayInChart` | Indicates whether or not record level connect IQ data should be rendered in a chart | `true` if you want this entry to be displayed as a chart, `false` otherwise. Graph fields can only support numeric data. |
| `displayInActivityLaps` | Indicates whether or not lap level connect IQ data should be rendered in the Activity Laps section in the Garmin Connect Activity Details page | `true` if you want this entry to be displayed in the activity laps, `false` otherwise |
| `displayInActivitySummary` | Indicates whether or not activity (fit session) level connect IQ data should be rendered in the Activity Summary section in the Garmin Connect Activity Details page | `true` if you want this entry to be displayed in the activity summary data, `false` otherwise |
| `sortOrder` | Determines the order in which the Connect IQ data will appear in the Summary or Lap Sections of the Activity Details page and what order charts will be displayed on the Activity Details page | No duplicates are allowed |
| `precision` | Decimal point precision for numeric data | 0 for integer, 1 for one decimal point, 2 for two decimal points. Without this attribute the default is no rounding |
| `chartTitle` | This is the resources string key to use to render the title of the chart | Optional if `displayInChart` is `false`. Must be a string resource. |
| `dataLabel` | This is the resources string key to use to render the label of the data field in the Activity Summary or Activity Laps section of the Activity Details page (ex. Cadence, or Heart Rate). | Must be a string resource |
| `unitLabel` | This is the key to use to render the unit of the data field in the Activity Summary or Activity Laps section of the Activity Details page (ex. kph, or miles). | Must be a string resource |
| `fillColor` | RRGGBB value of color to use for chart | Optional if `displayInChart` is `false` |

This will communicate the metadata to display our chart to Garmin Connect. Now we need to create our Field in the code. You do this by using the Session.createField() method of the ActivityRecording.Session object within your source:

```
// Field ID from resources.
const NAMASTE_FIELD_ID = 0;
hidden var mNamasteField;

// Initializes the new Namaste field in the activity file
function setupField(session as Session) {
    // Create a new field in the session.
    // Current namastes provides an file internal definition of the field
    // Field id _must_ match the fitField id in resources or your data will not display!
    // The field type specifies the kind of data we are going to store.
    // For Record data this must be numeric, for others it can also be a string.
    // The mesgType allows us to say what kind of FIT record we are writing.
    //    FitContributor.MESG_TYPE_RECORD for graph information
    //    FitContributor.MESG_TYPE_LAP for lap information
    //    FitContributor.MESG_TYPE_SESSION` for summary information.
    // Units provides a file internal units field.
    mNamasteField =
        session.createField(
            "current_namastes", NAMASTE_FIELD_ID, FitContributor.DATA_TYPE_FLOAT,
            { :mesgType=>Fit.MESG_TYPE_RECORD, :units=>"N" });
}
```

Now when you call on `mNamasteField` the value will be recorded into either the Record, Lap, or Session information of the FIT file based on the message type specified when calling Session.createField(). If you are creating a Record (graph), you should update this value once a second. For lap and summary, you should provide constant updates to the current lap or workout value for the metric.

After setting this up, you will want to preview how this will look on Garmin Connect. We can use the Monkey Graph tool to create a preview. The Monkey Graph tool requires the following: a FIT file with the recorded developer data, and an IQ file of the app (you can acquire an IQ file via the App Export Wizard. The tool will allow you to test how charts will look before uploading your app for review. See how to launch the Monkey Graph tool included with the SDK.
