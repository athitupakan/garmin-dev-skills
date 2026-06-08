---
source: doc/docs/Monkey_C/Annotations.html
sdk: 9.1.0
---

# Annotations

Decorate classes / methods / variables with symbols using `(:name)` syntax:

```monkey-c
(:debug) class TestMethods {
    (:test) static function testThisClass(x) { /* ... */ }
}
```

## Standard annotations

| Annotation | Effect |
|------------|--------|
| `(:background)` | Code available to Background process |
| `(:debug)` | Excluded from release builds |
| `(:glance)` | Available in Glance Mode |
| `(:release)` | Excluded from debug builds |
| `(:test)` | Run No Evil unit test; excluded from app at compile time |
| `(:typecheck(disableBackgroundCheck))` | Suppress background-scope type check |
| `(:typecheck(disableGlanceCheck))` | Suppress glance-scope type check |
| `(:typecheck([disableBackgroundCheck, disableGlanceCheck]))` | Both |
| `(:initialized)` | Tell type checker "assume initialized before reference" |
| `(:extendedCode)` | (API 5.1.0+) Put function in extended code space — 16 MB beyond heap, paged in on demand. Performance penalty if paged in. Don't put hot code here. |
| `(:optimizer(do_not_remove))` | Disable constant inlining for this `const` — look up at runtime instead. |

Annotations are written to `debug.xml` at compile time. May gain runtime semantics in future SDK versions.
