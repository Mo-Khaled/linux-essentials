#!/usr/bin/env bash
# Linux Essentials CTF — one-command start.
#
#   ./start.sh          set up (idempotent — safe to re-run any time)
#   ./start.sh --reset  wipe all lab-generated state and start clean
#
# This never uses sudo and never modifies real system files. The one
# exception to "everything stays inside this repository" is `--reset`,
# which also removes the lab's own tagged line from your personal
# crontab (never the whole crontab).
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/state.sh"

require_not_root

if [ "${1:-}" = "--reset" ]; then
    warn "Resetting the lab: stopping lab processes and wiping lab_workspace/ ..."
    stop_recorded_procs
    "$SCRIPT_DIR/scripts/remove_cron_entry.sh" || true
    rm -rf "$LAB_WORKSPACE"
    ok "Reset complete."
fi

bash "$SCRIPT_DIR/scripts/preflight.sh"
echo
bash "$SCRIPT_DIR/scripts/init_missions.sh"
echo
ok "Lab is ready."
say ""
say "Next step:"
say "  cat missions/00-identify-your-system/README.md"
say ""
say "Full instructions: README.md"
