# garmin-dev

A Claude Code skill for building, running, and packaging Garmin Connect IQ apps — watch faces, data fields, widgets, device apps — on **Windows, macOS, and Linux**.

Auto-detects Connect IQ SDK + JDK + project name + target device. **No per-machine config.**

---

## What this is

A *skill* is a folder Claude Code loads to extend its capabilities for a specific domain. When you ask Claude *"build the watch face"* or *"push to the sim"*, the `garmin-dev` skill dispatches the right script for your OS and points Claude at cached Connect IQ documentation.

You don't run anything directly. Claude does. Your workflow stays:

> *"please build and push to the sim"*
> *"diagnose why monkeydo says connection refused"*
> *"package the .iq for the store"*

## Prerequisites

| | Required |
|---|---|
| **JDK 17** | Microsoft OpenJDK, Eclipse Temurin, or equivalent. Set `JAVA_HOME` if installed outside standard locations. |
| **Connect IQ SDK** | Install via [Garmin's SDK Manager](https://developer.garmin.com/connect-iq/sdk/). The skill picks the newest installed SDK automatically. |
| **Developer key** | File `developer_key` in your project root, generated via the SDK Manager. Used to sign builds. Add to `.gitignore`. |
| **Garmin project** | Standard layout — `manifest.xml`, `monkey.jungle`, `source/`, `resources/` at the project root. |
| **Claude Code** | <https://docs.claude.com/en/docs/claude-code> |

## Install

This repo is a Claude Code **plugin** — the `SKILL.md` lives at `skills/garmin-dev/SKILL.md` per the [Anthropic plugin spec](https://code.claude.com/docs/en/plugins). Two install modes:

### Option 1 — Plugin (recommended)

Clone the repo anywhere, then point Claude Code at it:

```
git clone https://github.com/athitupakan/garmin-dev-skills
claude --plugin-dir ./garmin-dev-skills
```

The skill loads under the namespace `garmin-dev`. Session-scoped — re-pass `--plugin-dir` next session, or pin it to a marketplace for persistent install.

### Option 2 — Standalone skill (copy into your project)

If you don't want the plugin overhead, copy just the skill folder into your project:

```
# from your project root
git clone https://github.com/athitupakan/garmin-dev-skills /tmp/garmin-dev-repo
cp -r /tmp/garmin-dev-repo/skills/garmin-dev .claude/skills/
```

Claude Code auto-loads any skill at `.claude/skills/<name>/SKILL.md`. No namespacing — invoked simply by intent ("build the watch face").

Then in Claude Code: *"build the watch face."* Claude detects your OS, dispatches the right script, and proceeds.

## Supported OS

| OS | Script set | Status |
|----|-----------|--------|
| Windows 10 / 11 | `scripts/windows/*.ps1` (PowerShell 5.1+) | ✓ developed against |
| macOS (Intel + Apple Silicon) | `scripts/posix/*.sh` (Bash) | scripts written but not yet community-tested |
| Linux (Ubuntu LTS officially supported by Garmin) | `scripts/posix/*.sh` (Bash) | scripts written but not yet community-tested |

If a script misbehaves on Mac or Linux, please open an issue with the failing command + error output.

## What's inside

```
.claude-plugin/
  plugin.json             plugin manifest (name, version, author, license)
LICENSE
README.md                 this file
skills/
  garmin-dev/             the skill itself
    SKILL.md              what Claude reads — dispatch table, operating rules
    scripts/
      windows/            PowerShell — Windows
      posix/              Bash — macOS + Linux
    references/
      index.md            map: what's where, when to open it
      connect-iq-docs/    local mirror of developer.garmin.com/connect-iq
        reference/        sdk/api (version-pinned): api/ (Toybox) · monkey-c/ · reference-guides/
        portal/           program/policy/concept docs: basics, core-topics, ux, faq, store rules
      commands/           per-command behavior contract
      guides/             task workflows (custom fonts, simulator data injection)
      catalogs/           curated lookups (sensor catalog + walled-garden list)
      troubleshooting.md  known errors + fixes
```

For the full dispatch table and operating rules, see [skills/garmin-dev/SKILL.md](skills/garmin-dev/SKILL.md).

## How auto-detection works

`_env.ps1` (Windows) and `_env.sh` (POSIX) are dot-sourced by every script. They detect:

- **JDK** — uses `JAVA_HOME` if set + valid, else searches standard install locations per OS. Throws a clear error with install instructions if nothing found.
- **SDK** — picks the newest `connectiq-sdk-<os>-*` directory under Garmin's install root.
- **Project name** — defaults to your project folder name, lowercased. Becomes the `.prg` / `.iq` filename. Override at line 1 of `_env` if you want a different binary name.
- **Device** — parsed from the first `<iq:product>` entry in your `manifest.xml`.

Nothing is hardcoded per machine. The skill works the same on every contributor's setup.

## Documentation cache

`references/connect-iq-docs/` is a local mirror of <https://developer.garmin.com/connect-iq/> — API reference, Monkey C language docs, store submission rules. Cached because developer.garmin.com is a JS-rendered SPA that WebFetch can't read, and for offline access. See [skills/garmin-dev/references/connect-iq-docs/index.md](skills/garmin-dev/references/connect-iq-docs/index.md) for the full sitemap and refresh procedure.

`references/catalogs/sensors.md` adds two things you can't get from Garmin docs:

- **Wearer-priority tier grouping** — what to surface on a watch face, organized by what matters to the person wearing it (Body → Activity → Device)
- **Walled garden list** — metrics Garmin tracks but **does not** expose to Connect IQ (HRV Status, Training Load, Sleep Score, etc.) with workarounds where they exist

## License

MIT — see [LICENSE](LICENSE).
