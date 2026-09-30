#!/usr/bin/env bash
# Watch source/ + resources/ — rebuild + re-push on file change. Polls every 2s.
# Prerequisite: simulator running (run.sh once first).
# Ctrl+C to stop. Background monkeydo is cleaned up on exit.

set -uo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

marker="$(mktemp -t garmin-watch.XXXXXX)"
monkeydo_pid=""

# monkeydo is a wrapper script; its java child survives unless killed explicitly.
stop_monkeydo() {
  [ -n "$monkeydo_pid" ] || return 0
  pkill -P "$monkeydo_pid" 2>/dev/null || true
  kill "$monkeydo_pid" 2>/dev/null || true
  monkeydo_pid=""
}

cleanup() {
  stop_monkeydo
  rm -f "$marker"
}
trap cleanup EXIT
# A trap handler that doesn't exit lets the loop keep running after Ctrl+C / kill.
trap 'exit 130' INT
trap 'exit 143' TERM

build_and_push() {
  if "$Sdk/bin/monkeyc" -d "$Device" -f "$Jungle" -o "$Prg" -y "$Key"; then
    stop_monkeydo
    "$Sdk/bin/monkeydo" "$Prg" "$Device" >/dev/null 2>&1 &
    monkeydo_pid=$!
    echo "[$(date +%H:%M:%S)] PUSHED"
    touch "$marker"
  else
    echo "[$(date +%H:%M:%S)] BUILD FAILED"
  fi
}

echo "Watching source/ + resources/ — Ctrl+C to stop"
build_and_push

while true; do
  sleep 2
  changes="$(find source resources -type f -newer "$marker" 2>/dev/null || true)"
  if [ -n "$changes" ]; then
    names="$(echo "$changes" | head -3 | xargs -n1 basename | paste -sd, -)"
    echo "[$(date +%H:%M:%S)] CHANGED: $names"
    build_and_push
  fi
done
