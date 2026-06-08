---
source: https://developer.garmin.com/connect-iq/personality-library/progress-bars/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Progress_Bars.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Progress Indicators

At points where your app needs to perform an asynchronous operation, such as loading an update or a new view, you should indicate to the user that they need to wait. Progress indicators provide a full-page experience informing the user the process is ongoing while they wait.

## Percent Progress Indicator

If you quantify the percentage or time you need to complete a process, you can use a percent progress indicator to present that progress to the user.

### Example

WatchUI.ProgressBar shows a progress percentage if you initialize it with a value between 0 to 100. Call ProgressBar.setProgress() to update the progress displayed.

```
// InputDelegate.mc

    progressBar = new WatchUi.ProgressBar(
        "Processing...",
        0
    );
    WatchUi.pushView(
        progressBar,
        new MyProgressDelegate(),
        Ui.SLIDE_DOWN
    );
```

## Infinite Progress Indicator

If you do not have a known progress end point, you can use an infinite progress mode. This displays a spinning indicator to show that a task is ongoing.

### Example

WatchUi.ProgressBar shows a busy progress if you initialize it with a `null` value.

```
// InputDelegate.mc

    progressBar = new WatchUi.ProgressBar(
        "Processing...",
        null
    );
    WatchUi.pushView(
        progressBar,
        new MyProgressDelegate(),
        Ui.SLIDE_DOWN
    );
```
