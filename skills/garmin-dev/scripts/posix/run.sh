#!/usr/bin/env bash
# Full cycle: ensure simulator running, compile, push. Idempotent.
# Blocks at the end while monkeydo streams device logs. Ctrl+C to stop.

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

if ! pgrep -x simulator >/dev/null 2>&1; then
  echo "Launching simulator..."
  # SDK's own launcher: opens bin/ConnectIQ.app on macOS, runs bin/simulator on Linux.
  ("$Sdk/bin/connectiq" >/dev/null 2>&1 &)
  for _ in $(seq 1 30); do
    pgrep -x simulator >/dev/null 2>&1 && break
    sleep 1
  done
  if ! pgrep -x simulator >/dev/null 2>&1; then
    echo "Simulator did not start within 30s. Try: \"$Sdk/bin/connectiq\"" >&2
    exit 1
  fi
  sleep 3
fi

echo "Compiling..."
"$Sdk/bin/monkeyc" -d "$Device" -f "$Jungle" -o "$Prg" -y "$Key"

echo "Pushing to simulator (Ctrl+C to stop)..."
"$Sdk/bin/monkeydo" "$Prg" "$Device"
