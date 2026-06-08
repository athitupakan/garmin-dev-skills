---
source: https://developer.garmin.com/connect-iq/core-topics/notifications/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Notifications.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Notifications

Background services are allowed to periodically run, either by scheduling an update or being woken up by an event. Sometimes you may want to ask the user to open your app based on background processing.

| API | Description | API level |
| --- | --- | --- |
| Background.requestApplicationWake() | Request the user launch the application. This displays as a confirmation. | 2.3.0 |
| Notifications.showNotification() | Notify the user of an event from the background. This displays as an app notification. | 5.1.0 |
| Notifications.registerForNotificationMessages() | Receive status of app notifications. | 5.1.0 |

## Waking the Application

*Since API level 2.3.0*

Background.requestApplicationWake() allows you to interrupt the user to request that they open your application. When called, the user will be presented with a confirmation message of your choice. The system may suppress the request if there are not sufficient resources to launch the app.

## Notifications

*Since API level 5.1.0*

The Notifications API allows you to tie into the notification system and give actionable notifications to the user. To show a notification to the user, use the Notifications.showNotification() API. The notification can have the following items:

- Title string
- Sub-title string
- Body string
- Custom icon. If this is not specified, the app icon is used.

The presentation will match the personality of the device, and is not guaranteed to display the same across different devices. If multiple notifications are present, the most recent notification will be displayed. You can set the `:dismissPrevious` option to true to request the system clear other notifications from your application before displaying the new one.

You are allowed to define an array of actions with the notification. The actions are defined as a string and serializable data. The action strings are presented to the user with the notification. If the user selects one of these actions, the `state` dictionary of your AppBase.onStart() is called with `:launchedFromNotification` containing the action data. By default, the notification has a launch and dismiss action associated with it. Using the `:data` option allows you to associate data with the default action.

Notifications.registerForNotificationMessages() allows the app to be notified if a notification action is triggered, or if the notification is dismissed.

## Example

The following would display a notification with the “Reply” and “Dismiss” options:

```
Notifications.showNotification("Jeff", "Something Happened", {
     :icon => Rez.Drawables.EmergencyIcon,
     :data => {},
     :actions => [
        { :label => Rez.Strings.ReplyAction, :data => MY_NOTIFICATION_ID_REPLY },
        { :label => Rez.Strings.ForwardAction, :data => MY_NOTIFICATION_ID_FORWARD },
     ],
});
```

# See Also

The Notification sample shows how to use notifications.
