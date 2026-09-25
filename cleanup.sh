#!/usr/bin/env bash
# Lab teardown. Only ever touches things this lab created:
#   - recorded lab process PIDs (verified by name before signaling)
#   - lab_workspace/ (all generated mission files)
#   - prints (does not silently remove) any pending `at` job from bonus b4
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/state.sh"

info "Stopping lab programs..."
stop_recorded_procs
if command -v pkill >/dev/null 2>&1; then
    pkill -f 'linuxctf_' 2>/dev/null || true
fi

if command -v atq >/dev/null 2>&1 && command -v at >/dev/null 2>&1; then
    while read -r jobnum _; do
        [ -n "$jobnum" ] || continue
        if at -c "$jobnum" 2>/dev/null | grep -q 'at_emitter.sh'; then
            warn "Your bonus b4 'at' job $jobnum is still waiting. Remove it with: atrm $jobnum"
        fi
    done <<< "$(atq 2>/dev/null || true)"
fi

info "Deleting lab_workspace/ ..."
rm -rf "$LAB_WORKSPACE"

ok "All clean. Only the lab's own files and programs were touched."
