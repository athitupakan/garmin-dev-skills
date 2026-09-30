# Shared env + project config for garmin-dev scripts (macOS + Linux / Bash).
# Source from sibling scripts:  . "$(dirname "$0")/_env.sh"
#
# Auto-detects SDK + JDK at runtime so SDK upgrades / JDK reinstalls do not
# require editing this file. Override any of the variables below if needed.
#
# Exports:
#   Sdk      Connect IQ SDK root (newest installed)
#   Project  binary name stem (defaults to project folder name, lowercase)
#   Device   target device id (from manifest.xml first product)
#   Prg      output .prg path
#   Jungle   jungle file
#   Key      developer key file

set -eu

# ---- Project (override here if you want a different binary name) ----------
Project="$(basename "$PWD" | tr '[:upper:]' '[:lower:]')"

# ---- OS detection ---------------------------------------------------------
case "$(uname -s)" in
  Darwin) os_id="mac" ;;
  Linux)  os_id="lin" ;;
  *) echo "Unsupported OS: $(uname -s). Use the Windows scripts on Windows." >&2; exit 1 ;;
esac

# ---- JDK auto-detect ------------------------------------------------------
# Garmin Connect IQ SDK 9.x requires JDK 17 specifically. The `*17*` glob
# patterns below are intentional, not lazy. If Garmin moves to a newer JDK in
# a future SDK release, update the globs AND the JAVA_HOME version regex.
find_jdk() {
  if [ -n "${JAVA_HOME:-}" ] && [ -x "$JAVA_HOME/bin/java" ]; then
    # Verify version 17 — JAVA_HOME may point at JDK 8/11/21 etc.; using
    # the wrong JDK makes monkeyc fail with cryptic class-version errors.
    ver_out="$("$JAVA_HOME/bin/java" -version 2>&1)"
    if echo "$ver_out" | grep -q 'version "17'; then
      echo "$JAVA_HOME"; return 0
    else
      echo "Warning: JAVA_HOME ($JAVA_HOME) is not JDK 17 — skipping. Searching standard install paths..." >&2
    fi
  fi
  case "$os_id" in
    mac)
      for p in /Library/Java/JavaVirtualMachines/*-17*/Contents/Home \
               /Library/Java/JavaVirtualMachines/*17*/Contents/Home \
               /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home \
               /usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home; do
        [ -x "$p/bin/java" ] && echo "$p" && return 0
      done
      ;;
    lin)
      for p in /usr/lib/jvm/java-17-openjdk* \
               /usr/lib/jvm/temurin-17-jdk* \
               /usr/lib/jvm/*-17-* \
               /opt/jdk-17*; do
        [ -x "$p/bin/java" ] && echo "$p" && return 0
      done
      ;;
  esac
  return 1
}

if ! jdk="$(find_jdk)"; then
  echo "JDK 17 not found. Install:" >&2
  echo "  macOS: brew install --cask temurin@17" >&2
  echo "  Linux: sudo apt install openjdk-17-jdk  (or your distro equivalent)" >&2
  echo "Or set JAVA_HOME to an existing JDK 17 install." >&2
  exit 1
fi
export JAVA_HOME="$jdk"
export PATH="$jdk/bin:$PATH"

# ---- Connect IQ SDK auto-detect ------------------------------------------
case "$os_id" in
  mac) sdk_root="$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks" ;;
  lin) sdk_root="$HOME/.Garmin/ConnectIQ/Sdks" ;;
esac
# Pick newest SDK by the ISO date in the dir name (connectiq-sdk-mac-9.1.0-2026-05-01-<hash>).
# Sorting the whole name would rank 9.x above 10.x.
Sdk=""
newest=""
for d in "$sdk_root"/connectiq-sdk-${os_id}-*; do
  [ -d "$d" ] || continue
  stamp="$(basename "$d" | cut -d- -f5-7)"
  if [ -z "$Sdk" ] || [[ "$stamp" > "$newest" ]]; then Sdk="$d"; newest="$stamp"; fi
done
if [ -z "$Sdk" ]; then
  echo "Connect IQ SDK not found under $sdk_root" >&2
  echo "Install via SDK Manager: https://developer.garmin.com/connect-iq/sdk/" >&2
  exit 1
fi

# ---- Device (from manifest.xml first product) ----------------------------
if [ ! -f manifest.xml ]; then
  echo "manifest.xml not found in current directory. Run scripts from the project root." >&2
  exit 1
fi
Device="$(sed -n 's/.*<iq:product[[:space:]][^>]*id="\([^"]*\)".*/\1/p' manifest.xml | head -1)"
if [ -z "$Device" ]; then
  echo "Could not parse device id from manifest.xml <iq:products>." >&2
  exit 1
fi

# ---- Derived paths -------------------------------------------------------
Prg="bin/${Project}.prg"
Jungle="monkey.jungle"
Key="developer_key"

export Sdk Project Device Prg Jungle Key
