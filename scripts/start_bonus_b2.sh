#!/usr/bin/env bash
# Launches the bonus b2 watcher process. The evidence folder is named after
# how many digits long its PID happens to be — a fact you get from a
# process listing, not a guess.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
require_not_root
ensure_workspace

NAME="linuxctf_bonus_watcher"
room="$LAB_WORKSPACE/rooms/b2/investigation"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker bonus_b2 "$NAME" idle /dev/null "" ""
PID="$LAST_SPAWNED_PID"
LEN=${#PID}

mkdir -p "$room/len_${LEN}"
gen_flag b2 signal_log > "$room/len_${LEN}/flag.txt"
for wrong in 2 3 4 5 6 7; do
    [ "$wrong" = "$LEN" ] && continue
    mkdir -p "$room/len_${wrong}"
    printf 'Wrong PID length.\n' > "$room/len_${wrong}/note.txt"
done

ok "Bonus watcher started. Find its PID and see how many digits it has."
