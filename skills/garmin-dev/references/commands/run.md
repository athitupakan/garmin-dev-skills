# Run (full cycle: simulator + compile + push)

For the **first run of a session** or after closing the simulator.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\run.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/run.sh
```

The script is idempotent — re-running mid-session just skips the simulator launch if it's already up.

## What it does

1. Ensures `bin\` exists
2. Launches simulator if not already running (Windows: 2-sec boot buffer; POSIX: via `bin/connectiq`, waits up to 30s for the `simulator` process, then 3s more)
3. Compiles → `bin\<project>.prg`
4. Pushes via `monkeydo` — **blocks** while streaming device logs

## Caveats

- **Step 4 blocks** the terminal. `monkeydo` is streaming `System.println` output. Not a hang — Ctrl+C to stop.
- If `monkeydo` errors immediately with a connection issue → simulator hasn't fully booted. Wait for the simulator window to render, then re-run.
- Simulator window title should read: `CIQ Simulator - <your device> (<firmware version>)` — the device name comes from your `manifest.xml` `<iq:product>` entry

## Claude Code invocation

Long-lived — pass `run_in_background: true` in the PowerShell tool call. Do not wait for exit.

## Re-pushing after edits

- Manual: Ctrl+C → re-run `run.ps1` (or just `build.ps1` + `monkeydo` yourself)
- Auto: stop `run.ps1`, switch to [watch.md](watch.md)
