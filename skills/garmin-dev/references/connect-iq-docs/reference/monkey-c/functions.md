---
source: doc/docs/Monkey_C/Functions.html
sdk: 9.1.0
---

# Functions, Variables, Operators

## Basic types

- **Integer** — 32-bit signed (`var x = 5`)
- **Float** — 32-bit (`var y = 6.0`)
- **Long** — 64-bit signed (`var l = 5l`)
- **Double** — 64-bit float (`var d = 4.0d`)
- **Boolean** — `true` / `false`
- **Char** — Unicode (`var c = 'x'`)
- **String** — `"Hello"`
- **Object** — class instances
- **Array** — `new [size]` or `[1, 2, 3]`
- **Dictionary** — `{ "key" => value }`

## Keywords (reserved — can't use as identifiers)

```
as       break    case      catch     class
const    continue default   do        else
enum     extends  finally   for       function
has      hidden   if        instanceof  me
module   private  protected public    return
self     static   switch    throw     try
using    var      while
```

Also reserved: `native`, `alias`.

Literals/operators that look like keywords: `true`, `false`, `null`, `NaN`, `new`, `and`, `or`.

## Operators (precedence high → low)

| Prec | Ops |
|------|-----|
| 1 | `new`, `!`, `~`, `()` |
| 2 | `*`, `/`, `%`, `&`, `<<`, `>>` |
| 3 | `+`, `-`, `\|`, `^` |
| 4 | `<`, `<=`, `>`, `>=`, `==`, `!=` |
| 5 | `&&`, `and` |
| 6 | `\|\|`, `or` |
| 7 | `?:` (ternary) |

**Ternary works:** `var r = a ? 1 : 2;`

## Symbols

Lightweight unique identifiers — `:foo`. Useful as dict keys, enum values, callback selectors:

```monkey-c
var a = :foo;
var b = :foo;
a == b;  // true
var person = { :firstName => "Bob", :lastName => "Jones" };
```

## Constants

```monkey-c
const PI = 3.14;
const COLOR = "#FFE135";
```

- Declared at **module or class level**, NEVER inside function.
- For arrays: `const` prevents replacement of the reference, but elements still mutable (like Java `final`).

## Enumerations

Auto-incrementing constants starting at 0:

```monkey-c
enum {
    Monday,     // 0
    Tuesday,    // 1
    Wednesday   // 2
}

enum {
    x = 1337,   // x = 1337
    y,          // y = 1338
    a = 0, b, c // 0, 1, 2
}
```

Must be at module or class level.

## if / switch

```monkey-c
if (a == true) {
    // ...
} else if (b) {
    // ...
} else {
    // ...
}
```

Truthy: `true`, non-zero integer, non-null object.

```monkey-c
switch (obj) {
    case true:
        break;
    case 1:
        break;
    case "B": { break; }
    case instanceof MyClass:
        break;
    default:
        break;
}
```

Fall-through works (no `break` → next case runs). `instanceof` in case is supported.

**Switch variable scoping caveat:** vars declared in switch block are scoped at switch level. Due to fall-through, they must be initialized before reads in later cases. Use `{ }` around a case body for local scope.

## Loops

```monkey-c
for (var i = 0; i < array.size(); i += 1) { /* ... */ }
while (expr) { /* ... */ }
do { /* ... */ } while (expr);
```

- **Single-line bodies not allowed** — braces required.
- `break`, `continue` work as expected.

## Return

```monkey-c
return expression;
```

- Expression optional.
- If no `return`, function automatically returns the last value evaluated.
- All functions return values (no void at language level — see Monkey Types for `as Void`).

## Calling methods

```monkey-c
foo("hello");                  // same class/module
obj.foo("hello");              // instance
var x = self.member;           // own member
A.overridableMethod();         // super class method (use class name, not `super`)
```

⚠ **No `SuperClass.memberVariable`** syntax — always use `self.x`.

## instanceof and has

```monkey-c
if (value instanceof Toybox.Lang.Number) { /* ... */ }
if (Toybox has :Magnetometer) { /* ... */ }
```

- `instanceof` — check inheritance.
- `has` — check if symbol exists on an object/module. Use to feature-detect optional APIs that vary by device.

## Callbacks

Functions are not first-class. Use **`Method` objects**:

```monkey-c
class Foo {
    function operation(a, b) { /* ... */ }
}
var v = new Foo();
var m = v.method(:operation);   // get Method object
m.invoke(1, 2);                  // invoke later
```

- `method()` is inherited from `Toybox.Lang.Object`.
- The `Method` keeps a **strong reference** to the source instance.

For module-level functions (modules don't inherit from Object):

```monkey-c
module Foo {
    function operation() { /* ... */ }
}
var m = new Method(Foo, :operation);
m.invoke();
```
