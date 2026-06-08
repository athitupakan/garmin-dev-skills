# References — Map

What's where, and when to open it.

## Layout

| Folder | Owner | When to open |
|---|---|---|
| [connect-iq-docs/](connect-iq-docs/) | **Garmin** (mirror) | Verify what the platform actually supports. Split into [reference/](connect-iq-docs/reference/) (sdk/api — version-pinned API + language) and [portal/](connect-iq-docs/portal/) (program/policy/concept docs) |
| [commands/](commands/) | us | "What does user mean by `build` / `run` / `push` / `watch` / `release` / `package`?" — dispatch contract |
| [guides/](guides/) | us | Task workflows — configurable settings, custom fonts, simulator data injection |
| [catalogs/](catalogs/) | us | Lookup tables — sensor catalog (which API → which metric) |
| [troubleshooting.md](troubleshooting.md) | us | Something broke — known errors + fixes |

## Quick navigation

- **Writing Monkey C** → [connect-iq-docs/reference/api/](connect-iq-docs/reference/api/) (Toybox) + [connect-iq-docs/reference/monkey-c/](connect-iq-docs/reference/monkey-c/) (language)
- **Making settings configurable (colors, data fields, themes)** → [guides/app-settings.md](guides/app-settings.md)
- **Adding a custom font** → [guides/custom-fonts.md](guides/custom-fonts.md)
- **Feeding sensor data to the simulator** → [guides/simulator-data.md](guides/simulator-data.md)
- **Which API gives me HR / steps / SpO2 / battery?** → [catalogs/sensors.md](catalogs/sensors.md)
- **Preparing to publish** → [connect-iq-docs/portal/submit-an-app.md](connect-iq-docs/portal/submit-an-app.md) + [connect-iq-docs/portal/app-review-guidelines.md](connect-iq-docs/portal/app-review-guidelines.md)
- **Build failed / `'java' not recognized` / simulator won't connect** → [troubleshooting.md](troubleshooting.md)

## Principle

> `connect-iq-docs/` is **what Garmin says**. Refresh from URLs.
> Everything else is **what we figured out**. Refresh by editing.

If a fact contradicts between the two, trust `connect-iq-docs/` first — then update our content if the platform has changed.
