#!/usr/bin/env bash
# Launches the mission 08 target process. It only writes its flag after
# receiving a clean SIGTERM — SIGKILL skips its cleanup entirely.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

NAME="linuxctf_target"
OUTFILE="$LAB_WORKSPACE/rooms/08/flag_after_term.txt"
rm -f "$OUTFILE"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "bin/$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker mission08 "$NAME" sigterm-flag "$OUTFILE" 08 process_stopped
ok "A program called $NAME is now running in the background."
