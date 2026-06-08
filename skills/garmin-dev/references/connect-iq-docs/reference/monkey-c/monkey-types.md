---
source: doc/docs/Monkey_C/Monkey_Types.html
sdk: 9.1.0
---

# Monkey Types — gradual type system

Type checking is **opt-in**, **compile-time only**, **no runtime cost**. Enabled with `-l <level>`.

## Type-check levels (`-l`)

| Flag | Name | Behavior |
|------|------|----------|
| `-l 0` | Silent | No type checking |
| `-l 1` | Gradual | Check where types can be inferred; otherwise silent |
| `-l 2` | Informative | Check only typed code; warn about ambiguity |
| `-l 3` | Strict | Error on ambiguity |

## `as` clause — binding types

```monkey-c
var globalX as Lang.Number = 0;
globalX = 2;     // OK
globalX = "2";   // compile error
```

**Locals are inferred at assignment** — no `as` needed.

### Multiple types — `or`

```monkey-c
var x as Lang.Number or Lang.String = 0;
```

### Nullable — `?` shorthand

```monkey-c
function foo() as Number? { ... }       // returns Number or Null
function foo() as Number or Null { ... }  // same
```

⚠ Concrete types **do NOT implicitly accept null**. Use `?` or explicit `or Null`.

## `import` vs `using` (with Monkey Types)

```monkey-c
import Toybox.Lang;           // brings module + class names into type namespace
var x as Number = 0;          // OK — Number resolved

using Toybox.Lang;             // module only — must prefix Lang.Number
var x as Lang.Number = 0;
```

**Use `import` when typing** — avoids redundant prefixes.

`import` does NOT support `as` for renaming (intentional design choice).

## `typedef` — named types

```monkey-c
typedef Numeric as Number or Float or Long or Double;

function add(a as Numeric, b as Numeric) as Numeric {
    return a + b;
}
```

## Type categories

### Any
Default when no `as` clause. Behaves like duck-typed.

### Void
For return type — function must not return a value.

```monkey-c
function doNothing() as Void {
    return true;  // compile error
}
```

### Concrete
Single class. Accepts that class or subclasses. Does NOT implicitly accept null.

### Poly
Union of types via `or`. Used to model duck typing.

### Interface
Required member shape:

```monkey-c
typedef Drawable as interface {
    var x as Number;
    function draw() as Void;
};
// Any class with var x as Number + function draw() satisfies Drawable
// No `implements` keyword needed
```

### Container — Array<T> / Dictionary<K, V>

```monkey-c
typedef Nums as Array<Number>;
typedef Map as Dictionary<String, Number>;
```

⚠ Container types match **exactly**: `Array<String>` does NOT match `Array<String or Number>`.

### Tuples — `[A, B, C]`

```monkey-c
function getInitialView() as [Views] or [Views, InputDelegates] {
    return [new StartView(), new StartDelegate()];
}
```

- Type system tracks tuple element types.
- A tuple `[A, B, C]` is an `Array<A or B or C>` — useful for passing to typed-array params.

### Dictionary — options pattern

```monkey-c
function doWork(options as {
    :option1 as String,
    :option2 as { "name" as String, "value" as Number }
});
```

Compiler tracks per-key value types. Allows missing keys, allows extra keys.

### Enumerations — named

```monkey-c
enum Dog {
    SPOT = "Spot",
    LUKE = "Luke",
    BINGO = "B_I_N_G_O"
}

function getDogName(dog as Dog) as String {
    return dog.toString();
}
```

Enum values are bound to both the enum type AND their value type.

### Callback

```monkey-c
function doWork(x as Method(a as Number) as String) as String {
    return x.invoke(2);
}
```

### Null
Its own type. Use `?` or `or Null` to allow.

## Type matching table (A receives B)

|  A↓  B→  | Any | Concrete | Poly | Interface | Container | Dict | Enum | Callback | Null |
|----------|-----|----------|------|-----------|-----------|------|------|----------|------|
| Any | T | T | T | T | T | T | T | T | T |
| Concrete | Maybe | T iff B extends A | Maybe | F | Maybe (Dict/Array) | Maybe | T if enum matches | F | F |
| Poly | Maybe | T iff B in A | Mixed | T if B in A | T if B in A | T if B in A | T if B in A | T if B in A | T if B in A |
| Interface | Maybe | T if B has all members | Maybe | T if A subset of B | T if matches | T if matches | F | F | F |
| Container | Maybe | F | Maybe | F | T iff exact match | F | F | F | F |
| Dict | Maybe | F | Maybe | F | T iff all match | T iff all match | F | F | F |
| Enum | Maybe | T iff enum value type matches | Maybe | F | F | F | T iff same enum | F | F |
| Callback | Maybe | F | Maybe | F | F | F | F | T iff signatures match | F |
| Null | Maybe | F | Maybe | F | F | F | F | F | T |

T = True, F = False, Maybe = ambiguous. **Ambiguity** can be silent/warning/error per `-l`.

## Type inference in functions

Locals are tracked through assignment AND branches:

```monkey-c
function process(a as Boolean) as Boolean? {
    var x = null;             // x is Null
    if (a) { x = true; }      // x is now Boolean or Null (poly type)
    return x;
}
```

Once a value has a known type, the compiler validates method calls:

```monkey-c
var a = new A();
a.foo();   // OK if A.foo exists
a.fonz();  // compile error
```

## Type casting

```monkey-c
function process(a as View) {
    (a as MyView).specialMethod();
}
```

Casts are **lexical only** — zero runtime effect.

## Runtime type checking

Use `instanceof` and `has` for actual runtime checks:

```monkey-c
// instanceof — concrete class check
switch (x) {
    case instanceof Number: doNum(x); break;
    case instanceof Float:  doFloat(x); break;
}

// has — symbol existence check (works for interface-like patterns)
if (jack has :isNimble and jack has :jumpOverCandleStick) {
    jack.jumpOverCandleStick();
}
```

⚠ `instanceof` only works on **concrete classes**, not lexical interface types. Use `has` for interface checks.

## If-splitting

The type system narrows types within if branches:

```monkey-c
function foo(x as Number?) as Boolean {
    if (x != null) {
        // x is Number here
    } else {
        // x is Null here
    }
}
```

Splits propagate through `&&` and split anew through `||`.

⚠ **If-splitting on member variables resets after any function call** (the call might mutate it).

## Class / module type rules

- Member variables default to `Any` unless typed.
- **Member variables with `as` must be initialized** — either at declaration or in `initialize`. Otherwise compile error:

```monkey-c
class Messenger {
    private var _message as String;     // error — uninitialized non-nullable
}
// Fix: initialize in initialize() OR change type to String?
```

- Constants are typed by assignment.
- Enum values are typed both as the enum type and their literal type.

## Inheritance rules

1. Override with **same arg count, no decorations** → arg/return types inherited from parent.
2. Override with **same arg count + decorations** → must match parent exactly or compile error.

## Application-scope checks

Compiler validates that members called are available in the caller's app scope (background / glance).

To disable for background or glance scope:

```monkey-c
(:typecheck(disableBackgroundCheck)) function ...
(:typecheck(disableGlanceCheck)) function ...
(:typecheck([disableBackgroundCheck, disableGlanceCheck])) function ...
```
