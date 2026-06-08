---
source: https://developer.garmin.com/connect-iq/core-topics/resources/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Resources.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Resources

The resource compiler compiles images, text, and static data into a resource database that the application can access at run time. The resource compiler is tied into the Monkey C compiler. Its input is an XML file:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <bitmap id="bitmap_id" filename="path/for/image" />
    <font id="font_id" filename="path/to/fnt" />
    <string id="string_id">Hello World!</string>
</resources>
```

## The Resource Module (a.k.a. Rez)

The resource compiler auto-generates a Monkey C module named `Rez` that contains the resource IDs for the resource file. These identifiers, of type Lang.ResourceId, are used to refer to your resources:

The code can use the `Rez` class to reference the resources at run time. You can use the following APIs:

| API | Purpose | API Level |
| --- | --- | --- |
| WatchUi.loadResource() | Load a resource from the PRG into memory | 1.0.0 |
| Application.loadResource() 1 | Load a resource from the PRG into memory | 3.1.0 |

For example, let's say you have a bitmap you want to use in your view. Before it can be used by the app, it must be loaded from the resource file:

```
image = Application.loadResource( Rez.Drawables.bitmap_id ) as BitmapResource;
```

Now the bitmap can be drawn in the update handler:

```
dc.drawBitmap( 50, 50, image );
```

Resources are reference counted just like other Monkey C objects. Loading a resource can be an expensive operation, so do not load resources when handling screen updates.

### Referencing Resources Within Resource Files

Resources can also be referenced from within another resource file. To do this use the syntax `@.`. For example, you could reference a String resource within a menu definition using the following code.

```
<string id="menu_item_1_label">Item 1</string>

<menu id="MainMenu">
    <menu-item id="item_1" label="@Strings.menu_item_1_label" />
</menu>
```

This code would use the string defined with an ID of `menu_item_1_label` as the label for the menu item.

## Resource Scopes

*Since API level 3.1.0*

Adding resources to an app comes with a minor runtime memory cost. While the cost is small, it can seriously cut into the available memory for background services and glances. To mitigate these costs, Connect IQ has an additional `scope` attribute to the following resource tags: ``, ``, ``, ``, ``, ``. The `scope` attribute tells the resource compiler the type of application that the resource should be made available to. Valid values for the `scope` attribute are `background`, `glance`, and `foreground`. If the attribute is not specified for a resource, it will be considered part of the `foreground` scope by default. An example of using the `scope` attribute with string resources:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <string id="MyBackgroundString" scope="background">Background String</string>
    <string id="MyGlanceString" scope="glance">Glance String</string>
    <string id="MyForegroundString" scope="foreground">Foreground String</string>
</resources>
```

Use the `scope` attribute to save memory in your glance or background service. All background scoped resources will be available to the glance and foreground application. All glance scoped resources will be available to the foreground application, but not to the background service. Foreground scoped resources will only be available to the foreground application.

| Application Mode | MyBackgroundString | MyGlanceString | MyForegroundString |
| --- | --- | --- | --- |
| Background Service | X |  |  |
| Glance | X | X |  |
| Foreground | X | X | X |

In the example above, `MyBackgroundString` would be available when running the application in any valid mode. `MyGlanceString` would be available to the glance and foreground application, but not to the background service if present. `MyForegroundString` would only be available to the foreground application. By providing this hierarchy, developers can better determine how their resources should be scoped.

See Background Services or Glances for more information.

## Strings

Connect IQ products are used around the world, and those users want apps to work in their language. Connect IQ supports adding strings using a strings resource file:

```
<strings>
    <string id="identifier">String Value</string>
</strings>
```

At runtime, you can load this string using WatchUi.loadResource(). String definitions take the following attributes:

| Attribute | Required | Description |
| --- | --- | --- |
| `id` | Yes | Identifier for the string |
| `scope` | No | See resource scopes. String can have the additional `settings` scope which removes it from the runtime. This is useful when a string is only used within your setting definitions. |
| `translatable` | No | Indicates if a string requires translations. Set to `false` to mark a string as not requiring translations. |

Using localization qualifiers of your resource folders you can provide different strings for different languages. Adding the following suffixes to your resource folder will allow you to add string files for various languages

| Qualifier | Language | Notes |
| --- | --- | --- |
| No qualifier | Base language | These strings will be used if no language is provided. If a translation is not provided for a string in a specific language, the system will use the base language version as a substitution. |
| `ara` | Arabic |  |
| `bul` | Bulgarian |  |
| `ces` | Czech |  |
| `dan` | Danish |  |
| `deu` | German |  |
| `dut` | Dutch |  |
| `eng` | English |  |
| `est` | Estonian |  |
| `fin` | Finnish |  |
| `fre` | French |  |
| `hrv` | Croatian |  |
| `hun` | Hungarian |  |
| `ind` | Indonesian |  |
| `ita` | Italian |  |
| `jpn` | Japanese |  |
| `kor` | Korean |  |
| `lav` | Latvian |  |
| `lit` | Lithuanian |  |
| `nob` | Norsk Bokmål |  |
| `pol` | Polish |  |
| `por` | Portuguese |  |
| `slo` | Slovak |  |
| `slv` | Slovenian |  |
| `spa` | Spanish |  |
| `swe` | Swedish |  |
| `rus` | Russian |  |
| `ron` | Romanian |  |
| `tha` | Thai |  |
| `tur` | Turkish |  |
| `ukr` | Ukrainian |  |
| `vie` | Vietnamese |  |
| `zsm` | Standard Malay |  |
| `zhs` | Simplified Chinese |  |
| `zht` | Traditional Chinese |  |

You can combine these qualifiers with device, family and screen qualifiers to have strings that are customized to each device if necessary.

See the `Strings` sample for an example of how to use the strings resource system.

## Bitmaps

Garmin devices have different form factors, screen sizes and screen technologies, so bitmaps need to be explicitly converted for every device. The resource compiler will generate resources for every intended product, which allows the developer to have one set of resources for black and white products, one set for color products, one for larger screen sizes, etc. The resource compiler supports `JPG/JPEG`, `BMP/WBMP`, `GIF`, `SVG` and `PNG` file formats.

While each device has a unique palette, the developer can specify a palette to use for an image. The resource compiler will map the colors that are defined in the developer's palette to the closest match in the device palette and use only those colors. A palette can be defined using the following syntax:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <bitmap id="bitmap_id" filename="path/for/image">
        <palette disableTransparency="false">
            <color>FF0000</color>
            <color>FFFFFF</color>
            <color>0000FF</color>
        </palette>
    </bitmap>
</resources>
```

The table below shows some of the valid attributes for a `` definition.

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the layout, which is used to reference the layout in the Rez module | Any value that starts with a letter | NA | Required |
| `filename` | The relative path to the image file | A valid, resolvable path to an image file | NA | Required |
| `dithering` | The type of dithering to use when compiling the image | `floyd_steinberg` or `none` | `floyd_steinberg` |  |
| `compress` | Indicate that the compiled bitmap should be compressed to reduce .PRG size | `true` or `false` | `false` |  |
| `automaticPalette` | Automatically determine a reduced color palette to use while compiling the image. Images will be limited to 256 colors for 16-bit color devices. | `true` or `false` | `true` for 16-bit color devices |  |
| `packingFormat` | The format with which the image will be encoded into the PRG | `default`, `png`, `jpg`, `yuv`. | `default` | Options besides `default`only available on certain devices. See Bitmap Packing Formats |
| `scaleX` | How should the image be scaled in the x dimension? | Pixel size or percentage | If `scaleY` is set, will default to `scaleY`’s value. Otherwise will default to 100% of image width | See `scaleRelativeTo` |
| `scaleY` | How should the image be scaled in the x dimension? | Pixel size or percentage | If `scaleX` is set, will default to `scaleX`’s value. Otherwise will default to 100% of image height | See `scaleRelativeTo` |
| `scaleRelativeTo` | What should the scale factor be based on? | `screen` or `image` | `screen` | Sets what to base relative scaling on. If set to screen, image will be re-scaled based on product it is being built for at compile time |
| `personality` | Personality class for the element | Personality class | None | See Monkey Style |

The valid attributes for a `` definition are in the table below.

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `disableTransparency` | Should the compiler allow transparent pixels in the image? Disabling transparency may save memory | `true` or `false` | `false` |  |

### Bitmap Packing Formats

*Since API level 4.0.0*

Images can grow your executable size, which can add extra wait when users install or update your app. To reduce executable bloat use these bitmap attributes for packing images into your executable.

Each of the formats can have their advantages and disadvantages:

| Format | Advantage | Disadvantage | Use Case |
| --- | --- | --- | --- |
| `default` | Available on all products, fastest to load, supports alpha channel | No compression | App runs on pre-API level 4.0.0 devices. Low palette images can have very small runtime costs |
| `png` | Lossless, compressed and supports alpha channel | Slowest to load, which can add runtime cost if purged and reloaded frequently from the graphics pool | Importing non-photo images with or without alpha channel |
| `jpg` | Compresses very well, fast to load | Lossy format and does not support alpha channel | Importing photo imagery without alpha channel |
| `yuv` | Compresses well, supports alpha channel, fast to load | Lossy format | Importing photo imagery with alpha channel |
|  |  |  |  |

## Fonts

The resource compiler reads fonts in `TXT` or `PNG` format. You can use the BMFont tool (available at http://www.angelcode.com/products/bmfont/) to convert a font from many different formats to a compatible format. Prior to export, ensure that BMFont's *Font Settings* specify the Unicode character set. Recommended export options are shown in the image below:

Figure 1.
The BMFont Export Options

The color can be set using Dc.setColor(). Since bitmap fonts can take a lot of runtime memory, the font converter defaults to non-anti-aliased 1-bit fonts to save memory. If you know you will have the runtime RAM available, you can turn on font anti-aliasing with the `antialias` option.

```
<!-- Domo arigato mister font -->
<font id="font_id" filename="roboto.fnt" antialias="true" />
```

If you are creating a large font, sometimes, only particular glyphs need to be large-sized (like numbers for a watch face). Use the filter attribute to specify the particular glyphs to include:

```
<!-- Only include digits from this large font -->
<font id="font_id" filename="big_font.fnt" filter="0123456789:"/>
```

Font elements accept the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | String | Yes | None | Unique identifier for the font |
| `filename` | String | Yes | None | BMFont generated `.fnt` file |
| `filter` | String | No | None | Optional string that outlines all characters to import from the font |
| `antialias` | Boolean | No | `false` | Boolean that identifies if fonts should be imported with anti-aliasing information |
| `scope` | String | No | `foreground` | See resource scopes |
| `personality` | Personality class | No | None | Personality class for the element. See Monkey Style for more information |

## Menus

Menus are common UI elements on Connect IQ products. Menu resources allow you to define your menus within your resource definitions.

### Standard Menus

Menus are defined using the `` element, which has the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | String | Yes | None | Unique identifier for the menu |
| `title` | String | No | None | String, string resource identifier, or drawable resource identifier |
| `icon` | Drawable reference | No | None | Bitmap identifier. Used for Instinct 2 sub-screen icon. |
| `personality` | Personality class | No | None | Personality class for the element. See Monkey Style for more information |

Within a `` element can be an array of ``, ``, or `` types.

#### Standard Menu Items

Standard menu items are contained within `` elements and have the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | String | Yes | None | Unique identifier for the menu item |
| `label` | String | Yes | None | String title for the menu item |
| `subLabel` | String | No | None | String sub-title for the menu item |
| `icon` | Drawable reference | No | None | Drawable icon displayed in the Instinct 2 sub-screen 2 |
| `personality` | Personality class | No | None | Personality class for the element. See Monkey Style for more information |

#### Toggle Menu Items

Toggle menu items are contained within the `` element. In addition to the attributes mentioned in standard menu items, they have the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `disabledSubLabel` | String | No | None | Separate sub-label for when the toggle id in the disabled state |
| `checked` | Boolean | No | `false` | `true` if toggle should be enabled, `false` otherwise |

#### Icon Menu Items

Icon Menu items are defined with the `` element. With icon menu icons, the `icon` attribute is displayed in the menu item.

### Checkbox Menus

Checkbox menus are defined with the `` element, which has the same attributes as standard menus. Inside of the checkbox menu can be a sequence of `` elements.

#### Checkbox Menu Items

Checkbox menu items are defined with the `` element. In addition to the attributes mentioned in standard menu items, they have the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `checked` | Boolean | No | `false` | `true` if toggle should be enabled, `false` otherwise |

### Action Menus

Action menus are contextual menus associated with a page. Action menus are defined with the `` element, which can have the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | String | Yes | None | Unique identifier for the menu |
| `theme` | `WatchUi.ACTION_MENU_THEME_DARK` or `WatchUi.ACTION_MENU_THEME_LIGHT` | No | `WatchUi.ACTION_MENU_THEME_DARK` | Allows configuring if the action menu is light on dark or dark on light. Not configurable on all products. |
| `personality` | Personality class | No | None | Personality class for the element. See Monkey Style for more information |

#### Action Menu Items

Action menu items are contained within `` elements and have the following attributes:

| Attribute | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `id` | String | Yes | None | Unique identifier for the menu item |
| `label` | String | Yes | None | String title for the menu item |
| `personality` | Personality class | No | None | Personality class for the element. See Monkey Style for more information |

## Animations

*Since API level 3.1.0*

The Monkey Motion tool included in the Connect IQ SDK that can be used to generate animation resources for compatible Connect IQ products.

The Monkey Motion tool supports importing from `YUV` and `GIF` file formats. Due the fact that `YUV` is a true color, close-to-raw file format, it is the recommended format when entering a high quality animation into the Monkey Motion encoder tool. If necessary, FFmpeg is a convenient tool for converting video file formats. For example, if your creative team has provided a video in some other popular format, convert the file to the `YUV` format:

```
> ffmpeg -i input.mp4 -vf format=yuv420p output.y4m
```

Additionally, to overcome the fact that the `YUV` format does not support transparency (unlike the `GIF` file format), the Monkey Motion tool accepts an additional `YUV` file as input. This video file should represent an alpha channel mask of the original animation that contained transparency. Again, FFmpeg is a convenient tool for creating such a video. The `alphaextract` option can be used to take an input stream with an alpha channel and return a video containing just the alpha component as a greyscale value:

```
> ffmpeg -i input.gif -vf alphaextract,format=yuv420p output.y4m
```

For the same reasons outlined in the section above, animations need to be explicitly converted for every device. For easy import into your Connect IQ application, the Monkey Motion tool batch converts video to binary encoding3 for devices you select.

### Including Animation Resources in a Monkey C Project

To include an animation resource in a Monkey C project, define an animation resource. This can be done manually or by using the Monkey Motion tool. The table below shows all of the valid attributes for an `` resource:

| Attribute | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `id` | The handle for the layout, which is used to reference the layout in the Rez module | Any value that starts with a letter | NA | Required |
| `filename` | The relative path to the Monkey Motion Manifest file | A valid, resolvable path to a Monkey Motion Manifest file | NA | Required |
| `personality` | Personality class for the element | A defined personality class | NA | Optional |

An example Animation XML resource:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <animation id="swirl" filename="swirl.mmm" />
</resources>
```

To load this animation resource in code, create a WatchUi.AnimationLayer then add it to a WatchUi.View:

```
class MyAnimationView extends WatchUi.View {

   var mySwirl;

   function initialize( dc ) {
       var dev = System.getDeviceSettings();
       var x = ( dev.screenWidth - mySwirl.getWidth() ) / 2;
       var y = ( dev.screenHeight - mySwirl.getHeight() ) / 2;

       // create a new AnimationLayer with the resource then add it to the view
       // as a WatchUi.Layer
       mySwirl = new WatchUi.AnimationLayer(Rez.Drawables.swirl, {:locX=>x, :locY=>y});
       view.addLayer( mySwirl );
    }

    function onShow() {
        mySwirl.play();
        View.onShow();
    }

    function onUpdate(dc) {
        // override 'onUpdate' to clear the screen
        dc.clear();
    }
}
```

Read more about Animations in the Monkey Motion reference, API documentation, AnimationLayer documentation, and the `AnimationWatchFace` sample.

## JSON Data

JSON data resources can store relatively large amounts of data in your app without having to keep it in memory at all times. This can be useful for storing something like a table of information that must be referenced at runtime, but will not be modified.

These resources are declared with the `jsonData` tag in a resource file, are read by the resource compiler, and loaded on demand at runtime. The `jsonData` tag supports the following attributes:

| Attribute | Definition | Valid Values |
| --- | --- | --- |
| `id` | The identifier of the JSON resource | Any string starting with a letter |
| `filename` | The name of a file containing JSON data | A valid, resolvable path to a data file |

JSON data resources may be provided as either a `jsonData` value or as a file referenced by the `filename` attribute, depending on whether it's easier to manage the data inside a resource file or in a separate JSON file. If using a file, it may only contain JSON data. Here are a few examples:

```
<resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://developer.garmin.com/downloads/connect-iq/resources.xsd">
    <jsonData id="jsonDictionary">{"key":"value", "3":"three", "three":3}</jsonData>
    <jsonData id="jsonArray">[1,2,3,4,5,6]</jsonData>
    <jsonData id="jsonMix">[1,{"1":"one"},["a","b","c"]]</jsonData>
    <jsonData id="jsonPrimitive">5</jsonData>
    <jsonData id="jsonFile" filename="data.json"/>
</resources>
```

The JSON data is loaded with the Application.loadResource() method by passing in the `jsonData` ID. For example, to load the `jsonArray` data from the example above, the following code would be used:

```
var array = Application.loadResource(Rez.JsonData.jsonArray);
```

For more see the `JsonDataResources` sample app distributed with the SDK.

1 Toybox.WatchUi wasn't accessible by background services so we moved it.

2 We stan a sub-screen icon. QUEEN!

3 Their own language and their own video file format? Who do these people think they are?
