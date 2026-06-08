#!/usr/bin/env bash
# Store-ready .iq package (-e + -r) for ALL products listed in manifest.xml
# Output: bin/<project>.iq — upload at https://apps.garmin.com/en-US/developer/upload
#
# With -e / --package-app, monkeyc reads <iq:products> from manifest.xml and
# compiles a binary for each. Do NOT pass -d here — packaging targets every
# product at once.

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

IqFile="bin/${Project}.iq"

"$Sdk/bin/monkeyc" -e -f "$Jungle" -o "$IqFile" -y "$Key" -r -w

if [ -f "$IqFile" ]; then
  size_bytes="$(stat -f%z "$IqFile" 2>/dev/null || stat -c%s "$IqFile")"
  size_kb=$((size_bytes / 1024))
  echo "PACKAGE OK -> $IqFile (${size_kb} KB)"
  echo "Upload at: https://apps.garmin.com/en-US/developer/upload"
fi
