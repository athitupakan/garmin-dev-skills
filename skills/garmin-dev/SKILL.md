---
name: garmin-dev
description: Build, run, package, and ship Garmin Connect IQ apps (watch face, data field, widget, device app) on Windows/macOS/Linux, AND answer Connect IQ development questions from a cached mirror of Garmin's official docs. Auto-detects SDK + JDK + project name + target device from manifest.xml — no per-machine config. Invoke when the user asks to build, compile, run in the simulator, push, watch, package a .iq, or build a release binary; to troubleshoot Monkey C build errors ('java not recognized', 'BUILD FAILED', simulator not found, monkey.jungle parse errors, missing developer_key, manifest.xml issues); OR asks how to implement a Connect IQ feature, how a Toybox API or Monkey C construct works, or what a device supports — e.g. configurable colors / data fields / themes, on-device vs phone settings, sensors, location, weather, storage, glances, backgrounding, complications, AOD, custom fonts, permissions, the jungle build, or store / publishing rules. For any such question, find and read the relevant cached reference under references/connect-iq-docs/ FIRST (navigate its indexes — do not guess a path), cite it, and only then analyze the user's code; the docs hold platform and device constraints that code analysis misses.
---

# garmin-dev

Cross-platform workflow for compiling, running, and packaging Connect IQ apps — **plus a cached mirror of Garmin's official docs to ground every API / how-to answer in what the platform actually allows.**

**OS support:** Windows (PowerShell 5.1+) · macOS (Bash, Apple Silicon + Intel) · Linux (Bash, Ubuntu LTS officially supported by Garmin)

## How dispatch picks the right script

The skill ships parallel script sets — one per OS family. Detect OS first, then invoke the matching command:

| OS | Detect via | Script set |
|----|-----------|-----------|
| Windows | `$env:OS = "Windows_NT"` (or `$PSVersionTable.Platform = "Win32NT"`) | `scripts/windows/*.ps1` |
| macOS | `uname -s` returns `Darwin` | `scripts/posix/*.sh` |
| Linux | `uname -s` returns `Linux` | `scripts/posix/*.sh` |

Every script auto-detects SDK + JDK at runtime — no per-machine path config needed. Every script reads `manifest.xml` from cwd for project name + device id, so **always invoke from the project root** (not from the skill folder).

## Layout

```
scripts/
  windows/                   PowerShell — Windows
    _env.ps1                 shared: auto-detect SDK + JDK, parse manifest.xml
    build.ps1                compile only (debug)
    push.ps1                 push existing .prg
    run.ps1                  sim + compile + push
    watch.ps1                auto-rebuild on save
    release.ps1              release-stripped build for one device
    package.ps1              .iq package for all manifest products
  posix/                     Bash — macOS + Linux
    _env.sh                  shared: OS-aware paths, JDK chain, manifest parse
    build.sh, push.sh, run.sh, watch.sh, release.sh, package.sh

references/                  all docs the skill consults
  index.md                   map: what's where, when to open it
  connect-iq-docs/           MIRROR of developer.garmin.com/connect-iq
    reference/               sdk/api — version-pinned: api/ (Toybox) + monkey-c/ + reference-guides/
    portal/                  program/policy/concept docs: basics, core-topics, ux, faq, store rules
  commands/                  per-command behavior contract
  guides/                    task workflows (custom fonts, simulator data)
  catalogs/                  curated lookups (sensor catalog)
  troubleshooting.md         known errors + fixes
```

## Dispatch

| User intent | Windows | macOS / Linux | Notes |
|-------------|---------|---------------|-------|
| Start a new project (watch face / data field / widget / app) | — | — | [connect-iq-docs/portal/connect-iq-basics/your-first-app.md](references/connect-iq-docs/portal/connect-iq-basics/your-first-app.md) — created via VS Code *Monkey C: New Project*; no CLI generator exists |
| Compile only | `scripts\windows\build.ps1` | `scripts/posix/build.sh` | [commands/build.md](references/commands/build.md) |
| Push existing .prg | `scripts\windows\push.ps1` | `scripts/posix/push.sh` | [commands/push.md](references/commands/push.md) |
| First run of session | `scripts\windows\run.ps1` | `scripts/posix/run.sh` | [commands/run.md](references/commands/run.md) |
| Auto-rebuild on save | `scripts\windows\watch.ps1` | `scripts/posix/watch.sh` | [commands/watch.md](references/commands/watch.md) |
| Test release build in sim | `scripts\windows\release.ps1` | `scripts/posix/release.sh` | [commands/release.md](references/commands/release.md) |
| Build store-ready `.iq` | `scripts\windows\package.ps1` | `scripts/posix/package.sh` | [commands/package.md](references/commands/package.md) |
| Publish / submit to store / "will it pass app review?" | — | — | [connect-iq-docs/portal/submit-an-app.md](references/connect-iq-docs/portal/submit-an-app.md) + [app-review-guidelines.md](references/connect-iq-docs/portal/app-review-guidelines.md) |
| Connect IQ developer docs (API / language / store policy) | — | — | [connect-iq-docs/index.md](references/connect-iq-docs/index.md) |
| Add a custom .fnt font | — | — | [guides/custom-fonts.md](references/guides/custom-fonts.md) |
| Inject sensor data into simulator | — | — | [guides/simulator-data.md](references/guides/simulator-data.md) |
| Make settings configurable (colors, data fields, themes) | — | — | [guides/app-settings.md](references/guides/app-settings.md) |
| Native UI components (toast, confirmation, progress bar, prompt, page loop) | — | — | [connect-iq-docs/portal/personality-library/index.md](references/connect-iq-docs/portal/personality-library/index.md) |
| Look up which sensor API gives metric X | — | — | [catalogs/sensors.md](references/catalogs/sensors.md) |
| Error or unexpected behavior | — | — | [troubleshooting.md](references/troubleshooting.md) |

The script paths above are relative to this skill's own folder. When dispatching, expand to the absolute path on the user's machine — the location depends on install mode:
- **Standalone** install: `<workspace>/.claude/skills/garmin-dev/scripts/<os>/<script>`
- **Plugin** install (`--plugin-dir` or marketplace): plugin install dir + `/skills/garmin-dev/scripts/<os>/<script>`

Either way, run the script from the user's **project root** (where `manifest.xml` lives), not from the skill folder.

## Claude Code invocation

- `build.ps1` / `build.sh` and `release.ps1` / `release.sh` exit when compile finishes — run foreground.
- `run.ps1` / `run.sh`, `push.ps1` / `push.sh`, `watch.ps1` / `watch.sh` are **long-lived** (block on `monkeydo` log stream). Pass `run_in_background: true` in the PowerShell / Bash tool call; do not wait for exit.

## About `_env`

`_env.ps1` (Windows) and `_env.sh` (POSIX) are dot-sourced by every other script. They handle:

- **JDK detection** — uses `JAVA_HOME` if set + valid, else searches common install paths per OS. Throws a clear error with install instructions if nothing found.
- **SDK detection** — picks the newest `connectiq-sdk-<os>-*` directory in Garmin's standard install location. Throws if none found.
- **Project name** — defaults to `$(basename pwd)` lowercased. Override by editing line 1 of `_env` if you want a different binary name.
- **Device id** — parsed from `manifest.xml` first `<iq:product>` entry.

Result: no per-machine paths anywhere in `_env`. The same file works on every user's machine.

## Operating rules

- **Answer Connect IQ questions by retrieval, not recall — follow this procedure (it is what makes the skill right for *any* question, not just pre-mapped ones).** Do this BEFORE reading the user's source code:
  1. **Shortlist from the indexes (cheap) — never invent a path.** Start at [connect-iq-docs/index.md](references/connect-iq-docs/index.md), then drill into the matching section index: [portal/connect-iq-basics/index.md](references/connect-iq-docs/portal/connect-iq-basics/index.md) (starting a new project, app types, jungle intro), [portal/core-topics/index.md](references/connect-iq-docs/portal/core-topics/index.md) (44 concept guides), [reference/api/index.md](references/connect-iq-docs/reference/api/index.md), [reference/monkey-c/index.md](references/connect-iq-docs/reference/monkey-c/index.md), [reference/reference-guides/index.md](references/connect-iq-docs/reference/reference-guides/index.md), [portal/ux-guidelines/index.md](references/connect-iq-docs/portal/ux-guidelines/index.md) (UX design *principles* — when/why), [portal/personality-library/index.md](references/connect-iq-docs/portal/personality-library/index.md) (stock UI *components* — how to show a toast / confirmation / progress bar / prompt), [portal/device-reference/index.md](references/connect-iq-docs/portal/device-reference/index.md), [portal/index.md](references/connect-iq-docs/portal/index.md) (store/publishing/policy, monetization, FAQ), plus our [guides/index.md](references/guides/index.md) and [catalogs/sensors.md](references/catalogs/sensors.md). Pick the **2–4 files** whose one-line descriptions best fit the user's words. Weight the user's **exact Garmin terms** heavily — proper nouns like *"Data Color"*, *"Accent Color"*, *"Glance"*, *"Complication"* point straight at the feature that defines them.
  2. **Verify by reading — do NOT trust the index blurb or a quick-map.** Open the shortlisted files and read them; confirm each against what the user literally said *and* their context (target device from `manifest.xml`, app type). A quick-map / topic-guide entry is only a *candidate to verify*, never the answer.
  3. **Rank and compare.** Decide which file actually answers it, and watch for two candidates that both look plausible but lead to **different answers** (e.g. *Watch Face Configurations* vs *App Settings* — same goal, different feature, different device support).
  4. **Decide:** clear winner → answer + cite the file · two diverge materially → present the distinction and route by the user's device/context · **all weak or genuinely ambiguous → ask the user** ("Do you mean A, B, or C?") rather than guess. A "file not found" means you fabricated a path instead of reading an index — go back to step 1.
  5. **Only now read the user's source**, grounded in the doc. The docs hold platform and device constraints that code analysis cannot reveal.
  6. **Separate fact from inference — this is where most wrong answers come from.** State only what you can point to in a doc; mark anything you deduce as an inference, not a fact. Never assert a device or feature limitation you cannot cite — quote the doc, verify it, or ask. Take the user's stated facts at face value: if they say a downloaded app already configures on their device, that is evidence the device supports *some* configuration path — engage it, don't explain it away. Do **not** manufacture a plausible-sounding reason to justify a conclusion you jumped to.
- **Never invoke `monkeyc` / `monkeydo` / `monkeyc.bat` / `monkeydo.bat` directly.** Always go through `scripts/<os>/<command>` — `_env` auto-detects SDK + JDK + project + device, and direct invocation skips all of that.
- **After any rendering change: build → push → verify visually in the simulator.** Type checking and unit tests verify code correctness, not feature correctness. If the simulator is unavailable, say so explicitly — do not claim success.
- **Cite the reference file when answering SDK questions.** E.g. *"per [references/connect-iq-docs/reference/api/graphics-dc.md](references/connect-iq-docs/reference/api/graphics-dc.md), `Dc.drawArc` truncates Float silently."* Recalling from memory is unreliable — the cache documents project-observed gotchas that contradict the official docs.
- **Doc tiers — use the right layer, in order.** Concept / how-to / "what can it do / when to use" → `connect-iq-docs/portal/core-topics/` (start here — e.g. native UI widgets like Menu2/Picker live in [native-controls.md](references/connect-iq-docs/portal/core-topics/native-controls.md), settings in [properties-and-app-settings.md](references/connect-iq-docs/portal/core-topics/properties-and-app-settings.md)). `connect-iq-docs/reference/api/*.md` is a **condensed** class + enum list — for exact method signatures (params, returns, options dicts) read the **full** API reference: the SDK's `doc/Toybox/.../<Class>.html` (identical content to developer.garmin.com/connect-iq/api-docs, shipped local with the SDK). Don't infer a signature from the condensed `.md` or from memory — open the full page.
- **Check [references/catalogs/sensors.md](references/catalogs/sensors.md) before claiming a sensor API exists.** The catalog includes the *"NOT available"* walled-garden list (Sleep Score, HRV Status, Training Load) with workarounds.
- **Handle null / absent values explicitly, and keep the layout stable.** Sensor and profile values can be null; pick a placeholder and make sure the layout does not shift when a value is missing. (The exact placeholder is a project design choice — not the skill's to mandate.)
- **Never commit `developer_key`.** It's the per-developer signing identity; the store rejects uploads signed by a different key.
- **Never write to the user's CLAUDE.md or to memory from this skill.** Project name + device come from `manifest.xml`; SDK + JDK are auto-detected. There is no skill-managed config that needs remembering.

## When NOT to use this skill

- **Inventing the visual/creative design** — what the face should *look* like, the aesthetic, the brand feel. The skill answers the *technical* how (which API, what the platform permits, the resource/setting wiring) grounded in the cached docs; it does not choose the look for you.
- **Garmin platforms outside Connect IQ** — BaseCamp, Express, fitness-equipment SDKs, etc. Different toolchains.
- **Connect IQ Mobile SDK (iOS / Android companion apps).** Separate SDK with its own build flow.
- **Editing the SDK itself.** This skill consumes the SDK; it does not modify it.

## Worked example — diagnosing a render bug

User: *"BUILD SUCCESSFUL but the time field looks chopped off on the right."*

1. **Verify build status.** Read [commands/build.md](references/commands/build.md) — `BUILD SUCCESSFUL` confirms compile passed. Rendering bugs are runtime, not compile-time. Move on.
2. **Re-push and observe.** Run `scripts/windows/run.ps1` (or `scripts/posix/run.sh`) — push to sim, confirm the symptom visually. Yes, the right edge of the time digits is missing.
3. **Consult the API reference for the relevant call.** Read [connect-iq-docs/reference/api/graphics-dc.md](references/connect-iq-docs/reference/api/graphics-dc.md) for `dc.setColor` / `drawText` semantics.
4. **Spot the cause.** The code called `setColor(fg, COLOR_BLACK)` before `drawText`. The bg argument fills the **full font bounding box** — not just the glyph silhouette — so it black-rectangles anything drawn earlier in that bbox area. This is a known SDK gotcha worth flagging in the project's own CLAUDE.md if the user hasn't yet.
5. **Fix.** Change to `setColor(fg, COLOR_TRANSPARENT)`.
6. **Re-build + re-push + verify in sim.** Right edge of time is intact.
7. **Done.**

The skill's value: dispatching the right tool (`run.ps1`) + pointing at the right reference (`reference/api/graphics-dc.md`). The diagnosis is the user's domain knowledge plus the cached gotcha — neither comes from skill defaults.

## Worked example — applying the retrieval procedure

User: *"How do I make the colors / which data field shows configurable?"*

1. **Shortlist from the indexes.** The request can map to **more than one** Connect IQ feature. Scan the section indexes and shortlist the candidates — weight the user's exact terms, but do not conclude yet.
2. **Read the candidates — not just the index blurbs.** Each names a real mechanism with its **own availability conditions** (which device / API level / app type) and its own wiring. Note where they agree and where they diverge.
3. **Bring in context, separating fact from inference.** Read the target from `manifest.xml`. Then check what the docs *actually say* about that device or feature: if a doc states the condition, quote it; if the docs are silent (e.g. a device page doesn't mention the feature), that is an **inference, not a fact** — flag it as such.
4. **Decide or ask.** If one mechanism clearly fits both the user's words and their device → answer and cite it. If the candidates diverge and you cannot confirm which the user means, or whether their device qualifies → **present the options and ask**, rather than picking one. Do **not** invent a requirement (e.g. a hardware constraint that no doc states) to force a single answer.
5. **Only then read the user's code**, grounded in the confirmed mechanism. Build → push → verify in the sim.

> This example shows the **method** — it deliberately reaches **no fixed answer**, because the right one depends on the actual device and on confirming the user's intent. Don't lift a conclusion from an example; run the steps for the case in front of you.

## Per-OS notes

- **Windows:** `Get-Process simulator` for sim check. `Start-Sleep 2` after launch. JDK chain: `JAVA_HOME` → `~/.jdks` → Microsoft → Eclipse Adoptium → Oracle Java.
- **macOS:** `pgrep -x simulator` for sim check. Sim launched via `open -a`. JDK chain: `JAVA_HOME` → `/Library/Java/JavaVirtualMachines/*-17*` → Homebrew `openjdk@17`.
- **Linux:** Same Bash scripts as macOS. JDK chain: `JAVA_HOME` → `/usr/lib/jvm/java-17-*` → `/opt/jdk-17*`. Garmin officially supports Ubuntu LTS — other distros may need extra Qt libraries (`libxcb-xinerama0`, etc.) for the simulator.

When in doubt about a per-OS edge case, fall through to [troubleshooting.md](references/troubleshooting.md).
