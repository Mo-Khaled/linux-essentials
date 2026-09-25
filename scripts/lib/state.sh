#!/usr/bin/env bash
# PID / process bookkeeping so cleanup.sh can target exactly the processes
# this lab spawned, instead of a broad name-based sweep.
#
# Sourced by other scripts — do not execute directly.

: "${LAB_STATE_DIR:?common.sh must be sourced before state.sh}"

PROC_STATE_DIR="$LAB_STATE_DIR/procs"
WORKER_BIN_DIR="$LAB_STATE_DIR/bin"

# spawn_worker <tag> <name> <mode> <outfile> <mission> <label>
# Copies scripts/worker.sh to a file named <name>, launches it in the
# background under that name (so ps/pgrep see the distinctive lab name),
# and records the PID for cleanup.sh. Returns the PID via $LAST_SPAWNED_PID.
spawn_worker() {
    local tag="$1" name="$2" mode="$3" outfile="$4" mission="$5" label="$6"
    mkdir -p "$WORKER_BIN_DIR"
    local bin="$WORKER_BIN_DIR/$name"
    cp "$LAB_ROOT/scripts/worker.sh" "$bin"
    chmod +x "$bin"
    nohup "$bin" "$mode" "$outfile" "$mission" "$label" >/dev/null 2>&1 &
    LAST_SPAWNED_PID=$!
    disown "$LAST_SPAWNED_PID" 2>/dev/null || true
    record_proc "$tag" "$LAST_SPAWNED_PID" "$name"
}

# record_proc <tag> <pid> <expected_name>
# Writes lab_workspace/.state/procs/<tag>.pid = "<pid> <expected_name>"
record_proc() {
    local tag="$1" pid="$2" name="$3"
    mkdir -p "$PROC_STATE_DIR"
    printf '%s %s\n' "$pid" "$name" > "$PROC_STATE_DIR/${tag}.pid"
}

# proc_is_ours <pid> <expected_name>  -> 0 if that PID is still running
# AND its command line still matches the name we spawned it with.
proc_is_ours() {
    local pid="$1" name="$2" cmdline=""
    [ -n "$pid" ] || return 1
    if [ -r "/proc/$pid/cmdline" ]; then
        cmdline="$(tr '\0' ' ' < "/proc/$pid/cmdline" 2>/dev/null)"
    elif command -v ps >/dev/null 2>&1; then
        cmdline="$(ps -p "$pid" -o args= 2>/dev/null)"
    fi
    [ -n "$cmdline" ] || return 1
    case "$cmdline" in
        *"$name"*) return 0 ;;
        *) return 1 ;;
    esac
}

# stop_recorded_procs — reads every *.pid file, verifies identity, then
# sends SIGTERM (falls back to SIGKILL only if it refuses to die).
stop_recorded_procs() {
    [ -d "$PROC_STATE_DIR" ] || return 0
    local f pid name
    for f in "$PROC_STATE_DIR"/*.pid; do
        [ -e "$f" ] || continue
        read -r pid name < "$f"
        if proc_is_ours "$pid" "$name"; then
            kill -TERM "$pid" 2>/dev/null
            sleep 1
            if proc_is_ours "$pid" "$name"; then
                kill -KILL "$pid" 2>/dev/null
            fi
            info "Stopped lab process $name (PID $pid)"
        fi
        rm -f "$f"
    done
}
