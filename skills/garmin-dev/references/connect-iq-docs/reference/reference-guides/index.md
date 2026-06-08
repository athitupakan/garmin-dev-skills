# Reference Guides (§13)

The language / build-system / toolchain spec pages from developer.garmin.com/connect-iq/reference-guides.
Part of the 🔧 **sdk/api** bucket — version-pinned, sourced from the SDK install at `doc/docs/Reference_Guides/`.

**Cached against SDK:** 9.1.0 · **Batch:** 2026-05-30

All files here are **auto-converted mirrors** (see the `generated:` frontmatter line) — faithful, not hand-curated.

| File | Guide | What it covers |
|------|-------|----------------|
| [monkey-c-reference.md](monkey-c-reference.md) | Monkey C Language Reference | Full language spec — grammar, types, scoping, the `as` type system, operators, symbols |
| [jungle-reference.md](jungle-reference.md) | Jungle Reference | The `monkey.jungle` build language — qualifiers, build exclusions, monkey barrels, source/resource paths |
| [monkey-motion-reference.md](monkey-motion-reference.md) | Monkey Motion | Animation primitives for `WatchUi` |
| [monkey-graph-reference.md](monkey-graph-reference.md) | Monkey Graph | Charting / graph drawing helpers |
| [vscode-extension.md](vscode-extension.md) | VS Code Extension | The Monkey C extension — commands, build/run/debug, device + product management |
| [command-line-setup.md](command-line-setup.md) | Command Line Setup | Using `monkeyc` / `monkeydo` directly (the skill's scripts wrap these — see [../../../commands/](../../../commands/)) |

## Most relevant to this skill

- **[jungle-reference.md](jungle-reference.md)** — the build scripts consume `monkey.jungle`; this is its grammar.
- **[monkey-c-reference.md](monkey-c-reference.md)** — the authoritative language spec, deeper than the narrative [../monkey-c/](../monkey-c/) intro pages.

**Refresh:** `node ../../_refresh/convert.js` (see [_refresh/README.md](../../_refresh/README.md)).
**Bucket index:** [../index.md](../index.md) · **Full sitemap:** [../../index.md](../../index.md)
