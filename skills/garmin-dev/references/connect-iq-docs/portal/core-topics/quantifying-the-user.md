---
source: https://developer.garmin.com/connect-iq/core-topics/quantifying-the-user/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Quantifying_the_User.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Quantifying User Information

Garmin devices collect and quantify numerous metrics about the user1. Connect IQ exposes many of the collected metrics so they can be incorporated into your solutions.

The Toybox.ActivityMonitor and Toybox.SensorHistory modules allow apps to access the activity tracking, wellness features, and historical sensor information of Garmin wearable devices.

## User Profile

The Toybox.UserProfile provides access to personal information about the user, including their gender, birth year, height, weight, and athletic metrics like VO2 Max and activity class. It requires the `UserProfile` permission to access.

The UserProfile.getProfile() call returns a UserProfile.Profile object, which provides

| Metric | API | Value | API Level |
| --- | --- | --- | --- |
| Activity Class | Profile.activityClass | A quantification of how active the user from 0 to 100 | 1.0.0 |
| Average Resting Heart Rate | Profile.averageRestingHeartRate | The user's seven day average resting heart rate (bpm) | 3.2.0 |
| Biological Sex | Profile.gender | The user's biological gender | 1.0.0 |
| Birth Year | Profile.birthYear | The year the user was born | 1.0.0 |
| Cycling VO2 Max | Profile.vo2maxCycling | The user's VO2 Max value for a cycling activity | 3.3.0 |
| Height | Profile.height | The user's height in centimeters (cm) | 1.0.0 |
| Resting Heart Rate | Profile.restingHeartRate | The user's current resting heart rate in beats per minute (bpm) | 1.0.0 |
| Running Step Length | Profile.runningStepLength | The user's running step length in millimeters (mm) | 1.0.0 |
| Running VO2 Max | Profile.vo2maxRunning | The user's VO2 Max value for a running activity | 3.3.0 |
| Sleep Time | Profile.sleepTime | Typical sleep time as configured by the user | 1.0.0 |
| Wake Time | Profile.wakeTime | Typical wake time as configured by the user | 1.0.0 |

Toybox.UserProfile provides access to the additional data:

| Information | API | Value | API Level |
| --- | --- | --- | --- |
| Activity History | UserProfile.getUserActivityHistory() | Record of the activities the user has done | 3.3.0 |
| Heart Rate Zones | UserProfile.getHeartRateZones() | The user's defined heart rate zones for running, cycling, or swimming | 1.2.6 |

## Activity Monitoring

Toybox.ActivityMonitor provides access to the current day's metrics via ActivityMonitor.getInfo() which returns a ActivityMonitor.Info object.

You can also get a daily history of some of these metrics with ActivityMonitor.getHistory() which returns an array of ActivityMonitor.History objects. How far back this history goes can vary by device as well as how long the device has been turned on, but a seven day history is fairly typical.

| Metric | API | Value | API Level |
| --- | --- | --- | --- |
| Calories Burned | Info.calories, History.calories | The calories burned so far for the current day in kilocalories (kCal) | 1.0.0 |
| Daily Active Minutes | Info.activeMinutesDay, History.activeMinutes | The number of active minutes for the current day | 2.1.0 |
| Distance Traveled2 | Info.distance, History.distance | The distance traveled since midnight of the current day in centimeters (cm) | 1.0.0 |
| Floors Climbed | Info.floorsClimbed, History.floorsClimbed | The number of floors climbed for the current day | 2.1.0 |
| Floors Climbed Goal | Info.floorsClimbedGoal, History.floorsClimbedGoal | The goal the user has set for the number of floors climbed in a day | 2.1.0 |
| Floors Descended | Info.floorsDescended, History.floorsDescended | The number of floors descended for the current day | 2.1.0 |
| Meters Climbed | Info.metersClimbed | The vertical distance of floors climbed in meters (m) | 2.1.0 |
| Meters Descended | Info.metersDescended | The vertical distance of floors descended in meters (m) | 2.1.0 |
| Move Bar Level | Info.moveBarLevel | The current level of the move bar between MOVE_BAR_LEVEL_MIN and MOVE_BAR_LEVEL_MAX | 1.0.0 |
| Respiration Rate | Info.respirationRate | Current respiration rate for the user, in breaths per minute | 3.3.0 |
| Steps | Info.steps, History.steps | The step count since midnight of the current day in number of steps | 1.0.0 |
| Step Goal | Info.stepGoal, History.stepGoal | The step goal for the current day in number of steps | 1.0.0 |
| Stress | Info.stressScore | The current stress score based on the last 30 seconds | 5.0.0 |
| Time to Recovery | Info.timeToRecovery | Time to recovery from the last activity, in hours | 3.3.0 |
| Weekly Active Minutes | Info.activeMinutesWeek | The number of active minutes for the current week | 2.1.0 |
| Weekly Active Minutes Goal | Info.activeMinutesWeekGoal | The user's goal number of weekly active minutes | 2.1.0 |
| Wheelchair Pushes | Info.pushes | The user's number of wheelchair pushes | 4.2.0 |
| Wheelchair Pushes Goal |  | The user's goal number of wheelchair pushes | 4.2.0 |

When wheelchair mode is enabled, ActivityMonitor.Info will have zeroes for Info.steps, Info.stepGoal, Info.floorsClimbed, Info.floorsDescended and Info.floorsClimbedGoal and will instead have values in Info.pushes and .

## Sensor History

*Since API level 2.1.0*

The Toybox.SensorHistory module allows the app to access saved sensor history on the device. Data from sensors can be accessed by getting an iterator.

| Function | Purpose | API Level |
| --- | --- | --- |
| SensorHistory.getBodyBatteryHistory() | Get the user's body battery samples as recorded over the previous hours on the device. This does not have access to synced data. | 3.3.0 |
| SensorHistory.getHeartRateHistory() | Get the user's heart rate samples as recorded over the previous hours on the device. This does not have access to synced data. | 2.1.0 |
| SensorHistory.getTemperatureHistory() | Get the temperature as recorded over the previous hours on the device. This does not have access to synced data. | 2.1.0 |
| SensorHistory.getPressureHistory() | Get the barometric pressure as recorded over the previous hours on the device. This does not have access to synced data. | 2.1.0 |
| SensorHistory.getElevationHistory() | Get the distance from sea level as recorded over the previous hours on the device. This does not have access to synced data. | 2.1.0 |
| SensorHistory.getOxygenSaturationHistory() | Get the user's SpO2 as recorded over the previous hours on the device. This does not have access to synced data. Depends on if user has enabled MO2 recording. | 3.2.0 |
| SensorHistory.getStressHistory() | Get the user's stress as recorded over the previous hours on the device. This does not have access to synced data. | 3.3.0 |

Not all Toybox.SensorHistory types are available on all devices. Capabilities should be validated using the `has` operator. The get functions will return a SensorHistory.SensorHistoryIterator type.

Calling the SensorHistoryIterator.next() function will iterate through the history values until the end of the data is reached. When there is no more data the iterator will return null. There are no guarantees on the sample interval or that the requested range will be available.

This function returns a SensorHistory.SensorSample object. The iterator can be adjusted to provide the newest data values first or the oldest values first by using the enumeration values `ORDER_NEWEST_FIRST` and `ORDER_OLDEST_FIRST`.

1 Number 6's argument of "I am not a number, I am a free man!" never met Garmin Connect

2 🎵 ...and I would walk five hundred miles / and I would walk five hundred more / just to be the man who walks a thousand miles / and beats my Connect step challenge 🎵
