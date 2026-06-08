---
source: https://developer.garmin.com/connect-iq/core-topics/intents/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Intents.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Intents

*Since API level 2.2.0*

Intents allow a Connect IQ watch-app or widget to launch another Connect IQ watch-app, Connect IQ widget, or native application (e.g. built in activities like Run, Bike, etc.) by calling System.exitTo():

Calling System.exitTo() will cause a confirmation view to be displayed asking the user whether to exit to the intended app. If the user chooses 'No' then the app that called System.exitTo() will continue to run. If the user chooses 'Yes' then the app will exit and the new app will launch. While the confirmation view is shown, the originating app will continue to run.

## Exiting to Connect IQ Apps

In order to exit to another Connect IQ app, a System.Intent must be created, which contains a target app identifier and any arguments you wish to pass to the target app. The target app identifier must be specified using one of two supported URI schemes:

- `manifest-id://` followed by a valid UUID from the app's manifest.xml
- `store-id://` followed by a valid app store UUID

Arguments are passsed to the target app as a dictionary, which may be empty or `null`, and are received by the target app's AppBase.onStart() method as a Lang.Dictionary object.

```
import Toybox.System;
...
var intent = new System.Intent("manifest-id://01234567-89AB-CDEF-0123-456789ABCDEF", {"lat"=>38.856419, "lon"=>-94.801369});
System.exitTo(intent);
```

Assuming the target app is installed on the device, this example launches the app with manifest ID `01234567-89AB-CDEF-0123-456789ABCDEF` and passes it the `"lat"` and `"lon"` arguments.

## Exiting to Native Apps

System.Intent objects to launch native apps deal exclusively with Toybox.PersistedContent objects, such as PersistedContent.Waypoint, PersistedContent.Route, and PersistedContent.Track. Connect IQ handles most of the System.Intent functionality for native apps behind the scenes, automatically embedding the appropriate native app identifier in the Toybox.PersistedContent object, which is accessible via the `toIntent()` method. See the Persisted Content section for more information.

## Intent Exceptions

Connect IQ includes three exception types related to intents:

- System.UnexpectedAppTypeException is thrown if your app tries to exit to a Connect IQ app type other than device app or widget
- System.AppNotInstalledException is thrown if your app tries to exit to an app that is not installed
- System.PreviousOperationNotCompleteException is thrown if System.exitTo() is called a while a confirmation view from a previous System.exitTo() call has not been acknowledged by the user
