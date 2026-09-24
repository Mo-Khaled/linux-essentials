#!/usr/bin/env bash
# Launches the mission 09 process pool: several genuine lab workers plus one
# differently-named impostor, so pgrep/pstree/ps have to be used precisely.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
require_not_root
ensure_workspace

room="$LAB_WORKSPACE/rooms/09/investigation"
N=4

if command -v pgrep >/dev/null 2>&1 && pgrep -f "linuxctf_worker_9_" >/dev/null 2>&1; then
    warn "Mission 09 workers already running — nothing to do."
    exit 0
fi

for i in $(seq 1 "$N"); do
    NAME="linuxctf_worker_9_${i}"
    spawn_worker "mission09_worker_${i}" "$NAME" idle /dev/null "" ""
done
# one impostor with a different name family — should NOT be counted
IMPOSTOR="linuxctf_decoy_service"
spawn_worker mission09_impostor "$IMPOSTOR" idle /dev/null "" ""

# real evidence dir is named by the genuine worker count; decoys use wrong counts
mkdir -p "$room/found_${N}"
gen_flag 09 process_hunted > "$room/found_${N}/flag.txt"
for wrong in 3 5 6; do
    [ "$wrong" = "$N" ] && continue
    mkdir -p "$room/found_${wrong}"
    printf 'Wrong count.\n' > "$room/found_${wrong}/note.txt"
done

ok "Started $N lab workers (plus one impostor). Go hunt them."
