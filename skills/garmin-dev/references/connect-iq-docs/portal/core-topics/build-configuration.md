---
source: https://developer.garmin.com/connect-iq/core-topics/build-configuration/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Build_Configuration.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Build Configuration

Connect IQ supports a wide variety of Garmin devices, like watches, bike computers and handhelds. Even within these broader categories, devices can have different screen sizes, shapes and resolutions. Application developers may wish to define specific resources, like fonts and bitmap graphics, for certain devices or device families for a better user experience. For example, an app may need to use a round background image for round devices and a square background image for square devices.

Connect IQ offers a few ways to manage app resources: device and family qualifiers, Jungles and build exclusions.

## Device, Family, and Localization Qualifiers

The simplest way to override resources is with device, family, and localization qualifiers, which are added to a resources folder by adding a hyphen (`-`) followed by a valid qualifier value. Let's take a look at an example:

Figure 1.
Figure 1: A project that uses a fēnix 5 device resource qualifier

In Figure 1, the `resources-fenix5` directory uses a `-fenix5` qualifier to segregate resources specifically intended for the fēnix 5. When this project is built for fēnix 5, the layout and drawable in the `resources-fenix5` directory will be used to display a different background image than the one in the more generic `resources` directory. All other supported products will compile with the default resources.

**Note:** Multiple qualifiers separated by hyphens may be used on a single folder, but device qualifiers are not allowed to co-exist with family qualifiers in the same folder name (e.g. `resources-round-fenix3`) and will be skipped by the resource compiler if encountered.

### Device Qualifiers

The device qualifier format allows for resources to target specific devices (as demonstrated in Figure 1). Resources included in a folder with a device qualifier will override the resources with the same ID that are defined in the base resource folder when building for the associated device. Device qualifiers also take precedence over less specific qualifiers, such as family qualifiers.

### Family Qualifiers

The family qualifier format allows for resources to target specific device families, which is a group of devices differentiated by shared screen characteristics. There are two family qualifiers:

- **Screen shape:** The shape of the screen (e.g. `round`, `rectangle`, etc.)
- **Screen size:** The physical size of the screen in pixels ( e.g. `218x218`, `148x205`, etc.)

The screen shape must always be specified when using a family qualifier, and the screen size may be added to further refine the target family. Here are some examples of valid and invalid family qualifier examples:

- `resources-round`: *Valid*—targets round screen devices, like the fēnix 3 series and fēnix 5 series
- `resources-round-218x218`: *Valid*—targets 218px x 218px, round screen screen devices, like the fēnix 3 and fēnix 5S (but not the 5 or 5X since they have 240px x 240px screens)
- `resources-218x218`: *Invalid*—this will be ignored by the resource compiler because no screen shape has been specified
- `resources-218x218-round`: *Invalid*—the screen shape was not specified first

Resources with more specific qualifiers will always take precedence over less specific ones, so on a round, 218px x 218px device, any resources contained in the `resources-round-218x218` resources folder will be used in place of those in `resources-round` if they share an ID. In addition any resource folder that carries a family qualifier will always defer to resource folders named with device qualifiers.

### Localization Qualifiers

Localization qualifiers are a way to specify language-specific string resources, and are specified as an ISO 639–2 language code. These qualifiers may be combined with either device or family qualifiers, and are always specified last in the qualifier naming scheme. For example:

- `resources-fre`: Provides French language-specific string resources for all devices
- `resources-round-fre`: Provides French language-specific string resources for round devices only
- `resources-fenix5s-fre`: Provides French language-specific string resources for fēnix 5 devices only

## Build Configuration via Jungles

Connect IQ runs on a diverse set of purpose built devices. Because of the variety of inputs, screen shapes and resources, it often is necessary to include code and resources tailored to specific conditions. For example, on a square device a progress bar may be rectangular, but on a round device it might look better as an arc that orbits the screen.

Jungles allow developers to write custom build configurations for Monkey C projects. With Jungles, developers may:

- Define per-device or per-device family paths to source and resource directories
- Exclude portions of source code with annotations
- Specify Monkey Barrels that should be included when a project is built.

### Per Device Configuration

Jungles allow for the source path, resource path and exclusions to be set for all products, by screen shape, or for particular products. The following prefixes are allowed:

| Name | Description |
| --- | --- |
| `base` | Configuration applies to all products |
| `round` | Configuration applies to products with round screens |
| `semiround` | Configuration applies to products with semi-round screens |
| `rectangle` | Configuration applies to products with rectangle or square screens |
| `semioctagon` | Configuration applies to products with octagon screens with sub-window |
| `` | Configuration applies to a specific product. `` is the same as what is used in the manifest file |

For `round`, `semiround`, `semi-octagon`, and `rectangle` identifiers, an optional `-x` suffix can be added for narrow the scope.

Let's say you are writing a wearable app that has different resources for round, semi-round and rectangle layouts. The Venu has a AMOLED specific implementation as well. Jungles make it easy to manage project build configurations in one place:

```
base.sourcePath = source

# Configure paths based on screen shape
round.resourcePath = $(base.resourcePath);resource-round
semiround.resourcePath = $(base.resourcePath);resource-semiround
rectangle.resourcePath = $(base.resourcePath);resource-rectangle

# Set the venu source and resource paths
venu.sourcePath = $(base.sourcePath);source-venu
venu.resourcePath = $(base.resourcePath);resource-venu
```

These instructions set the source path for all devices to `source`. It tells the build system to use the `resource-round`, `resource-semiround` and `resource-rectangle` paths for the round, semi-round and rectangle the devices respectively. Finally, the Venu has an additional source and resource folders added.

### Feeling Excluded

Now, let's say that we have some code in our application that should only be run on round products, and all the non-round products should use the "regular" version:

```
(:roundVersion)
function drawThis(dc) {
    // Implementation
}

(:regularVersion)
function drawThis(dc) {

}
```

We don't want to include both versions in any executable because one version would just be dead code. Jungles allow us to specify this using exclusions.

```
# Say that all products exclude declarations
# with the annotation :roundVersion
base.excludeAnnotations = roundVersion
# Now say that the round products exclude
# the regular version
round.excludeAnnotations = regularVersion
```

When building the app for a product, round products will exclude the version of `drawThis` with the `:regularVersion` annotation, and the rest of the products will exclude the version of `drawThis` with the `:roundVersion` annotation.

For more information on how to use Jungles see the Jungle Reference Guide.
