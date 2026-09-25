#!/usr/bin/env bash
# Generic lab worker process engine — never run directly by students.
#
# The per-mission start_*.sh scripts (missions 07, 08 and bonus b3, b5) give this
# process its distinctive lab name by COPYING this file to
# lab_workspace/.state/bin/<name> and executing that copy directly — since
# the OS execs the file at the path it was invoked with, `ps`/`pgrep`/
# `pstree` naturally see that name in the command line. (This is simpler and
# more portable than the bash `exec -a` argv0 trick, which behaves
# inconsistently across environments.)
#
# usage: <name-copy-of-worker.sh> <mode> <outfile> [mission_id] [label_or_payload]
#
# modes:
#   alive-flag    writes the flag to <outfile> every 2s while running;
#                 removes it immediately on SIGTERM/SIGINT/exit (mission 07)
#   sigterm-flag  writes nothing until SIGTERM arrives, then writes the flag
#                 and exits cleanly (mission 08) — SIGKILL skips this
#                 entirely, which is the point
#   sigterm-b64   like sigterm-flag but writes base64(label_or_payload)
#                 instead of a flag (bonus b5 chain step)
#   idle          just idles (bonus b3 worker pool)
set -u
REAL_SELF="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)/$(basename "${BASH_SOURCE[0]}")"

MODE="${1:?usage: worker.sh <mode> <outfile> [mission] [label]}"
OUTFILE="${2:?}"
MISSION="${3:-}"
LABEL="${4:-}"

# lib/ lives next to the real worker.sh; this copy runs from
# lab_workspace/.state/bin/, so find lib/ via the canonical scripts/ dir.
SCRIPT_DIR="$(cd -P "$(dirname "$REAL_SELF")/../../../scripts" >/dev/null 2>&1 && pwd)"
if [ ! -f "$SCRIPT_DIR/lib/common.sh" ]; then
    # fallback: running the original (uncopied) worker.sh directly
    SCRIPT_DIR="$(cd -P "$(dirname "$REAL_SELF")" >/dev/null 2>&1 && pwd)"
fi
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"

# NOTE: idle mode never touches OUTFILE (it's passed as /dev/null for decoy
# workers) — never mkdir/rm on it here, that would be run against /dev/null.
case "$MODE" in
    alive-flag)
        mkdir -p "$(dirname "$OUTFILE")"
        rm -f "$OUTFILE"
        cleanup() { rm -f "$OUTFILE"; exit 0; }
        trap cleanup TERM INT EXIT
        while true; do
            gen_flag "$MISSION" "$LABEL" > "$OUTFILE"
            sleep 2 & wait $!
        done
        ;;
    sigterm-flag)
        mkdir -p "$(dirname "$OUTFILE")"
        rm -f "$OUTFILE"
        trap 'gen_flag "$MISSION" "$LABEL" > "$OUTFILE"; exit 0' TERM
        # `sleep & wait` (not plain sleep) so the TERM trap runs at once,
        # not after the current sleep finishes
        while true; do sleep 2 & wait $!; done
        ;;
    sigterm-b64)
        mkdir -p "$(dirname "$OUTFILE")"
        rm -f "$OUTFILE"
        trap 'printf "%s\n" "$LABEL" | base64 > "$OUTFILE"; exit 0' TERM
        while true; do sleep 2 & wait $!; done
        ;;
    idle)
        while true; do sleep 2; done
        ;;
    *)
        echo "worker.sh: unknown mode '$MODE'" >&2
        exit 1
        ;;
esac
