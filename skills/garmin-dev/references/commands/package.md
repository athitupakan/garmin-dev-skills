# package — `package.ps1`

Build a store-ready `.iq` package containing **every** product listed in `manifest.xml` → `bin\<project>.iq`.

This is the artifact uploaded at <https://apps.garmin.com/en-US/developer/upload>.

## Run

```powershell
# Windows
.\.claude\skills\garmin-dev\scripts\windows\package.ps1
```

```bash
# macOS / Linux
./.claude/skills/garmin-dev/scripts/posix/package.sh
```

## Prerequisite

Run [release.ps1](release.md) first and verify the release-stripped build still works in the simulator. Catches bugs introduced by `-r` optimization that debug builds never see.

## How packaging differs from release

| | release | package |
|---|---|---|
| Devices | one (`$Device`) | all from `<iq:products>` in manifest |
| Output | `.prg` | `.iq` (bundle) |
| Flags | `-r` | `-e -r` |
| Purpose | sim-verify release binary | upload to store |

The `-e` / `--package-app` flag reads device list from the manifest. **Do NOT pass `-d`** to a packaging build — it confuses the package target.

## Expected output

Console prints one `N OUT OF M DEVICES BUILT` line per product as compilation finishes. Final line on success: `PACKAGE OK -> bin\<project>.iq (NN KB)` and the upload URL.

## After packaging

Required for the store listing (see [../connect-iq-docs/portal/submit-an-app.md](../connect-iq-docs/portal/submit-an-app.md)):

1. Description — be specific
2. Screenshots — one per device family
3. Category — Watch Faces
4. Pricing — Free / Paid

Common rejection causes are documented in [../connect-iq-docs/portal/app-review-guidelines.md](../connect-iq-docs/portal/app-review-guidelines.md) — read before uploading.

## About `developer_key`

`developer_key` (referenced as `$Key` in `_env.ps1`) is the signing identity for THIS developer account. The store will refuse uploads signed by a different key than your registered account.

**Never commit `developer_key` to git.** Verify it's in `.gitignore`.
