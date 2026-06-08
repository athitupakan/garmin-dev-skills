---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/WatchUi.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/WatchUi.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.WatchUi

## Overview

The WatchUi module contains user interface elements available within apps.

WatchUi provides several classes that represent Views, or what is displayed on the screen of a device. Also available are UI elements like on-screen menus, progress bars, buttons, and various pickers. More abstract classes represent all drawable objects, such as bitmaps and text.

Note:

All keys in the key types enum listed after EXTENDED_KEYS (16) were added after ConnectIQ version 1.1.2. Before evaluating these keys, check for the availability of these keys with a `has` check: if (Toybox.WatchUi has :EXTENDED_KEYS) ...

**Since:** API Level 1.0.0

**App Types and Runtime Contexts:**

- Audio Content Provider
- Background (supported since API Level 5.1.0)
- Data Field
- Glance
- Watch App
- Watch Face
- Widget

## Classes Under Namespace

**Classes:** ActionMenu, ActionMenuDelegate, ActionMenuItem, AnimationDelegate, AnimationLayer, AnimationResource, BehaviorDelegate, Bitmap, BitmapResource, Button, CheckboxMenu, CheckboxMenuItem, ClickEvent, ComplicationDrawableRef, Confirmation, ConfirmationDelegate, CustomMenu, CustomMenuItem, DataField, DataFieldAlert, DragEvent, Drawable, FlickEvent, FontResource, GlanceView, GlanceViewDelegate, IconMenuItem, InputDelegate, InvalidMenuItemTypeException, InvalidPointException, InvalidSelectableStateException, KeyEvent, Layer, MapMarker, MapPolyline, MapTrackView, MapView, Menu, Menu2, Menu2InputDelegate, MenuInputDelegate, MenuItem, NumberPicker, NumberPickerDelegate, Picker, PickerDelegate, PickerFactory, ProgressBar, ReviewResponseToken, Selectable, SelectableEvent, SimpleDataField, SwipeEvent, Text, TextArea, TextPicker, TextPickerDelegate, ToggleMenuItem, TransparentProgressBar, View, ViewLoop, ViewLoopDelegate, ViewLoopFactory, WatchFace, WatchFaceDelegate, WatchFacePowerInfo

## Constant Summary

### Key

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| KEY_POWER | 0 | API Level 1.0.0 | The power key |
| KEY_LIGHT | 1 | API Level 1.0.0 | The light key |
| KEY_ZIN | 2 | API Level 1.0.0 | The zoom in key |
| KEY_ZOUT | 3 | API Level 1.0.0 | The zoom out key |
| KEY_ENTER | 4 | API Level 1.0.0 | The enter key |
| KEY_ESC | 5 | API Level 1.0.0 | The escape key |
| KEY_FIND | 6 | API Level 1.0.0 | The find key |
| KEY_MENU | 7 | API Level 1.0.0 | The menu key |
| KEY_DOWN | 8 | API Level 1.0.0 | The down key |
| KEY_DOWN_LEFT | 9 | API Level 1.0.0 | The down left key |
| KEY_DOWN_RIGHT | 10 | API Level 1.0.0 | The down key |
| KEY_LEFT | 11 | API Level 1.0.0 | The left key |
| KEY_RIGHT | 12 | API Level 1.0.0 | The right key |
| KEY_UP | 13 | API Level 1.0.0 | The up key |
| KEY_UP_LEFT | 14 | API Level 1.0.0 | The up-left |
| KEY_UP_RIGHT | 15 | API Level 1.0.0 | The up-right key |
| EXTENDED_KEYS | 16 | API Level 1.1.2 | Indicates extended key support |
| KEY_PAGE | 17 | API Level 1.1.2 | The page key |
| KEY_START | 18 | API Level 1.1.2 | The start key |
| KEY_LAP | 19 | API Level 1.1.2 | The lap key |
| KEY_RESET | 20 | API Level 1.1.2 | The reset key |
| KEY_SPORT | 21 | API Level 1.1.2 | The sport key |
| KEY_CLOCK | 22 | API Level 1.1.2 | The clock key |
| KEY_MODE | 23 | API Level 1.1.2 | The mode key |
| KEY_ACTION_MENU | 24 | API Level 5.1.1 | The action menu key |

### AnimationType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| ANIM_TYPE_LINEAR | 0 | API Level 1.0.0 | Animation with a constant speed |
| ANIM_TYPE_EASE_IN | 1 | API Level 1.0.0 | Animation that increases in speed from start to end |
| ANIM_TYPE_EASE_OUT | 2 | API Level 1.0.0 | Animation that decreases in speed from start to end |
| ANIM_TYPE_EASE_IN_OUT | 3 | API Level 1.0.0 | Animation that increases in speed from the start, then decreases in speed toward the end |

### KeyPressType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| PRESS_TYPE_DOWN | 0 | API Level 1.1.2 | The key is pressed down |
| PRESS_TYPE_UP | 1 | API Level 1.1.2 | The key is released |
| PRESS_TYPE_ACTION | 2 | API Level 1.1.2 | The key's action is performed |

### ClickType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CLICK_TYPE_TAP | 0 | API Level 1.0.0 | A tap on the screen |
| CLICK_TYPE_HOLD | 1 | API Level 1.0.0 | A press and hold on the screen |
| CLICK_TYPE_RELEASE | 2 | API Level 1.0.0 | A release of a hold on the screen |

### MapMarkerIcon

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| MAP_MARKER_ICON_PIN | 0 | API Level 3.0.0 | The default Garmin map marker pin icon |

### MapMode

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| MAP_MODE_PREVIEW | 0 | API Level 3.0.0 | The preview mode for a MapView |
| MAP_MODE_BROWSE | 1 | API Level 3.0.0 | The browse mode for a MapView |

### SwipeDirection

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| SWIPE_UP | 0 | API Level 1.0.0 | A swipe in the upward direction |
| SWIPE_RIGHT | 1 | API Level 1.0.0 | A swipe towards the right |
| SWIPE_DOWN | 2 | API Level 1.0.0 | A swipe in the downward direction |
| SWIPE_LEFT | 3 | API Level 1.0.0 | A swipe towards the left |

### DragType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| DRAG_TYPE_START | 0 | API Level 3.3.0 | Start of a screen drag |
| DRAG_TYPE_CONTINUE | 1 | API Level 3.3.0 | Continuation of a screen drag |
| DRAG_TYPE_STOP | 2 | API Level 3.3.0 | Stop of a screen drag |

### ControlBarLeftButton

**Since:** API Level 4.1.2

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONTROL_BAR_LEFT_BUTTON_BACK | 0 | API Level 4.1.2 |  |
| CONTROL_BAR_LEFT_BUTTON_CANCEL | 1 | API Level 4.1.2 |  |

### ControlBarRightButton

**Since:** API Level 4.1.2

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONTROL_BAR_RIGHT_BUTTON_ACCEPT | 2 | API Level 4.1.2 |  |
| CONTROL_BAR_RIGHT_BUTTON_MENU | 3 | API Level 4.1.2 |  |

### AnalogClockState

Set the state for analog clock hands

**Since:** API Level 3.3.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| ANALOG_CLOCK_STATE_RESTING | 0 | API Level 3.3.0 | Set the clock hands to resting position |
| ANALOG_CLOCK_STATE_SYSTEM_TIME | 1 | API Level 3.3.0 | Set the clock hands to system time |
| ANALOG_CLOCK_STATE_HOLDING | 2 | API Level 3.3.0 | Set the clock hands to the specified position |

### WatchFaceConfigType

WatchFace config types.

**Since:** API Level 5.1.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| WATCH_FACE_CONFIG_TYPE_STYLE | 0 | API Level 5.1.0 |  |
| WATCH_FACE_CONFIG_TYPE_COMPLICATION | 1 | API Level 5.1.0 |  |
| WATCH_FACE_CONFIG_TYPE_ACCENT_COLOR | 2 | API Level 5.1.0 |  |
| WATCH_FACE_CONFIG_TYPE_COMPLICATION_COLOR | 3 | API Level 5.1.0 |  |

### MenuTheme

Menu theme for supported devices

**Since:** API Level 4.1.8

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| MENU_THEME_DEFAULT | 0 | API Level 4.1.8 | The default theme color as specified by the device. |
| MENU_THEME_BLUE | 1 | API Level 4.1.8 |  |
| MENU_THEME_CYAN | 2 | API Level 4.1.8 |  |
| MENU_THEME_GREEN | 3 | API Level 4.1.8 |  |
| MENU_THEME_YELLOW | 4 | API Level 4.1.8 |  |
| MENU_THEME_ORANGE | 5 | API Level 4.1.8 |  |
| MENU_THEME_RED | 6 | API Level 4.1.8 |  |
| MENU_THEME_PINK | 7 | API Level 4.1.8 |  |
| MENU_THEME_PURPLE | 8 | API Level 4.1.8 |  |
| MENU_THEME_GREEN_YELLOW | 9 | API Level 4.1.8 |  |

### Confirm

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| CONFIRM_NO | 0 | API Level 1.0.0 |  |
| CONFIRM_YES | 1 | API Level 1.0.0 |  |

### NumberPickerMode

 **This has been deprecated**

This enum may be removed after System 3.

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| NUMBER_PICKER_DISTANCE | 0 | API Level 1.0.0 | A Float in meters (m) |
| NUMBER_PICKER_TIME | 1 | API Level 1.0.0 | A Duration |
| NUMBER_PICKER_TIME_MIN_SEC | 2 | API Level 1.0.0 | A Duration |
| NUMBER_PICKER_TIME_OF_DAY | 3 | API Level 1.0.0 | A Duration representing the number of seconds since midnight |
| NUMBER_PICKER_WEIGHT | 4 | API Level 1.0.0 | A Float in kilograms (kg) |
| NUMBER_PICKER_HEIGHT | 5 | API Level 1.0.0 | A Float in meters (m) |
| NUMBER_PICKER_CALORIES | 6 | API Level 1.0.0 | A Number |
| NUMBER_PICKER_BIRTH_YEAR | 7 | API Level 1.0.0 | A Number |

### SlideType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| SLIDE_IMMEDIATE | 0 | API Level 1.0.0 | No transition. |
| SLIDE_LEFT | 1 | API Level 1.0.0 | The View slides to the left. |
| SLIDE_RIGHT | 2 | API Level 1.0.0 | The View slides to the right. |
| SLIDE_DOWN | 3 | API Level 1.0.0 | The View slides down. |
| SLIDE_UP | 4 | API Level 1.0.0 | The View slides up. |
| SLIDE_BLINK | 5 | API Level 3.1.0 | The View fades in. |

### LayoutVerticalAlignment

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| LAYOUT_VALIGN_TOP | -0x7FFFFFFF | API Level 1.2.0 | Set a Drawable object's locY property to this to align it to the top edge of the device context (Dc). |
| LAYOUT_VALIGN_BOTTOM | -0x7FFFFFFE | API Level 1.2.0 | Set a Drawable object's locY property to this to align it to the bottom edge of the device context (Dc). |
| LAYOUT_VALIGN_CENTER | -0x7FFFFFFD | API Level 1.2.0 | Set a Drawable object's locY property to this to center it vertically in the device context (Dc). |
| LAYOUT_VALIGN_START | -0x7FFFFFFC | API Level 1.2.0 | Set a Drawable object's locY property to this to make it equal to its parent's locY property. |

### LayoutHorizontalAlignment

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| LAYOUT_HALIGN_LEFT | -0x7FFFFFFF | API Level 1.2.0 | Set a Drawable object's locX property to this to align it along the left edge of the device context (Dc). |
| LAYOUT_HALIGN_RIGHT | -0x7FFFFFFE | API Level 1.2.0 | Set a Drawable object's locX property to this to align it along the right edge of the device context (Dc). |
| LAYOUT_HALIGN_CENTER | -0x7FFFFFFD | API Level 1.2.0 | Set a Drawable object's locX property to this to center it horizontally in the device context (Dc). |
| LAYOUT_HALIGN_START | -0x7FFFFFFC | API Level 1.2.0 | Set a Drawable object's locX property to this to make it equal to its parent's locX property. |

### AnimationEvent

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| ANIMATION_EVENT_COMPLETE | 0 | API Level 3.1.0 | Indicates the completion of an animation. |
| ANIMATION_EVENT_CANCELED | 1 | API Level 3.1.0 | Indicates the cancel of the animation playback |

### ActionMenuTheme

The theme for the ActionMenu

**Since:** API Level 3.4.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| ACTION_MENU_THEME_DARK | 0 | API Level 3.4.0 | Dark theme for the action menu |
| ACTION_MENU_THEME_LIGHT | 1 | API Level 3.4.0 | Light theme for the action menu |

### ReviewRequestStatus

Enum class for makeReviewTokenRequest return status

**Since:** API Level 3.4.2

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| REVIEW_REQUEST_STATUS_GRANTED | 0 | API Level 3.4.2 |  |
| REVIEW_REQUEST_STATUS_DENIED | 1 | API Level 3.4.2 |  |
| REVIEW_REQUEST_STATUS_FAILED | 2 | API Level 3.4.2 |  |

## Typedef Summary
- **InputDelegates** as WatchUi.InputDelegate or WatchUi.BehaviorDelegate or WatchUi.ConfirmationDelegate or WatchUi.MenuInputDelegate or WatchUi.NumberPickerDelegate or WatchUi.PickerDelegate or WatchUi.TextPickerDelegate or WatchUi.WatchFaceDelegate or WatchUi.Menu2InputDelegate or WatchUi.ViewLoopDelegate
- **Resource** as Lang.Array or Lang.Dictionary or Lang.String or WatchUi.AnimationResource or WatchUi.BitmapResource or WatchUi.FontResource or Graphics.BitmapReference or Graphics.FontReference
- **TouchEventSettings** as { :enabled as Lang.Boolean }
- **Views** as WatchUi.View or WatchUi.Menu or WatchUi.TextPicker or WatchUi.ProgressBar or WatchUi.Confirmation or WatchUi.NumberPicker or WatchUi.ViewLoop

## Instance Method Summary
- **animate**(object as Lang.Object, property as Lang.Symbol, type as WatchUi.AnimationType, start as Lang.Numeric, stop as Lang.Numeric, period as Lang.Numeric, callback as **Null** or Lang.Method() as **Void**) as **Void** Animate an Object.
- **cancelAllAnimations**() as **Void** Cancel animations started with WatchUi.animate() Stop all animations that were started with WatchUi.animate().
- **configureTouchEvents**(options as WatchUi.TouchEventSettings) as Lang.Boolean Configurate touch event settings, only allowed for Watch Apps and Audio Content Providers when running in the foreground mode.
- **getCurrentView**() as [ WatchUi.View or **Null**, WatchUi.InputDelegates or **Null** ] Get the current view that is displayed in the UI.
- **getSubscreen**() as Graphics.BoundingBox or **Null** Get the subscreen area in the display.
- **getTouchEventsConfiguration**() as WatchUi.TouchEventSettings Returns the current touch event settings.
- **loadResource**(resource as Lang.ResourceId) as WatchUi.Resource Load a resource from the executable.
- **makeReviewTokenRequest**(callback as Lang.Method(responseStatus as WatchUi.ReviewRequestStatus, token as WatchUi.ReviewResponseToken or **Null**) as **Void**) as **Void** Initiate a request to ask for this app to be reviewed.
- **popView**(transition as WatchUi.SlideType) as **Void** Pop the current View from the View stack.
- **pushView**(view as WatchUi.Views, delegate as WatchUi.InputDelegates or **Null**, transition as WatchUi.SlideType) as **Void** Push a View onto the View stack.
- **requestUpdate**() as **Void** Request a call to the onUpdate() method for the current View.
- **showActionMenu**(menu as WatchUi.ActionMenu, delegate as WatchUi.ActionMenuDelegate) as **Void** Push an action menu to the display.
- **showToast**(text as Lang.String or Lang.ResourceId, options as { :icon as WatchUi.BitmapResource or Graphics.BitmapReference or Lang.ResourceId } or **Null**) as **Void** Push a toast notification to the display.
- **startUserReview**(token as WatchUi.ReviewResponseToken) as **Void** Start the app review UI flow.
- **switchToView**(view as WatchUi.Views, delegate as WatchUi.InputDelegates or **Null**, transition as WatchUi.SlideType) as **Void** Pop the current View from the View stack and push a new one.

## Typedef Details

### `InputDelegates as WatchUi.InputDelegate or WatchUi.BehaviorDelegate or WatchUi.ConfirmationDelegate or WatchUi.MenuInputDelegate or WatchUi.NumberPickerDelegate or WatchUi.PickerDelegate or WatchUi.TextPickerDelegate or WatchUi.WatchFaceDelegate or WatchUi.Menu2InputDelegate or WatchUi.ViewLoopDelegate`

**Since:** API Level 1.0.0

### `Resource as Lang.Array or Lang.Dictionary or Lang.String or WatchUi.AnimationResource or WatchUi.BitmapResource or WatchUi.FontResource or Graphics.BitmapReference or Graphics.FontReference`

**Since:** API Level 1.0.0

### `TouchEventSettings as { :enabled as Lang.Boolean }`

**Since:** API Level 1.0.0

### `Views as WatchUi.View or WatchUi.Menu or WatchUi.TextPicker or WatchUi.ProgressBar or WatchUi.Confirmation or WatchUi.NumberPicker or WatchUi.ViewLoop`

**Since:** API Level 1.0.0

## Instance Method Details

### `animate(object as Lang.Object, property as Lang.Symbol, type as WatchUi.AnimationType, start as Lang.Numeric, stop as Lang.Numeric, period as Lang.Numeric, callback as Null or Lang.Method() as Void) as Void`

Animate an Object.

Animate works by changing an object property over time, such as the x-position of a Drawable. The animation starts after the call and runs the length of the specified period. During this time, the View object's onUpdate() method will be invoked at an increased rate to facilitate animation.

Note:

Will cause an app crash if called from background or data field app, or from watch face while in low power mode

**Parameters:**
- object — (Lang.Object) — The object to animate
- property — (Lang.Symbol) — The Symbol of the object's property to animate (e.g. :locX, :locY, etc.)
- type — (WatchUi.AnimationType) — A WatchUi.ANIM_TYPE_* value
- start — (Lang.Number) — The starting value of the property
- stop — (Lang.Number) — The ending value of the property
- period — (Lang.Float) — The duration of the animation in seconds
- callback — (Lang.Method) — A Method to call when the animation is complete; this can be `null`

**Example:**
Move a bitmap across the screen from left to right

```
using System.WatchUi;

square = new Ui.Bitmap({
    :rezId=>Rez.Drawables.square,
    :locX=>10,
    :locY=>30
});
WatchUi.animate(square, :locX, Ui.ANIM_TYPE_LINEAR, 10, 200, 10, null);
```

**See Also:**

- Toybox.WatchUi.Drawable
- Toybox.WatchUi.Bitmap

**Since:** API Level 1.0.0

### `cancelAllAnimations() as Void`

Cancel animations started with WatchUi.animate()

Stop all animations that were started with WatchUi.animate(). This will leave all animations at their final frame, as if WatchUi.animate() ran to completion.

**See Also:**

- WatchUi.animate()

**Since:** API Level 3.1.7

### `configureTouchEvents(options as WatchUi.TouchEventSettings) as Lang.Boolean`

Configurate touch event settings, only allowed for Watch Apps and Audio Content Providers when running in the foreground mode.

**Parameters:**
- options — (Lang.Dictionary) — Dictionary of touch event settings. :enabled — (Lang.Boolean) — Master flag to enable or disable touch events while application is running in the foreground.

_Supported on 39 devices._

**Returns:**
- Lang.Boolean — True if the operation was successful, false otherwise.

**Since:** API Level 5.2.0

**Throws:**
- (Lang.OperationNotAllowedException) — if called by application type that is not Watch App or Audio Content Provider, or called in background mode.
- (Lang.InvalidValueException) — If invalid options are provided.

### `getCurrentView() as [ WatchUi.View or Null, WatchUi.InputDelegates or Null ]`

Get the current view that is displayed in the UI

**Returns:**
- Lang.Array — An array containing the view and the delegate.

**Since:** API Level 3.4.0

### `getSubscreen() as Graphics.BoundingBox or Null`

Get the subscreen area in the display.

_Supported on 7 devices._

**Returns:**
- Graphics.BoundingBox — object or `null` if no subscreen is present or if a virtual subscreen is present but not used for normal views.

**Since:** API Level 3.2.7

### `getTouchEventsConfiguration() as WatchUi.TouchEventSettings`

Returns the current touch event settings.

_Supported on 39 devices._

**Returns:**
- Lang.Dictionary — Current touch event settings.

**Since:** API Level 5.2.0

### `loadResource(resource as Lang.ResourceId) as WatchUi.Resource`

Load a resource from the executable.

Note:

Toybox::Graphics::BitmapReference and Toybox::Graphics::FontReference are returned for Toybox::WatchUi::BitmapResource and Toybox::WatchUi::FontResource in CIQ 4.0.0 and later.

**Parameters:**
- resource — (Lang.ResourceId) — An identifier for a resource defined in the project's `resources.xml` file

**Example:**
Loading a String resource

```
// The resources.xml file contents:
// <resources>
//     <string id="AppName">APEELingApp</string>
// </resources>
using Toybox.WatchUi;

var banana = WatchUi.loadResource(Rez.Strings.AppName);
```

**Returns:**
- Lang.Array, Lang.Dictionary, Lang.String, WatchUi.AnimationResource, WatchUi.BitmapResource, WatchUi.FontResource, Graphics.BitmapReference, Graphics.FontReference

**Since:** API Level 1.0.0

### `makeReviewTokenRequest(callback as Lang.Method(responseStatus as WatchUi.ReviewRequestStatus, token as WatchUi.ReviewResponseToken or Null) as Void) as Void`

Initiate a request to ask for this app to be reviewed

**Parameters:**
- callback — (Lang.Method) — Callback to invoke when the review token request has completed.

_Supported on 75 devices._

**Since:** API Level 3.4.2

### `popView(transition as WatchUi.SlideType) as Void`

Pop the current View from the View stack.

**Parameters:**
- transition — (WatchUi.SlideType) — A WatchUi.SLIDE_* value

**Since:** API Level 1.0.0

**Throws:**
- (Lang.OperationNotAllowedException) — Thrown if called from background, data field, glance, or watch face app; or of called from the base page of a widget

### `pushView(view as WatchUi.Views, delegate as WatchUi.InputDelegates or Null, transition as WatchUi.SlideType) as Void`

Push a View onto the View stack.

**Parameters:**
- view — (WatchUi.View) — View to push
- delegate — (WatchUi.BehaviorDelegate, WatchUi.ConfirmationDelegate, WatchUi.InputDelegate, WatchUi.MenuInputDelegate, WatchUi.NumberPickerDelegate, WatchUi.PickerDelegate, WatchUi.TextPickerDelegate, WatchUi.WatchFaceDelegate) — The input delegate to handle input for the View
- transition — (WatchUi.SlideType) — A WatchUi.SLIDE_* value

**Since:** API Level 1.0.0

**Throws:**
- (Lang.UnexpectedTypeException) — Thrown when view is type MapView and the visible map area parameters are invalid
- (Lang.OperationNotAllowedException) — Thrown if called from background, data field, glance, or watch face app; or if the new view is a DataField, a GlanceView, or a WatchFace

### `requestUpdate() as Void`

Request a call to the onUpdate() method for the current View.

**See Also:**

- View.onUpdate()

**Since:** API Level 1.0.0

### `showActionMenu(menu as WatchUi.ActionMenu, delegate as WatchUi.ActionMenuDelegate) as Void`

Push an action menu to the display

Note:

An action menu will dismiss it self on either user selecting a menu item or pressing back button.

**Parameters:**
- menu — (WatchUi.ActionMenu) — An action menu object.
- delegate — (WatchUi.ActionMenuDelegate) — An action menu delegate object.

_Supported on 87 devices._

**Since:** API Level 3.4.0

### `showToast(text as Lang.String or Lang.ResourceId, options as { :icon as WatchUi.BitmapResource or Graphics.BitmapReference or Lang.ResourceId } or Null) as Void`

Push a toast notification to the display

**Parameters:**
- text — (Lang.String, Lang.ResourceId) — The text to display in the notification toast.
- options — (Lang.Dictionary) — A Dictionary of options. :icon — (Graphics.BitmapReference, WatchUi.BitmapResource, Lang.ResourceId) — The icon to display with this notification. If no icon is provided and the system requires an icon for a toast, the app icon will be used.

_Supported on 95 devices._

**Since:** API Level 3.4.0

### `startUserReview(token as WatchUi.ReviewResponseToken) as Void`

Start the app review UI flow

**Parameters:**
- token — (WatchUi.ReviewResponseToken) — The token that was passed as a parameter to a successful call to the callback parameter in makeReviewTokenRequest.

_Supported on 75 devices._

**Since:** API Level 3.4.2

**Throws:**
- (Lang.OperationNotAllowedException) — if `token` is not a ReviewResponseToken.

### `switchToView(view as WatchUi.Views, delegate as WatchUi.InputDelegates or Null, transition as WatchUi.SlideType) as Void`

Pop the current View from the View stack and push a new one.

Note:

Prior to ConnectIQ 3.1, this method only supported switching to user-defined View objects, and would only accept InputDelegate or BehaviorDelegate objects as delegates for the given View.

**Parameters:**
- view — (WatchUi.View) — The View object to push
- delegate — (WatchUi.BehaviorDelegate, WatchUi.InputDelegate) — The input delegate to handle input for the View
- transition — (WatchUi.SlideType) — A WatchUi.SLIDE_* value

**Since:** API Level 1.0.0

**Throws:**
- (Lang.OperationNotAllowedException) — Thrown if called from background, data field, glance, or watch face app; or of called from the base page of a widget and the new view is native; or if the new view is a DataField, a GlanceView, or a WatchFace
