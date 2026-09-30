# CLAUDE.md — maintainer guide for the `garmin-dev-skills` repo

**Scope:** This file is for editing **this repo** (the skill source). It is loaded only when
Claude Code runs with this repo as the working directory. It does **not** affect end-users of
the skill — they run Claude in their own Garmin project, where this file is never seen. The
skill's runtime behavior lives entirely in [skills/garmin-dev/SKILL.md](skills/garmin-dev/SKILL.md)
+ `references/`. Put *runtime* rules there; put *how-to-maintain-the-repo* rules here.

## What this repo is

A Claude Code **plugin** shipping one skill, `garmin-dev`, that helps build / run / package
Garmin Connect IQ apps (watch faces, data fields, widgets, device apps) on Windows / macOS / Linux.
Users install it as a plugin (`--plugin-dir` / marketplace) or copy `skills/garmin-dev/` into
their project's `.claude/skills/`. Either way the skill loads via `SKILL.md`'s `description`.

- Repo: <https://github.com/athitupakan/garmin-dev-skills>  ·  Plugin/skill name: `garmin-dev` (intentionally different from the repo name)
- Everything skill-related lives under `skills/` (single-skill layout — no category folder). Root holds only `.claude-plugin/{plugin,marketplace}.json`, `README.md`, `LICENSE`, `.gitignore`, `.gitattributes`, and this file.
- The repo is its own marketplace (`marketplace.json`, plugin `source: "./"`). Users update via `/plugin marketplace update`, which only sees a new release when `version` in `plugin.json` changes — **bump it on every user-facing change**.
- Validate before committing: `claude plugin validate .` (the CLAUDE.md-not-loaded warning is expected).

## Layout

```
skills/garmin-dev/
  SKILL.md                       runtime contract: dispatch table + operating rules
  scripts/{windows,posix}/       build/run/push/watch/release/package + _env (SDK/JDK auto-detect)
  references/
    commands/ guides/ catalogs/  OUR content (behavior contracts, workflows, lookups)
    troubleshooting.md
    connect-iq-docs/             MIRROR of developer.garmin.com — split into two buckets:
      reference/                 🔧 sdk/api, version-pinned: api/ (Toybox) · monkey-c/ · reference-guides/
      portal/                    📄 program/policy/concept: basics, core-topics, ux, faq, store rules
      _refresh/                  HTML→markdown tooling (htmlmd.js + convert.js)
      index.md                   sitemap of all 16 Garmin portal sections + cache status
```

## Doc cache: the two-bucket model

`connect-iq-docs/` mirrors Garmin's docs, split by **source + refresh cadence**:

- **`reference/`** — pinned to the SDK toolchain. Source = the installed SDK's `doc/` HTML
  (the website is a JS SPA that WebFetch can't read). Refresh on SDK bump.
- **`portal/`** — program/policy/concept docs. Can change without an SDK bump.

### Two kinds of doc file — check the frontmatter before editing

- **Hand-curated** (NO `generated:` line): condensed + annotated with project-observed gotchas
  that contradict the official docs (e.g. `api/graphics-dc.md`, all of `monkey-c/`). These are
  the skill's real value. **Never overwrite blindly** — re-read the new SDK HTML and fold changes
  in by hand so the gotchas survive.
- **Auto-converted mirror** (`generated:` line present): faithful full conversion of SDK HTML via
  `_refresh/htmlmd.js`. Safe to regenerate/overwrite.

## Common maintenance tasks

**Add or refresh an auto-converted doc:** edit the `targets` array in
[`skills/garmin-dev/references/connect-iq-docs/_refresh/convert.js`](skills/garmin-dev/references/connect-iq-docs/_refresh/convert.js)
(`src` = path under SDK `doc/`; `out` = path under `connect-iq-docs/`; `extra` = submodule pages
to append — that's where the real fields/methods live), then:
```
node skills/garmin-dev/references/connect-iq-docs/_refresh/convert.js   # auto-detects newest SDK
```
Then add the new file to the relevant `index.md` table.

**Refresh everything after an SDK bump:**
1. Install the new SDK (the skill's `_env` auto-detects it at build time — nothing to hardcode).
2. Re-run `convert.js`.
3. Bump `SDKVER` in `convert.js` + the "Cached against SDK" lines in the `index.md` files.
4. Hand-fold real changes into the **curated** files (they're not touched by the batch).

**Convert one file ad-hoc:** `node .../_refresh/htmlmd.js <file.html>` → markdown on stdout.

**Move/rename a doc:** update every cross-link, then run the link checker:
```
node -e 'const fs=require("fs"),p=require("path");function w(d){let r=[];for(const e of fs.readdirSync(d,{withFileTypes:true})){const q=p.join(d,e.name);e.isDirectory()?r=r.concat(w(q)):e.name.endsWith(".md")&&r.push(q);}return r;}let bad=0;for(const f of w("skills/garmin-dev")){for(const m of fs.readFileSync(f,"utf8").matchAll(/\]\(([^)]+)\)/g)){let l=m[1].split("#")[0];if(!l||/^(https?:|mailto:)/.test(l))continue;if(!fs.existsSync(p.resolve(p.dirname(f),l))){bad++;console.log("BROKEN",f,"->",m[1]);}}}console.log(bad+" broken");'
```

## Conventions / guardrails

- **Scripts stay path-free.** `_env.ps1` / `_env.sh` auto-detect SDK + JDK at runtime — never
  hardcode a per-machine path. JDK 17 specifically (SDK 9.x requirement); keep the `jdk-17*` globs
  and the version regex in sync if Garmin moves to a newer JDK.
- **Parallel script sets.** Any change to a `windows/*.ps1` must have the matching `posix/*.sh`
  change, and vice-versa. Same for the per-command contracts in `references/commands/`.
- **Line endings** are enforced by `.gitattributes`: `.sh`=LF (bash breaks on CRLF), `.ps1`=CRLF,
  `.md`/`.json`/`.js`=LF. Don't fight the CRLF warning on dotfiles — it's cosmetic.
- **Don't put runtime skill rules here.** They belong in `SKILL.md` so they load for users.
- **Cite the reference file** when documenting SDK behavior; prefer SDK-sourced facts over memory.
