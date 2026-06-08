#!/usr/bin/env bash
# Full cycle: ensure simulator running, compile, push. Idempotent.
# Blocks at the end while monkeydo streams device logs. Ctrl+C to stop.

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

if ! pgrep -x simulator >/dev/null 2>&1; then
  echo "Launching simulator..."
  case "$os_id" in
    mac) (open -a "$Sdk/bin/simulator" >/dev/null 2>&1 || open "$Sdk/bin/simulator" >/dev/null 2>&1) || true ;;
    lin) ("$Sdk/bin/simulator" >/dev/null 2>&1 &) ; disown 2>/dev/null || true ;;
  esac
  sleep 2
fi

echo "Compiling..."
"$Sdk/bin/monkeyc" -d "$Device" -f "$Jungle" -o "$Prg" -y "$Key"

echo "Pushing to simulator (Ctrl+C to stop)..."
"$Sdk/bin/monkeydo" "$Prg" "$Device"
