#!/usr/bin/env bash
# What bonus b3's crontab entry runs on every tick.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
ensure_workspace
out="$LAB_WORKSPACE/rooms/b3/.evidence"
mkdir -p "$(dirname "$out")"
{
    printf 'Recurring bonus evidence refreshed at: %s\n' "$(date)"
    gen_flag b3 cron_hunter
} > "$out"
