---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Time/Gregorian.html
fetched: 2026-05-23
sdk: 9.1.0
---

# Toybox.Time.Gregorian

Calendar-based `Moment` / `Duration` factory + extracted calendar fields (`Gregorian.Info`).

## Constants

| Group | Constants |
|-------|-----------|
| Seconds per unit | `SECONDS_PER_MINUTE` (60), `SECONDS_PER_HOUR` (3600), `SECONDS_PER_DAY` (86400), `SECONDS_PER_YEAR` (31557600) |
| Days | `DAY_SUNDAY` (1) → `DAY_SATURDAY` (7) |
| Months | `MONTH_JANUARY` (1) → `MONTH_DECEMBER` (12) |

## Module functions

### `moment(options) → Time.Moment`
Build a `Moment` in **UTC** from calendar fields.
Options dict: `:year` (1970–2106), `:month` (1–12 or `:january`…), `:day` (1–31), `:hour` (0–23), `:minute` (0–59), `:second` (0–59). Omitted fields inherit from `today()`.

### `duration(options) → Time.Duration`
Build a `Duration` from familiar units. Options: `:years` (≤69), `:days` (≤24855), `:hours` (≤596523), `:minutes` (≤35791394), `:seconds` (≤2147483647).

### `info(moment, format) → Gregorian.Info`
Extract calendar fields in **local time**. `moment` = `Time.Moment` or `Time.LocalMoment`. `format` = `Time.FORMAT_SHORT` / `FORMAT_MEDIUM` / `FORMAT_LONG`.

### `utcInfo(moment, format) → Gregorian.Info`
Same as `info()` but **UTC**.

### `localMoment(location, moment) → Time.LocalMoment | null`
Create a `LocalMoment` with timezone + DST from a `Position.Location`. Returns `null` if timezone resolution fails.

## Gregorian.Info fields

| Field | Type | Meaning |
|-------|------|---------|
| `year` | Number | Calendar year |
| `month` | Number or String | Month — see format table below |
| `day` | Number | Day of month (1–31) |
| `day_of_week` | Number or String | Day — see format table below |
| `hour` | Number | 0–23 |
| `min` | Number | 0–59 |
| `sec` | Number | 0–59 |

## ⚠️ Format behavior (observed, contradicts docs)

| Format | `day_of_week` | `month` | Use case |
|--------|---------------|---------|----------|
| `FORMAT_SHORT` | **Number** (1=Sun … 7=Sat) | **Number** (1=Jan … 12=Dec) | **Locale-independent** — pair with hardcoded `DAY_NAMES`/`MONTH_NAMES` arrays |
| `FORMAT_MEDIUM` | String (locale-dependent: "Sat", "ส.") | String ("May", "พ.ค.") | **Don't use unless you have a font with the device locale's glyphs.** |
| `FORMAT_LONG` | String, long ("Saturday") | String, long ("May") | Same locale caveat. |

**Our pattern (in `Format.mc`):**

```monkey-c
var info = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
var dayName = DAY_NAMES[info.day_of_week - 1];    // "SAT"
var monName = MONTH_NAMES[info.month - 1];         // "MAY"
```

## Gotchas

- `info()` returns local time; `utcInfo()` returns UTC — different hour for the same `Moment`.
- `moment()` overlays values on today — omitted fields inherit current date.
- `localMoment()` needs valid GPS location; returns `null` if timezone resolution fails (e.g., first boot, no GPS lock).
- For Watch Face current time, use `Time.now()` not `today()` — `now()` includes time-of-day, `today()` is midnight.
