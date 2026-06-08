# release — `release.ps1`

Compile a release-stripped build for the active device → `bin\<project>-release.prg`.
Single device, single .prg. Does **not** push.

Use to verify the optimized binary still runs in the simulator **before** packaging for the store.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\release.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/release.sh
```

## Why test release before packaging

The `-r` / `--release` flag strips debug info AND lets the compiler optimize more aggressively. This is exactly the build the store ships. Release builds can break in ways debug builds never see:

- **Type pruning** — code reachable only from debug paths gets eliminated. If anything was relying on side effects in those paths, it disappears.
- **Latent null/type errors** — debug builds tolerate some sloppy types via runtime checks; release strips those.
- **Aggressive inlining** — exposes ordering assumptions that the debug build's slower dispatch hid.

So: always `release.ps1` + push + verify in sim FIRST. Only then [package.ps1](package.md).

## Output naming

Output is intentionally distinct from `bin\<project>.prg` (the debug build) so [push.ps1](push.md) / [run.ps1](run.md) — which target the debug `$Prg` — don't accidentally push the release binary on the next dev-loop iteration.

## Pushing the release build to the simulator

`push` targets `$Prg` (the debug name). To push the release binary, invoke `monkeydo` directly:

```powershell
# Windows
. .\.claude\skills\garmin-dev\scripts\windows\_env.ps1
& "$Sdk\bin\monkeydo.bat" "bin\$Project-release.prg" $Device
```

```bash
# macOS / Linux
. ./.claude/skills/garmin-dev/scripts/posix/_env.sh
"$Sdk/bin/monkeydo" "bin/${Project}-release.prg" "$Device"
```

(Long-lived — pass `run_in_background: true` in PowerShell / Bash tool calls.)

## On failure

- Type errors that pass in debug → almost always a missing null guard. Fix in source.
- Other unexpected errors → [../troubleshooting.md](../troubleshooting.md)
