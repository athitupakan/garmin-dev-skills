---
source: https://developer.garmin.com/connect-iq/personality-library/iconography/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Iconography.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Iconography

Garmin® products use a common system of icons. While the intent and shape of the icons are shared across products, their visual styles are altered to match the product personality.

There is a subset of system icons in the personality library that you can integrate into your apps. Icon assets in the personality library have icon in the prefix.

## Asset Colors

Icons in the personality system have all of their colors documented with `light` and `dark` selectors. On some products, especially those with AMOLED displays, these selectors are the same. If your app does not take night mode into account or does not run on products that have night mode, use only the dark selectors.

Components may also have `positive` or `destructive` colors to represent positive or destructive actions. Not every asset has positive or destructive variations.

## Sizing and Placement

The size and screen placement of icons are determined by the kind of page being made. Selectors for location have `loc` in the prefix, while selectors for sizing have `size` in the prefix. By using these selectors, you can adapt your images across multiple products.

## Example

The following example places the warning icon in the header of a text prompt.

```
<!-- layout.xml -->

    <!-- Warning icon in prompt header -->
        <bitmap id="warningIcon" personality="
            system_icon_light__warning
            prompt_loc__title_icon
            prompt_size__title_icon
        " />
```

## Selectors

| Selector | Icon | Context |
| --- | --- | --- |
| `system_icon_light__about`, `system_icon_dark__about` |  | Use for pages with instructional information or help pages. |
| `system_icon_light__check`, `system_icon_dark__check`, `system_icon_positive__check` |  | Use to present confirmation actions. |
| `system_icon_light__cancel`, `system_icon_dark__cancel`, `system_icon_destructive__cancel` |  | Use to present cancellation actions. |
| `system_icon_light__discard`, `system_icon_dark__discard`, `system_icon_destructive__discard` |  | Use to identify actions that involve discarding recorded information. |
| `system_icon_light__question`, `system_icon_dark__question` |  | Use on pages where the user must answer a query. |
| `system_icon_light__revert`, `system_icon_dark__revert` |  | Use to indicate actions that undo or revert previous actions. |
| `system_icon_light__save`, `system_icon_dark__save` |  | Use to identify actions where information is saved. |
| `system_icon_light__search`, `system_icon_dark__search` |  | Use to highlight query or browse actions. |
| `system_icon_light__warning`, `system_icon_dark__warning`, `system_icon_destructive__warning` |  | Use to warn the user of an action that can have a detrimental effect. |
