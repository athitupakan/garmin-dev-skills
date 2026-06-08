---
source: https://developer.garmin.com/connect-iq/core-topics/monkey-style/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Monkey_Style.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Monkey Style

Monkey style is a domain-specific property language for managing style elements. It borrows heavily from CSS but has been tailored for Monkey C. Monkey style allows developers to create style property constants that can adapt between Garmin products.

## Personality Classes

Monkey style allow you to create personality classes of constants. These classes can be defined using the following syntax:

```
personality_class {
    property: "constant";
}
```

Personality classes and properties have to be named with Monkey C legal names and can have the following value types:

| Type | Example |
| --- | --- |
| Number | 500 |
| Percent | 80% |
| String | “What’s the deal with style sheets?” |
| Boolean | true |
| Color | #555555 |
| Symbol | `:myBitmap` |
| Resource | `@Rez.Strings.promptTitle` |
| API Constant | `Graphics.TEXT_JUSTIFY_CENTER` |
| Array | `[Graphics.FONT_SMALL, Graphics.FONT_TINY]` |

## Resource Compiler

Personality classes can be referenced by resource compiler elements using the `personality` attribute. The `personality` attribute can reference multiple space-separated personality classes.

For example, you can have a personality class with the following definition:

```
layout1__time {
    x: "center";
    y: 10%;
    font: Graphics.FONT_LARGE;
    justification: Graphics.TEXT_JUSTIFY_CENTER;
    color: Graphics.COLOR_BLUE;
}
```

This can then be referenced in your layout:

```
<layout id="WatchFace">
    <drawable class="Background" />
    <label id="TimeLabel" personality="layout1__time" />
</layout>
```

## Using Personality Classes in Source

Any personality class you define is addressable from the `Rez.Styles` namespace. The class is defined as a module of constant values that you can address via its name.

```
dc.setFont(Rez.Styles.layout1__time.font);
```

When referenced this way, the compiler can replace the constant references at compile time and eliminate the personality classes from your runtime.

## Configuring Personalities

You can configure the series of monkey style sheets in the jungle. This allows you to have specific style sheets for each product while keeping the content universal across products. You can configure the personality with the `personality` selector:

```
fenix7system6preview.personality=$(fenix7system6preview.personality);resources-fenix2022
```
