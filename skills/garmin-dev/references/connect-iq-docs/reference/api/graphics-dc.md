---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Graphics/Dc.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.Graphics.Dc

Device context for all drawing. Only use inside `onUpdate(dc)` — never instantiate directly.

## Coordinate & Angle Conventions

- **Origin (0, 0)** = top-left. `x` increases right, `y` increases down.
- **Arc angles** — `0° = 3 o'clock (east)`, `90° = 12 o'clock (top)`, `180° = west`, `270° = south`. Angles **increase counter-clockwise** (math convention).
- **Color format** — `Graphics.COLOR_*` constants or 24-bit hex `0xRRGGBB` for fg/bg. 32-bit `0xAARRGGBB` accepted for `setStroke` / `setFill` (alpha channel).

## Screen Management

| Method | Purpose |
|--------|---------|
| `clear() → Void` | Erase screen with background color. Since API 3.1.0, `COLOR_TRANSPARENT` bg replaces pixels with transparency. |
| `getWidth() → Number` | Display width in pixels. |
| `getHeight() → Number` | Display height in pixels. |

## Clipping

| Method | Purpose |
|--------|---------|
| `setClip(x, y, width, height) → Void` | Restrict subsequent drawing to a rect. |
| `clearClip() → Void` | Restore full screen (API 2.3.0+). |

## Color & Style

| Method | Notes |
|--------|-------|
| `setColor(fg, bg) → Void` | **`bg` fills the full font bbox before `drawText` — always pass `COLOR_TRANSPARENT` unless intentionally erasing.** |
| `setPenWidth(width) → Void` | Stroke thickness in pixels. |
| `setStroke(stroke) → Void` | `BitmapTexture` or 32-bit color. Overrides `setColor`'s fg (API 4.0.0+). |
| `setFill(fill) → Void` | Same as setStroke but for fills (API 4.0.0+). |
| `setAntiAlias(enabled) → Void` | Smoother edges; unsupported on paletted bitmaps (API 3.2.0+). |
| `setBlendMode(mode) → Void` | Blend mode; only `BLEND_MODE_NO_BLEND` works for bitmaps (API 4.0.0+). |

## Basic Shapes — Outline

| Method | Purpose |
|--------|---------|
| `drawPoint(x, y)` | Single pixel. |
| `drawLine(x1, y1, x2, y2)` | Line. |
| `drawCircle(x, y, radius)` | Circle outline. |
| `drawEllipse(x, y, a, b)` | Ellipse outline; `a, b` are x/y radii. |
| `drawRectangle(x, y, w, h)` | Rect outline. Top-left = (x, y). |
| `drawRoundedRectangle(x, y, w, h, r)` | Rect with rounded corners. |
| `drawArc(x, y, r, attr, degStart, degEnd)` | Arc. `attr` = `ARC_CLOCKWISE` or `ARC_COUNTER_CLOCKWISE`. **Degrees are `Number` — Float truncates silently. Use integer math.** |

## Basic Shapes — Filled

| Method | Purpose |
|--------|---------|
| `fillCircle(x, y, radius)` | Filled circle. |
| `fillEllipse(x, y, a, b)` | Filled ellipse. |
| `fillRectangle(x, y, w, h)` | Filled rect. |
| `fillRoundedRectangle(x, y, w, h, r)` | Filled rounded rect. |
| `fillPolygon(pts)` | Filled polygon from `Array<Point2D>`. Max 64 points. |

## Text

| Method | Purpose |
|--------|---------|
| `drawText(x, y, font, text, justification)` | Draw text. `font` = `Graphics.FONT_*` or custom. Justify = bitmask of `TEXT_JUSTIFY_LEFT/CENTER/RIGHT \| TEXT_JUSTIFY_VCENTER`. |
| `drawAngledText(x, y, font, text, just, angle)` | Text perpendicular to a radial. Requires `VectorFont` (API 4.2.1+). |
| `drawRadialText(x, y, font, text, just, angle, radius, direction)` | Text along an arc (API 4.2.1+). |
| `getFontHeight(font) → Number` | Font line height. |
| `getTextWidthInPixels(text, font) → Number` | Width of `text` rendered in `font`. |
| `getTextDimensions(text, font) → [w, h]` | Width + height, honors newlines. |

## Bitmaps

| Method | Purpose |
|--------|---------|
| `drawBitmap(x, y, bitmap)` | Draw bitmap. Source palette must be subset of dest. |
| `drawScaledBitmap(x, y, w, h, bitmap)` | Scale to (w, h) (API 4.0.0+). |
| `drawOffsetBitmap(x, y, bx, by, bw, bh, bitmap)` | Draw sub-region (API 4.0.0+). |
| `drawBitmap2(x, y, bitmap, options)` | Advanced — supports `:bitmapX/Y/Width/Height`, `:tintColor`, `:filterMode`, `:transform` (API 4.2.1+). |

## Gotchas (project-observed)

1. **Always use `COLOR_TRANSPARENT` as `bg` in `setColor` before `drawText`** — otherwise the font bbox erases pixels around earlier text. Symptom: an earlier-drawn label appears clipped to whatever sticks past the next text's bbox.
2. **`drawArc` degree params truncate `Float`** — for segmented rings, use integer angles + integer math.
3. **`setAntiAlias(true)`** can smooth ring edges; not yet enabled in our project.
4. **Performance** — `setClip()` limits expensive operations to a region; useful in `onPartialUpdate` for AOD.
