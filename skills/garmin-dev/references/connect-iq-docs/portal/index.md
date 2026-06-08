# portal/ — program / policy / concept docs

The non-API side of developer.garmin.com: store rules, monetization, UX guidance, conceptual guides, FAQ. These describe *what the store requires* and *how to design the app* — and can change **without** an SDK bump, so they refresh on their own cadence.

## Cached

**Multi-page sections** (folder + `index.md`):
- [connect-iq-basics/](connect-iq-basics/) — §7 · 4 pages (onboarding)
- [core-topics/](core-topics/) — §9 · 44 pages, grouped into 7 categories (the guides devs actually read)
- [ux-guidelines/](ux-guidelines/) — §10 · overview + 14 sub-pages
- [personality-library/](personality-library/) — §11 · 11 pages (stock UI look-and-feel kit)
- [device-reference/](device-reference/) — §16 · 163 per-device spec pages (screen, buttons, **per-app-type memory limits**)

**Single pages:**
| File | Section | What |
|------|---------|------|
| [submit-an-app.md](submit-an-app.md) | §5 Submit an App | Upload + listing flow |
| [app-review-guidelines.md](app-review-guidelines.md) | §14 App Review Guidelines | Rejection causes — read before uploading |
| [monetization.md](monetization.md) | §15 Monetization | Pricing, trials, IAP |
| [faq.md](faq.md) | §12 FAQ | Common questions |

## Not yet cached

Everything in the portal taxonomy is now cached except the **online-only** pages (not shipped in the SDK): Overview (§1), Compatible Devices (§2 — live matrix), Get the SDK (§4 — download page), Stay Informed (§6 — blog/news). Fetch those from the URL when needed.

## vs. the reference/ bucket

[../reference/](../reference/) is the version-pinned technical reference (Toybox API, Monkey C language, toolchain spec). When *what the API does* contradicts *what the store requires*, both are right — they answer different questions.

**Full portal sitemap (all 16 sections):** [../index.md](../index.md)
