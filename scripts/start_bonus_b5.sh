#!/usr/bin/env bash
# Launches the bonus b5 final chain: a hidden note naming a process; that
# process (once cleanly terminated) writes a base64-encoded path to the
# file holding the real flag.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
require_not_root
ensure_workspace

room="$LAB_WORKSPACE/rooms/b5"
vault="$room/vault"
mkdir -p "$vault"
gen_flag b5 final_boss > "$vault/final_flag.txt"

if [ ! -f "$room/.note" ]; then
    printf 'A program is hiding the last secret.\nIts name is: linuxctf_final_target\nStop it politely (plain kill, not kill -9).\n' > "$room/.note"
fi

NAME="linuxctf_final_target"
ENCFILE="$room/secret.b64"
rm -f "$ENCFILE"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "bin/$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker b5 "$NAME" sigterm-b64 "$ENCFILE" b5 "lab_workspace/rooms/b5/vault/final_flag.txt"
ok "The final challenge has started. Look for a hidden file in lab_workspace/rooms/b5/"
