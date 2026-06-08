# Monkey C Language Reference

Local cache of the Monkey C language docs (the LANGUAGE, not Toybox API — those are in `../api/`).

**Source:** Local SDK at `<sdk-root>/doc/docs/Monkey_C/*.html` — `<sdk-root>` resolves to:
- Windows: `%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-*`
- macOS: `~/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-*`
- Linux: `~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-*`

**Why local:** The online docs at developer.garmin.com/connect-iq/monkey-c/ are JS-rendered (SPA). WebFetch can't see content. SDK ships the same docs as plain HTML.
**SDK version:** 9.1.0
**Last refresh:** 2026-05-24

## Files

| File | Topic | Priority |
|------|-------|----------|
| [basic-syntax.md](basic-syntax.md) | Hello Monkey C — using/import, differences from other languages | medium |
| [functions.md](functions.md) | Basic types, keywords, operators, symbols, constants, enums, if/switch, loops, instanceof/has, callbacks | **high** |
| [objects-and-memory.md](objects-and-memory.md) | Class, initialize, inheritance, public/protected/private, modules, scoping, weak references | **high** |
| [containers.md](containers.md) | Array + Dictionary syntax, typed/untyped, hashCode | **high** |
| [monkey-types.md](monkey-types.md) | Gradual type system, `as` clause, poly types, interfaces, tuples, null, if-splitting | **high** |
| [exceptions-and-errors.md](exceptions-and-errors.md) | try/catch/finally, custom exceptions, fatal error list | medium |
| [annotations.md](annotations.md) | `(:debug)`, `(:test)`, `(:background)`, etc. | low |
| [coding-conventions.md](coding-conventions.md) | Naming, source layout, idioms | low |
| [compiler-options.md](compiler-options.md) | monkeyc flags, typecheck levels, optimization | medium |

## How to refresh

Read from the SDK install path above. Each file's source HTML is at `doc/docs/Monkey_C/<Topic>.html`. No network fetch needed.

When SDK updates → SDK path changes → update `_env.ps1` first (skill already does this) and re-read the HTMLs.

## Cross-reference

- Toybox API references: `../api/`
- Known doc errors / observed behavior: `../api/index.md`
