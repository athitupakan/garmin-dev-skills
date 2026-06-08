# Custom Fonts (BMFont workflow)

How to bundle a custom typeface as a watch face / app font. Generic procedure verified against SDK 9.1.0. A concrete project example is at the end of this file.

## Why custom

Most Garmin devices ship with only a handful of built-in faces (typically Roboto + Oswald — bitmap, fixed sizes). On many AMOLED devices `Graphics.getVectorFont()` returns null for every face — confirm for your target device by reading [../catalogs/sensors.md](../catalogs/sensors.md) or testing in the simulator. To use any other typeface (Orbitron, Share Tech Mono, VT323, etc.) → must bundle `.fnt` + `.png`.

## Tool: BMFont (Garmin's choice)

http://www.angelcode.com/products/bmfont/ — free Windows GUI from AngelCode (~1 MB).
Garmin's FAQ references it explicitly; Export Options screenshot at `Sdks/.../doc/resources/programmers-guide/bmfont_options.png`.

CLI alternative: `fontbm` (open source port) — same .fnt output, scriptable.

## Required BMFont Export Options

| Section | Value |
|---------|-------|
| Padding | 0 / 0 / 0 / 0 |
| Spacing | 1 / 1 |
| Bit depth | 8 |
| Channels (A/R/G/B) | all `glyph` |
| Font descriptor | Text |
| Textures | PNG |
| Compression | Deflate |
| **Texture Width × Height** | **512 × 512** minimum (see "Multi-page atlas" gotcha) |

## Font Settings (per font you generate)

- `Add Font File` → browse to the actual `.ttf` (don't trust the dropdown — see "Arial fallback" gotcha)
- `Size (px)` = the rendered size in pixels (no runtime scaling — generate exactly the size you'll display)
- `Match char height` ✓
- Output invalid char glyph: unchecked

## Char selection — limit to save .prg size

In `Edit → Select chars from file` (or via the character map UI), include **only** what you actually draw.

A common minimal set (TIME + DATE + uppercase labels):
```
0 1 2 3 4 5 6 7 8 9
:
(space)
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
```
= 38 chars. A full Latin (0-255) set would be ~10× the .fnt + .png size. Tailor the set to your watch face's actual rendered strings.

## Project integration (3 files)

### 1. Drop the artefacts

```
resources/fonts/MyFontName.fnt
resources/fonts/MyFontName_0.png    (only _0; if more pages, increase texture size)
```

### 2. Declare in `resources/fonts/fonts.xml`

```xml
<fonts xmlns:xsi="..." xsi:noNamespaceSchemaLocation="...">
    <font id="MyFontName" filename="MyFontName.fnt" antialias="true" />
</fonts>
```

### 3. Wire into your theme / resource module

`WatchUi.loadResource()` is a runtime call → can't go in a `const`. Use a module-level `var` populated by an `init()` that runs from `View.onLayout`. Module name + variable name are project choices — the pattern is what matters:

```monkey-c
module Theme {
    (:initialized) var MY_FONT as FontResource;

    function init() as Void {
        MY_FONT = WatchUi.loadResource(Rez.Fonts.MyFontName) as FontResource;
    }
}
```

The `(:initialized)` annotation tells the type checker to treat `MY_FONT` as non-null at use sites (we promise init runs first).

### 4. Call your module's `init()` from `View.onLayout`

```monkey-c
function onLayout(dc as Dc) as Void {
    Theme.init();
}
```

`onLayout` is the right phase — resources can only load after the view is attached.

## Gotchas (project-observed)

### Arial fallback
If `.fnt` shows `face="Arial"` instead of your font name → BMFont didn't actually load your TTF (Add Font File step skipped or path wrong). Re-export with the TTF properly added; verify the BMFont preview before exporting.

### Multi-page atlas (`pages=2+`)
If `.fnt` declares `pages=2`, you need both `_0.png` AND `_1.png`. Easy to miss the second file. Fix: re-export with bigger **Texture Width/Height** (try 512×512 first, 1024×1024 if still split).

### Missing glyphs render as blanks / squares
If a character isn't in the .fnt charset, `drawText` renders nothing (or a placeholder). Always include `:` (often forgotten in numeric-only sets), space, and any punctuation you use.

### Fixed size — re-generate per use
`.fnt` is a baked bitmap. To use the same font at 80 AND 60 AND 24 → generate three separate `.fnt` files (one per size). Each adds ~10-30 KB to the .prg.

### App size budget
Each (font × size) ≈ 10-50 KB depending on char count and size. Adding a single 80px display font to a small watch face typically grows `bin\<project>.prg` by ~15-20 KB — manageable. Watch for `(:extendedCode)` opportunities (API 5.1.0+) if .prg approaches device limits.

### Type warnings without (:initialized)
Without the annotation, `-l 2` complains:
`Passing 'PolyType<Null or FontResource>' as parameter ...`
Adding `(:initialized) var MY_FONT as FontResource` (without `= null`) silences it.

## Worked example: Vital Core / Orbitron Bold 80

The vital-core watch face (Instinct 3 AMOLED 50mm) bundles Orbitron Bold 80 as `FONT_TIME` for the main time digits, with a minimal 38-char set (digits + uppercase + colon + space).

- **Char selection**: the 38-char set shown above is exactly what vital-core uses — no lowercase, no punctuation other than `:`. Total `.fnt` + `_0.png` ≈ 17 KB.
- **App size delta**: `bin\vital-core.prg` grew from ~97 KB → ~114 KB after adding Orbitron Bold 80 (= +17 KB, ~18% bigger). The same font at 60px would add ~10 KB; at 24px ~5 KB.
- **Why Orbitron at 80px**: target was a single TIME digit ~70-75px tall on-device, and BMFont sizes correspond roughly 1:1 with rendered pixels.

This is a concrete reference point for any AMOLED Instinct project — your own font + size will scale similarly per the size-budget table in the App size budget gotcha above.
