#!/usr/bin/env bash
# Checks that the tools this lab uses are installed. Never installs anything
# and never uses sudo. Quiet when everything is fine.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

missing_core=""
for cmd in bash ls cat ps grep awk sha256sum pgrep kill; do
    command -v "$cmd" >/dev/null 2>&1 || missing_core="$missing_core $cmd"
done

missing_bonus=""
for cmd in at base64 df; do
    command -v "$cmd" >/dev/null 2>&1 || missing_bonus="$missing_bonus $cmd"
done

if [ -n "$missing_core" ]; then
    warn "These programs are missing:$missing_core"
    warn "Please tell your instructor (fix: sudo apt install procps coreutils)."
fi
if [ -n "$missing_bonus" ]; then
    warn "Some bonus missions need:$missing_bonus (ask your instructor: sudo apt install at)."
fi
if [ -z "$missing_core" ] && [ -z "$missing_bonus" ]; then
    ok "All the tools you need are installed."
fi
exit 0
