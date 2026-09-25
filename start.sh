#!/usr/bin/env bash
# Linux Essentials CTF — one-command start.
#
#   ./start.sh          set up the lab (safe to run again any time)
#   ./start.sh --reset  delete everything the lab made and start fresh
#
# Never uses sudo and never changes real system files.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/state.sh"

require_not_root

if [ "${1:-}" = "--reset" ]; then
    warn "Starting over: stopping lab programs and deleting lab_workspace/ ..."
    stop_recorded_procs
    rm -rf "$LAB_WORKSPACE"
fi

bash "$SCRIPT_DIR/scripts/preflight.sh"
bash "$SCRIPT_DIR/scripts/init_missions.sh"
say ""
ok "The lab is ready!"
say ""
say "Now type this to read your first mission:"
say ""
say "  cat missions/00-first-steps/README.md"
say ""
