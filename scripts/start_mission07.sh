#!/usr/bin/env bash
# Launches the mission 07 background process. While it runs it keeps
# writing the flag file; the moment it stops, the file disappears.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

NAME="linuxctf_evidence_daemon"
OUTFILE="$LAB_WORKSPACE/rooms/07/flag_while_running.txt"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "bin/$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker mission07 "$NAME" alive-flag "$OUTFILE" 07 process_found
ok "A program called $NAME is now running in the background."
