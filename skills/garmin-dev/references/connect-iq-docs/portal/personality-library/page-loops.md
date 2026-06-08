---
source: https://developer.garmin.com/connect-iq/personality-library/page-loops/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Page_Loops.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Page Loops

Page loops present the user with a set of pages containing data and insights. There are standard behaviors for moving to the next and previous pages. Advancing from the last page typically loops the user back to the first page.

## Activity Page Loop

One common page loop on Garmin® products appears when the user records an activity. While the activity is in progress, the user can navigate through multiple pages of information and metrics related to it.

## Example

The System 6 WatchUi.ViewLoop can be used to handle the inputs and transitions between pages. You create a WatchUi.ViewLoopFactory that feeds WatchUi.View on demand. As the user selects the system input to navigate the page loop, the WatchUi.ViewLoop handles the page transitions and displays the page indicators. You provide your own WatchUi.InputDelegate for each view to handle inputs not involved with page navigation.

```
// InputDelegate.mc

import Toybox.Lang;
import Toybox.WatchUi;

var loop = new WatchUi.ViewLoop(new PageLoopFactory(),
    {:wrap => true});
WatchUi.pushView(loop, new ViewLoopDelegate(loop),
    WatchUi.SLIDE_IMMEDIATE);
```
