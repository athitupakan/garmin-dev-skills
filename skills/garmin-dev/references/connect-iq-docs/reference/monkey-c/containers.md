---
source: doc/docs/Monkey_C/Containers.html
sdk: 9.1.0
---

# Containers — Array & Dictionary

Two built-in container types. Both typeless by default; types can be added with `as` clause.

## Array

### Create

```monkey-c
// Empty, fixed size
var a = new [10];                          // typeless
var b = new Array<Number>[10];             // typed

// Pre-initialized
var c = [1, 2, 3, 4, 5];                              // typed as Tuple
var d = [1, 2, 3] as Array<Number>;                   // typed as Array<Number>

// Multidimensional
var matrix = [[1, 2], [3, 4]];

// 2D empty
var grid = new [rows];
for (var i = 0; i < rows; i += 1) {
    grid[i] = new [cols];
}
```

### Typed-array assignment is enforced

```monkey-c
var arr as Array<Number> = [1, 2, 3] as Array<Number>;
arr[0] = "string";    // compile error
```

## Dictionary

### Create

```monkey-c
var dict = { "a" => 1, "b" => 2 };
var empty = {};

// Typed
var typed = {} as Dictionary<Symbol, String>;
typed[:option] = "value";       // OK
typed["option"] = "value";      // compile error — key not a Symbol
```

### Lookup

```monkey-c
dict["a"];     // 1
dict["nope"];  // null  (not exception)
```

### Custom hash

Default hashing uses reference equality. Override `hashCode()` in your class:

```monkey-c
class Person {
    function hashCode() { return mPersonId; }
}
```

**Rule:** two objects that compare equal MUST return the same hash code.

## Performance notes

- Dictionaries **auto-resize** and **rehash** as contents change → insertion/removal can be expensive at growth boundaries.
- Hash tables use more memory than equivalent arrays/objects.
- For fixed structured data, arrays or class fields are more efficient than dictionaries.
