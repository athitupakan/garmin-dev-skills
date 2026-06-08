---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/UserProfile.html
fetched: 2026-05-24
sdk: 9.1.0
---

# Toybox.UserProfile

Static user data set in the Connect IQ companion app: birth year, gender, height, weight, HR zones, FTP, sport-specific thresholds.

API Level 1.0.0+. **Requires `<iq:uses-permission id="UserProfile"/>` in manifest.xml.**

## Core functions

### `getProfile() → UserProfile.Profile`
The full user profile. Object itself is non-null, but individual fields can be `null`/`0` if the user hasn't filled them in.

```monkey-c
var p = UserProfile.getProfile();
var by = p.birthYear;
```

### `getHeartRateZones(sport) → Array<Number>` and `getHeartRateZones2(sport) → Array<Number>?`
Returns 6 thresholds defining 5 zones. `2` variant takes `Activity.Sport` enum; original takes `UserProfile.SportHrZone`.

```
[ min_zone_1, max_zone_1, max_zone_2, max_zone_3, max_zone_4, max_zone_5 ]
   ^---- zone 1 floor               ^---- zone 4 top, zone 5 floor
```

API 1.2.6+ (`getHeartRateZones`), 3.2.0+ (`getHeartRateZones2`, nullable).

### `getCurrentSport() → SportHrZone` / `getCurrentSport2() → [Sport, SubSport]`
Which sport's zones are currently active.

### `getFunctionalThresholdPower(sport) → Number?`
Cycling FTP (watts). API 3.2.0+.

### `getPowerZones(sport) → Array<Number>?`
Power thresholds (watts). API 3.2.0+.

### `getUserActivityHistory() → UserActivityHistoryIterator`
Past activity history. Rare on watch face.

## UserProfile.Profile — fields

| Field | Type | Notes |
|-------|------|-------|
| `birthYear` | `Number` | 4-digit year (`0` if unset) — we compute age = currentYear − birthYear |
| `gender` | `Gender` enum | `GENDER_MALE` / `GENDER_FEMALE` / `GENDER_UNSPECIFIED` (4.2.3+) |
| `height` | `Number?` | cm |
| `weight` | `Number?` | grams |
| `restingHeartRate` | `Number?` | bpm (when available) |
| `runningStepLength` | `Number?` | mm (3.2.0+) |
| `walkingStepLength` | `Number?` | mm (3.2.0+) |
| `vo2maxRunning` | `Number?` | mL/kg/min |
| `vo2maxCycling` | `Number?` | mL/kg/min |
| `wheelchairUse` | `Boolean?` | (4.2.0+) |

## Constants

### `Gender`
| Name | Value |
|------|-------|
| `GENDER_FEMALE` | 0 |
| `GENDER_MALE` | 1 |
| `GENDER_UNSPECIFIED` | 2 (4.2.3+) |

### `SportHrZone` (legacy zone selectors)
| Name | Value | API |
|------|-------|-----|
| `HR_ZONE_SPORT_GENERIC` | 0 | 1.2.6 |
| `HR_ZONE_SPORT_RUNNING` | 1 | 1.2.6 |
| `HR_ZONE_SPORT_BIKING` | 2 | 1.2.6 |
| `HR_ZONE_SPORT_SWIMMING` | 3 | 1.2.6 |

## Watch-face patterns

### Age (derived)
```monkey-c
function age() as String {
    var p = UserProfile.getProfile();
    var by = p.birthYear;
    if (by == null || by == 0) { return "--"; }
    var info = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    return (info.year - by).format("%d");
}
```

### HR zone classification (for status color)
```monkey-c
function hrZone(currentHr as Number) as Number {
    var zones = UserProfile.getHeartRateZones(UserProfile.HR_ZONE_SPORT_GENERIC);
    // zones = [zMin, z1max, z2max, z3max, z4max, z5max]
    if (currentHr < zones[0]) { return 0; }   // below zone 1
    for (var z = 1; z <= 5; z += 1) {
        if (currentHr <= zones[z]) { return z; }
    }
    return 6;   // above zone 5
}
```

## Gotchas

1. **Permission required** — without `<iq:uses-permission id="UserProfile"/>` the calls return null/empty data.
2. **`birthYear` may be 0** — never assume non-zero. Treat 0 as "not set" like null.
3. **`weight` is grams**, not kg.
4. **HR zones depend on the configured sport context** — `HR_ZONE_SPORT_GENERIC` (0) is the safe default for a watch face that doesn't know the user's current activity.
