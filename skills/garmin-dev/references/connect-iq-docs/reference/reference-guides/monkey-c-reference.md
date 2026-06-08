---
source: https://developer.garmin.com/connect-iq/reference-guides/monkey-c-reference/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Reference_Guides/Monkey_C_Reference.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Monkey C Language Reference

Monkey C is an object-oriented language built from the ground up, designed for easy app development on wearable devices. If you've worked with dynamic languages in the past like Java™, PHP, Ruby, or Python™, Monkey C should be very familiar.

The goal of Monkey C is to round the sharp edges of app development, allowing developers to focus more on the customer and less on resource constraints. Monkey C compiles into byte code that is interpreted by a virtual machine, similar to Java. Also like Java, objects are allocated on the heap, and the virtual machine cleans up memory.

## Language Essentials

### Data Types

Monkey C is a duck typed language, and does not have true primitive types. The Lang.Boolean, Lang.Char, Lang.Number, Lang.Long, Lang.Float, and Lang.Double types are all objects, which means primitives can have methods just like other objects. In languages like Java or C++, types must be declared for each function parameter and return value. The Monkey C compiler will optionally verify type safety, however, and runtime errors occur when functions mishandle objects. Using operators like `instanceof` and `has` can help avoid potential typing issues.

The basic data types supported by Monkey C are:

| Type | Description | Example |
| --- | --- | --- |
| Number | 32-bit signed integer | `var x = 5;` |
| Float | 32-bit floating point number | `var y = 6.0;` |
| Long* | 64-bit signed integer | `var l = 5l;` |
| Double* | 64-bit floating point number | `var d = 4.0d;` |
| Boolean | `true` and `false` | `var bool = true;` |
| Char | UTF-32 character | `var c = 'x';` |
| String* | A sequence of characters | `var str = "Hello";` |
| Symbol | A lightweight constant identifier (See Symbols for more info) | `var sym = :mySymbol;` |

Monkey C also supports two container types:

| Type | Description | Example |
| --- | --- | --- |
| Array* | Fixed size (not a linked list), numerically indexed, single dimensional list of objects | `var arr = new [1, 2, 3];` |
| Dictionary* | An associative array or hash table that maps keys to values | `var dict = {one=>1, two=>2};` |

*Requires heap allocation, which requires more memory than a 32-bit type.

There are several keywords, operators, and reserved words in the Monkey C programming language that cannot be used as variables or symbols in your programs:

| Operator | Description | Example |
| --- | --- | --- |
| `and` | Logical AND, equivalent to `&&` | See Logical Operators |
| `as` | Assign an alias to a module denoted by a `using` statement | See Using Statements |
| `break` | Break out of a loop or a switch-case block | See Loops and Switch-Case Statements |
| `catch` | Catch a thrown Lang.Exception | See Exception Handling |
| `case` | Specify a case in a `switch` block | See Switch-Case Statements |
| `class` | Declare a new class | See Classes and Objects |
| `const` | Declare a new constant | See Constants |
| `continue` | Continue to executing the current flow, primarily used within loops | See Loops |
| `default` | Specify a default case in a `switch` block | See Switch-Case Statements |
| `do` | Start a `do` loop | See Loops |
| `else` | Specify an alternate case in an `if` block | See If Statements |
| `enum` | Declare a new enumeration | See Enumerations |
| `extends` | Declare a class that inherits from another class | See Classes and Objects |
| `false` | Logical `false` | See If Statements |
| `finally` | Specify a block of code to always execute in a `try` block | See Exception Handling |
| `for` | Start a `for` loop | See Loops |
| `function` | Declare a new function | See Functions |
| `has` | Check whether an object has a particular symbol | See Instanceof and Has |
| `hidden` | Specify a protected object member, equivalent to `protected` | See Data Hiding |
| `if` | Start an `if` block | See If Statements |
| `instanceof` | Check object type | See Instanceof and Has |
| `me` | Refer to the current object instance | See Classes and Objects |
| `module` | Declare a new module | See Modules |
| `NaN` | An invalid or undefined value, "Not a Number" | NA |
| `native` | Reserved for internal use | NA |
| `new` | Create a new instance of an object | See Miscellaneous Operators |
| `null` | A null value | See Declaring Variables |
| `or` | Logical OR, equivalent to `\|\|` | See Logical Operators |
| `private` | Specify a private object member | See Data Hiding |
| `protected` | Specify a protected object member | See Data Hiding |
| `public` | Specify a public object member | See Data Hiding |
| `return` | Specify a value to return from a function | See Functions |
| `self` | Refer to the current object instance | See Classes and Objects |
| `static` | Declare a static variable or function | See Static Members |
| `switch` | Start a `switch` block | See Switch-Case Statements |
| `throw` | Throw an exception | See Exception Handling |
| `true` | Logical `true` | See If Statements |
| `try` | Start a try-catch block to handle exceptions | See Exception Handling |
| `using` | Import a module for use in the app | See Using Statements |
| `var` | Declare a new variable | See Declaring Variables |
| `while` | Start a new `while` loop or set a condition for a `do` loop | See Loops |

### Operators

Monkey C supports several useful operators outlined below. In the examples below, assume `a = 10`, `b = 5`, `x = 1`, `y = 0`, `m = true`, and `n = false`.

#### Arithmetic Operators

| Operator | Description | Example |
| --- | --- | --- |
| `+` | Add two operands; unary positive | `a + b` results in 15; `+a` is 10 |
| `-` | Subtract the second operand from the first; unary negative | `a - b` results in 5; `-a` is -10 |
| `*` | Multiply two operands | `a * b` results in 50 |
| `/` | Divide the dividend by the divisor | `a / b` results in 2 |
| `%` | Modulus, provides the remainder after division | `a % b` results in 0 |
| `++` | Increment a numeric value by one, may be prefix or postfix | `a++` results in 11 |
| `--` | Decrement a numeric value by one, may be prefix or postfix | `a--` results in 9 |

**Note:** The `+` operator is also used to concatenate String values.

#### Relational Operators

| Operator | Description | Example |
| --- | --- | --- |
| `==` | Check to see if two operands are equal | `a == b` is `false` |
| `!=` | Check to see if two operands are not equal | `a != b` is `true` |
| `>` | Check to see if the left operand is greater than the right operand | `a > b` is `true` |
| `<` | Check to see if the left operand is less than the right operand | `a < b` is `false` |
| `>=` | Check to see if the left operand is greater than or equal to the right operand | `a >= b` is `false` |
| `<=` | Check to see if the left operand is less than or equal to the right operand | `a <= b` is `false` |

#### Logical Operators

| Operator | Description | Example |
| --- | --- | --- |
| `&&`, 'and' | Logical AND, which is `true` if both values are true | `m && n` is `false` |
| `\|\|` | Logical OR, which is `true` if either value is true | `m \|\| n` is `true` |
| `!` | Logical NOT, which reverses the value of a logical expression | `!(m && n)` is `true` |

In Monkey C the following apply:

- If an object is not `null`, it is evaluated as `true`. A value of `0` is evaluated as `false`.
- A `!` applied to a `Number` or `Long` is the same as applying a `~`.

When comparing non-Boolean values in logical expressions:

- The expression `x && y` first evaluates `x`. If `x` is `false`, its value is returned; otherwise, `y` is evaluated and the resulting value is returned.
- The expression `x || y` first evaluates `x`. If `x` is `true`, its value is returned; otherwise, `y` is evaluated and the resulting value is returned.

#### Bitwise Operators

Bitwise operators perform operations on binary values, bit-by-bit. These adhere to conventions illustrated by the following truth table:

| p | q | p & q | p \| q | p ^ q |
| --- | --- | --- | --- | --- |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 | 1 |
| 1 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 | 1 |

Assume `p = 3` and `q = 1`. If written as byte values in binary, `p` is `0000 0011` and `q` is `0000 0001`.

| Operator | Description | Example |
| --- | --- | --- |
| `&` | Bitwise AND, which copies a bit to the result if it exists in both operands | `p & q` results in 1 (0000 0001) |
| `\|` | Bitwise OR, which copies a bit to the result if it exists in either operand | `p \| q` results in 3 (0000 0011) |
| `^` | Bitwise XOR, which copies a bit to the result if it exists in either operand, but not both | `p ^ q` results in 2 (0000 0010) |
| `~` | Bitwise NOT, two's compliment, which effectively "flips" the bits | `~q` results in -2 (1111 1110) |

**Note:** All numeric values in Monkey C are signed values, indicated by the high-order bit.

#### Assignment Operators

| Operator | Description | Example |
| --- | --- | --- |
| `=` | Assign the value from the right operand to the left operand | `b = a` assigns `b` the value of `a` (10) |
| `+=` | Add the right operand and left operand and assign the result to the left operand | `a += b` equivalent to `a = a + b` (15) |
| `-=` | Subtract the right operand from the left operand and assign the result to the left operand | `a -= b` equivalent to `a = a - b` (5) |
| `*=` | Multiply the right operand with the left operand and assign the result to the left operand | `a *= b` equivalent to `a = a * b` (50) |
| `/=` | Divide the left operand from the right operand and assign the result to the left operand | `a /= b` equivalent to `a = a / b` (2) |
| `%=` | Divide the left operand from the right operand and assign the remainder to the left operand | `a %= b` results in 0 |
| `<<=` | Left shift the left operand by the right operand and assign the result to the left operand | `x <<= y` equivalent to `x = x << y` (1) |
| `>>=` | Right shift the left operand by the right operand and assign the result to the left operand | `x >>= y` equivalent to `x = x >> y` (1) |
| `&=` | Bitwise AND the right operand by the left operand and assign the result to the left operand | `x &= y` equivalent to `x = x & y` (0) |
| `\|=` | Bitwise OR the right operand by the left operand and assign the result to the left operand | `x \|= y` equivalent to `x = x \| y` (1) |
| `^=` | Bitwise XOR the right operand by the left operand and assign the result to the left operand | `x ^= y` equivalent to `x = x ^ y` (1) |

#### Miscellaneous Operators

| Operator | Description | Example |
| --- | --- | --- |
| `?` and `:` | The ternary operator, a shorthand form of if-else | `var myBool = a > 5 ? true : false` |
| `new` | Create a new instance of an object | `var myTimer = new Toybox.Timer.Timer` |

#### Operator Precedence

Operator precedence determines which parts of an expression will be evaluated first. The list below groups the operators by precedence, the highest appearing at the top of the table, and the lowest at the bottom.

| Precedence | Operators |
| --- | --- |
| 1 | `new ! ~ ()` |
| 2 | `* / % & >` |
| 3 | `+ -` |
| 4 | `== != >=` |
| 5 | `&& and` |
| 6 | `\|\| or` |

## Variables and Expressions

### Comments

Commented statements are ignored by the compiler. Monkey C supports multi-line (`/* */`) and single-line (`//`) comments. Here is an example of a multi-line comment:

```
/*
This is a multi-line comment. Notice that the information
continues to appear as a comment as long as it remains
inside the comment delimiters.
*/
```

Single-line comments may appear on their own line, or may appear in-line with other Monkey C code:

```
using Toybox.System;

// This is a single-line comment on its own line
System.println("Hello World!");  // This comment shares a line with code that will execute
```

### Declaring Variables

All variables must be declared before use with the `var` keyword. Since Monkey C is a duck typed language, it is not necessary to delcare each variable's type.

```
var x = 5;            // A 32-bit integer value
var myString = "";    // An empty string
var n = null;         // Null value
var f = 4.0d;         // A 64-bit floating point value
```

The flexibility of duck typing means there are things watch out for:

```
var arr = new[10];     // Create a new array; since the values are unassigned, they are initialized as 'null'
var z = arr[0] + 5;    // Attempt to add a Number to a null array element. UnexpectedTypeException!
```

### Constants

Constants, declared with the `const` keyword, are named, immutable values that support all basic data types. These are useful for storing unchanging values that may be used repeatedly throughout code. Constants must be declared at the module or class level and cannot be declared within a function. It is important to note that with data structures like arrays, `const` works in a way similar to Java's `final` keyword. For example, a `const` array prevents the array from being replaced by a new instance, but the elements of the array may be modified.

```
const PI = 3.14;
const EAT_BANANAS = true;
const BANANA_YELLOW = "#FFE135";
```

### Symbols

Lang.Symbol objects are lightweight constant identifiers. When the Monkey C compiler finds a new symbol, it will assign it a new unique value. This allows symbols to be used as constants without explicitly declaring a constant:

```
using Toybox.System;

var a = :symbol_1;
var b = :symbol_1;
var c = :symbol_2;
System.println(a == b);  // Prints true
System.println(a == c);  // Prints false
```

Symbols are also useful as keys in data structures like dictionaries:

```
var person = {:title=>"George", :name=>"Taylor"};
```

One other important use for symbols is to reference method implementations for calls to Object.method() or when assigning callbacks with Lang.Method. In this instances, if a method `myMethod{...}` has been implemented, it can be referenced as a callbacks using the symbol `:myMethod`. See the section on Callbacks for more in-depth examples.

### Enumerations

Enumerations are constant mappings from a Lang.Symbol to a Lang.Number value, created using the `enum` keyword. Unless explicitly set, the first symbol in an enumeration is assigned a value of `0`, and each subsequent symbol is automatically assigned the value of the previous unassigned symbol plus one. Enumeration symbols can be used just like constants (that's essentially what they are), and like constants, enumerations must be declared at the module or class level.

```
// Automatically incremented enumeration
enum {
    Sunday,     // 0
    Monday,     // 1
    Tuesday,    // 2
    Wednesday,  // 3
    Thursday,   // 4
    Friday,     // 5
    Saturday    // 6
}
```

```
// Enumeration initialized with an explicit starting value
enum {
    x = 1337,   // x = 1337
    y,          // y = 1338
    z,          // z = 1339
    a = 0,      // a = 0
    b,          // b = 1
    c           // c = 2
}
```

### Arrays

Lang.Array objects are fixed-size (not a linked list), numerically indexed lists of objects. All members of an array do not need to be the same type of object. Like variables, arrays in Monkey C are typeless, so it is not necessary to declare an array's type. There are two ways to create a new array:

```
// A new array with ten empty slots, initialized to 'null'
var myArray = new[10];

// A new five-slot array with assigned values
var myArray = [1, 2, 3, 4, 5];
```

Array elements are expressions, so it's also possible to build multi-dimensional arrays:

```
var myArray = [[1, 2], ["one", "two"]];
```

Although Monkey C does not have a direct way of creating an empty, two-dimensional array, it can be done:

```
// Specify the array sizes
var first_dimension_size = 2;
var second_simension_size = 100;

// Create an empty one-dimensional array
var myArray = new [first_dimension_size];

// Initialize the sub-arrays to complete the two-dimensional array
for(var i = 0; i < first_dimension_size; i += 1) {
    myArray[i] = new [second_dimension_size];
}
```

**Note:** When using this technique, it's important to pay close attention to the array dimensions. The example above only makes three Array allocations to provide 200 slots, but were the dimensions reversed, this would make 101 allocations, using a lot more memory to provide the same number of slots.

### Dictionaries

Lang.Dictionary objects, also called associative arrays or hash tables, are data structures similar to Lang.Array objects that map key-value pairs. Keys and values can be any type of Lang.Object, and each key-value pair does not need to be the same type combination within a given dictionary.

```
using Toybox.System;

var x = {};                                 // Declare a new, empty Dictionary
var myDictionary = { "a" => 1, "b" => 2 };  // Declare a new Dictionary with initialized values
myDictionary.put("c", "three");             // Add a new key-value pair with a String value
System.println(myDictionary["a"]);          // Prints "1"
System.println(myDictionary["c"]);          // Prints "three"
System.println(myDictionary["d"]);          // Prints "null" (there is no key "d")
```

The Lang.Object class has a built-in Object.hashCode() method that automatically hashes (indexes) the keys added to a Dictionary. This provides an efficient way of looking up the arbitrarily ordered Dictionary values. Dictionaries automatically resize and rehash as items are added or removed, which makes them extremely flexible, but comes at a cost:

- Insertion and removal of Dictionary contents can cause performance problems if there is excessive resizing and rehashing
- Dictionaries are not as space-efficient as either Lang.Object or Lang.Array type objects because they require extra memory allocation space

The built-in Object.hashCode() method is adequate in most cases, but if a custom Lang.Object type is used as keys in a Dictionary, it may be beneficial to override it to avoid index collisions and reduce lookup time:

```
class Monkey
{
    var mLengthInCentimeters;
    var mWeightInKilograms;

    initialize(length, weight) {
        mLengthInCentimeters = length;
        mWeightInKilograms = weight;
    }

    // Return a unique Number as the hash code for Monkey objects used as keys in Dictionaries.
    // For the record, this is a pretty terrible hashing function.
    function hashCode() {
        return (Math.pow(self.mLengthInCentimeters, self.mWeightInKilograms)).toNumber();;
    }
}

var rhesusMacaque = new Monkey(53.4, 7.7);
var capuchin = new Monkey(48.3, 4.2);
var mandrill = new Monkey(82.9, 32.3);

var monkeyContinents = {
    rhesusMacaque => "Asia",
    capuchin => "South America",
    mandrill => "Africa"
}
```

## Flow Control

### If Statements

In Monkey C, `if` statement are the most basic of the available flow control statements. They are used to execute a certain section of code *only* if a particular Boolean expression evaluates to `true`. The expression evaluated by the `if` statement cannot be an assignment. Values or objects that will evaluate to `true` include:

- A value of `true`
- A non-zero Lang.Number
- A non-null Lang.Number

As an example, this prints a message to the console when the value of `result` is greater than zero:

```
using Toybox.System;

var result = 5;
if (result > 0) {
    System.println("Result is greater than zero");
}
```

The `else` keyword can be added to an `if` block for more complex branching. Once an expression evaluates to `true`, its associated block of statements are executed and any remaining statements in the `if` block are skipped:

```
using Toybox.System;

var a = false;
var b = true;

if (a == true) {
    // 'a' is false, so this will not execute
    System.println("The variable 'a' is true!");
} else if (b == true) {
    // 'b' is true, so this block will execute
    System.println("The variable 'b' is true!");
} else {
    // Since the previous block has executed, this is skipped
    System.println("Neither is true!");
}
```

Statements may also be nested. In the example below, `b` and `c` are only evaluated if `a` is equal to 1:

```
using Toybox.System;

if (a == 1) {
    if (b == true) {
        System.println("The variable 'b' is true!");
    } else if (c == true) {
        System.println("The variable 'c' is true!");
    }
}
```

Lastly, Monkey C supports the ternary operator, which is a simple, alternative syntax for a basic if-else statement. The general form is:

```
var result = testExpression ? whenTrueExpression : whenFalseExpression
```

Where `testExpression` is evaluated to determine whether it is `true`, `whenTrueExpression` is the `true` result, and `whenFalseExpression` is the `false` result. The value of the resulting expression is assigned to the `result` variable. If resulting expression does not resolve to a value (e.g. something like a System.println() statement), the `result` variable is assigned a value of `null`.

```
// If 'a' is true, 'myValue' is assigned a value of 1; otherwise, it is assigned a value of 2.
var myValue = a ? 1 : 2;
```

### Switch-Case Statements

A `switch` statement is another type of flow control statement that may have multiple execution paths rather than the single path offered by `if` statements. A `switch` statement first evaluates a condition, which must be an object—assignments are not allowed. Any number of successive `case` statements are allowed within a switch block, each followed by either an object or an `instanceof` expression. When the `switch` evaluation is either equal to or an instance of a `case` statement, the matching case block will execute. For example, these two examples function similarly:

```
using Toybox.System;

// An if-else block checking the myValue variable
if (myValue == 1) {
    System.println("The value is 1!");
} else if (myValue == 2) {
    System.println("The value is 2!");
} else {
    System.println("The value is not 1 or 2!");
}

// A switch-case block checking the myValue variable
switch (myValue) {
    case 1:
        System.println("The value is 1!");
        break;
    case 2:
        System.println("The value is 2!");
        break;
    default:
        System.println("The value is not 1 or 2!");
}
```

All statements following the matching case block, including subsequent case blocks, are executed in sequence until a `break` statement is encountered. At this point, the switch block terminates and the remaining case blocks are skipped. This behavior, called *fall through*, is illustrated below:

```
using Toybox.System;

switch (myValue) {
    case 1:
        System.println("The value is 1!");
        // Since there is no 'break', this will "fall through" and execute
        // the code in the next case block until its break statement is reached
    case 2:
        System.println("The value is 2!");
        break;
    default:
        System.println("The value is not 1 or 2!");
}
```

A switch block may also have a single, optional `default` case, which handles all cases not explicitly handled by one of the preceding `case` statements. A final `break` statement is not required because control flow will naturally fall out of the switch block at the end of the block, but it may be included if preferred.

Since `switch` statements can switch on objects or object types, it's possible to perform more sophisticated actions. Below is a snippet of an app that receives an Ant payload that must be handled differently depending on how the message is coded:

```
var payload = message.getPayload();

switch (payload[MESSAGE_CODE_INDEX]) {
    case instanceof Number:
        System.println("Valid code!");
    case Toybox.Ant.MSG_CODE_EVENT_CHANNEL_CLOSED:
        // Open the channel
        ...
        break;
    case Toybox.Ant.MSG_CODE_EVENT_RX_FAIL_GO_TO_SEARCH:
        // Search for device
        ...
        break;
    case Toybox.Ant.MSG_CODE_EVENT_CRYPTO_NEGOTIATION_FAIL:
        // Data not encrypted, so handle appropriately
        ...
        break;
     case Toybox.Ant.MSG_CODE_EVENT_CRYPTO_NEGOTIATION_SUCCESS:
        // Data  encrypted, so handle appropriately
        ...
        break;
    case Toybox.Ant.MSG_CODE_EVENT_TX:
        // Update data and send out the next part of the message
        ...
    default:
        System.println("Invalid response!");
}
```

Deciding whether to use `switch` instead of `if` is often a matter of personal preference. In some cases, switch blocks may be more readable, particularly when there are a relatively large number of cases to consider. Fall through can also be a useful tool depending on the needs of a particular application.

#### Scoping in Switch Blocks

Variables declared within the switch block are scoped at the switch block level. Variables may also be enclosed by curly braces within a case block to limit scope to that case block. All variables defined at the switch block level must be initialized before being used in any subsequent `case` statements. For example:

```
switch (myValue) {
    case true:
        // Variable 'a' is scoped at the switch block level
        var a = 1;
    case 1:
        // Results in a compiler error because 'a' was not initialized in this case block
        var z = a;
        break;
    case "B": {
        // Variable 'a' is scoped at the code block level within the curly braces, so no scoping
        // conflict with 'a' at the switch block level
        var a = true;
        break;
    }
    case instanceof MyClass:
        // Results in a compiler error because 'a' has already been defined in the switch block
        var a = "Hello!"
    default:
        // No errors because 'a' was defined in the first case and initialized at the beginning of
        // the default case
        a = 0;
        var b = a;
}
```

### Loops

Monkey C supports `for`, `while`, and `do-while` loops. Loops are used to repeat statements until conditions specified by an expression are met. All loops require braces enclosing their block of statements, and single-line loops are not supported.

The `while` and `do-while` loops have a familiar syntax:

```
// A do-while loop
var myCounter = 0;
do {
    // Do something
    myCounter++;
}
while (myCounter < 10);

// A while loop
myCounter = 0;
while (myCounter < 10) {
    // Do something
    myCounter++;
}
```

Monkey C allows variable declaration in `for` loops, which also have a familiar syntax:

```
var myArray = [1, 2, 3, 4, 5];
for (var i = 0; i < myArray.size(); i++) {
    // Do something until 'i' is greater than or equal to the array size
}
```

Flow control within loops can be managed by using the `break` and `continue` statements:

```
using Toybox.System;

// This for loop should only print the values 5, 6, and 7.
for (var i = 0; i < 10; i += 1) {
    if (i < 5) {
        continue;
    }
    System.println(i);
    if (7 == i) {
        break;
    }
}
```

### Exception Handling

Monkey C supports structured Lang.Exception handling for non-fatal errors in the form of `try-catch` blocks:

```
try {
    // Attempt to execute this code
} catch (e) {
    // Catch and handle any exceptions thrown
}
```

Multiple `catch` statements are allowed to handle more than one possible exception type. When an exception is thrown, the first matching catch block will execute, and all subsequent catch blocks will be skipped (if a generic Lang.Exception handler is used, it's a good idea to place last). An optional `finally` statement can be placed at the end of a try-catch block, which will execute regardless of whether an exception has been thrown.

```
try {
    // Attempt to execute this code
} catch (e instanceof MyExceptionClass) {
    // Catch and handle the MyExceptionClass exception
} catch (e) {
    // Catch all other exception types
} finally {
    // Execute this after the preceding try and catch statements are completed
}
```

To throw an Lang.Exception, use The `throw` keyword:

```
throw new Lang.Exception();
```

If an exception is not handled, an *Unhandled Exception* error will occur at runtime. The Connect IQ API throws exceptions in a few instances instances, such as Lang.SymbolNotAllowedException and Lang.UnexpectedTypeException. Refer to the API Documentation for more details about the various Lang.Exception types.

## Functions

Functions (also called methods) are the meat of an application, defining discrete, callable units of code. They can exist in a class, module, or appear in the global module.

### Defining a Function

Monkey C functions can take arguments, but because Monkey C is a dynamically typed language, argument types are not declared. Below is a simple function that takes a single 'myValue' argument and multiplies it by two:

```
function myFunction(myValue) {
    var result = myValue * 2;
}
```

**Note:** Dynamic typing makes it easy to accidentally write functions that may not work under every circumstance. The example above works great if you provide a Number as an argument, but won't be as happy if it's passed a String. For this reason, it's often a good idea to do some basic type checking within functions to make sure functions receive what's expected.

### Returning Values From Functions

It is not necessary to declare the return value of a function, thanks to dynamic typing, but all functions in Monkey C will still return a value. A return value may be specified with a `return` keyword:

```
function myFunction(myValue) {
    var result = myValue * 2;
    return result;
}
```

The `return` statement is optional, and if a function doesn't have one, it will return a "garbage" value from the viewpoint of the caller.

### Calling Functions

To use a function or a method, simply use the function call syntax:

```
// Call myFunction() and pass it an argument of '2', but do nothing with the result
myFunction(2);

// Call myFunction(), pass it an argument of '2', and assign the result to the 'myResult' variable
var myResult = myFunction(2);
```

It is also possible to call a function or method within another function or method:

```
function myOtherFunction() {
    var result = myFunction(2);
    // Do some other stuff with the result here
}
```

## Classes and Objects

Classes are blueprints that bundle data and operations together into an instance of the class, called an *object*. Variables, functions, and other classes (often referred to as *members*) can be defined within a Monkey C class. Objects are compiled and cannot be modified at runtime, so all variables must be declared in either a local function, the class instance, or the parent module before they can be used.

### Defining Classes

A class is defined using the `class` keyword. For example, here is a simple class that defines a circle with an `mRadius` member, representing the radius of a circle:

```
class Circle {
    var mRadius;
}
```

### Creating Objects

To create an instance of a class, use the `new` keyword:

```
var myCircle = new Circle();
```

This doesn't do too much that's useful yet. However, when an object is instantiated with the `new` keyword, memory for the object is allocated and its `initialize()` method is automatically called, acting as a constructor. An `initialize()` method has been implemented in the Circle class below, which sets a radius value whenever a new Circle is created:

```
class Circle {
    var mRadius;
    function initialize(aRadius) {
        mRadius = aRadius;
    }
}

// Create a new circle with a radius of 2
var myCircle = new Circle(2);
```

If classes are nested, the outermost class must first be instantiated before and enclosed class may be instantiated.

### Accessing Class Members

Within a method implementation, the current object instance can be referred to with either the `self` or `me` keywords. These may be used for disambiguating instance variables from local variables, or simply for clarity. For example, here's the Circle class with new methods to calculate its circumference and surface area that use the `self` keyword to refer to the `mRadius` instance variable:

```
using Toybox.Math as Math;

class Circle {
    var mRadius;
    function initialize(aRadius) {
        mRadius = aRadius;
    }

    function getCircumference() {
        return 2 * Math.PI * Math.pow(self.mRadius, 2);  // 2*PI*r
    }

    function getArea() {
        return Math.PI * Math.pow(self.mRadius, 2);      // PI*r^2
    }
}
```

**Note:** Nested classes in Monkey C do not have access to the members of the enclosing class.

### Inheritance

Inheritance allows one class to be based on another class, which helps speed development time and promotes code re-use. Instead of defining entirely new classes for similar objects, new classes can inherit members from existing classes. For example, a new Sphere class can be defined that shares a lot of the same characteristics of a circle by using the `extends` keyword to inherit from the Circle class:

```
using Toybox.Math as Math;
using Toybox.System as System;

class Circle {
    var mRadius;
    function initialize(aRadius) {
        mRadius = aRadius;
    }

    function getCircumference() {
        return 2 * Math.PI * Math.pow(self.mRadius, 2);   // 2*PI*r
    }

    function getArea() {
        return Math.PI * Math.pow(self.mRadius, 2);     // PI*r^2
    }

    function describe() {
        System.println("Circle!");
    }
}

class Sphere extends Circle {
    function initialize(aRadius) {
        Circle.initialize(aRadius);
    }

    // Notice Sphere has no getCircumference() method implemented here. Instead, it inherits the
    // getCircumference() method from the Circle class and may use it as if it were its own method.

    function getArea() {
        return 4 * Math.PI * Math.pow(self.mRadius, 2);  // 4*PI*r^2
    }

    function describe() {
        System.print("I'm a Sphere! My parent is a ");
        Circle.describe();
    }
}
```

The only thing not inherited from the parent class (also called a base class or superclass) is an `initialize()` method, which must be implemented separately for Sphere. In this case, it's just calling the parent class's `initialize()` method to set a radius.

**Note:** Monkey C does not implicitly call a parent class's `initialize()` method, so child classes must explicitly call the base class constructor. Examples of this can be seen in the samples distributed with the Connect IQ SDK anywhere something like a `View` class is extended.

The `getArea()` method from the Circle class won't work for spheres, so a new `getArea()` method was also implemented to *override* the `getArea()` the method from the Circle class. Lastly, `describe()` methods were added to each class to let each object type describe itself. Let's put these classes to work:

```
// Create new objects
var myCircle = new Circle(5);
var mySphere = new Sphere(5);

System.println(myCircle.getCircumference());  // 31.415928
System.println(myCircle.getArea());           // 78.539818
myCircle.describe();                          // "Circle!"

System.println(mySphere.getCircumference());  // 31.415928 (same as a circle of the same radius)
System.println(mySphere.getArea());           // 314.159271
mySphere.describe();                          // "I'm a Sphere! My parent is a Circle!"
```

Notice the `describe()` method from Sphere calls the parent's `describe()` method directly using the parent class's symbol. The `superclass.memberMethod()` is valid in Monkey C, but the `superclass.memberVariable` syntax is not supported.

### Static Members

In some cases, certain class members need to be accessible within an object without creating an instance of an object. For example, imagine a unit conversion class that only contains unit conversion constants:

```
class Conversion {
    const FEET_PER_METER      = 3.28084;
    const MILE_PER_KILOMETER  = 0.621371;
    const TABLESPOONS_PER_CUP = 16;
    ...
}

var meters = 32;
var myConverter = new Conversion(); // Create an instance of the Conversion class
System.println(meters * myConverter.FEET_PER_METER + " feet"); // Prints "104.986877 feet"
```

Normally, it would be necessary to first create an instance of the Conversion class before using any of the members within the class, including variables, constants, enumerations, or functions. If the `static` keyword is applied to the constants, however, it's possible to use them without instantiating the Conversion class:

```
class Conversion {
    static const FEET_PER_METER      = 3.28084;
    static const MILE_PER_KILOMETER  = 0.621371;
    static const TABLESPOONS_PER_CUP = 16;
    ...
}

var meters = 32;
System.println(meters * Conversion.FEET_PER_METER + " feet"); // Prints "104.986877 feet"
```

Another advantage to static members is that they belong to the class rather than to a particular instance of the class. This means that something like a static variable can be shared between mutliple instances of class, and if its value is changed in one instance, the new value is immediately available in all instances:

```
class BananaBunch {
    static var mNumberOfBananas = 10;
}

var bunchOne = new BananaBunch();
var bunchTwo = new BananaBunch();

System.println(bunchOne.mNumberOfBananas); // 10
System.println(bunchTwo.mNumberOfBananas); // 10

bunchOne.mNumberOfBananas = 12; // Change the value of the static variable

System.println(bunchOne.mNumberOfBananas); // 12
System.println(bunchTwo.mNumberOfBananas); // 12 - notice this one also reflects the change!
```

### Data Hiding

Class members have three levels of access—*private*, *protected*, and *public*. The `private` modifier specifies that the member can only be accessed in its own class. The `protected` modifier specifies that the member can only be accessed by its own class or one of its subclasses. The `hidden` keyword is synonymous with the `protected` keyword. A `public` access modifier is the default, but it can also be explicitly specified. When the `public` access modifier is used for an enumeration, variable, or function, those members are visible to all other classes.

```
using Toybox.System as System;

class MyClass {
    protected var mVariable;
}

// This will produce a runtime error since it's trying to access a protected variable from myClass
function myFunction() {
    var myObject = new MyClass();
    System.println(myObject.mVariable);
}
```

Variables that are `public` or `protected` may be accessed using either one of the following formats:

```
var x = mMmemberVariable;
var y = self.mMemberVariable;
```

**Note:** Data hiding is only available at a class member level. Modules in Monkey C have no concept of data hiding, and classes are always public.

### Instanceof and Has

Monkey C provides two operators to do runtime type checking that need some special attention: `instanceof` and `has`. Monkey C's object-oriented design patterns in conjunction with the `has` and `instanceof` operator enables software that has implementations for many devices in a single code base.

The `instanceof` operator checks whether an object instance inherits from a given class:

```
using Toybox.System;

var value = 5;
if (value instanceof Lang.Number) {
    System.println("Value is a number");
}
```

The `has` operator checks whether a given object has a particular symbol, which may be a public method, instance variable, or even a class definition or module. For example, accelerometer data is available in Sensor.Info, but not all products have an accelerometer. Attempting to use this data on certain products may cause the app to crash with a *Symbol Not Found* error. To avoid this, the `has` operator can be used to check for accelerometer support:

```
using Toybox.Sensor as Sensor;

var sensorInfo = Sensor.getInfo();
if (sensorInfo has :accel && sensorInfo.accel != null) {
    var accel = sensorInfo.accel;
    var xAccel = accel[0];
    var yAccel = accel[1];
    System.println("x: " + xAccel + ", y: " + yAccel);
}
```

### Callbacks

Functions in Monkey C are not first class, so cannot be passed as arguments to other functions to be used as callbacks. Since functions are bound to the object in which they are created, Lang.Method objects must be used to create callbacks.

One approach is to use a combination of a function and its object instance:

```
class MyClass {
    function operation(a, b) {
        // The code here is really amazing. Like mind blowing amazing.
    }
}

function myFunction() {
    var myObject = new MyClass();                // Create a new instance of MyClass
    var myMethod = myObject.method(:operation);  // Get a callback for the "operation" method from myObject
    myMethod.invoke(1, 2);                       // Invoke myObjects's "operation" method
}
```

Unlike classes, modules do not inherit from Lang.Object so do not have access to the `method()` function. However, a new instance of Lang.Method can be created, which allows module-level functions to be invoked as callbacks in a similar fashion:

```
using Toybox.Lang as Lang;

module MyModule
{
    function operation() {
        // Some more amazing code. Only an infinite number of monkeys typing randomly over an
        // infinite period of time could write something this good.
    }
}

function myFunction() {
    var myMethod = new Lang.Method(MyModule, :operation);
    myMethod.invoke();
}
```

A Lang.Method object will invoke a method on the instance of the object it came from, and keeps a strong reference to the source object.

### Weak References

Monkey C is *reference counted*, which means the runtime system will free memory when the number of objects referencing that memory decrements to zero. Reference counting allows memory to become available very quickly, which is important in low memory environments. The kryptonite of reference counting are *circular references*. A circular reference happens when a cycle is formed in the reference chain. For example, imagine that object C references an object A, while object A references object B *and* object B references object A:

After a while, C gets invited to sit at the cool-kid table, so it dereferences A to go hang out with its *real* friends:

The memory for A and B should be freed at this point, but A and B both have a reference count of one because they reference *each other*. The memory used by A and B are now unavailable to objects from the cool-kids table, which is generally not a good thing. However, sometimes A and B really do need to reference each other. In these cases, you can use a *weak reference*, which keeps a reference to an object but does not increment the reference count. This means the object reference can be destroyed, and is a case that should be handled.

To create a weak reference, use the `weak()` method, an Lang.Object method available to all Monkey C objects.

```
// We would make a "Hans and Franz" reference here but certain advertising has probably made them uncool.
var weakReference = myObject.weak()
```

If calling `weak()` on one of the immutable types (Lang.Number, Lang.Float, Lang.Char, Lang.Long, Lang.Double, Lang.String), then it returns the object itself. Otherwise, it will return a Lang.WeakReference instance. Weak references have a `stillAlive()` method to check if a weak reference is still valid, and have a `get()` method to create a strong reference to an object:

```
if (weakReference.stillAlive()) {
    var strongReference = weakReference.get();
    strongReference.myMethod();
}
```

Remember to only keep the strong reference within the needed scope!

## Modules

Monkey C modules serve a purpose similar to Java packages, but can contain variables, functions, classes, and other modules:

```
module MyModule
{
    class MyClass {
        var mValue;
    }
    var moduleVariable;
}

function myFunction() {
    MyModule.moduleVariable = new MyModule.MyClass();
}
```

It is common for static methods to exist at the module level instead of belonging to a particular class. Unlike classes, however, modules have no concept of inheritance or data hiding (the `extends` and `hidden` keywords are not supported for modules).

### Using Statements

Modules can be imported into another class or module with the `using` keyword, scoping the module to the class or module in which they are defined.

```
using Toybox.System;

function myFunction() {
    System.print("Hello");
}
```

Modules may also be assigned an alias with the `as` clause, useful for shortening module names or when a different naming scheme is preferred:

```
using Toybox.System as Sys;

function myFunction() {
    Sys.print("Hello");
}
```

Once imported, all classes inside a module must be referenced through their parent module.

## Scoping

Monkey C is a message-passed language. When a function is called, the virtual machine searches a hierarchy at runtime in the following order to find the function:

1. Instance members of the class
2. Members of the superclass
3. Static members of the class
4. Members of the parent module, and the parent modules up to the global namespace
5. Members of the superclass's parent module up to the global namespace
6. Public static members of the parent module, and the parent modules up to the global namespace
7. Public static members of the superclass’s parent module up to the global namespace

The code below illustrates:

```
using Toybox.System;

// A globally visible function
function globalFunction() {
    System.println("This is the global function!");
}

module Parent
{
    function parentFunction() {
        System.println("This is the parent's function!");
        globalFunction();  // May call a globally visible function
    }

    class Child {
        function childFunction() {
            System.println("This is the child's function!");
            globalFunction();       // May call a globally visible function
            parentFunction();       // May call a function in our parent module
            staticChildFunction();  // May call a static function within the class

        }

        static function staticChildFunction() {
            System.println("This is the child's static function!");
            globalFunction();  // May call a globally visible function
            parentFunction();  // May call a function in our parent module
            // Static methods can't call instance methods (childFunction) but still have access to parent modules!
        }
    }
}
```

In some cases, it may be more efficient to search from the global namespace instead of the current scope with the bling symbol `$`, which refers to the global scope:

```
using Toybox.System as System;
function myFunction() {
    System.println("Hello Hello");
}

class MyClass {
    function myFunction() {
        System.println("Every time I say goodbye you say hello");
    }

    function() {
        $.myFunction();  // Call the global myFunction()
        myFunction();    // Call the instance myFunction()
    }
}
```

Using bling can improve runtime performance when referring to a global variable. Because Monkey C is dynamically typed, referencing a global variable will search your object's inheritance structure and the module hierarchy before it will eventually find the global variable. Instead, we can search globals directly with the bling symbol:

```
using Toybox.System as System;

var familyFortune = "There's always money in the banana stand.";

module BluthCompany
{
    class BananaStand {
        function getMoney() {
            // At runtime, the VM will search:
            //   1. The BananaStand
            //   2. The BananaStand's superclass, Toybox.Lang.Object
            //   3. The BluthCompany module
            //   4. The BluthCompany module's parent globals
            // ...and finally finds the family fortune!
            System.println(familyFortune);

            // This will search only the global namespace for the family fortune. Thanks bling!
            System.println($.familyFortune);
        }
    }
}
```

While Monkey C will normally search the entire object hierarchy for an object, when the bling symbol is used, only the global space is checked. If nothing is found there, the virtual machine will not traverse back down the object hierarchy looking and will instead return a *Symbol Not Found* error.

**Note:** Switch blocks have some additional scoping rules, which can be found in the Switch-Case Statements section.

## Annotations

Monkey C allows associating symbols with class or module methods and variables. Annotations are used to communicate additional intentions to the compiler, and are sometimes used to add new features without changing the Monkey C grammar. For example, Run No Evil tests require annotations to demark sections of code that are meant only for testing:

```
// A test class containing a Run No Evil test method denoted by (:test)
class TestMethods {
    (:test)
    static function testThisClass(x)
}
```

The following annotations have special meanings to the Monkey C compiler:

- ****:background****: Denotes code blocks available to the Background process.
- ****:debug****: Code blocks decorated with this annotation will not be included in release builds at compile time.
- ****:release****: Code blocks decorated with this annotation will not be included in debug builds at compile time.
- ****:test****: Denotes code blocks available to the Test module for Run No Evil tests

For reference, annotations are written into the `debug.xml` file generated in a project's 'bin' directory by the compiler when a project is built.
