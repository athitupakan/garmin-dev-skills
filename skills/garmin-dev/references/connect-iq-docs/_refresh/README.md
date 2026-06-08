# _refresh — doc mirror tooling

Reproducible conversion of the Connect IQ SDK's bundled HTML docs into the markdown
under [reference/](../reference/) and [portal/](../portal/).

**Why this exists:** developer.garmin.com is a JS-rendered SPA (Gatsby) — WebFetch returns
nav HTML only. The same docs ship inside the installed SDK as plain HTML at `<sdk>/doc/`.
This tool converts that HTML to clean markdown so the cache is faithful and refreshable
without scraping the website.

**Requirement:** Node.js (only at refresh time — not needed to use the skill).

## Files

| File | What |
|------|------|
| `htmlmd.js` | Pure converter. `node htmlmd.js <file.html>` → markdown on stdout. Tuned for the YARD-generated API pages and the article-style guide pages. |
| `convert.js` | Batch driver. Auto-detects the newest installed SDK, regenerates the auto-converted mirror set (Reference Guides + the Toybox modules listed in its `targets` array), writes straight into `reference/`. |

## Usage

```sh
# one file → stdout (inspect or redirect)
node _refresh/htmlmd.js "%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-9.1.0-<build>\doc\Toybox\Weather.html"

# regenerate the whole auto-converted mirror set
node _refresh/convert.js

# point at a specific SDK (e.g. macOS / Linux, or an older build)
SDK="/path/to/connectiq-sdk-.../doc" node _refresh/convert.js
```

`convert.js` finds the SDK under `%APPDATA%\Garmin\ConnectIQ\Sdks` (Windows),
`~/Library/Application Support/...` (macOS), or `~/.Garmin/...` (Linux), newest build wins.

## Adding a module to the mirror

Edit the `targets` array in `convert.js`. Each entry:

```js
{ src: 'Toybox/Media.html', out: 'reference/api/media.md', url: API + 'Toybox/Media.html',
  extra: ['Toybox/Media/SomeClass.html'] }   // extra = submodule pages appended (carry the real fields)
```

`src` is relative to `<sdk>/doc/`; `out` is relative to `connect-iq-docs/`.

## After an SDK bump

1. Install the new SDK (the skill's `_env` auto-detects it at build time).
2. `node _refresh/convert.js` — regenerates every auto-converted file against the new SDK.
3. Bump `SDKVER` in `convert.js` and the "Cached against SDK" lines in the index files.
4. **Hand-curated** files (those *without* a `generated:` frontmatter line — e.g.
   `reference/api/graphics-dc.md`, all of `reference/monkey-c/`) are **not** touched by
   the batch. Re-read their new SDK HTML and fold real changes in by hand so the
   project-observed gotchas survive. See [reference/api/index.md](../reference/api/index.md).

## Limitations

Regex-based, not a DOM parser (no `jsdom`/`pandoc` dependency). Output is a faithful but
lightly-cleaned mirror — it does **not** add the curated gotchas that the hand-written
files carry. Tables, code blocks, method signatures, params/returns/since, and nested
classes convert well; very unusual nested HTML may need a manual touch-up.
