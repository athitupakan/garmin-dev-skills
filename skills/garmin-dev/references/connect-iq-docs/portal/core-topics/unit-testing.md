---
source: https://developer.garmin.com/connect-iq/core-topics/unit-testing/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Unit_Testing.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Unit Testing

The Connect IQ SDK has Run No Evil, an automated unit testing framework found in the Test module. Run No Evil operates only within the Connect IQ simulator and provides the ability to add asserts and unit test methods to your app.

## Asserts

Asserts are a useful way to check for conditions at critical points in your code and will always execute when your app is launched in the simulator. For example, if your app always expects the value of x and y to not be equal:

```
import Toybox.Test;

function onShow() {
  var x = 1;
  var y = 1;
  // Prints an error to the console when x and y are equal
  Test.assertNotEqualMessage(x, y, "x and y are equal!");
}
```

The code above produces the following output in the console when the app is run in the Simulator:

```
Device Version 0.1.0
Device id 1 name "A garmin device"
Shell Version 0.1.0
ASSERTION FAILED: x and y are equal!
```

Assert code requires no special compiler commands to execute within the simulator, and are removed by the compiler when building release code. Run No Evil has four different assert flavors:

| Function | Description |
| --- | --- |
| Test.assert() | Assert throws an exception if the test is false |
| Test.assert() | Assert throws an exception and outputs a message if the test is false |
| Test.assertNotEqual() | Throws an exception if value1 and value2 are not equal |
| Test.assertNotEqualMessage() | Throws an exception and outputs a message if value1 and value2 are not equal |

## Unit Tests

Unit tests are a great way to check discrete pieces of your app for pass/fail criteria. Each test is run independently, so if a test fails or causes a crash, the test will be marked as a failed test and the next test will automatically be executed. This allows an entire suite of tests to be run with a single command in an automated fashion.

Unit tests are written mostly like any other class, module, or function in Monkey C, but have the following requirements:

- Tests methods must be marked with the `:test` annotation
- Test methods must take a Test.Logger object
- Tests methods that are not global (part of a test class or custom test module) must be static methods

Here is a simple example of a unit test method:

```
// Unit test to check if 2 + 2 == 4
(:test)
function myUnitTest(logger as Logger) as Boolean {
  var x = 2 + 2; logger.debug("x = " + x);
  return (x == 4); // returning true indicates pass, false indicates failure
}
```

The unit tests include a handy logger with different logging levels for more meaningful error reporting. The sample code above uses a "debug" logging level, but the Logger contains a total of three logging levels that can be used to distinguish between different types of errors in your unit test output:

- Logger.debug()
- Logger.warning()
- Logger.error()

While unit tests are defined in program source code, they are not included in debug or release executables.

### Running Unit Tests from the Monkey C Extension

The Monkey C Extension Test Explorer provides a powerful user interface for executing unit tests on your application. You can initiate the test explorer by clicking on the test tube icon on the left. When you start the test explorer, it will enumerate all tests in the code and list them by the module and class they belong to. You can configure which products you want to test by right clicking on an element and selecting *Configure Devices*.

Hitting the play button on a list element will run that test or the collection of tests contained by that element. The test output will be directed to the *Test Results* tab next to the terminal section.

### Running Unit Tests from the Command Line

If you want to run unit tests on your application, build the app with the `--unit-test` flag on the build command to compile with unit tests. It's usually easiest to copy and paste the build command from the Visual Studio Code console and add the unit test flag. Then use the `connectiq` script in your SDK's bin directory to launch the simulator from the terminal (no arguments required), and use the `monkeydo` script in your SDK's bin directory with the `/t` flag to run the app with unit tests enabled - `monkeydo.bat path\to\projects\bin\MyApp.prg /t`

You may also supply a function name after `/t` to run the test associated with a single function. The sample unit test above produces the following output in the console:

```
Device Version 0.1.0
Device id 1 name "A garmin device"
Shell Version 0.1.0
\------------------------------------------------------------------------------
Executing test myUnitTest…
DEBUG (14:16): x = 4
Pass
==============================================================================
RESULTS
Test:              Status:
myUnitTest           Pass
Ran 1 test
PASSED (failures=0, errors=0)
Connection Finished
Closing shell and port
```

If you want to run tests in your monkey barrel, you can use the `barreltest` script. It supports the same options as the compiler, but can output a PRG that can be used by the test system.

Unit test code will not execute unless the compiler is explicitly told to run unit tests. All test code is automatically removed at compile time when your app is exported for use on devices.
