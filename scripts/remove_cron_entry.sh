#!/usr/bin/env bash
# Removes ONLY the lab's own crontab line (tagged with the
# "# LINUX_ESSENTIALS_CTF" marker), never the student's whole crontab.
# Never runs `crontab -r`, which would wipe everything.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

if ! command -v crontab >/dev/null 2>&1; then
    info "crontab not installed — nothing to clean up."
    exit 0
fi

current="$(crontab -l 2>/dev/null || true)"
if [ -z "$current" ]; then
    info "No crontab for this user — nothing to clean up."
    exit 0
fi

if ! printf '%s\n' "$current" | grep -qF "$LAB_CRON_MARKER"; then
    info "No lab crontab entry (marker: $LAB_CRON_MARKER) found — nothing to clean up."
    exit 0
fi

filtered="$(printf '%s\n' "$current" | grep -vF "$LAB_CRON_MARKER")"
printf '%s\n' "$filtered" | crontab -
ok "Removed the lab's crontab entry. Your other crontab entries (if any) were left untouched."
