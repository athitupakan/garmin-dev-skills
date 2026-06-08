---
source: https://developer.garmin.com/connect-iq/core-topics/backgrounding/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Backgrounding.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Background Services

*Since API level 2.3.0*

Applications can register for background services. Services can be registered to run when various events occur. These events include when the user reaches goal targets, when sleep and wake times occur, when a steps threshold is reached, or at a scheduled time. Modules available to background processes differ from those of their parent application.

Services may be terminated at any time free memory for foreground applications. Services will also be terminated automatically if the do not exit properly within 30 seconds of opening.

## Registering for Events

When your application runs you can register for events your application can subscribe to by using calls in the Toybox.Background module.

| Event | Description | Register With | API Level |
| --- | --- | --- | --- |
| Activity Completed | Wakes your background service when the user completes an activity | Background.registerForActivityCompletedEvent() | 3.1.0 |
| Goal | Wakes your background service when the user meets one of their activity goals | Background.registerForGoalEvent() | 2.3.0 |
| OAUTH Response | Wakes your background service when the user completes the OAUTH flow | Background.registerForOAuthResponseEvent() | 2.3.0 |
| Phone App Message | Wakes your background service when your app receives a message from the Mobile SDK | Background.registerForPhoneAppMessageEvent() | 3.2.0 |
| Sleep | Wakes your background service at the time the user has configured as their sleep time | Background.registerForSleepEvent() | 2.3.0 |
| Steps | Wakes your background service every 1000 steps taken by the user | Background.registerForStepsEvent() | 2.3.0 |
| Temporal | Allows your service to be woken at a specific time or repeatedly at a certain interval (up to every five minutes) | Background.registerForTemporalEvent() | 2.3.0 |

## Making a `ServiceDelegate`

When background services are started, the AppBase.getServiceDelegate() is called. This method returns a System.ServiceDelegate and the method corresponding to the event that triggered is invoked. Once a background service has finished any necessary tasks, it should exit using the Background.exit() method. This method takes a argument containing data to be sent to the main process. Use null to provide no data.

### Application Scope

Background services are allowed to run at any time, including while the user is in an activity. In order to achieve this, the memory pool made available to background services is much smaller than what is available for the application. In many instances, the executable code of your application will be larger than the memory pool available.

The Connect IQ compiler allows you to select what code is necessary for running in the background with the `:background` annotation. Only modules, classes, functions and member variables decorated with the `:background` annotation will be compiled into your background service. This means you must decorate all related code with the annotation (including your Application class).

```
import Toybox.Application;
import Toybox.Background;
import Toybox.System;
import Toybox.Time;

// Because this is referenced in the application object
// constructor, it must be marked as background.
(:background)
var globalMember;

// Your application object has to be marked as background
// so that the service delegate can be referenced
(:background)
class MyApp extends Application.AppBase {

    // Constructor. Remember everything referenced in this function
    // must be marked as background
    public function initialize() {
        // Register to run every five minutes
        if(Background.getTemporalEventRegisteredTime() != null) {
            Background.registerForTemporalEvent(new Time.Duration(5 * 60))
        }
        // Initialize a global member
        $.globalMember = true;
    }

    public function getServiceDelegate() as [System.ServiceDelegate] {
        return [new MyServiceDelegate()];
    }

}

// Your service delegate has to be marked as background
// so it can handle your service callbacks
(:background)
class MyServiceDelegate extends System.ServiceDelegate {

    public function onTemporalEvent() as Void {
        // Do fun stuff here
    }

}
```

If your type check level is at `informative` or above, the compiler will detect if your background service or any objects referenced is attempting to reference something not marked as background. See Monkey Types for more information.

The resource compiler can control the scope level of your resources as well. See the Resources section for more information.

## Simulating Background Services

In the Connect IQ simulator, an option has been added under the Simulation menu, which allows manually triggering background services. When manually triggering a service, the background service for the most recently run application will be loaded, and the corresponding call in the System.ServiceDelegate will be triggered regardless of whether the application has registered for that event.
