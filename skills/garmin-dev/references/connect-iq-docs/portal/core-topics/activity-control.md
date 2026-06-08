---
source: https://developer.garmin.com/connect-iq/core-topics/activity-control/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Activity_Control.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Activity Control

*Since API 5.2.0*

Using System.exitTo() allows apps to transition the user to an activity with downloaded content. The DataField.setWorkout() and DataField.routeTo() functions allow a data field to directly update the current workout or route of an activity.

These APIs require the `ActivityControl` permission:

| Function or Class | Purpose | API Version |
| --- | --- | --- |
| DataField.routeTo() | Change the current route of an activity. Takes Position.Location or PersistedContent.Waypoint objects. | 5.2.0 |
| DataField.setWorkout() | Change the current workout of an activity. Takes a PersistedContent.Workout or an array of Activity.WorkoutStepInfo objects. | 5.2.0 |
