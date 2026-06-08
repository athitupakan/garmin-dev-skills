# Watch (auto-rebuild + re-push on file change)

Polls `source\` + `resources\` every 2s. On change → kill old monkeydo → rebuild → push fresh.

**Status: experimental.** Connect IQ has no official hot reload — this script approximates it.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\watch.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/watch.sh
```

## Prerequisites

- Simulator already running ([run.ps1](run.md) once first, or manually open it)
- `bin\` exists (script creates it if missing)

## What it does

1. Initial build + push as a background `Start-Job`
2. Loops every 2s checking file mtimes in `source\` + `resources\`
3. On change: stop old monkeydo job → re-compile → start new monkeydo job
4. On Ctrl+C: `try/finally` cleans up the background job

## Caveats

- **2-second poll latency** — rebuild starts up to 2s after Ctrl+S. Acceptable for watch face dev.
- **Device logs hidden** — `monkeydo` runs as a background job, so `System.println` doesn't appear in this terminal. To see logs: `Receive-Job <job-id> -Keep`, or use `run.ps1` instead.
- **Rapid saves** — if you save twice within one build cycle, the second change may be missed. Save once, wait for `PUSHED`, save again.
- **Simulator must stay open** — closing it kills monkeydo's socket; the next push fails silently. Re-run `run.ps1` to recover.

## When to prefer `run.ps1` instead

- You want to see device logs (debugging with `System.println`)
- You're doing fewer than ~3 builds in a sitting (re-running run.ps1 manually is fine)
