---
source: https://developer.garmin.com/connect-iq/user-experience-guidelines/progress-bars/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/User_Experience_Guidelines/Progress_Bars.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Progress Bars

At points where your app needs to do something asynchronous, you should present an indication that the user needs to wait. Progress bars provide a full-page experience that communicates progress. If you don't have a known progress end point, you can use an infinite progress mode.

Percent Progress:

Infinite Progress:

## Best Practices

- Provide a back behavior in case the user wants to cancel the action.
- Be informative, so the user understands what process is taking place.
- If there are multiple processes taking place one after another, try to represent the progress for these in one progress bar, or use the infinite progress. Use the message to keep the user apprised of status.
