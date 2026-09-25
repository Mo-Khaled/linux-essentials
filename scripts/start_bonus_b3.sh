#!/usr/bin/env bash
# Launches the bonus b3 process pool: 5 genuine lab workers plus 2
# similarly-named bystanders, so a sloppy grep pattern over-counts.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
require_not_root
ensure_workspace

N=5
room="$LAB_WORKSPACE/rooms/b3"
mkdir -p "$room"
rm -f "$room/answer.txt"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "bin/linuxctf_worker_" >/dev/null 2>&1; then
    warn "Bonus b3 workers already running — nothing to do."
    exit 0
fi

for i in $(seq 1 "$N"); do
    NAME="linuxctf_worker_${i}"
    spawn_worker "b3_worker_${i}" "$NAME" idle /dev/null "" ""
done
for i in 1 2; do
    NAME="linuxctf_helper_${i}"
    spawn_worker "b3_helper_${i}" "$NAME" idle /dev/null "" ""
done

echo "$N" > "$LAB_STATE_DIR/b3_expected_count"
ok "Started some linuxctf_worker_ programs and some linuxctf_helper_ programs."
