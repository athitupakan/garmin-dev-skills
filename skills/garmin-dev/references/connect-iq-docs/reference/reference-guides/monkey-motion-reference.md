---
source: https://developer.garmin.com/connect-iq/reference-guides/monkey-motion-reference/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Reference_Guides/Monkey_Motion_Reference.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Monkey Motion

The Monkey Motion UI tool or the command line can be used to import your animations.

## Using the Monkey Motion UI

To use the Monkey Motion tool's user interface, launch the executable, `monkeymotion` (Windows/Linux) or `monkeymotion.app` (Mac), either from the command line or using the Visual Studio Code Monkey C extension with the *Monkey C: Open Monkey Motion* command from the command palette.

When initially launched, the tool will populate a list of devices that support Connect IQ Animations:

Figure 1.
The Monkey Motion Tool

The developer can then select which devices to encode an animation for. A Connect IQ project manifest file can be loaded into the tool if the developer prefers which causes the tool to mark any devices that are both supported by the project as well as that support Connect IQ Animations as selected. If a developer wishes to tweak the file encoding to use something other than the default settings, the advanced tab offers more options:

Figure 2.
The Monkey Motion Tool Advanced Settings

The Monkey Motion tool generates a Monkey Motion Manifest (or .mmm) file for each animation processed. The manifest will contain mappings between a device and a Monkey Motion (or .mm) file containing the binary of the encoded file. It is possible for a single animation to produce multiple .mm files since different encodings will be created based off of a video's target resolution and the bits per pixel of the device.

In addition to generating encodings of the input, the tool can be used for scrubbing the encoded animation:

Figure 3.
Monkey Motion Scrubbing

If the developer wishes to scrub a previously encoded animation, the *File* menu option can be used to select *Load Animation*, which accepts Monkey Motion Manifest files as input.

## Using the Command Line

Videos can also be encoded at the command line using the `monkeym` script. The following options are available at the command line:

| Argument | Definition | Valid Values | Default Value | Notes |
| --- | --- | --- | --- | --- |
| `-a ` | The target alpha channel mask for a `YUV` encoded video file | A valid, resolvable `YUV` encoded video file | NA | Optional |
| `-c ` | The preferred color depth (bits per color channel) of the animation. See Color Depth for AMOLED Devices for more information | A value between 1 and 6 | 6 | Optional |
| `-d ` | Target devices | Device qualifiers separated by a colon (:); devices that support orientation changing should be followed by '-portrait' or '-landscape' to determine the appropriate resolution when encoding a full screen animation | NA | Required |
| `-e ` | The identifier of an animation resource that should be exported along with the Monkey Motion encoded files | Any value that starts with a letter | NA | Optional |
| `-f ` | The target frame rate of the animation | A value between 1 and 10 is recommended; higher frame rates will be subject to the speed in which the animation can be decoded. See Frame Rate Considerations for more information | 10 for YUV encoded videos; GIF files can have a delay rate encoded within the animation, which will apply if not specified | Optional |
| `-h` | Print help information | NA | NA | Optional |
| `-m ` | Manifest file to specify the devices to build for | A path to a project manifest file | Empty | Optional |
| `-o ` | The output file path | A valid, resolvable file path | The target animation file path | Optional |
| `-p ` | The target compression level of the encoded animation | A value between 1 and 7. See Compression Level Impact for more information | 5 | Optional |
| `-q ` | The target image quality of the encoded animation | A value between 1 and 3. See Considerations for more information | 3 | Optional |
| `-r ` | The target resolution of the animation (if not the device screen size) | `x` where `width` and `height` are the numeric values of the target resolution (ex: 40x40) | NA | Optional |
| `-s ` | The target image scaling quality of the animation | A value between 1 and 3 | If applicable, 3 | Optional |
| `-v ` | The target animation file | A valid, resolvable `YUV` / `GIF` file | NA | Required |
| `-w` | Print Monkey Motion warnings | NA | NA | Optional |

## Considerations

The Monkey Motion tool offers several advanced settings options, which introduce multiple areas of consideration. This section offers developers a few tips, case studies, and generally more in-depth information with the intention of them finding the most beneficial video encoding configurations.

### Image Quality Considerations

Specifying an image quality value of 3 provides lossless compression (lossless in the sense that the encoder always uses the closest color available in the palette for each pixel), whereas specifying a value of 2 or 1 may allow further compression at the expense of making color substitutions which allow for better compression (lossy).

### Frame Rate Considerations

The maximum frame rate of an animation is limited by both decoding time, which increases with higher compression, and by the amount of motion in the input video.

**Note:** Because Connect IQ devices do not support vertical synchronization, high frames rates could potentially result in screen tearing.

### Compression Level Impact

Compression level effects both compression and decoding overhead. Videos where the majority of the frame does not change from frame to frame can benefit from higher compression levels such as 9 without much consideration to the performance impact. For videos with lots of motion all over the screen, selecting a higher compression level may cause slower playback (due to the extra overhead necessary to decompress). For reference, this is a table showing the correlation between compression level and decoding time of a `GIF` file (with a high degree of complexity) running on the Fēnix 5 Plus:

| Compression Level | Monkey Motion File Size (KB) | Frame Decoding Time (ms) |
| --- | --- | --- |
| 1 | 981 | 30 |
| 2 | 883 | 36 |
| 3 | 798 | 38 |
| 4 | 758 | 39 |
| 5 | 728 | 39 |
| 6 | 711 | 40 |
| 7 | 703 | 40 |

At the same time, it is possible in some cases of these high motion, hard to compress videos that using a lower compression level may actually result in a smaller file size. For reference, this is another table showing the correlation between compression level and decoding time of a different `GIF` file (again with a high degree of complexity) running on the Venu:

| Compression Level | Monkey Motion File Size (KB) | Frame Decoding Time (ms) |
| --- | --- | --- |
| 1 | 602 | 58 |
| 2 | 602 | 60 |
| 3 | 602 | 60 |
| 4 | 601 | 61 |
| 5 | 600 | 64 |
| 6 | 599 | 71 |
| 7 | 600 | 84 |

The compression level of 6 actually produces the smallest file size. However, in this scenario, it would be better to accept the negligible size increase and use the compression level 1 because the decoding overhead would be much less. When in doubt about trying to get the maximum frame rate for a high motion video, a developer should start at compression level 1 and work their way up (knowing it may make the frame rate / size worse).

**Note:** The decoding time on high color resolution devices can potentially be affected more dramatically.

### Complexity Level Impact

Like the video compression level, the complexity of the video also has a direct impact on animation file size, as well as decoding performance. The complexity is determined by both the variations within the same frame and the variations among successive frames.

For reference, sample `GIF` files were encoded for the Fēnix 5 Plus using a compression level of 5 to test the complexity impact.

#### Low Complexity

- Frame Count: 30
- Monkey Motion File Size: 107 KB
- Average Frame Decoding Time: 8 ms

#### Medium Complexity

- Frame Count: 25
- Monkey Motion File Size: 412 KB
- Average Frame Decoding Time: 26 ms

#### High Complexity

- Frame Count: 24
- Monkey Motion File Size: 758 KB
- Average Frame Decoding Time: 39 ms

### Color Depth for AMOLED Devices

AMOLED devices use the RGB565 color format, i.e., red / blue can never exceed 5 bits per pixel. Specifying the value of 5 for AMOLED devices, which will reduce green from 6 to 5 bits per pixel, could potentially result in improving the animation's compression without causing a visually noticeable difference considering the 256 color palette restriction.

### Memory Impact

Each animation is considered a rendering layer. When an animation is added to a `View`, it will be assigned a frame buffer (in the form of a BufferedBitmap), which is worth a single frame of raw pixel data. For example, if the color depth is 8 bits, then a 240x240 animation will take roughly 58 KB (240 x 240 x 1) of memory out of the Connect IQ app memory budget.

#### Overlay Frame Memory

In the context of a `View` with animations, native drawables added to a `View` are grouped into a single layer, known as the "overlay" layer. The overlay frame is needed to ensure a smooth playback experience and will only be created on demand. Currently, the overlay buffer takes a full screen's worth of memory from the app memory budget (in the form of a BufferedBitmap, like animations).

#### Case Studies

For reference, these tables show the memory impact of animations played on the Fēnix 5 Plus, which has a 240x240 screen resolution and 8bpp color depth.

A `View` with two animations and no native drawables:

| Layer | Resolution | Frame Buffer Size (KB) |
| --- | --- | --- |
| Animation 1 | 240x240 | 58 |
| Animation 2 | 40x40 | 1.6 |
| Overlay | N / A | 0 |

Total: 60 KB

A `View` with two animations and native drawables:

| Layer | Resolution | Frame Buffer Size (KB) |
| --- | --- | --- |
| Animation 1 | 240x240 | 58 |
| Animation 2 | 40x40 | 1.6 |
| Overlay | 240x240 (fixed) | 58 |

Total: 118 KB
