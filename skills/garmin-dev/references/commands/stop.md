# Stop (close simulator)

Close the Connect IQ simulator and any `monkeydo` log streams left running by `run` / `push` / `watch`.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\stop.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/stop.sh
```

## Use when

- The user asks to close / quit / stop the simulator
- A background `run` / `push` / `watch` was abandoned and the simulator is still open
- The simulator is hung and needs a clean restart (follow with `run`)

## Behavior

- Does **not** dot-source `_env` — needs no `manifest.xml`, works from any directory
- Kills `monkeydo` first (its `java … MonkeyDoDeux` process), then the `simulator` process
- macOS: the simulator app ignores an AppleScript quit, so the process is terminated directly (force-killed after 5s if still up)
- Prints `Simulator stopped.` or `Simulator was not running.`; always exits 0

## Claude Code invocation

Short — run foreground. Also stop any background task that was running `run` / `push` / `watch`.
