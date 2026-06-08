---
source: https://developer.garmin.com/connect-iq/reference-guides/monkey-c-command-line-setup/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Reference_Guides/Monkey_C_Command_Line_Setup.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Using Monkey C from the Command Line

Before getting started with the installation on Mac or Windows, you'll need version 11 or higher of the Oracle Java™ Runtime Environment installed. Once that's done, continue on to your platform's installation instructions.

## OS X Installation

1. Install the Connect IQ SDK Manager, download the SDK, and set the active SDK.
2. Point your `PATH` to the active Connect IQ bin directory in the Terminal. To temporarily add it to a single local shell instance:

```
$ export PATH=$PATH:`cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg`/bin
```

For a more persistent addition, open `.bash_profile` in a text editor:

```
$ touch ~/.bash_profile
$ open ~/.bash_profile
```

Then add the line below to the file and save the changes:

```
export PATH=$PATH:`cat $HOME/Library/Application\ Support/Garmin/ConnectIQ/current-sdk.cfg`/bin
```

## Windows Installation

1. Install the Connect IQ SDK Manager, download the SDK, and set the active SDK.
2. Point your `PATH` to the active Connect IQ bin directory in the command prompt:

```
> for /f usebackq %i in (%APPDATA%\Garmin\ConnectIQ\current-sdk.cfg) do set CIQ_HOME=%~pi
> set PATH=%PATH%;%CIQ_HOME%\bin
```

## Linux Installation

1. Install the Connect IQ SDK Manager, download the SDK, and set the active SDK.
2. Point your `PATH` to the active Connect IQ bin directory in the command prompt:

```
$ export PATH=$PATH:`cat $HOME/.Garmin/ConnectIQ/current-sdk.cfg`/bin
```

For a more persistent addition, open `.bash_profile` in a text editor:

```
$ touch ~/.bash_profile
$ nano ~/.bash_profile
```

Then add the line below to the file and save the changes: CTRL-X

```
export PATH=$PATH:`cat $HOME/.Garmin/ConnectIQ/current-sdk.cfg`/bin
```

## Basic Commands

After installation, three new shell commands are available: `connectiq`, `monkeyc`, and `monkeydo`.

- `connectiq` launches the Connect IQ simulator, which can be used to run and test apps on your computer before running them on your device. In the simulator, your app will only have access to those APIs that are available on the currently simulated device. For example, an API only available in Connect IQ v2.2.x or higher, such as `PersistedContent`, will not be available on devices that run earlier versions of Connect IQ.
- `monkeyc` calls the Monkey C compiler. The compiler can take code from multiple files and link them together into a single Connect IQ executable (a PRG file). The usage is:

```
> monkeyc [-d <arg>] [-f <arg>] [-o <arg>] [-y <arg>]
```

| Argument | Definition |
| --- | --- |
| `-d ` | Target device |
| `-f ` | Jungle files |
| `-o ` | Output file to create |
| `-y ` | Private key to sign builds with |

**Note:** For more information on all the command line options, refer to the Compiler Options section in the Monkey C guide.

- `monkeydo` runs a Connect IQ executable in the simulator. You must have previously started the simulator with `connectiq`. The usage is:

```
monkeydo [executable] [device_id] [-n] [-t | -t test_name]
```

| Argument | Definition |
| --- | --- |
| `executable` | A Connect IQ executable (PRG) to run |
| `device_id` | The device to simulate (e.g. "fenix5plus") |
| `-n` | Runs the app in sensor native pairing mode |
| `-t` | Execute Run No Evil unit tests. Supply an optional test method or class name to only run that test or set of tests. |

Here is an example of a basic build and run cycle from the command line:

```
// Launch the simulator:
> connectiq

// Compile the executable:
> monkeyc -d fenix5plus -f /path/to/monkey.jungle -o project_name.prg -y /path/to/Dev_Key

// Run in the simulator
> monkeydo myApp.prg fenix5plus
```

**Note:** For more information on the `-f` option and the Jungle build framework, see the Overriding Resources section of this guide.

## Generating a Key Using OpenSSL

If you're working from the command line you can generate a RSA key using OpenSSL. The following command will generate a valid signing key.

```
> openssl genrsa -out developer_key.pem 4096
> openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

This developer key, `developer_key.der`, is passed to the compiler using the `-y` command line option.
