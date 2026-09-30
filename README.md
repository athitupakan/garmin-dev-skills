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

## macOS setup

Step by step from a fresh Mac (Apple Silicon or Intel). Run the commands in Terminal.

**1. Homebrew** — skip if `brew --version` already works.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. JDK 17** — the Connect IQ SDK needs exactly 17, not 21+.

```
brew install --cask temurin@17
/usr/libexec/java_home -v 17     # should print /Library/Java/JavaVirtualMachines/temurin-17.jdk/...
```

The installer asks for your Mac password (it runs a `.pkg` with `sudo`), so run it in your own terminal — or in Claude Code as `! brew install --cask temurin@17`. No `JAVA_HOME` needed — the scripts find it. (`brew install openjdk@17` also works.) If `JAVA_HOME` is already set to another version, the scripts skip it and keep searching.

**3. Connect IQ SDK**

1. Download the SDK Manager from <https://developer.garmin.com/connect-iq/sdk/> (*Accept & Download*).
2. Open the `.dmg` and copy the SDK Manager into a folder (e.g. `~/Applications`), then launch it.
3. Log in with your Garmin Connect account.
4. **SDK** tab → download the latest SDK.
5. **Devices** tab → download every device listed in your `manifest.xml` (builds fail for devices that aren't downloaded).

The SDK lands in `~/Library/Application Support/Garmin/ConnectIQ/Sdks/` — the scripts pick the newest one.

**4. Developer key** — one per developer, reused across projects. From your project root:

```
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key -nocrypt
printf 'developer_key\ndeveloper_key.pem\n' >> .gitignore
```

Keep a backup of this key outside the project — the store only accepts updates signed with the same key.

**5. Claude Code + this plugin**

```
brew install --cask claude-code
cd path/to/your-garmin-project
claude
```

Then inside Claude Code: `/plugin marketplace add athitupakan/garmin-dev-skills` and `/plugin install garmin-dev@garmin-dev-skills`.

**6. Check it works** — ask Claude *"build the watch face"*. A successful build writes `bin/<project>.prg`. Then *"run it in the simulator"*.

## Install

This repo is a Claude Code **plugin** — the `SKILL.md` lives at `skills/garmin-dev/SKILL.md` per the [Anthropic plugin spec](https://code.claude.com/docs/en/plugins). Two install modes:

### Option 1 — Plugin via marketplace (recommended)

This repo is also its own marketplace. Inside Claude Code:

```
/plugin marketplace add athitupakan/garmin-dev-skills
/plugin install garmin-dev@garmin-dev-skills
```

Persistent across sessions. Update later with `/plugin marketplace update garmin-dev-skills`.

To try it for one session without installing, clone and pass `--plugin-dir`:

```
git clone https://github.com/athitupakan/garmin-dev-skills
claude --plugin-dir ./garmin-dev-skills
```

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
| macOS (Intel + Apple Silicon) | `scripts/posix/*.sh` (Bash) | ✓ tested on Apple Silicon (macOS 26, SDK 9.2.0, Temurin 17); Intel untested |
| Linux (Ubuntu LTS officially supported by Garmin) | `scripts/posix/*.sh` (Bash) | scripts written but not yet community-tested |

If a script misbehaves on Mac or Linux, please open an issue with the failing command + error output.

## What's inside

```
.claude-plugin/
  plugin.json             plugin manifest (name, version, author, license)
  marketplace.json        makes this repo installable via /plugin marketplace add
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
