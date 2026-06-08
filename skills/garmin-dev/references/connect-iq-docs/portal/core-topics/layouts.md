---
source: https://developer.garmin.com/connect-iq/core-topics/layouts/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Layouts.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Layouts

The resource compiler allows page layouts to be customized to a particular device without changing any Monkey C code. In addition, drawable List objects can also be defined, which are WatchUi.Drawable objects that can draw a number of graphics primitives.

When defining a layout in XML, simply list the drawable objects to include in your layout inside a set of layout tags. Each drawable listed will be turned into Monkey C WatchUi.Drawable objects and drawn one after the other. Because of this, if two drawables in your layout overlap each other the drawable that is defined second will draw on top of the drawable that is defined first. Here is an example of a basic layout:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <layout id="MainLayout">
        <drawable id="MainBackground" />
        <label text="Page Heading" x="10" y="25" font="Gfx.FONT_LARGE" color="Gfx.COLOR_BLACK" />
        <label text="Your information goes here." x="50%" y="50%" font="Gfx.FONT_MEDIUM" color="Gfx.COLOR_DK_GRAY" />
    </layout>
</resources>
```

To use this layout in your code simply call View.setLayout() inside the View.onLayout() function. Call the parent View.onUpdate() if you plan on using the View.onUpdate() function to update dynamic values on the screen. For example:

```
class MainView extends WatchUi.View {
    public function onLayout( dc as Dc ) as Void {
        setLayout( Rez.Layouts.MainLayout( dc ) );
    }

    public function onUpdate( dc as Dc) as Void {
        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate( dc );

        // Include anything that needs to be updated here
    }
}
```

## Layout

The following attributes are supported by the `layout` tag:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the layout. This is used to reference the layout in the Rez module | Any value that starts with a letter | NA | Required |

## Label

Text can be included in layouts. To include text use the `label` tag, which supports the following attributes:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the label. The ID provided here references the label defined in the resource XML file | Any value that starts with a letter | NA |  |
| `text` | The text to be displayed | NA | An empty string |  |
| `font` | The font to be used when drawing the text | See font references | `Graphics.FONT_MEDIUM` |  |
| `x` | The X coordinate of the point that the text will be justified against | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | The Y coordinate of the point that the text will be justified against | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |
| `justification` | How the text should be justified in relation to the X & Y location | `Graphics` text justify constant | `Graphics.TEXT_JUSTIFY_LEFT` |  |
| `color` | The color of the text | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | `Graphics.COLOR_WHITE` |  |
| `background` | The background color of the text | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | `Gfx.COLOR_TRANSPARENT` |  |
| `visible` | The drawable is visible | `true` or `false` | `true` | Only supported for devices with ConnectIQ 3.3.0 and later |

## Text Area

*Since API level 3.1.0*

Text may also be included in a layout as a text area. A text area is similar to a text label, except it will attempt to fit text into the provided area by selecting an appropriate font, adding line breaks, or applying truncation. To include a text area, use a `text-area` element. The following attributes are permitted:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the text area. The ID provided here references the text area defined in the resource XML file | Any value that starts with a letter | NA |  |
| `text` | The text to be displayed | NA | An empty string |  |
| `font` | The font to be used when drawing the text | See font references | `Graphics.FONT_MEDIUM` | Cannot be used if a font sequence is provided |
| `x` | The X coordinate of the point that the text will be justified against | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | The Y coordinate of the point that the text will be justified against | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |
| `width` | The width of the area to fit the text into | pixel value, a relative dimension using '%', or `fill` | `0` |  |
| `height` | The height of the area to fit the text into | pixel value, a relative dimension using '%', or `fill` | `0` |  |
| `justification` | How the text should be justified in relation to the X & Y location | `Graphics` text justify constant | `Graphics.TEXT_JUSTIFY_LEFT` |  |
| `color` | The color of the text | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | `Graphics.COLOR_WHITE` |  |
| `background` | The background color of the text | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | `Gfx.COLOR_TRANSPARENT` |  |
| `visible` | The drawable is visible | `true` or `false` | `true` | Only supported for devices with ConnectIQ 3.3.0 and later |

A text area can select a font from a sequence to minimize truncation. The text area will try the fonts in the specified order until the text can be drawn in the given area without truncation. If no font is found that avoids truncation, the last font in the sequence will be used and the text will be truncated. Valid values for each font element are the same as that of the `font` attribute. An example `text-area` with a font sequence:

```
<text-area id="BlockOfText" text="Lorem ipsum dolor sit amet, consectetur adipiscing elit." x="10%" y="10%" width="80%" height="80%">
    <fonts>
        <font>Gfx.FONT_MEDIUM</font>
        <font>@Rez.Fonts.MySmallFont</font>
        <font>Gfx.FONT_XTINY</font>
    </fonts>
</text-area>
```

### Font References

In layout definitions, there are three ways to refer to fonts:

| Reference | Description | Example |
| --- | --- | --- |
| System font reference | Reference the standard FONT enumeration in the Toybox.Graphics module. | `Graphics.FONT_SMALL` |
| Custom font reference | Reference a font in application resources. | `@Rez.Fonts.MySmallFont` |
| Scalable font reference | Reference a system scalable font. This is the font name or names optionally separated by a comma and the pixel size separated by a colon. See Scalable Fonts for more information. | `"#BionicBold,Roboto:12"` |

## Drawables

Drawables (both bitmaps and drawable XML resources) can also be included in a layout using the `drawable` tag. The following attributes are supported by the `drawable` tag:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the drawable. The ID provided here references the drawable defined in the resource XML file | Any value that starts with a letter | NA | Required; the drawable must also be defined in a resource XML file |
| `x` | The X coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | The Y coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |

## Drawable List

Drawable XML resources consist of a list of basic drawables: bitmaps and shapes. To create an XML drawable, define a `` in an XML resource file. Both `` and `` tags should be be placed as child nodes inside the ``. An example drawable-list:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <drawable-list id="Smiley" background="Gfx.COLOR_YELLOW">
        <shape type="circle" x="10" y="10" radius="5" color="Gfx.COLOR_BLACK" />
        <shape type="circle" x="30" y="10" radius="5" color="Gfx.COLOR_BLACK" />
        <bitmap id="mouth" x="15" y="25" filename="../bitmaps/mouth.png" />
    </drawable-list>
</resources>
```

To use this drawable in code do the following:

```
function onUpdate( dc as Dc ) as Void {
    var mySmiley = new Rez.Drawables.Smiley();
    mySmiley.draw( dc );
}
```

The `` tag supports the following attributes:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the drawable | Any string that starts with a character | NA | Required |
| `x` | The X coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | The Y coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |
| `width` | The width of the drawable list. | pixel value, a relative dimension using '%', or `fill` | `fill` |  |
| `height` | The height of the drawable list. | pixel value, a relative dimension using '%', or `fill` | `fill` |  |
| `foreground` | The color of elements (shapes and text) drawn in the drawable | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | The current draw context's foreground color |  |
| `background` | The background color of the drawable | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | `Gfx.COLOR_TRANSPARENT` |  |

For more, see the `Drawable` sample app distributed with the SDK.

## Shape

The `` tag supports the following attributes:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `type` | The type of the shape to be drawn | `rectangle`, `ellipse`, `circle`, or `polygon` | NA | Required |
| `x` | For circles and ellipses: X coordinate of the center of the shape in relation to the parent; for everything else: the X coordinate of the top left corner in relation to the parent element. | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | For circles and ellipses: Y coordinate of the center of the shape in relation to the parent; for everything else: the Y coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |
| `points` | A list of points which defines the `polygon` | `[[x1, y1], [x2, y2], ... , [xN, yN]]`, points can be relative positions using '%' | NA | Required for `polygon`; must have at least 3 points |
| `width` | The width of the shape to be drawn | pixel value, a relative dimension using '%', or `fill` | `fill` | Required for `rectangle` |
| `height` | The height of the shape to be drawn | pixel value, a relative dimension using '%', or `fill` | `fill` | Required for `rectangle` |
| `a` | The a value of the ellipse to be drawn | pixel value, a relative dimension using '%', or `fill` | `fill` | Required for `ellipse` |
| `b` | The b value of the ellipse to be drawn | pixel value, a relative dimension using '%', or `fill` | `fill` | Required for `ellipse` |
| `color` | The color of the shape to be drawn | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | The current draw context's foreground color |  |
| `corner_radius` | The radius of the rounded corners of the `rectangle` | pixel value | `0` | Only valid for `rectangle` |
| `radius` | The radius of the `circle` | pixel value or a relative dimension using '%' | `0` | Required for `circle` |
| `border_width` | The width of the border around the shape | pixel value | `0` | Only valid for `rectangle`, `ellipse`, and `circle` |
| `border_color` | The color of the border around the shape | `Graphics` color constant or a 24-bit integer of the form `0xRRGGBB` | The current draw context's foreground color | Only valid for `rectangle`, `ellipse`, and `circle` |

For more see the `Drawable` sample app distributed with the SDK.

## Bitmap

The `` tag supports the following attributes:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The ID of the drawable | Any string that starts with a character | NA | Required |
| `x` | The X coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `left`, `right`, or `start` | `0` |  |
| `y` | The Y coordinate of the top left corner in relation to the parent element | pixel value, a relative position using '%', `center`, `top`, `bottom`, or `start` | `0` |  |
| `filename` | The relative path to the image that should be shown | A valid, relative path | NA | Required |
| `visible` | The drawable is visible | `true` or `false` | `true` | Only supported for devices with ConnectIQ 3.3.0 and later |

## Custom Drawables

In some cases it is useful to have a drawable entry within a layout point to a custom defined class which extends WatchUi.Drawable, or any of its directly known subclasses. This is possible by using the `class` attribute of the `` tag.

```
<layout>
    <drawable id="MoveBar" class="CustomMoveBar" />
</layout>
```

The drawable entry above will add a new instance of the `CustomMoveBar` class to the layout. You can then define how the `CustomMoveBar` is drawn by overriding the `draw(dc)` function.

```
import Toybox.WatchUi;

class CustomMoveBar extends WatchUi.Drawable {
    function draw(dc as Dc) as Void {
        // Draw the move bar here
    }
}
```

### Passing Parameters to Custom Drawables

If may be useful to pass values into a custom Drawable. To do this you define `` children within the `` tag. The `` tag should define the name of the parameter using the `name` attribute and the value as it's content. The content value is passed as is to the custom Drawable. This means if you want to pass a string you must wrap the content in quotes.

```
<layout>
    <drawable id="MoveBar" class="CustomMoveBar">
        <param name="color">Gfx.COLOR_RED</param>
        <param name="string">"Hello Custom Drawable!"</param>
    </drawable>
</layout>
```

The parameters defined in XML are passed to the custom Drawable's initialize function as a dictionary. The names are passed as symbols and the values are passed as they appear in the XML.

```
import Toybox.WatchUi;

class CustomMoveBar extends WatchUi.Drawable {

    private var _color, _string;

    public function initialize(params as Dictionary) {
        // You should always call the parent's initializer and
        // in this case you should pass the params along as size
        // and location values may be defined.
        Drawable.initialize(params);

        // Get any extra values you wish to use out of the params Dictionary
        _color = params.get(:color);
        _string = params.get(:string);
    }
}
```
