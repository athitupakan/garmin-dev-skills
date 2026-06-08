#!/usr/bin/env bash
# Push existing bin/<project>.prg to a running simulator. No build.
# Blocks while monkeydo streams device logs. Ctrl+C to stop.

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

if [ ! -f "$Prg" ]; then
  echo "No .prg at $Prg — run build.sh first" >&2
  exit 1
fi

if ! pgrep -x simulator >/dev/null 2>&1; then
  echo "Simulator not running — launch via run.sh or open it manually" >&2
  exit 1
fi

"$Sdk/bin/monkeydo" "$Prg" "$Device"
