---
source: https://developer.garmin.com/connect-iq/core-topics/input-handling/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Input_Handling.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Input Handling

As if input handling wasn't already one of the most important and complicated pieces of a UI toolkit, Garmin devices take the complication up a level. Unlike those touchable glowing rectangles that are modern smart phones, Garmin devices come in lots of shapes and sizes. Touch screens are not always ideal for all watch products, so there is a mix of input styles and screen technologies. It's the job of the UI toolkit to make this coherent to the developer.

## Input and App Types

Not all app types have full access to input. A watch face can only know if it has been pressed and data fields can only know if they have been tapped. Widgets and glances can receive input (may be limited on some devices) while watch-apps will have the most input capability.

## Input Delegates

The delegate object implements a certain interface specific to input handling. Monkey C provides a low level WatchUi.InputDelegate that allows handling of events at a basic level. This is useful for situations when the app needs to handle button presses or touchscreen interactions in a particular way.

| API | Purpose | API Level |
| --- | --- | --- |
| InputDelegate.onDrag() | This is sent when the user is dragging the touch screen | 3.3.0 |
| InputDelegate.onFlick() | This is sent when the user has flicked the touch screen | 3.3.0 |
| InputDelegate.onKey() | A physical button has been pressed and released | 1.0.0 |
| InputDelegate.onKeyPressed() | A physical button has been pressed down | 1.1.2 |
| InputDelegate.onKeyReleased() | A physical button has been pressed released after being pressed down | 1.1.2 |
| InputDelegate.onTap() | This is sent when the touch screen is tapped (a quick touch and release) | 1.0.0 |
| InputDelegate.onHold() | This is sent when the touch screen is touched and not released | 1.0.0 |
| InputDelegate.onRelease() | This is only sent after an InputDelegate.onHold() event, once the hold on the touch screen is released | 1.0.0 |
| InputDelegate.onSwipe() | This is sent when the touch screen is swiped | 1.0.0 |
| InputDelegate.onSelectable() | This is sent when the state of a WatchUi.Selectable has changed. | 2.1.0 |

To process input events, extend the WatchUi.InputDelegate and override the appropriate handler operation. If you return `true` in the handler, the system will know the event has been handled. Returning `false` will tell the system to handle the input.

For more see the `Input` sample app distributed with the SDK.

## Behaviors

Garmin makes products with a purpose, and that purpose can alter the design of one product line over another. Deciding whether a product has a touch screen or has buttons can depend on the environment in which the user will take. For instance, if the product is intended to be used in water (swimming, canoeing, on a boat), it may not have a touch screen. These decisions make for superior products, but also add to developer frustration due to device fragmentation.

Most products will support common behaviors (next page, back a page), but how they are executed by the user may differ based on the available input types. To help with this dilemma, Monkey C exposes events at a behavior level. Behaviors separate high-level intentions from the actual input type—next page versus screen press. The WatchUi.BehaviorDelegate is a super class of WatchUi.InputDelegate and maps its low level inputs to common operations across multiple products. Using the WatchUi.BehaviorDelegate can lead to much more portable code.

| API | Purpose | API Level |
| --- | --- | --- |
| BehaviorDelegate.onBack() | Handle the user performing the back behavior | 1.0.0 |
| BehaviorDelegate.onMenu() | Handle the user performing the menu behavior | 1.0.0 |
| BehaviorDelegate.onNextPage() | Handle the user performing a next page in page loop behavior | 1.0.0 |
| BehaviorDelegate.onPreviousPage() | Handle the user performing a previous page in page loop behavior | 1.0.0 |
| BehaviorDelegate.onSelect() | Handle the user performing a select behavior | 1.0.0 |

## Selectables and Buttons

### Selectables

*Since API level 2.1.0*

Monkey C provides an interface for products with large touch screens (and few buttons) to easily define touchable objects on-screen known as a WatchUi.Selectable.

A WatchUi.Selectable is a state driven object that supports four optional built-in states which are set based on touch interaction:

- Default (`:stateDefault`) - Initial state
- Highlighted (`:stateHighlighted`) - Selectable is currently being pressed
- Selected (`:stateSelected`) - Selectable was pressed and released (i.e. tapped)
- Disabled (`:stateDisabled`) - Selectable has been disabled

Once a state change occurs, a WatchUi.SelectableEvent is sent which results in a call to InputDelegate.onSelectable(), which passes both the instance of the current Selectable and the symbol of the previous state for comparison, and allows for custom actions as a result of the state change. Selectables *must* be registered as part of the View's layout via the View.setLayout() call in order to for the View to know about them and direct touch events to the object. Stacked instances of Selectables will have input directed to them depending on their order as passed to View.setLayout() (last in, first drawn / selected).

Each of the four states must be mapped to a WatchUi.Drawable, Graphics.COLOR constant, or 24-bit integer of the form 0xRRGGBB. States are optionally defined and be specified in the WatchUi.Selectable constructor, or manually modified as members of the instance. Each WatchUi.Selectable will draw the current state using the defined `locX` and `locY` coordinates as an offset if it has been defined. Extending WatchUi.Selectable with additional states is encouraged and the Selectable.getState() and Selectable.setState() routines may used to alter the default state machine (see Selectable sample application for a demonstration of check boxes).

A WatchUi.Button is derived from WatchUi.Selectable and adds the ability to define a background and map interaction to an existing or new custom method (i.e. `onMenu()`) within WatchUi.BehaviorDelegate.

### Button-Only and Touch Screen Interfaces

It can be difficult to make a user interface that operates with both button-only products and products with touch screens. You can use View.setKeyToSelectableInteraction() to enable compatibility mode with button-only products. View.setKeyToSelectableInteraction() may be called to enable the up/down keys to cycle through the list of Selectables registered via the View's View.setLayout() call, which sets the highlighted state on a WatchUi.Selectable until it is put in the Selected state via the enter key.

### Defining Selectables And Buttons In Layouts

Much like their parent WatchUi.Drawable, Selectables and Buttons both support the layout system. Selectable and Button XML resources consist of a list of state ID's and optional parameters. To create an XML Selectable, define a `` in an XML resource file:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the Selectable | Any string that starts with a character | NA |  |
| `x` | The X coordinate of the top left corner of the Selectable region | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | N/A | Required |
| `y` | The Y coordinate of the top left corner of the Selectable region | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | N/A | Required |
| `width` | The width of the Selectable region | pixel value or a relative dimension using '%' or `fill` | N/A | Required |
| `height` | The height of the Selectable region | pixel value or a relative dimension using '%' or `fill` | N/A | Required |

The `` resource expands the definition of `` and adds the following:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `behavior` | A method existing within a View's registered BehaviorDelegate | Method symbol | `null` | Optional / Param |
| `background` | The background color of the Button | color constant or a 24-bit integer of the form `0xRRGGBB` | `Graphics.COLOR_TRANSPARENT` | Optional / Param |

Both `` and `` tags use `` as child nodes to define their states at construction. Each state is defined optionally but is defined as the following:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The state ID for the Button / Selectable | `stateDefault`, `stateHighlighted`, `stateSelected`, or `stateDisabled` | N/A | Required |
| `bitmap` | A bitmap resource in the layout drawn at the Selectable / Button origin | `WatchUi.Bitmap` objects | N/A | Required or either `color` or `drawable` must be specified |
| `color` | A color fill applied to the Selectable / Button region | color constant or a 24-bit integer of the form `0xRRGGBB` | `Graphics.COLOR_TRANSPARENT` | Required or either `bitmap` or `drawable` must be specified |
| `drawable` | A drawable object in the layout drawn at the Selectable / Button origin | `WatchUi.Drawable` objects | N/A | Required or either `bitmap` or `color` must be specified |

An example layout containing two a menu and back button:

```
<layout id="ButtonLayout">
    <button x="40" y="center" width="50" height="50" background="Gfx.COLOR_BLACK" behavior="onBack">
        <state id="stateDefault" bitmap="@Drawables.DefaultBackButton" />
        <state id="stateHighlighted" bitmap="@Drawables.PressedBackButton" />
        <state id="stateSelected" bitmap="@Drawables.PressedBackButton" />
        <state id="stateDisabled" color="Graphics.COLOR_BLACK" />
    </button>
    <button x="115" y="center" width="50" height="50">
        <state id="stateDefault" bitmap="@Drawables.DefaultMenuButton" />
        <state id="stateHighlighted" bitmap="@Drawables.PressedMenuButton" />
        <state id="stateSelected" bitmap="@Drawables.PressedMenuButton" />
        <state id="stateDisabled" color="Graphics.COLOR_BLACK" />
        <param name="background">Graphics.COLOR_BLACK</param>
        <param name="behavior">onMenu</param>
    </button>
</layout>
```

For more, see the `Selectable` sample app distributed with the SDK.
