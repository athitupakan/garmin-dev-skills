---
source: https://developer.garmin.com/connect-iq/core-topics/debugging/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Debugging.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Testing and Debugging

Connect IQ has a couple of different methods for testing and debugging your apps:

1. Basic debugging with `println()` statements
2. Using the Visual Studio Code debugger
3. Using the command line debugger (`mdd`)

## Basic Debugging

One way to test Connect IQ apps is to include System.println() statements at strategic points in your app. Within Visual Studio Code, these System.println() statements will output to the console. On a device, System.println() statements write to an `.TXT file` in the `/GARMIN/APPS/LOGS` directory in the device file system.

These log files are not automatically created, so they must be manually created on the device and named to match the name of the app's corresponding `PRG` file. For example, to log output from `/GARMIN/APPS/MYAPP.PRG`, you must create `/GARMIN/APPS/LOGS/MYAPP.TXT`.

## Debugging with Visual Studio Code

To begin debugging your application select *Run > Start Debugging*. Make sure you have a source file from the project you wish to debug open in the editor. After selecting the product you want to debug, the app will launch in debug mode in the simulator. Debugging is only supported while running an application on the Connect IQ simulator.

### Setting a Breakpoint

Like other projects in Visual Studio Code, to set a breakpoint in the Monkey C editor, highlight a line in the vertical ruler next to the source code and click to set a breakpoint.

### Viewing Application Status

When your application hits a breakpoint, you can examine the runtime state in *Run and Debug*. The *Variables* view allows you to see your arguments and locals, while the *Call Stack* allows you to see state at different stack frame.

When your application suspends while debugging you will be prompted to open the native *Debug* perspective. From here, you can view the stack trace within the native Debug view. Clicking on a stack frame within the stack trace will populate the native Variables view with the applicable variables at that stack frame. Global variables will only be visible in the top stack frame; they appear as the `$` variable within that stack frame.

## Debugging with the Command Line

`mdd` is the Monkey C command line debugger. Modeled after `gdb`, `mdd` allows you to load your executables, set breakpoints, and examine stack frames, local variables, and the global environment.

### Getting Started

Make sure you have followed the "Getting Started" instructions to set up the command line environment. Before you begin, start the simulator:

```
> simulator &
[1] 27984
> mdd
```

You will be greeted with the following:

```
Connect IQ Version 3.2.0. Type "help" for more information.
(mdd)
```

Help is always available from the command line prompt:

```
(mdd) help
List of classes of commands:

breakpoints -- Making program stop at certain points.
data -- Examining data.
running -- Running the program.
stack -- Examining the stack.
status -- Status inquiries.
support -- Support facilities.

Type "help" followed by a class name for a list of commands in that class.
Type "help all" for the list of all commands.
Type "help" followed by a command name for full documentation.
Command name abbreviations are allowed if defined.
```

### Loading and Running an Executable

To load an executable into `mdd`, you need the `prg`, the debug XML and the product the `prg` is built for. If you compile your `prg` using the `monkeyc` command, the `debug.xml` will also be generated, and Visual Studio Code typically outputs these files in the `bin` folder of your project.

You use the `file` command to load these into the `mdd` environment.

```
(mdd) file MyFace.prg MyFace.prg.debug.xml fenix6
```

Now you can run the executable using the `run` command:

```
(mdd) r
Starting app: C:\Projects\ciq-apps\strava\bin\Strava.prg
```

### Setting Breakpoints

Breakpoints can be assigned to a file/line pair with the `break` command:

```
(mdd) break \path\to\Thx.mc:1138
```

Execution will pause when your program executes that line:

```
Hit breakpoint 1, initialize () at Thx.mc:1138
(mdd)
```

### Frame Information

You can inquire about your current stack frame using `info frame`:

```
(mdd) info frame
Stack level 0, frame at 0x10002120
 in initialize() at Thx.mc:1138
 called by frame at 0x10000b48
 Args:
      self = <0x84> (Thx)
 Locals:
      thx = null
      sen = null
```

You can also use the `print` command to output variables as well as expressions.

```
(mdd) print thx
thx = null
```

### Controlling Execution

You can step to the next line using the `next` command:

```
(mdd) next
```

The `step` command will step into a subroutine:

```
(mdd) step
```

The `continue` command will return to full execution until the next breakpoint is set or the app terminates:

```
(mdd) continue
```

## Handling Crashes

Despite the best debugging efforts, crashes will sometimes happen. There are two general types of on-device crash that can occur related to Connect IQ, which each generate log files: *app crashes* and *device crashes*.

### App Crashes

App crashes typically result in an app quitting unexpectedly or displaying an 'IQ!' icon, but does not cause the entire device to crash or reboot. This kind of crash is most commonly due to a bug in an app, though it can also be due to a bug in Connect IQ itself. Whenever an app crash occurs, a `CIQ_LOG.YAML` file is written or updated to `/GARMIN/APPS/LOGS` on the device, and contains information related to the crash that app developers may use to address the problem. Here is what a CIQ_LOG generally looks like:

```
Error: ErrorName
Details: Error description.
Time: 2018-02-07T19:07:56Z
Store-Id: 00000000-0000-0000-0000-000000000000
Store-Version: 0
Device-Id: 006-B0000-00
Device-Version: '0.00'
ConnectIQ-Version: 3.0.0
Filename: PRGNAME
Appname: DemoAppName
Stack:
  - pc: 0x100000ef
    File: 'C:\Path\To\source\File.mc'
    Line: 53
    Function: function_causing_error
  - pc: 0x10000080
    File: 'C:\Path\To\source\File2.mc'
    Line: 30
    Function: otherBrokenItems
```

The `ConnectIQ-Version` entry is not the Connect IQ version of the device. Rather, this refers to the SDK version used by the developer when exporting the application.

**Note:** For devices before API level 3.0.0, a simplified error log will be printed as `CIQ_LOG.TXT`.

### Device Crashes

Device crashes typically cause the device to reboot or freeze. These indicate a Connect IQ or device firmware bug, and should be much less common than app crashes. When a device crash occurs, an `ERR_LOG.txt` file is written to `/GARMIN` on the device, containing stack trace information related to the crash. Please provide this file when reporting a crash on our developer forum. Garmin's device teams can take a look at the device crash logs to determine the cause of the crash and will typically provide a fix in a future firmware release.

### A Note About Log Files

When any log file on a device exceeds 5kb in size, it will automatically be archived to `.BAK`, and a new log will be started. Any old `.BAK` files will be overwritten when the archive occurs, so the max space a log can reach is around 10kb.
