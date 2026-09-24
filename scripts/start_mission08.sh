#!/usr/bin/env bash
# Launches the mission 08 background process. Run this once, then
# investigate it with the tools taught in Part 3/4 of the PDF.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

NAME="linuxctf_evidence_daemon"
OUTFILE="$LAB_WORKSPACE/rooms/08/flag_while_running.txt"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker mission08 "$NAME" alive-flag "$OUTFILE" 08 daemon_caught
ok "Started a background process. It's on its own now — go find it."
