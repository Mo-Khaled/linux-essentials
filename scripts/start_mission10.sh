#!/usr/bin/env bash
# Launches the mission 10 target process. It only writes its flag after
# receiving a clean SIGTERM — SIGKILL skips its cleanup entirely.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

NAME="linuxctf_target"
OUTFILE="$LAB_WORKSPACE/rooms/10/flag_after_term.txt"
rm -f "$OUTFILE"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker mission10 "$NAME" sigterm-flag "$OUTFILE" 10 signal_master
ok "Target process started. It will only cooperate with the right signal."
