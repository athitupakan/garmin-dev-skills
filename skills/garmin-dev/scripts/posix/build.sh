#!/usr/bin/env bash
# Compile source/ + resources/ -> bin/<project>.prg (debug build).
# Does not launch simulator. Does not push.

set -euo pipefail
. "$(cd "$(dirname "$0")" && pwd)/_env.sh"

mkdir -p bin

# -l 2 = informative type check (warn on ambiguity)
# -w   = show build warnings
"$Sdk/bin/monkeyc" -d "$Device" -f "$Jungle" -o "$Prg" -y "$Key" -l 2 -w
