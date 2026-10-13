#!/usr/bin/env bash
# Linux/macOS installer; no Python required.
set -euo pipefail
usage() { echo "Usage: bash scripts/install.sh --profile-dir PATH [--launch] [--firefox EXECUTABLE]"; exit 2; }
profile=''; launch=0; firefox=''
while (( $# )); do
  case "$1" in
    --profile-dir) (( $# >= 2 )) || usage; profile=$2; shift 2 ;;
    --firefox) (( $# >= 2 )) || usage; firefox=$2; shift 2 ;;
    --launch) launch=1; shift ;;
    *) usage ;;
  esac
done
[[ -n "$profile" && -d "$profile" ]] || { echo 'Profile missing: create it using about:profiles and pass its Root Directory.' >&2; exit 1; }
profile=$(cd "$profile" && pwd -P)
[[ -f "$profile/prefs.js" || -f "$profile/times.json" ]] || { echo 'Profile not initialized: launch it once, then close Firefox.' >&2; exit 1; }
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
echo 'Close Firefox completely before installing.'
printf 'Install to %s ? Type YES to continue: ' "$profile"
IFS= read -r answer
[[ "$answer" == YES ]] || { echo 'Cancelled.'; exit 1; }
if [[ -f "$profile/user.js" ]]; then
  backup="$profile/user.js.backup-$(date +%Y%m%d-%H%M%S)"
  cp -p "$profile/user.js" "$backup"
  echo "Saved backup: $backup"
fi
cp "$root/config/user.js" "$profile/user.js"
echo "Installed: $profile/user.js"
if (( launch )); then
  if [[ -z "$firefox" ]]; then
    if [[ "$(uname -s)" == Darwin ]]; then firefox='/Applications/Firefox.app/Contents/MacOS/firefox'; else firefox='firefox'; fi
  fi
  guide="file://$root/extensions/install.html"
  if [[ "$firefox" == */* ]]; then
    [[ -x "$firefox" ]] || { echo 'Firefox executable not found. Open extensions/install.html manually.'; exit 0; }
  elif ! command -v "$firefox" >/dev/null 2>&1; then
    echo 'Firefox executable not found. Open extensions/install.html manually.'; exit 0
  fi
  "$firefox" -no-remote -profile "$profile" "$guide" >/dev/null 2>&1 &
fi
echo 'Open extensions/install.html in the configured profile and approve add-on installations.'
