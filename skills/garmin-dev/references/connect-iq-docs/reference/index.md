# reference/ — sdk/api bucket

Version-pinned **technical** reference: the API, the language, and the toolchain spec. Everything here is sourced from the installed Connect IQ SDK (`doc/`), so it always matches the toolchain that compiles your `.prg`.

**Cached against SDK:** 9.1.0 (build `connectiq-sdk-win-9.1.0-2026-03-09`)

| Folder | What | SDK source |
|--------|------|------------|
| [api/](api/) | Toybox module reference (`Graphics.Dc`, `System`, `Sensor`, …) | `doc/Toybox/<Module>.html` |
| [monkey-c/](monkey-c/) | Monkey C **language** — syntax, types, memory, exceptions | `doc/docs/Monkey_C/<Topic>.html` |
| [reference-guides/](reference-guides/) | Jungle Reference · Monkey C Reference (full spec) · Monkey Motion · Monkey Graph · CLI setup · VSCode extension | `doc/docs/Reference_Guides/<Guide>.html` |

See each folder's `index.md` for the cached file list and what's still fetch-on-demand.

## vs. the portal/ bucket

`reference/` is *what the API does* and *how the language works* — pinned to one SDK version.
[../portal/](../portal/) is *what the store requires* and *how to design the app* — program/policy/concept docs that can change without an SDK bump.

**Refresh:** on SDK bump — re-convert from the new SDK's `doc/`. The website versions are JS-rendered (Gatsby SPA) and unreadable via WebFetch; always source from the SDK install.

**Full portal sitemap (all 16 sections):** [../index.md](../index.md)
