# Push (existing .prg to simulator)

Push `bin\<project>.prg` to a running simulator. Does NOT build or launch simulator.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\push.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/push.sh
```

## Use when

- You already built (via `build.ps1`) and want to deploy now
- Iterating on rendering after a recent build — skip the compile if source hasn't changed
- Simulator is already open from a prior `run.ps1`

## Prerequisites

- `bin\<project>.prg` exists (script aborts if not)
- Simulator running (script warns if not — start via `run.ps1` or open `simulator.exe` manually)

## Behavior

- Dot-sources `_env.ps1` for `JAVA_HOME` fix
- Calls `monkeydo.bat` with the .prg → uploads to simulator + streams device logs
- Blocks until Ctrl+C or simulator closes

## Claude Code invocation

Long-lived — pass `run_in_background: true`. Don't wait for exit.
