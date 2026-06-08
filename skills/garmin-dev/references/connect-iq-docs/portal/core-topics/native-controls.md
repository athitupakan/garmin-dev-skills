---
source: https://developer.garmin.com/connect-iq/core-topics/native-controls/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Native_Controls.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Native UI Controls

Toybox.WatchUi provides a number of native widgets to handle input:

- Menus
- Generic Picker
- Confirmation Dialog
- Progress Bar
- Page Loops
- Toasts
- Data Fields
- Map Views

Two additional handlers provided by Toybox.WatchUi can be used to give feedback to the user: the confirmation dialog and progress dialog.

## Menus

Menus are full screen lists of options for the user. Menus can be used to present options or settings for the user to choose from.

### Menu2

*Since API level 3.0.0*

The WatchUi.Menu2 system allows for complex menu user interfaces. The WatchUi.Menu2 class includes new capabilities like graphical titles1, menu items that can be updated dynamically, and additional menu elements such as check boxes. The Menu2 system includes multiple new classes. Let's start with the most simple of the new menu elements.

Here is a basic implementation of a Menu2 using a simple WatchUi.MenuItem:

```
import Toybox.WatchUi;

class MyBehaviorDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean{
        var menu = new WatchUi.Menu2({:title=>"My Menu2"});
        var delegate;

        // Add a new MenuItem to the Menu2 object
        menu.addItem(
            new MenuItem(

                // Set the 'Label' parameter
                "Item 1 Label",

                // Set the `subLabel` parameter
                "Item 1 subLabel",

                // Set the `identifier` parameter
                "itemOneId",
                // Set the options, in this case `null`
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                "Item 2 Label",
                "Item 2 subLabel",
                "itemTwoId",
                {}
            )
        );

        // Create a new Menu2InputDelegate
        delegate = new MyMenu2Delegate(); // a WatchUi.Menu2InputDelegate

        // Push the Menu2 View set up in the initializer
        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}
```

While the WatchUi.Menu example is built using the resource system, the WatchUi.Menu2 example above is built programmatically. Let's take a look at some of the new features demonstrated:

- **new WatchUi.Menu2**: The WatchUi.Menu2 class is a special WatchUi.View that is similar to WatchUi.Menu that presents the user with a list of options.
- **MenuItem**: The MenuItem object constructor takes four parameters: `label`, `subLabel`, `identifier`, and `options`. Each `MenuItem` can display a label and sub-label defined by the first two parameters. Here is a diagram that demonstrates the layout of the label and sub-label in WatchUi.MenuItem:

Figure 1.
An Illustration of label and sub-labels in `Menu2`

The WatchUi.MenuItem `identifier` is an object, typically a string, and is used to identify the `MenuItem` object in event calls. There is a fourth parameter which is a `Dictionary` of options which can be `null`.

- **WatchUi.Menu2InputDelegate**: The new WatchUi.Menu2InputDelegate class is used to handle selected Menu2 items. This object handles these selections with three methods:

- Menu2InputDelegate.onBack() - Handles the back key and pops the current page off the stack if not overridden.
- Menu2InputDelegate.onDone() - Used with a specialized WatchUi.CheckboxMenu. Pops the current page when not overridden.
- Menu2InputDelegate.onSelect() - Handles when a Menu2 item is selected.

For more, see the `Menu2Sample` sample app distributed with the SDK.

#### Menu2 XML Resources

A basic WatchUi.Menu2 can be defined in XML as a resource as follows:

```
<menu2 id="MainMenu" title="@Strings.MainMenuTitle">
  <menu-item id="generic1" label="Generic 1" subLabel="With Sublabel"></menu-item>
  <menu-item id="generic2" label="Generic 2"></menu-item>
</menu2>
```

Here are the attributes and definitions of a WatchUi.Menu2 defined as an XML resource:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the `` | Any string that starts with a character | NA | Required |
| `title` | The label text to be displayed as the header | A valid WatchUi.Drawable identifier, a string resource, or `String` | NA | optional |
| `icon` | The icon to display in the sub-window (Instinct 2 only) | Bitmap resource identifier | NA |  |
| `dividerType` | The location of the divider (5.0.1+ device support only) | A | `WatchUi.Menu2.DIVIDER_TYPE_DEFAULT` | optional |
| `theme` | The background color of a menu item | A or "disabled" | `WatchUi.MENU_THEME_DEFAULT` | optional |
| `personality` | The personality class for the menu | A defined personality class | NA | See Monkey Style |

The WatchUi.MenuItem identified as "generic1" uses both a label and sublabel. The "generic2" item uses only a label.

Here are the attributes and definitions of a WatchUi.MenuItem defined as an XML resource:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the `` | Any string that starts with a character | NA | Required |
| `label` | The label text to be displayed | A valid string resource or `String` | NA | Required |
| `subLabel` | The sub-label text to be displayed | A valid string resource or `String` | NA |  |
| `icon` | The icon to display in the sub-window (Instinct 2 only) | Bitmap resource identifier | NA |  |

The most exciting part about Menu2 is the use of icons, check boxes and toggles within menus. All Menu2 items can be created and launched in the same way, but each new menu item behaves uniquely. We've already seen the basic `MenuItem` class. Lets talk about some of the specifics when using the others.

#### Icon Menu Item

The WatchUi.IconMenuItem class allows developers to implement an icon based menu system. The WatchUi.IconMenuItem uses a label and sub-label, but also includes an icon that may be displayed to the right or left of the label and sub-label text.

Figure 2.
An illustration of an `IconMenuItem` in `Menu2`

Here is an `IconMenuItem` created as an XML resource:

```
<menu2 id="IconMenu" title="@Strings.IconMenuTitle">
    <icon-menu-item id="defaultAlign" label="@Strings.IconDefaultLabel" subLabel="@Strings.IconDummySubLabel"
     icon="@Drawables.LauncherIcon" />
    <icon-menu-item id="right" label="@Strings.IconRightLabel" subLabel="@Strings.IconDummySubLabel"
     icon="@Drawables.LauncherIcon">
        <param name="alignment">WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_RIGHT</param>
    </icon-menu-item>
</menu2>
```

Here are the attributes available for ``:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the `` | Any string that starts with a character | NA | Required |
| `label` | The label text to be displayed | A valid string resource or `String` | NA | Required |
| `subLabel` | The sub-label text to be displayed | A valid string resource or `String` | NA |  |
| `icon` | The icon to be displayed | A valid drawable resource or custom drawable | NA | Required |

#### Checkbox and Toggle Menu Items

The WatchUi.CheckboxMenuItem allows users to check multiple items in a list of menu items and save their state at one time (i.e. selecting play lists for music content). The WatchUi.CheckboxMenuItem class is used in combination with a class extending the WatchUi.CheckboxMenu View and a WatchUi.Menu2InputDelegate.

Figure 3.
An illustration of a `CheckboxMenuItem` in `Menu2`

Developers define a WatchUi.CheckboxMenuItem using XML as follows:

```
<checkbox-menu id="CheckMenu" title="@Strings.CheckMenuTitle">
    <checkbox-menu-item id="defaultAlign" label="@Strings.CheckDefaultLabel" subLabel="@Strings.CheckDefaultSubLabel"
     checked="true" />
    <checkbox-menu-item id="right" label="@Strings.CheckRightLabel" subLabel="@Strings.CheckRightSubLabel"
     checked="false">
        <param name="alignment">Ui.MenuItem.MENU_ITEM_LABEL_ALIGN_RIGHT</param>
    </checkbox-menu-item>
</checkbox-menu>
```

The WatchUi.ToggleMenuItem class is an element that indicates a menu item is in one of two states: `:enabled` or `:disabled`. See the change in the image below:

Figure 4.
An illustration of a `ToggleMenuItem` in `Menu2`

You can create a WatchUi.ToggleMenuItem as a resource using XML:

```
<menu2 id="ToggleMenu" title="@Strings.ToggleMenuTitle">
    <toggle-menu-item id="defaultAlign" label="@Strings.ToggleLabel1" subLabel="@Strings.ToggleOnSubLabel"
     disabledSubLabel="@Strings.ToggleOffSubLabel" checked="true" />
    <toggle-menu-item id="left" label="@Strings.ToggleLabel2" subLabel="@Strings.ToggleOnSubLabel"
     disabledSubLabel="@Strings.ToggleOffSubLabel" checked="false">
        <param name="alignment">WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_LEFT</param>
    </toggle-menu-item>
</menu2>
```

The `` and `` attributes are identical in name and function:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the `` or `` | Any string that starts with a character | NA | Required |
| `label` | The label text to be displayed | A valid string resource or `String` | NA | Required |
| `subLabel` | The sub-label text to be displayed when `checked` is `true` | A valid string resource or `String` | NA |  |
| `disabledSubLabel` | The sub-label text to be displayed when `checked` is `false` | A valid string resource or `String` | NA |  |
| `checked` | The boolean state of the `` or `` | `true` for `:enabled`, `false` for `disabled` | `false` | Value will switch even when not defined in XML |
| `icon` | The icon to display in the sub-window (Instinct 2 only) | Bitmap resource identifier | NA |  |
| `dividerType` | The location of the divider (5.0.1+ device support only) | A | `WatchUi.Menu2.DIVIDER_TYPE_DEFAULT` | Optional |

The `checked` attribute is automatically created as part of a or object and does not have to be defined in XML. If it is not defined in XML, then it will default to `false`.

For a WatchUi.MenuItem using graphical elements such as toggles and check boxes, developers can choose to align the elements to the left or right of the WatchUi.MenuItem label. If not defined, then elements will be aligned to the right as seen in the `defaultAlign` toggle menu above. A `` tag with the desired `MenuItem.MENU_ITEM_LABEL_ALIGN_*` value is used to set the alignment of icons, checks, and toggles. Developers can also explicitly align items to the right by using the `MenuItem.MENU_ITEM_LABEL_ALIGN_RIGHT` value.

### Action Menus

*Since API level 3.4.0*

Action views are screens that both provide information and provide a contextual menu of actions. These actions might be next steps or tasks that can be performed on the visible information.

For more, see the WatchUi.showActionMenu() API and the Action Views chapter of the Personality Library.

### Original Menu API

WatchUi.Menu is the older API for providing a list of options for the user. The options are displayed in a list that matches the device the app is running on. A menu can be defined in the resource XML file using the following format:

```
<menu id="MainMenu">
    <menu-item id="item_1" label="@Strings.menu_item_1_label" />
    <menu-item id="item_1" label="@Strings.menu_item_2_label" />
</menu>
```

The resource compiler will then take this XML and generate a WatchUi.Menu object in the `Rez` module. In order to use this menu, a developer simply needs to push the menu and a delegate for the menu using WatchUi.pushView():

```
class MyView extends WatchUi.View {
    function openTheMenu() {
        WatchUi.pushView( new Rez.Menus.MainMenu(), new MyMenuDelegate(), Ui.SLIDE_UP );
    }
}

class MyMenuDelegate extends WatchUi.MenuInputDelegate {
    function onMenuItem(item) {
        if ( item == :item_1 ) {
            // Do something here
        } else if ( item == :item_2 ) {
            // Do something else here
        }
    }
}
```

## Generic Picker

The WatchUi.Picker class, along with the WatchUi.PickerDelegate and WatchUi.PickerFactory classes, provides applications with the ability to create on-screen lists of user-selectable objects. A picker consists of one or more objects, a title, a next and previous arrow, and a confirm button. The next and previous arrows and the confirm button are device specific but can be overwritten if desired. Pickers are pushed using WatchUi.pushView(), providing a WatchUi.PickerDelegate for the input delegate. A WatchUi.PickerFactory is required to indicate what should be displayed for each pick-able value.

### User Interface

The above image is a representation of the general structure of what a picker should look like on a square screen. Other screen formats should have the same layout with some size differences to account for the screen and button layout.

- The top red bar represents where the title of the picker is displayed.
- Up and down arrows to scroll through the available options are placed where the green boxes are.
- The leftmost blue box is where the last item you selected is shown if the picker has multiple selectable items.
- The center blue box is the item you are currently selecting.
- The white box will either be the next selectable item in the list or the button to confirm your selection.

For more, see the `Picker` sample app distributed with the SDK.

## Confirmation Dialog

The WatchUi.Confirmation and WatchUi.ConfirmationDelegate provides a simple yes/no dialog. This is useful when presenting a simple selection to the user.

For more, see the `ConfirmationDialog` sample app distributed with the SDK, and the Confirmations section of the Personality Library.

## Progress Bar

The progress dialog gives a standard wait dialog. It has two modes—one that shows the completion of some process, and a second that acts a wait timer displaying an indeterminate amount of progress. The look and feel of the progress bar will be device-specific.

For more, see the `ProgressBar` sample app distributed with the SDK, and the Progress Bars section of the Personality Library.

# Page Loops

Page loops are carousels of views. When the user is in a page loop, the user interface presents a set of pages of information that provide different data and insights to the user. There are standard behaviors for going to the next and previous pages. Advancing from the last page typically loops the user back to the first page.

For more, see the WatchUi.ViewLoop API, and the Page Loops section of the Personality Library.

## Toasts

*Since API level 3.4.0*

Toasts are partial screen banners with text and an optional icon. The user cannot interact with them, and they dismiss after a short period. Toasts are good for informing users about asynchronous events without disrupting what they are currently doing.

For more, see the WatchUi.showToast() API, and the Toasts section of the Personality Library.

## Data Field

Data fields function as plug-ins for the Garmin activity experience. After users install a data field from the store, they can place them inside of their activity pages for any Garmin activity.

On devices with touch screen support, an input delegate can be used to accept input. Only the InputDelegate.onTap() behavior is supported and will be triggered when the user touches a point inside the data field when it is active on the screen. The behavior delegate should be the second element of the array that is returned from AppBase.getInitialView() as with other app types.

```
// This data field accepts touch input
class DataFieldApp extends App.AppBase {
    // Data field view with associated behavior delegate
    function getInitialView() {
        return [ new DataFieldView(), new DataFieldDelegate() ];
    }
}

class DataFieldDelegate extends Ui.InputDelegate {
    // Handle touch events
    function onTap(evt) {
        // Process the touch event
    }
}
```

### Alerts

*Since API level 3.2.0*

When you want your data field to notify the user of a specific event, you can push a view that extends WatchUi.DataFieldAlert. WatchUi.DataFieldAlert is a special instance of WatchUi.View that can be presented to the user with DataField.showAlert(). The alert does not accept input and will time out after the standard alert period. The user is required to enable alerts for your app in the workout alert settings.

## Mapping

*Since API level 3.0.0*

Connect IQ enables developers to embed map views into their apps on products with onboard cartography. Mapping is accessible in two ways: The WatchUi.MapView and the WatchUi.MapTrackView.

### MapViews

The WatchUi.MapView class is pushed like any other WatchUi.View class, but has some unique characteristics. Namely, WatchUi.MapView objects give you access to a rendering of a specified portion of the on-board map for a device. WatchUi.MapView objects let you choose a portion of a map to focus on by using two points of the type .

Here is the setup for a basic WatchUi.MapView:

```
import Toybox.WatchUi;
import Toybox.Position;

class MyMapView extends MapView {

    // Initialize the MapView
    function initialize() {
        MapView.initialize();

        // Set the top left Location object for the Map Visible Area
        var topLeft = new Position.Location({:latitude => 38.85695, :longitude =>-94.80051, :format => :degrees});

        // Set the bottom right Location object for the Map Visible Area
        var bottomRight = new Position.Location({:latitude => 38.85391, :longitude =>-94.7963, :format => :degrees});

        // Set the area of the map to be displayed
        MapView.setMapVisibleArea(topLeft, bottomRight);

        // Set the area in which to display the selected map area
        MapView.setScreenVisibleArea(0, 0, 240, 240/2);

        // Set the map mode
        MapView.setMapMode(WatchUi.MAP_MODE_PREVIEW);
    }
}
```

Let's dissect this a bit to learn about the view itself:

- **MapView.initialize()**: It is recommended to set the parameters of your MapView in it's `initialize()` function as shown here.
- **MapView.setMapVisibleArea()**: This method takes `top_left` and `bottom_right` parameters as `Position.Location` objects. These two locations create a bounding box that defines the view area of the map which are the top-left and bottom-right most `Location` objects that must be displayed on the initial map render. Conceptually, this works itself out into a rectangular portion of a map that must be focused on for the initial render of the MapView.
- **MapView.setScreenVisibleArea()**: MapViews allow developers to overlay UI items on top. Sometimes you want the entire screen to have the map image, but other times you'll want to split the display between map and UI elements. If you want the map area to not be the center of the screen you can use this method to define the rectangular area. This method determines the rectangular area in which the area of the map defined in the `setMapVisibleArea()` call should be rendered. Here is a figure to help illustrate the relationship where the blue rectangles represent the map area and the red rectangles represent the screen area.

Figure 5.
An Illustration of relationship between Map Area and the Screen Area

- **MapView.setMapMode()**: This call sets the map mode to one of the `MAP_MODE_*` enum values.

MapViews and MapTrackViews have two modes:

- **Preview:** Selected with the `MAP_MODE_PREVIEW` enum value. This allows a non-movable map to be rendered on the screen.
- **Browse:** Selected with the `MAP_MODE_BROWSE` enum value. This mode allows the user to zoom, pan, and move the map using the system default controls.

### MapTrackView

The MapTrackView is similar to the MapView in all ways except for one. The MapTrackView will dynamically render the active location of the device on the screen.

For more, see the `MapSample` sample app distributed with the SDK.

### Mapping Artifacts

Maps can add context with your content, but only if you can combine them together. Thankfully, not only can you access the maps native to devices, you can draw on them too! Monkey C has two new objects to interact with maps: WatchUi.MapPolyline and WatchUi.MapMarker.

#### MapPolyline

The WatchUi.MapPolyline object allows developers to draw a line with multiple points of location on a MapView rendering of a map. Only one WatchUi.MapPolyline object is allowed in a view.

Here is an example of a WatchUi.MapPolyline with four points:

```
    // Initialize a new MapPolyline object
    var polyline = new WatchUi.MapPolyline();

    //Set the color of the MapPolyline
    polyline.setColor(Toybox.Graphics.COLOR_RED);

    // Set the pen width to draw the MapPolyline
    polyline.setWidth(2);

    // Set the Locations on the MapPolyline
    polyline.addLocation(
        new Position.Location({
            :latitude => 38.85391,
            :longitude =>-94.79630,
            :format => :degrees
        })
    );
    polyline.addLocation(
        new Position.Location({
            :latitude => 38.85465,
            :longitude =>-94.79922,
            :format => :degrees
        })
    );
    polyline.addLocation(
        new Position.Location({
            :latitude => 38.85508,
            :longitude =>-94.79959,
            :format => :degrees
        })
    );
    polyline.addLocation(
        new Position.Location({
            :latitude => 38.85557,
            :longitude =>-94.79864,
            :format => :degrees
        })
    );

    // Set the MapPolyline object to draw on the map
    MapView.setPolyline(polyline);
```

- **new WatchUi.MapPolyline**: This creates a new instance of WatchUi.MapPolyline object.
- **setColor()**: Sets the color of the WatchUi.MapPolyline with a `COLOR_*` enum value.
- **setWidth()**: Sets the pen width used to draw the WatchUi.MapPolyline in pixels.
- **addLocation()**: This method takes a object and adds it to an `Array` of WatchUi.MapPolyline objects. These locations make up the points used to draw the lines that comprise the WatchUi.MapPolyline representation on the map.
- **MapView.setPolyline()**: This sets the MapPolyline object to be rendered on the map in the WatchUi.MapView or WatchUi.MapTrackView. In this example it is using the WatchUi.MapPolyline object stored as `polyline`.

#### MapMarker

The WatchUi.MapMarker object pairs a object with a BitmapResource to create a marker to be draw on a map. Each Bitmap image used in a WatchUi.MapMarker object will have a "hotspot" for the image. The hotspot is the point of the image that will be drawn at the latitude and longitude for the provided for the WatchUi.MapMarker.

Here is a simple implementation of a WatchUi.MapMarker object:

```
    // Initialize a map marker with a Location object
    var bitmapMarker = new WatchUi.MapMarker(
        new Position.Location({
            :latitude => 38.85391,
            :longitude =>-94.79630,
            :format => :degrees
        })
    );
            bitmapMarker.setIcon(WatchUi.loadResource(Rez.Drawables.MapPin), 12, 24);
            bitmapMarker.setLabel("Custom Icon");

    var defaultMarker = new WatchUi.MapMarker(
        new Position.Location({
            :latitude => 38.85508,
            :longitude =>-94.79959,
            :format => :degrees
        })
    );
            defaultMarker.setIcon(WatchUi.MAP_MARKER_ICON_PIN, 0, 0);
            defaultMarker.setLabel("Predefined Icon");

    // Set the Map Marker for the view
    MapView.setMapMarker(defaultMarker);
```

Let's look at the code above to get a better handle on the APIs.

- **new WatchUi.MapMarker**: The WatchUi.MapMarker object is initialized with the `Location` object passed to it. This is be the point at which the `MapMarker` hotspot of the Bitmap resource is be drawn.
- **bitmapMarker.setIcon(WatchUi.loadResource(Rez.Drawables.MapPin), 12, 24)**: This call sets the icon of theWatchUi.MapMarker named `bitmapMarker` to the bitmap resource `Rez.Drawables.MapPin`. The hotspot is set to `12` for the `x` coordinate of the bitmap and `24` for the `y` coordinate of the `MapPin` icon.
- **setLabel()**: Sets the label of the WatchUi.MapMarker icon to be displayed on the rendered map.
- **defaultMarker.setIcon(WatchUi.MAP_MARKER_ICON_PIN, 0, 0)**: This WatchUi.MapMarker is using the `MAP_MARKER_ICON_PIN` enum value when setting the icon and use the system default icon for marking the point on the map. Note that the provided values for `x, y` for the hotspot are `0, 0` respectively. When using the default icon, the hotspot management is handled by the system.
- **setMapMarker()**: The method takes a WatchUi.MapMarker object and sets it on the map. In this example only the `defaultMarker` is set to be drawn on the map. However, it is acceptable to set multiple MapMarker objects by setting them in an Lang.Array. For example:

```
// Create an Array to hold the MapMarker objects
var markers = [];

// Add the MapMarkers to the Array
markers.add(bitmapMarker);
markers.add(defaultMarker);

// Set multiple markers in an Array
MapView.setMapMarker(markers);
```

### Simulating Maps

When working with maps in the simulator, Connect IQ uses web APIs to retrieve map images to simulate on-device behavior. Simulator and on-device mapping coverage with vary as on-device mapping is contingent on the device and maps available. Here is the detail coverage map for the simulator:

- **Green:** Low detail
- **Blue:** Medium detail
- **Red:** High detail

Figure 6.
The detail map available on the Connect IQ Simulator

1 Graphical titles are currently only supported via programmatic creation of `MenuItem` elements in `Menu2`. Defining a title as a drawable resource will result in compiler error.
