---
source: https://developer.garmin.com/connect-iq/core-topics/downloading-content/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Downloading_Content.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Downloading Content

*Since API level 2.2.0*

The Toybox.PersistedContent module allows access to the saved Tracks, Courses, Waypoints, Workouts, and Routes that the user has on their device. These content types contain a name and a unique identifier, which can be used by System.exitTo() as an System.Intent to launch into a native app and present the content to the user in some way. See the Intents section for more details.

| Type | Object | API Level |
| --- | --- | --- |
| Track, Route, Course | PersistedContent.Track, PersistedContent.Route, PersistedContent.Course 1 | 2.2.0 |
| Waypoint | PersistedContent.Waypoint | 2.2.0 |
| Workout | PersistedContent.Workout | 2.2.0 |

Calling System.exitTo() with a Toybox.PersistedContent object prompts the user to choose which native app to launch. For example, if an app calls System.exitTo() with a PersistedContent.Waypoint object, the dialog will ask whether to launch the waypoint with one of either the Run or Bike native apps.

When retrieving the list of stored content on the device, a PersistedContent.Iterator will be returned. The Iterator.next() function must be called to get the first entry, and `null` is returned when there are no more entries:

```
import Toybox.PersistedContent;
import Toybox.System;

function example() as Void {}
    // Get the first waypoint from the device
    var waypoints = PersistedContent.getWaypoints();
    var waypoint = waypoints.next();

    if(waypoint != null) {
        // Launch the waypoint (User will be asked
        // what activity to launch in)
        System.exitTo(waypoint.toIntent());
    }
}
```

There are three possible cases once the content is sent to the device:

1. **Data import is successful** - A `PersistedContent.Iterator` will be returned, which contains the elements that were downloaded.
2. **The system does not have enough space** - The `STORAGE_FULL` response will be returned to the `responseCallback`.
3. **The system does not support the file type** (i.e. a running workout is sent to a cycling device) - The `responseCallback` will return an empty iterator or `null` value.

Access to `PersistedContent` requires the 'Persisted Content' permission.

## Persisted Content in the Simulator

Because native apps are not simulated in Connect IQ simulator, an *Intent Launched* feature has been added that is useful for testing with Toybox.PersistedContent. This feature displays three critical pieces of information about the Toybox.PersistedContent object supplied via System.Intent in the simulator window:

1. The object type
2. The unique serializable ID of the object
3. The name of the object

For example, the sample code above may display a picture of an activity with "Intent Launched", a type, an ID number and its name displayed.

*Since API level 3.1.0*

In some cases, the Bluetooth low energy (BLE) link to Garmin Connect Mobile is too slow for downloading some content. For these situations, the WiFi Bulk Downloads feature can prove useful.

The Toybox.Communications module provides methods to initiate a transition to sync mode, and communicate sync status information to the system for display. The Application.AppBase class provides an entry point for the system to get a delegate used to communicate with the app while in sync mode.

| Function or Class | Purpose |
| --- | --- |
| Communications.startSync() | Exit the Application and launch it in sync mode. |
| AppBase.getSyncDelegate() | Get a SyncDelegate object that communicates sync status to the system |
| Communications.SyncDelegate | A delegate object that the user implements to respond to sync request |
| Communications.notifySyncProgress() | Send a system notification to the system to indicate overall sync progress. |
| Communications.notifySyncComplete() | Send a system notification to the system to indicate that the sync completed. |

To use the bulk download functionality, implement AppBase.getSyncDelegate() to return an instance of a class derived from Communications.SyncDelegate. When the application calls Communications.startSync(), the system will terminate the running application, re-launch it in sync mode, and make a call to AppBase.getSyncDelegate() to retrieve the application's Communications.SyncDelegate.

Once the application has retrieved the application's Communications.SyncDelegate, it will verify that a sync is necessary by calling SyncDelegate.isSyncNeeded(). If this method returns `true`, the system will proceed to call SyncDelegate.onStartSync(). At this point, the delegate may initiate a request to download content by making a call to Communications.makeWebRequest() or Communications.makeImageRequest(). When the response callback for the request is invoked, the delegate should notify the system of the progress made by calling Communications.notifySyncProgress(). If additional content remains to be downloaded, another content request may be issued. This cycle should repeat until all content has been downloaded or an error has occurred, at which time a call to Communications.notifySyncComplete() should be made to notify the system that the app can leave sync mode.

If the user decides to cancel the bulk download operation, the system will call SyncDelegate.onStopSync() to notify the application. The app must acknowledge the sync cancellation by calling Communications.notifySyncComplete(). The system will display the given error message, if appropriate, and will proceed to exit sync mode.

For more see the `BulkDownload` sample app distributed with the SDK.

1 I can't tell you what the differences are. Sometimes our job is to just abstract the thing and not ask questions.
