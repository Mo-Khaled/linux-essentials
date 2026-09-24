#!/usr/bin/env bash
# Launches the mission 14 final chain: a hidden clue naming a process, that
# process (once found and cleanly terminated) reveals a base64-encoded path
# to the vault holding the real final flag.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"
require_not_root
ensure_workspace

room="$LAB_WORKSPACE/rooms/14"
vault="$room/vault"
mkdir -p "$vault"
gen_flag 14 final_investigation > "$vault/final_evidence.txt"

if [ ! -f "$room/.dossier" ]; then
    printf 'A process is watching this investigation.\nIts name begins with: linuxctf_final\nIt will only talk if you ask it politely (a clean termination signal).\n' > "$room/.dossier"
fi

NAME="linuxctf_final_target"
ENCFILE="$room/encoded.b64"
rm -f "$ENCFILE"

if command -v pgrep >/dev/null 2>&1 && pgrep -f "$NAME" >/dev/null 2>&1; then
    warn "$NAME is already running — nothing to do."
    exit 0
fi

spawn_worker mission14 "$NAME" sigterm-b64 "$ENCFILE" 14 "rooms/14/vault/final_evidence.txt"
ok "Final investigation is live. Somewhere there's a hidden dossier..."
