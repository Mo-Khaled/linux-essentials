#!/usr/bin/env bash
# Builds the static scenario data for missions 00-07 under lab_workspace/.
# Called by start.sh. Idempotent: safe to re-run, will not clobber a room
# that's already been solved/touched by the student unless --reset was
# requested by start.sh (which wipes lab_workspace/ first).
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/flaglib.sh"

ensure_workspace
ensure_seed
ROOMS="$LAB_WORKSPACE/rooms"
mkdir -p "$ROOMS"

write_flag_file() {
    # write_flag_file <path> <mission> <label>
    local path="$1" mission="$2" label="$3"
    mkdir -p "$(dirname "$path")"
    gen_flag "$mission" "$label" > "$path"
}

# ---------------------------------------------------------------- mission 00
# "Identify Your System" — flag lives in a file named after the student's
# REAL $SHELL basename, sitting among decoys named after other shells.
init_mission00() {
    local room="$ROOMS/00"; mkdir -p "$room"
    local real_shell; real_shell="$(basename "${SHELL:-bash}")"
    for name in bash sh dash csh tcsh ksh zsh; do
        if [ "$name" = "$real_shell" ]; then
            write_flag_file "$room/${name}.shell" 00 system_identified
        else
            printf 'This is not the shell you are using. Keep looking.\n' > "$room/${name}.shell"
        fi
    done
    # in case $SHELL points to something outside the usual list, still cover them
    if [ ! -f "$room/${real_shell}.shell" ]; then
        write_flag_file "$room/${real_shell}.shell" 00 system_identified
    fi
}

# ---------------------------------------------------------------- mission 01
# "Explore Linux" — four rooms stand in for /etc, /dev, /var, /home; only
# the configuration room holds the flag.
init_mission01() {
    local room="$ROOMS/01"; mkdir -p "$room"
    mkdir -p "$room/config_room" "$room/devices_room" "$room/variable_data_room" "$room/user_homes_room"
    printf 'Wrong room: this one stands in for device files (like the real /dev).\n' > "$room/devices_room/note.txt"
    printf 'Wrong room: this one stands in for changing data such as logs (like the real /var).\n' > "$room/variable_data_room/note.txt"
    printf 'Wrong room: this one stands in for per-user home directories (like the real /home).\n' > "$room/user_homes_room/note.txt"
    write_flag_file "$room/config_room/flag.txt" 01 explorer
}

# ---------------------------------------------------------------- mission 02
# "Hidden Evidence" — dotfile.
init_mission02() {
    local room="$ROOMS/02"; mkdir -p "$room"
    printf 'Nothing to see here. A normal listing shows this file and stops.\n' > "$room/normal.txt"
    write_flag_file "$room/.evidence" 02 hidden_found
}

# ---------------------------------------------------------------- mission 03
# "File Detective" — regular file + directory decoys, a hidden real file,
# and a symlink pointing at it.
init_mission03() {
    local room="$ROOMS/03"; mkdir -p "$room/archive"
    printf 'A regular report. Not the flag.\n' > "$room/report.txt"
    printf 'Just some archived notes.\n' > "$room/archive/notes.txt"
    write_flag_file "$room/.locker" 03 symlink_traced
    ( cd "$room" && ln -sf .locker shortcut )
}

# ---------------------------------------------------------------- mission 04
# "Create the Evidence" — two fixed text parts the student must assemble
# themselves with > then >>. Flag is state-gated (see verifiers.sh) so
# nothing here is a real flag yet.
init_mission04() {
    local room="$ROOMS/04"; mkdir -p "$room"
    printf 'LAB-EVIDENCE-PART-ONE\n' > "$room/piece1.txt"
    printf 'LAB-EVIDENCE-PART-TWO\n' > "$room/piece2.txt"
}

# ---------------------------------------------------------------- mission 05
# "Move the Evidence" — student must cp the source into vault/, ln -s a
# link to it, and rm the scratch copy. State-gated (verifiers.sh).
init_mission05() {
    local room="$ROOMS/05"; mkdir -p "$room/source"
    printf 'Raw field notes. This copy is a working scratch copy only —\nonce it has been filed, this scratch copy should be removed.\n' > "$room/old_notes.txt"
    printf 'Raw field notes: case #4471. Copy this into the vault to file it officially.\n' > "$room/source/original.txt"
}

# ---------------------------------------------------------------- mission 06
# "Storage Investigation" — decoy folders named after fake df -h . output,
# one real folder named after THIS machine's actual df -h . output (captured
# now, at init time, so it always matches what the student sees later).
init_mission06() {
    local room="$ROOMS/06/storage"; mkdir -p "$room"
    local real_line mounted usep sanitized
    if command -v df >/dev/null 2>&1; then
        real_line="$(df -h "$LAB_ROOT" 2>/dev/null | awk 'NR==2')"
    fi
    mounted="$(printf '%s' "$real_line" | awk '{print $NF}')"
    usep="$(printf '%s' "$real_line" | awk '{print $(NF-1)}')"
    [ -n "$mounted" ] || mounted="unknown"
    [ -n "$usep" ] || usep="0%"
    local mount_label
    if [ "$mounted" = "/" ]; then
        mount_label="root"
    else
        mount_label="$(basename "$mounted" | tr -c 'A-Za-z0-9' '_')"
        [ -n "$mount_label" ] || mount_label="root"
    fi
    sanitized="mount_${mount_label}_use_${usep%\%}pct"
    mkdir -p "$room/$sanitized"
    printf '%s\n' "$sanitized" > "$LAB_STATE_DIR/mission06_real_dir"
    printf 'Real mount point at init time: %s (use %s)\n' "$mounted" "$usep" > "$room/$sanitized/.origin_note"
    # decoys — plausible-looking but wrong mount/use% combinations
    for decoy in mount__root__use_12pct mount__home__use_88pct mount__data__use_45pct; do
        [ "$decoy" = "$sanitized" ] && continue
        mkdir -p "$room/$decoy"
        printf 'Not this one.\n' > "$room/$decoy/note.txt"
    done
}

# ---------------------------------------------------------------- mission 07
# "Environment Investigation" — folder named after basename "$HOME"
# (matches the student's real $HOME on their own machine); an env file they
# must `source` tells them the exact filename to create there.
init_mission07() {
    local room="$ROOMS/07"; mkdir -p "$room"
    local user_dir; user_dir="$(basename "$HOME")"
    mkdir -p "$room/$user_dir"
    printf '# Source this file: `source unlock.env`\nexport CASE_FILE=claim.txt\n' > "$room/unlock.env"
    for decoy in guest visitor unknown_user; do
        [ "$decoy" = "$user_dir" ] && continue
        mkdir -p "$room/$decoy"
        printf 'Wrong case room.\n' > "$room/$decoy/note.txt"
    done
}

# ---------------------------------------------------------------- bonus b1
# "Linked Secret" — a chain of two symlinks, the second one hidden.
init_missionb1() {
    local room="$ROOMS/b1"; mkdir -p "$room"
    write_flag_file "$room/.step2_target" b1 linked_secret
    ( cd "$room" && ln -sf .step2_target .step2 && ln -sf .step2 clue )
    printf 'Something in this room points at something else, which points at\nsomething else again. ls -a and ls -l will both matter here.\n' > "$room/.info"
}

require_not_root
init_mission00
init_mission01
init_mission02
init_mission03
init_mission04
init_mission05
init_mission06
init_mission07
init_missionb1
ok "Missions 00-07 and bonus b1 scenario data ready under lab_workspace/rooms/"
