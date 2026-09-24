#!/usr/bin/env bash
# Launches the mission 11 process pool: 5 genuine lab workers plus 2
# similarly-named bystanders, so a sloppy grep pattern over-counts.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

N=5
room="$LAB_WORKSPACE/rooms/11"
mkdir -p "$room"
rm -f "$room/answer.txt"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "linuxctf_worker_11_" >/dev/null 2>&1; then
    warn "Mission 11 workers already running — nothing to do."
    exit 0
fi

for i in $(seq 1 "$N"); do
    NAME="linuxctf_worker_11_${i}"
    spawn_worker "mission11_worker_${i}" "$NAME" idle /dev/null "" ""
done
for i in 1 2; do
    NAME="linuxctf_bystander_${i}"
    spawn_worker "mission11_bystander_${i}" "$NAME" idle /dev/null "" ""
done

echo "$N" > "$LAB_STATE_DIR/mission11_expected_count"
ok "Started $N genuine workers plus 2 bystanders with similar names."
