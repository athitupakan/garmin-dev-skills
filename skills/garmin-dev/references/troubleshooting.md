# Troubleshooting

Known errors and fixes. Most apply across all 3 OS — Windows-specific or POSIX-specific notes are flagged.

---

## `'java' is not recognized` *(Windows)* / `java: command not found` *(POSIX)* {#java-is-not-recognized}

**Cause:** JDK 17 not found on PATH. `_env` auto-detects JDK from common install locations, but none matched.

**Diagnose:**

```powershell
# Windows
. .\.claude\skills\garmin-dev\scripts\windows\_env.ps1
Test-Path "$env:JAVA_HOME\bin\java.exe"  # must be True
```

```bash
# macOS / Linux
. ./.claude/skills/garmin-dev/scripts/posix/_env.sh
test -x "$JAVA_HOME/bin/java" && echo OK
```

If `_env` throws on load with the "JDK 17 not found" message, install or expose JDK 17:

| OS | Recommended install |
|----|---------------------|
| Windows | Microsoft OpenJDK 17 — <https://learn.microsoft.com/java/openjdk/download>. Installer puts it at `C:\Program Files\Microsoft\jdk-17.*` where `_env.ps1` will find it automatically. |
| macOS | `brew install openjdk@17` — follow brew's symlink instructions so it lands in `/Library/Java/JavaVirtualMachines/`. |
| Linux | `sudo apt install openjdk-17-jdk` (Debian/Ubuntu) or your distro's equivalent. |

**Manual override (any OS):** set `JAVA_HOME` to a valid JDK 17 root before running any script. `_env` uses it if set + valid.

---

## `BUILD FAILED` with no compiler error shown

**Cause:** usually a missing resource (drawable, layout, string) referenced from Monkey C but not in `resources/`.

**Fix:** scroll up in the `monkeyc` output for the first `ERROR:` line. Common ones:

- `ERROR: Resource not found 'Rez.Strings.X'` → add to `resources/strings/strings.xml`
- `ERROR: Resource not found 'Rez.Drawables.X'` → add to `resources/drawables/drawables.xml` + ship the bitmap
- `ERROR: Could not parse 'monkey.jungle'` → check syntax. Path separator is `;` on Windows, `:` on macOS / Linux.

---

## `monkeydo` exits immediately with connection error

**Cause:** simulator not running, or not yet finished booting.

**Diagnose + fix:**

```powershell
# Windows
Get-Process simulator -ErrorAction SilentlyContinue          # is sim running?
.\.claude\skills\garmin-dev\scripts\windows\run.ps1          # re-launches sim + push
```

```bash
# macOS / Linux
pgrep -x simulator                                            # is sim running?
./.claude/skills/garmin-dev/scripts/posix/run.sh              # re-launches sim + push
```

If still failing, increase the `Start-Sleep 2` (Windows) or `sleep 2` (POSIX) in the `run` script to 4–5 seconds — slow machines need more time for the sim to bind its IPC socket.

---

## `monkeydo` blocks the terminal forever

**Not a bug.** `monkeydo` streams device logs while the app runs. Ctrl+C to stop, or close the simulator.

---

## Source edits don't appear in the simulator

**Cause:** `monkeydo` push happens once at start. Simulator does not auto-reload when `.prg` is rebuilt.

**Fix:** stop monkeydo (Ctrl+C) → re-run `run` or `build` + manual `monkeydo`. Or use the `watch` script for auto re-push:

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\watch.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/watch.sh
```

---

## `The system cannot find the file specified` / `No such file or directory` on `bin/<project>.prg`

**Cause:** `bin/` doesn't exist (fresh checkout, or got deleted).

**Fix:** all scripts auto-create `bin/` — just re-run them. Or manually:

```powershell
New-Item -ItemType Directory bin   # Windows
```

```bash
mkdir -p bin                       # POSIX
```

---

## SDK version mismatch / wrong SDK picked

`_env` auto-detects the **newest** installed `connectiq-sdk-<os>-*` directory under Garmin's install root. If you have multiple SDKs and want to pin to an older one, set `$Sdk` (PowerShell) or `Sdk` (Bash) before sourcing `_env`, or comment out the auto-detect block and hardcode it.

To check what SDK is currently active:

```powershell
# Windows
Get-Content "$env:APPDATA\Garmin\ConnectIQ\current-sdk.cfg"
```

```bash
# macOS
cat "$HOME/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg"
# Linux
cat "$HOME/.Garmin/ConnectIQ/current-sdk.cfg"
```

After an SDK bump, also verify `manifest.xml` `minApiLevel` still matches the device firmware you target.

---

## Device firmware → Connect IQ API level

`manifest.xml` declares `minApiLevel="X.Y.Z"`. The simulator (and a real device) must run firmware ≥ `X.Y.Z` for that device id. In the simulator: **Settings → Device** to check the active firmware version.

---

## `manifest.xml not found` when running scripts

**Cause:** running scripts from a folder other than the project root. `_env` parses `manifest.xml` from cwd for `$Device`.

**Fix:** `cd` to the project root (where `manifest.xml`, `monkey.jungle`, `developer_key` live) before invoking any script.

---

## POSIX: `permission denied` running scripts/posix/*.sh

**Cause:** execute bit lost on git checkout (common on Windows-side commits).

**Fix:**

```bash
chmod +x .claude/skills/garmin-dev/scripts/posix/*.sh
```

To preserve the exec bit in git going forward:

```bash
git update-index --chmod=+x .claude/skills/garmin-dev/scripts/posix/*.sh
```

---

## Linux: simulator fails to launch with Qt library errors

**Cause:** Garmin officially supports Ubuntu LTS. Other distros may be missing Qt runtime libraries.

**Fix (Debian/Ubuntu family):**

```bash
sudo apt install libxcb-xinerama0 libxcb-cursor0
```

For other distros, install the equivalent `xcb-xinerama` / `xcb-cursor` packages.
