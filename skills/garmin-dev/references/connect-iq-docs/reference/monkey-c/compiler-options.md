---
source: doc/docs/Monkey_C/Compiler_Options.html
sdk: 9.1.0
---

# `monkeyc` Compiler Options

## Common flags

| Short | Long | Arg | Purpose |
|-------|------|-----|---------|
| `-d` | `--device` | device id | **Required** for device build. e.g. `instinct3amoled50mm` |
| `-e` | `--package-app` | — | Output an `.iq` package (for app store) instead of `.prg` |
| `-f` | `--jungles` | `:`-separated paths | **Required**. Path to `monkey.jungle`. |
| `-g` | `--debug` | — | Include debug output |
| `-h` | `--help` | — | Print help |
| `-k` | `--profile` | — | Include profiler info; analyze in simulator |
| `-l` | `--typecheck` | `0`/`1`/`2`/`3` | Off / Gradual / Informative / Strict (see [monkey-types.md](monkey-types.md)) |
| `-o` | `--output` | file path | **Required**. Output `.prg` or `.iq` path |
| `-O` | `--optimization` | `0`/`1`/`2`/`3` + optional `p`/`z` | None / Basic / Fast / Slow + Performance / Code-space focus. Default `1` debug, `2` release. e.g. `-O 2pz` |
| `-r` | `--release` | — | No debug info in PRG |
| `-t` | `--unit-test` | — | Include unit tests in build |
| `-v` | `--version` | — | Print compiler version |
| `-w` | `--warn` | — | Show build warnings (off by default) |
| `-y` | `--private-key` | path | **Required**. Path to developer key |

## Debug logging (for filing bugs)

| Option | Arg | Description |
|--------|-----|-------------|
| `--debug-log-level` | `0`–`3` | Errors / Basic / Intermediate / Verbose |
| `--debug-log-output` | path | Log file path |
| `--debug-log-device` | device id | Limit to one device (when building Barrel) |

⚠ Higher levels include more source detail in the log — limit to `1` if sharing externally.

## Feature toggles

| Option | Purpose |
|--------|---------|
| `--disable-api-has-check-removal` | Stop optimizer from removing `has` checks |
| `--disable-v2-opcodes` | Use older opcode set |

## Private (usually auto-set)

| Short | Long | Arg |
|-------|------|-----|
| `-a` | `--apidb` | api.db path |
| `-b` | `--apimir` | api.mir path |
| `-i` | `--import-dbg` | api.debug.xml path |
| `-p` | `--project-info` | projectInfo.xml path |
