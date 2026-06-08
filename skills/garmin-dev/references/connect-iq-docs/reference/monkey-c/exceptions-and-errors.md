---
source: doc/docs/Monkey_C/Exceptions_and_Errors.html
sdk: 9.1.0
---

# Exceptions & Errors

## try / catch / finally

Java-style:

```monkey-c
try {
    // code
} catch (ex instanceof AnExceptionClass) {
    // handle specific
} catch (ex) {
    // catch-all
} finally {
    // always runs
}
```

## throw

```monkey-c
throw new MyException("something broke");
```

## Custom exception

1. Extend `Toybox.Lang.Exception`
2. Call `Exception.initialize()` in your `initialize`
3. Set `self.mMessage` to a description string

```monkey-c
class AppSpecificException extends Lang.Exception {
    function initialize(msg) {
        Exception.initialize();
        self.mMessage = msg;
    }
}
```

## Fatal errors (NOT catchable)

These terminate the app — cannot be caught:

| Error | When |
|-------|------|
| Array Out Of Bounds | Index outside array allocation |
| Circular Dependency | Module/object construction loop |
| Communications Error | BLE failure |
| File Not Found | App resource load failed |
| Illegal Frame | Stack return address corrupt |
| Initializer Error | Error inside an `initialize` |
| Invalid Value | Bad arg to a function |
| Null Reference | Dereferencing null |
| Out of Memory | Heap exhausted |
| Permission Required | Restricted API without manifest permission |
| Stack Underflow / Overflow | Stack pointer past bounds |
| Symbol Not Found | Variable/method does not exist |
| System Error | Generic Toybox fatal |
| Too Many Arguments | >10 args to a method |
| Too Many Timers | Exceeded device's Timer count |
| Unexpected Type | Operation on wrong type (e.g. bitwise OR on strings) |
| Unhandled Exception | Exception thrown, no `catch` |
| Watchdog Tripped | Function ran too long (infinite loop guard) |

**Pattern:** for sensor/data null values (HR, Body Battery, etc.), explicit `if (x != null)` guard — never let it become a Null Reference fatal.
