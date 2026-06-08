---
source: https://developer.garmin.com/connect-iq/personality-library/toasts/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Toasts.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Toasts

Asynchronous events can occur outside of the user's current flow. For example, GPS may establish the user's location after being enabled. When these events occur, you can use toasts to update the user without interrupting the user's current flow. Toasts are UI elements that take up a small portion of the screen and disappear after a short time. When paired with a vibration or tone, they can effectively update the user.

## Standard Toast

The System 6 WatchUi.showToast() API provides access to the system toast. The toast can display a short text string and an icon.

## Example

Use the `size__toast_icon` selector to scale an icon asset to the system size for a toast.

```
<!-- drawables.xml -->

    <bitmap id="warningToastIcon" personality="
        system_icon_destructive__warning
        system_size__toast_icon
    "/>
```

```
<!-- InputDelegate.mc -->

WatchUi.showToast("Lost GPS", {:icon=>Rez.Drawables.warningToastIcon});
```
