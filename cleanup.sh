#!/usr/bin/env bash
# Surgical lab teardown. Only ever touches things this lab created:
#   - recorded lab process PIDs (verified by name before signaling)
#   - lab_workspace/ (all generated mission evidence)
#   - the lab's own tagged crontab line (never the whole crontab)
#   - prints (does not silently remove) any pending lab `at` jobs
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/state.sh"

info "Stopping recorded lab processes (verified by name before signaling)..."
stop_recorded_procs

info "Sweeping for any stray lab processes by name (belt-and-suspenders)..."
if command -v pkill >/dev/null 2>&1; then
    pkill -f 'linuxctf_' 2>/dev/null && ok "Stopped stray linuxctf_* processes." || info "None found."
fi

info "Removing the lab's crontab entry (marker-based, leaves everything else alone)..."
bash "$SCRIPT_DIR/scripts/remove_cron_entry.sh"

if command -v atq >/dev/null 2>&1; then
    pending="$(atq 2>/dev/null || true)"
    if [ -n "$pending" ]; then
        warn "You have pending 'at' jobs. This script won't guess which are the"
        warn "lab's — inspect them and remove the lab-related one yourself:"
        say "$pending"
        if command -v at >/dev/null 2>&1; then
            while read -r jobnum _; do
                [ -n "$jobnum" ] || continue
                if at -c "$jobnum" 2>/dev/null | grep -q 'at_emitter.sh'; then
                    info "  Job $jobnum looks like the lab's mission-12 job -> remove with: atrm $jobnum"
                fi
            done <<< "$pending"
        fi
    fi
fi

info "Removing lab_workspace/ (all generated mission evidence)..."
rm -rf "$LAB_WORKSPACE"

ok "Cleanup complete. Nothing outside this repository was touched."
