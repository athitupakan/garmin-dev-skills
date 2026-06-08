---
source: https://developer.garmin.com/connect-iq/personality-library/typography/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Typography.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Typography

The choice of fonts used for a product are based on readability, the product's visual language, and other aesthetic considerations.

## System and Number Fonts

Garmin® products typically have two sets of fonts. The system font is used for textural information, while the number font is used for numeric information. Each font has a set of sizes available. The device reference outlines the available fonts on each product.

The font selectors in the layout system map out the fonts available for each usage context. The selector typically provides the font size and justification, and it relies on other selectors for color, position, and bounding area.

### Example

The following example describes the body text displayed in a prompt with a title.

```
<!-- layout.xml -->

        <!-- Prompt body -->
        <text-area text="@Strings.warningPrompt" personality="
            prompt_color_dark__body
            prompt_size__body_with_title
            prompt_loc__body_with_title
            prompt_font__body_with_title
        " />
```

## Selectors

| Selector | Context |
| --- | --- |
| `confirmation_font__body` | The font for the body text in a confirmation. |
| `prompt_font__title` | The font for prompt titles. |
| `prompt_font__body_no_title` | The font for the body text in a prompt without a title. |
| `prompt_font__body_with_title` | The font for prompts with a title string or icon. |
