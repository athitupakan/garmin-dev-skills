---
source: https://developer.garmin.com/connect-iq/core-topics/graphics/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Graphics.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Graphics

The graphics module handles drawing bitmaps, fonts, and shapes to the device screen.

## Drawing Context

The Graphics.Dc object is used to draw to a graphics surface. The primary device surface is provided to the View object methods View.onLayout(), View.onUpdate(), and . The size of the surface can be queried with the Dc.getWidth() and Dc.getHeight() methods.

| Primitive or Operation | Draw | Fill | API Level | Notes |
| --- | --- | --- | --- | --- |
| Set the pen or fill color | Dc.setColor(), Dc.setStroke() | Dc.setColor(), Dc.setFill() | 1.0.0, 4.0.0 | Dc.setStroke() and Dc.setFill() are API 4.0.0. |
| Set the pen width | Dc.setPenWidth() | N/A | 1.0.0 |  |
| Clear the drawable area | N/A | Dc.clear() | 1.0.0 |  |
| Draw a bitmap | Dc.drawBitmap() | NA | 1.0.0 |  |
| Draw a bitmap | Dc.drawBitmap2() | NA | 4.2.0 |  |
| Draw a text string | Dc.drawText() | NA | 1.0.0 | Only works with Dc.setColor() 1 |
| Draw a pixel | Dc.drawPoint() | NA | 1.0.0 |  |
| Draw a line | Dc.drawLine() | NA | 1.0.0 |  |
| Draw a circle | Dc.drawCircle() | Dc.fillCircle() | 1.0.0 |  |
| Draw an ellipse | Dc.drawEllipse() | Dc.fillEllipse() | 1.0.0 |  |
| Draw a rectangle | Dc.drawRectangle() | Dc.fillRectangle() | 1.0.0 |  |
| Draw a rounded rectangle | Dc.drawRoundedRectangle() | Dc.fillRoundedRectangle() | 1.0.0 |  |
| Draw an arc | Dc.drawArc() | N/A | 1.0.0 |  |
| Draw a polygon | N/A2 | Dc.fillPolygon() | 1.0.0 |  |
| Set the clip area | Dc.setClip() | N/A | 2.3.0 |  |

The Dc.setColor() method allows you to set the foreground and background drawing colors. Colors are passed to Dc.setColor() as 24-bit colors of the form 0xRRGGBB. When setting a color, the device will select the closest available color on the system.

A clipping region can be set for a Graphics.Dc object using the Dc.setClip() method. The top left corner coordinates, width, and height are specified to set this region. All pixels outside of this region will be unaffected by any drawing operations. The pixels within the region will be updated normally. The Dc.clearClip() method will remove the clipping region.

## Strings and Fonts

Text can be drawn using the Dc.drawText() method. The Graphics.Dc object also has methods available to get the text width and height of a string with a specified font. Note that text size methods are also available in the Graphics module outside the Graphics.Dc object.

| Operation | Function | API Level |
| --- | --- | --- |
| Draw a text string | Dc.drawText() | 1.0.0 |
| Draw text at an angle | Dc.drawAngledText() | 4.2.2 |
| Draw text oriented along an arc | Dc.drawRadialText() | 4.2.2 |
| Get the width and height of a text string with a given font | Dc.getTextDimensions() | 1.0.0 |
| Get the width of a text string with a given font | Dc.getTextWidthInPixels() | 1.0.0 |
| Get the height of a given font | Dc.getFontHeight(), Graphics.getFontHeight() | 1.0.0, 1.2.0 |
| Get the ascent of a given font | Graphics.getFontAscent() | 1.2.0 |
| Get the descent of a given font | Graphics.getFontDescent() | 1.2.0 |
| Retrieve a system vector font | Graphics.getVectorFont() | 4.2.2 |

### Scalable Fonts

*Since API level 4.2.2*

Font support for Garmin devices can vary from device to device. All devices support unicode bitmap fonts, but some devices support scalable fonts. If a device supports scalable fonts, the supported fonts are published in the Device Reference as `Scalable Font` entries in the font list.

To access a scalable font, you can call Graphics.getVectorFont() using the name from the device reference as the `:face` argument. The `:face` argument also will take an array of face names. This allows you to specify backup font faces that are acceptable for your needs in case the device doesn't support your preferred choice. You can also specify the font size in pixels.

Scalable fonts work with Dc.drawText() but can also be used with the Dc.drawAngledText() and Dc.drawRadialText(). These APIs only support scalable fonts and do not support custom fonts loaded as resources.

## Anti-Aliasing

*Since API level 3.2.0*

By default, anti-aliasing of primitives like polygons and lines are disabled, but it can be enabled by calling Dc.setAntiAlias(). This method is not available before API level 3.2.0 so if your app runs with the API level set below 3.2.0 make sure to guard it with a `has` check.

```
function draw(dc) {
    if(dc has :setAntiAlias) {
        dc.setAntiAlias(true);
    }
    dc.drawPolygon()
}
```

## Alpha Channels, Color, Fills, Stroke and Blend Modes

*Since API level 4.0.0*

API level 4.0.0 adds some powerful new tools to the Graphics.Dc:

| Function | Purpose | Accepts | API Level |
| --- | --- | --- | --- |
| Dc.setFill() | Set fill tool for drawing primitives. | Graphics.ColorType, Graphics.BitmapTexture | 4.0.0 |
| Dc.setStroke() | Set pen tool for drawing primitives | Graphics.ColorType, Graphics.BitmapTexture | 4.0.0 |
| Dc.setBlendMode() | Set blend mode for drawing |  | 4.0.0 |

Previously, the Dc.setColor() API allowed the setting of a foreground or background color based on a 24-bit RRGGBB value. Dc.setFill() and Dc.setStroke() both accept 32-bit AARRGGBB values, allowing you to provide an alpha channel value with the RGB value. The Dc.setStroke() API allows setting the pen tool for the Dc, while Dc.setFill() sets the fill tool.

You can also set the blend mode with Dc.setBlendMode(). By default, the system will blend your color with whatever is being drawn over. However, you can use `BLEND_MODE_NO_BLEND` to set the color and alpha of a Graphics.BufferedBitmap directly. You can also use `BLEND_MODE_ADDITION` to have your blend added to the channels being drawn to.

In addition to colors, you can now also provide a Graphics.BitmapTexture. This allows a primitive to be filled by a bitmap and opens up many new drawing possibilities.

## Bitmaps

Bitmap resources can be added to your executable using the resource compiler. You can use Application.loadResource() to load a bitmap at runtime, and Dc.drawBitmap() or Dc.drawBitmap2() to render it to the screen on the View.onUpdate() call.

### Transformation

*Since API level 4.2.2*

Connect IQ allows you to create two-dimensional affine transforms using the Graphics.AffineTransform class. Graphics.AffineTransform provides access to the underlying transformation matrix and common operations like rotation, scaling and shearing3. To apply the transform, pass the Graphics.AffineTransform into Dc.drawBitmap2() as the `:transform` argument in the options dictionary.

### Tinting

*Since API level 4.2.2*

Sometimes you want the color of an asset, like an icon, to be user-definable. For example, you may want the complication icons on a watch face to match a user-defined theme color. One of the features of Dc.drawBitmap2() is the ability to apply a tint color to an asset. The `:tintColor` option can be used to specify a color to apply to a grayscale asset.

### Graphics Pool

*Since API level 4.0.0*

Before API level 4.0.0, all resources loaded at runtime into the application heap. This heap is used to hold your code, data, stack and runtime objects, so loading images could quickly limit the runtime functionality of your app. API level 4.0.0 introduced a new graphics pool that is separate from your application heap. When you load a bitmap or font at runtime, the resource will load into the graphics pool, and you will be returned a Graphics.ResourceReference. The graphics pool dynamically caches, unloads and reloads your resources behind the scenes based on available memory. All the drawing primitives that accept resource objects also accept references so your app should not have to be reworked to take advantage of the new system.

Calling ResourceReference.get() on a reference will return a resource object. As long as the object returned is in scope, the resource will be locked in the graphics pool.

### Buffered Bitmaps

*Since API level 2.3.0*

The Graphics.BufferedBitmap class can be used to draw to surface other than the primary display surface. There are two options for creating a Graphics.BufferedBitmap object. The first is to generate one from a loaded bitmap resource. In this case, the provided bitmap is used as the drawing surface that is manipulated. The second option is to specify the width, and height of the surface, and optionally a color palette. If no color palette is specified, the Graphics.BufferedBitmap will use the system colors, and will not have a palette. If a bitmap resource is provided to the initializer, the width, height, and palette parameters are ignored.

If a Graphics.BufferedBitmap does have a palette, it can be read using the BufferedBitmap.getPalette() method. The palette can also be modified using the BufferedBitmap.setPalette() method. The palette provided must have the same number of colors as the existing palette for that bitmap. All pixels in the image will change color to the new color assigned at each color index. Note that Bitmaps with a palette that are generated by the resource compiler will have an additional transparent index at the end of the specified palette unless the `disableTransparency` flag has been specified.

A Drawing Context can be obtained from the Graphics.BufferedBitmap using the BufferedBitmap.getDc() method. This returns a Graphics.Dc class that has the same capabilities as the primary device Graphics.Dc that is provided to the methods View.onLayout(), View.onUpdate(), and . This object can be used to modify the contents of the Graphics.BufferedBitmap by drawing shapes, text, and bitmaps to it.

#### Buffered Bitmaps and the Graphics Pool

Graphics.BufferedBitmap objects, like other graphics resources, now take advantage of the graphics pool, as well. The advantage of this scenario is that you can now liberally use temporary graphics buffers without running out of application heap.

As noted earlier, the graphics pool will intelligently purge and restore resources from the pool if the loaded resources exceed the available pool space. Unlike static resources that are reloaded from your executable, Graphics.BufferedBitmap are not restored if they have been purged. This works fine if you are using a short-lived, temporary buffer, but if your bitmap is purged after allocation, you need to re-render its contents. Alternatively, you can call the get() method on the reference to get a locked version of the bitmap. This will prevent the Graphics.BufferedBitmap object from being purged from the pool, but it can also lead to the graphics pool running out of available space if more resources are loaded.

To create a Graphics.BufferedBitmap, use the Graphics.createBufferedBitmap() API. If your application runs on pre-API level 4.0 devices, use a has check for allocating your Graphics.BufferedBitmap:

```
import Toybox.Graphics;

//! Factory function to create buffered bitmap
function bufferedBitmapFactory(options as {
            :width as Number,
            :height as Number,
            :palette as Array<ColorType>,
            :colorDepth as Number,
            :bitmapResource as WatchUi.BitmapResource
        }) as BufferedBitmapReference or BufferedBitmap {
    if (Graphics has :createBufferedBitmap) {
        return Graphics.createBufferedBitmap(options);
    } else {
        return new Graphics.BufferedBitmap(options);
    }
}
```

1 Yes, really.

2 Yes, really.

3 I'm so glad I wasn't the one to come up with this.
