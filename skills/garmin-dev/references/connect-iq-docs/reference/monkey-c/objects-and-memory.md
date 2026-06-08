---
source: doc/docs/Monkey_C/Objects_and_Memory.html
sdk: 9.1.0
---

# Objects, Modules, Memory

## Class + constructor

`new` allocates and calls `initialize`:

```monkey-c
class Circle {
    protected var mRadius;
    public function initialize(aRadius) {
        mRadius = aRadius;
    }
}
var c = new Circle(1.5);
```

Inside a method, refer to current instance with `self` or `me`:

```monkey-c
me.x = "Hello";
self.y = "Hello";
```

Nested classes work, but **do NOT have access to enclosing class members** (unlike Java inner classes).

## Inheritance

```monkey-c
class A {
    function print() { System.print("Hello!"); }
}
class B extends A {
    function print() {
        A.print();                  // call super — use ClassName, not `super`
        System.println(" Hola!");
    }
}
```

## Access modifiers

- `public` — default; visible everywhere.
- `protected` — own class + subclasses only. Synonym: `hidden` (legacy).
- `private` — own class only.

```monkey-c
class Foo {
    public var publicVar;
    protected var _protectedVar;
    private var _privateVar;
}
```

**Convention:** prefix private/protected vars with `_`.

## Polymorphism

No runtime polymorphism (no overload by signature). Workarounds:

```monkey-c
// Type dispatch
function poly(a) {
    switch (a) {
        case instanceof String: return doStr(a);
        case instanceof Number:
        case instanceof Long:   return doNum(a);
        default: throw new UnexpectedTypeException();
    }
}

// Options dict (extensible API pattern)
x = poly({ :param1 => "Foo", :param2 => "Bar" });
```

## Strong / weak references

Monkey C is **reference-counted** (not GC mark-sweep). Memory frees when refcount → 0.

**Circular reference problem:** A↔B referencing each other never reach 0 → memory leak.

Use `weak()` to avoid cycles:

```monkey-c
var weakRef = obj.weak();    // returns Lang.WeakReference (or obj itself if immutable type)

if (weakRef.stillAlive()) {
    var strongRef = weakRef.get();
    strongRef.doTheThing();
}
```

- `weak()` on primitives (Number, Float, Char, Long, Double, String) returns the value itself.
- `stillAlive()` — check if still referenced.
- `get()` — get strong reference (or null if gone). Hold strong only as long as needed.

Each unique object takes 1 memory handle. Connect IQ 2.4+ uses dynamic handle limit; earlier versions had static limit.

## Modules

Scoping for classes, functions, variables:

```monkey-c
module MyModule {
    class Foo { var mValue; }
    var moduleVariable;
}

MyModule.moduleVariable = new MyModule.Foo();
```

**No inheritance, no access modifiers** for modules. `extends`, `private`, `protected` don't apply.

## import vs using

```monkey-c
import Toybox.Lang;          // brings module + all classes into type namespace
using Toybox.System;          // brings only the module symbol
using Toybox.System as Sys;   // alias

// With import: class names directly available
var x as Number = 0;          // OK — Number resolved via import

// With using: still need module prefix
Sys.println("Hello");
```

**Rule of thumb:** use `import` when using Monkey Types (saves typing); use `using` for code that doesn't need type lookup.

`using` is scoped to the file (or class/module where declared); `import` is also file-scoped.

## Scoping / name resolution

When the VM looks up a symbol at runtime, it searches in this order:

1. Instance members of the class
2. Members of the superclass(es)
3. Static members of the class
4. Members of the parent module → up to globals
5. Members of the superclass's parent module → up to globals
6. Public static members of the parent module → up to globals
7. Public static members of the superclass's parent module → up to globals

For global access, prefix with `$.` ("bling"):

```monkey-c
$.helloFunction();     // skip class/module hierarchy, go straight to global
$.globalVar;           // faster than letting VM search the hierarchy
```

Using `$.` on globals is a **performance win** — avoids the hierarchical search.
