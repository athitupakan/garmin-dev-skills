---
source: doc/docs/Monkey_C/Coding_Conventions.html
sdk: 9.1.0
---

# Coding Conventions (Garmin official)

## Naming

| Kind | Convention |
|------|-----------|
| Module, Class | `PascalCase` |
| Function | `camelCase` |
| Private class member var | `_camelCase` (underscore prefix) |
| Public class member var | `camelCase` |
| Module variable | `camelCase` |
| Enum value | `COMMON_PREFIX_*` (e.g. `COLOR_RED`, `COLOR_BLUE`) |

In POMO (Plain Old Monkey C Objects) — all-public members OK.

## Source layout

- **One class per file**
- 4-space indent (no tabs); Monkey C editor converts tabs to spaces and trims trailing whitespace
- Opening `{` on same line as definition
- Closing `}` aligned to first char of the definition

## Definitions

- Avoid pure global variables.
- Putting class definitions in the global module is fine (modules have runtime cost).
- Avoid public static members in classes — move them to the parent module.
- **First line of `initialize`: call superclass `initialize`** (e.g. `AppBase.initialize();`).

## Sample

```monkey-c
class SampleName extends Toybox.Application.AppBase {
    public var publicVar;
    private var _privateVar;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {}
    function onStop(state) {}

    function getInitialView() {
        return [new SampleNameView(), new SampleNameDelegate()];
    }
}
```

## Project convention notes

Project deviates intentionally where it improves clarity — see the project root `CLAUDE.md` for project-specific rules.
