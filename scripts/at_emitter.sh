#!/usr/bin/env bash
# This is what bonus b4 schedules with `at`. The flag file does not exist
# until this actually runs — that's the whole point of the mission.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
ensure_workspace
out="$LAB_WORKSPACE/rooms/b4/flag.txt"
mkdir -p "$(dirname "$out")"
{
    printf 'Written by your scheduled job at: %s\n' "$(date)"
    gen_flag b4 run_it_later
} > "$out"
