# Build (compile only)

Compile `source\` + `resources\` → `bin\<project>.prg`. Does NOT launch simulator or push.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\build.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/build.sh
```

## Use when

- Checking that code compiles after an edit
- Simulator already running; you'll push manually with `monkeydo` or `run.ps1`
- CI / pre-commit check (exit code 0 = success)

## Expected outcome

- Stdout: `BUILD SUCCESSFUL`
- `$LASTEXITCODE` = 0
- `bin\<project>.prg` updated mtime (project name comes from `manifest.xml` parent folder — `_env` auto-detects it)

## On failure

- `'java' is not recognized` — `_env.ps1` JDK path wrong; see [../troubleshooting.md](../troubleshooting.md#java-is-not-recognized)
- `BUILD FAILED` with parse/type errors — fix source, re-run
- Other unexpected errors → [../troubleshooting.md](../troubleshooting.md)
