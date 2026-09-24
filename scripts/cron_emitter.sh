#!/usr/bin/env bash
# This is what mission 13's crontab entry runs on every tick. It
# (over)writes the evidence file each time it fires, so the student can
# watch it update in real time.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
ensure_workspace
out="$LAB_WORKSPACE/rooms/13/evidence.txt"
mkdir -p "$(dirname "$out")"
{
    printf 'Evidence refreshed by a recurring cron job at: %s\n' "$(date)"
    gen_flag 13 recurring_evidence
} > "$out"
