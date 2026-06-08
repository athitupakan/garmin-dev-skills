# Connect IQ Developer Docs — Local Mirror

Local cache of <https://developer.garmin.com/connect-iq/>, organized to mirror the official site.

**Cached against SDK:** 9.1.0 (build `connectiq-sdk-win-9.1.0-2026-03-09`)
**Last full refresh:** 2026-05-27

This folder is **what Garmin published**. Workflow guides, dispatch contracts, and curated lookups live elsewhere in `references/` — they are **our** content.

## Two buckets

The mirror is split by **source** and **refresh cadence** — not just topic:

| Bucket | Folder | What | Source | Refresh when |
|--------|--------|------|--------|--------------|
| 🔧 **sdk/api** | [reference/](reference/) | Toybox API · Monkey C language · Reference Guides (Jungle, Monkey C Reference, Monkey Motion/Graph) | **SDK install** — version-pinned to the toolchain that builds your `.prg` | SDK bump |
| 📄 **portal** | [portal/](portal/) | Program / policy / concept docs — Basics, Core Topics, UX Guidelines, FAQ, store rules, monetization | **developer.garmin.com** (most are also shipped in the SDK install) | independent of SDK — policy can change any time |

Rule of thumb: **technical / language / API → `reference/`. Conceptual / policy / program → `portal/`.**
If a fact contradicts between the two buckets, trust `reference/` for *what the API does* and `portal/` for *what the store requires*.

## How to use this folder

- **Writing Monkey C code** → [reference/api/](reference/api/) (Toybox modules) and [reference/monkey-c/](reference/monkey-c/) (language)
- **Language / jungle / toolchain spec** → [reference/reference-guides/](reference/reference-guides/)
- **Conceptual guides / how-to** → [portal/connect-iq-basics/](portal/connect-iq-basics/), [portal/core-topics/](portal/core-topics/) (44 articles), [portal/ux-guidelines/](portal/ux-guidelines/)
- **Preparing to publish** → [portal/submit-an-app.md](portal/submit-an-app.md), [portal/app-review-guidelines.md](portal/app-review-guidelines.md), [portal/monetization.md](portal/monetization.md)
- **General questions** → [portal/faq.md](portal/faq.md)
- **A section is not here** → see the sitemap below; not cached = fetch from the SDK install (preferred) or the URL

### Topic shortcuts (candidates to verify — *not* answers)

These are **starting candidates**, not the answer. **Open the file and confirm it matches the user's exact words + target device before relying on it** — follow the retrieval procedure in [SKILL.md](../../SKILL.md) (Operating rules: shortlist → read → compare → decide/ask). For anything not in this short list, shortlist via the section indexes (core-topics, api, …) below.

| The user asks… | Read |
|---|---|
| Configurable colors / **Data Color** / **Accent Color** / data fields / themes | [../guides/app-settings.md](../guides/app-settings.md) — lays out the two mechanisms (on-device editor [editing-watch-faces-on-device.md](portal/core-topics/editing-watch-faces-on-device.md) vs phone App Settings [properties-and-app-settings.md](portal/core-topics/properties-and-app-settings.md)) and their device conditions. Verify which applies to the target — don't assume |
| Which API gives metric X (HR, steps, Body Battery, SpO2) | [../catalogs/sensors.md](../catalogs/sensors.md) |
| Drawing / colors / text / arcs | [reference/api/graphics-dc.md](reference/api/graphics-dc.md) |
| Background service · glance · complication | [portal/core-topics/backgrounding.md](portal/core-topics/backgrounding.md) · [portal/core-topics/glances.md](portal/core-topics/glances.md) · [portal/core-topics/complications.md](portal/core-topics/complications.md) |
| Manifest / permissions / jungle build | [portal/core-topics/manifest-and-permissions.md](portal/core-topics/manifest-and-permissions.md) · [reference/reference-guides/jungle-reference.md](reference/reference-guides/jungle-reference.md) |
| Per-device specs / memory limits | [portal/device-reference/](portal/device-reference/) |

## Sitemap (mirrors Garmin's portal)

Each section is tagged with its bucket and cache status. Cached pages link to local files; uncached pages link to garmin.com.

| § | Section | Bucket | Cached |
|---|---------|--------|--------|
| 1 | [Overview](https://developer.garmin.com/connect-iq/overview/) | 📄 portal | online only |
| 2 | [Compatible Devices](https://developer.garmin.com/connect-iq/compatible-devices/) | 📄 portal | online only (live matrix) |
| 3 | API Docs → [reference/api/](reference/api/) | 🔧 sdk/api | partial — see [reference/api/index.md](reference/api/index.md) |
| 4 | [Get the SDK](https://developer.garmin.com/connect-iq/sdk/) | 📄 portal | online only (download page) |
| 5 | Submit an App → [portal/submit-an-app.md](portal/submit-an-app.md) | 📄 portal | ✓ |
| 6 | [Stay Informed](https://developer.garmin.com/connect-iq/stay-informed/) | 📄 portal | online only (blog/news) |
| 7 | Connect IQ Basics → [portal/connect-iq-basics/](portal/connect-iq-basics/) | 📄 portal | ✓ (4) |
| 8 | Monkey C → [reference/monkey-c/](reference/monkey-c/) | 🔧 sdk/api | ✓ — see [reference/monkey-c/index.md](reference/monkey-c/index.md) |
| 9 | Core Topics → [portal/core-topics/](portal/core-topics/) | 📄 portal | ✓ (44, grouped) |
| 10 | User Experience Guidelines → [portal/ux-guidelines/](portal/ux-guidelines/) | 📄 portal | ✓ (overview + 14) |
| 11 | Personality Library → [portal/personality-library/](portal/personality-library/) | 📄 portal | ✓ (11) |
| 12 | Connect IQ FAQ → [portal/faq.md](portal/faq.md) | 📄 portal | ✓ |
| 13 | Reference Guides → [reference/reference-guides/](reference/reference-guides/) | 🔧 sdk/api | see [reference/reference-guides/index.md](reference/reference-guides/index.md) |
| 14 | App Review Guidelines → [portal/app-review-guidelines.md](portal/app-review-guidelines.md) | 📄 portal | ✓ |
| 15 | Monetization → [portal/monetization.md](portal/monetization.md) | 📄 portal | ✓ |
| 16 | Device Reference → [portal/device-reference/](portal/device-reference/) | 📄 portal | ✓ (163) |

### Core Topics (§9) + UX Guidelines (§10) — now cached

Full per-page listings live in the section indexes: [portal/core-topics/index.md](portal/core-topics/index.md) (44 articles, grouped into 7 categories) and [portal/ux-guidelines/index.md](portal/ux-guidelines/index.md) (overview + 14 sub-pages). Connect IQ Basics (§7) → [portal/connect-iq-basics/index.md](portal/connect-iq-basics/index.md).

Personality Library (§11) → [portal/personality-library/index.md](portal/personality-library/index.md) · Device Reference (§16, 163 devices) → [portal/device-reference/index.md](portal/device-reference/index.md). The whole portal taxonomy is now cached except the **online-only** pages (§1 Overview, §2 Compatible Devices, §4 Get the SDK, §6 Stay Informed).

## App types Garmin watches can run

1. **Watch Faces** — always-on watch faces. Drawing toolkit, custom fonts, bitmaps.
2. **Widgets** — quick-glance cards in the main carousel.
3. **Data Fields** — custom data displays during recorded activities. ANT+ sensors, FIT recording.
4. **Device Apps** — full apps. GPS, sensors, BLE, OAuth, FIT files.
5. **Audio Content Provider Apps** — sync third-party audio/music to the device.

## External resources

- **Apps store (consumer-facing):** <https://apps.garmin.com>
- **Developer forums:** <https://forums.garmin.com/developer/connect-iq>
- **Developer blog:** <https://forums.garmin.com/developer/connect-iq/b/news-announcements>
- **Brand guidelines:** <https://developer.garmin.com/brand-guidelines/overview/>
- **Connect IQ Developer Agreement (legal):** <https://developer.garmin.com/downloads/connect-iq/sdks/agreement.html>
- **Contact:** <https://www.garmin.com/en-US/forms/developercontactus/>

## How to refresh

Almost everything in this mirror ships inside the installed SDK as **plain HTML** — no network needed. Source it from there, not from the JS-rendered website (which WebFetch can't read).

**SDK doc root** (Windows; auto-detected by `_env.ps1`):
```
%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-<build>\doc\
```

| Bucket / section | SDK HTML source |
|------------------|-----------------|
| 🔧 Toybox API (§3) | `doc/Toybox/<Module>.html` |
| 🔧 Monkey C language (§8) | `doc/docs/Monkey_C/<Topic>.html` |
| 🔧 Reference Guides (§13) | `doc/docs/Reference_Guides/<Guide>.html` |
| 📄 Connect IQ Basics (§7) | `doc/docs/Connect_IQ_Basics/*.html` |
| 📄 Core Topics (§9) | `doc/docs/Core_Topics/*.html` |
| 📄 UX Guidelines (§10) | `doc/docs/User_Experience_Guidelines/*.html` |
| 📄 App Review / Monetization / FAQ / Personality (§11–15) | `doc/docs/App_Review_Guidelines/`, `Monetization/`, `Connect_IQ_FAQ/`, `Personality_Library/` |
| 📄 Device Reference (§16) | `doc/docs/Device_Reference/*.html` |

**Online-only** (not in the SDK — fetch from the URL when needed): Overview (§1), Compatible Devices (§2), Get the SDK (§4), Stay Informed (§6). `submit-an-app` (§5) is prerendered into its page HTML and can be WebFetched directly.

For each cached file, read its source HTML, strip HTML, write condensed markdown — match the curated style of the existing files (signatures + gotchas, not a raw dump).

### Refresh checklist after an SDK bump

1. Confirm `_env.ps1` resolves the new SDK path (runtime auto-detect already handles this).
2. Re-convert 🔧 [reference/](reference/) — API, Monkey C, Reference Guides — from the new SDK's `doc/`.
3. Spot-check 📄 [portal/submit-an-app.md](portal/submit-an-app.md) and [portal/app-review-guidelines.md](portal/app-review-guidelines.md) for policy changes (these can change without an SDK bump).
4. Update the "Cached against SDK" build line at the top of this file.
