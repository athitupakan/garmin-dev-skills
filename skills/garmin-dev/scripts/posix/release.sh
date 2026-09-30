#!/usr/bin/env bash
# Release-stripped build (-r) for the active device -> bin/<project>-release.prg
# Use to verify the optimized binary still runs in the simulator BEFORE
# exporting a store .iq. Catches issues that -r introduces:
#   - type pruning removes code paths whose only callers were debug-only
#   - aggressive optimization can expose latent null-deref / type errors
#
# Does NOT push. To push the release binary manually:
#   . ./.claude/skills/garmin-dev/scripts/posix/_env.sh
#   "$Sdk/bin/monkeydo" "bin/${Project}-release.prg" "$Device"

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

ReleasePrg="bin/${Project}-release.prg"

"$Sdk/bin/monkeyc" -d "$Device" -f "$Jungle" -o "$ReleasePrg" -y "$Key" -r -l 2 -w

if [ -f "$ReleasePrg" ]; then
  # stat -f%z on macOS, stat -c%s on Linux
  size_bytes="$(stat -f%z "$ReleasePrg" 2>/dev/null || stat -c%s "$ReleasePrg")"
  size_kb=$((size_bytes / 1024))
  echo "RELEASE BUILD OK -> $ReleasePrg (${size_kb} KB)"
fi
