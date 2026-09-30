#!/usr/bin/env bash
# Close the Connect IQ simulator and any monkeydo log streams.
# Does not need a project — runs from any directory.

set -uo pipefail

stopped=0

if pgrep -f MonkeyDoDeux >/dev/null 2>&1; then
  pkill -f MonkeyDoDeux && stopped=1
fi

if pgrep -x simulator >/dev/null 2>&1; then
  # The macOS app ignores an AppleScript quit, so terminate the process directly.
  pkill -x simulator
  for _ in 1 2 3 4 5; do
    pgrep -x simulator >/dev/null 2>&1 || break
    sleep 1
  done
  pgrep -x simulator >/dev/null 2>&1 && pkill -9 -x simulator
  stopped=1
fi

if [ "$stopped" -eq 1 ]; then
  echo "Simulator stopped."
else
  echo "Simulator was not running."
fi
