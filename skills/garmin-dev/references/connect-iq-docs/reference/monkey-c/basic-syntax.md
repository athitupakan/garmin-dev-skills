---
source: doc/docs/Monkey_C/Basic_Syntax.html
sdk: 9.1.0
---

# Hello Monkey C

Watch-face app skeleton:

```monkey-c
using Toybox.Application as App;
using Toybox.System;

class MyProjectApp extends App.AppBase {
    function onStart(state)  {}
    function onStop(state)   {}
    function getInitialView() {
        return [ new MyProjectView() ];
    }
}
```

- `using` (or `import`) brings a module into namespace.
- `Toybox` is the root module for all SDK modules.
- `System.println("...")` logs to debug console.
- `System` also has: `print`, `getTimer`, `getSystemStats`, `exit`, `error`.

## Differences from other languages

### Java
- Compiles to bytecode interpreted by a VM (like Java).
- All objects on heap; **reference-counted GC** (not mark-sweep).
- **No primitive types** — `Number`, `Float`, `Char` are objects with methods.
- **Duck-typed**, not statically typed. Compiler does NOT verify type safety; type errors are runtime errors.
- Modules ~= Java packages, but modules can hold variables and functions (not just classes).

### Lua / JavaScript
- **Functions are NOT first-class.** You can't pass `foo` as a value.
- To create a callback, use a **`Method` object** (see [functions.md](functions.md#callbacks)).
- Classes are compiled — you can't add fields/methods at runtime (unlike Lua tables).

### Ruby / Python
- Objects are NOT hash tables. Compiled definitions; no runtime mutation.
- All variables must be declared before use (`var x = ...`).
- When importing a module, classes are referenced through the module prefix (no `from … import`).
