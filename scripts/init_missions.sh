#!/usr/bin/env bash
# Builds the static rooms for missions 00-06 and bonus b1/b2 under
# lab_workspace/rooms/. Called by start.sh. Safe to re-run: it rewrites the
# starting files but never deletes anything a student has created.
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
# "First Steps" — the flag is one folder deeper than where they land.
init_mission00() {
    local room="$ROOMS/00"; mkdir -p "$room/start_here" "$room/empty_box"
    printf 'Hello! You found your first file.\nThe flag is not here. Go inside the folder called start_here and look again.\n' > "$room/welcome.txt"
    printf 'Nothing in here. Try the other folder.\n' > "$room/empty_box/note.txt"
    write_flag_file "$room/start_here/flag.txt" 00 first_steps
}

# ---------------------------------------------------------------- mission 01
# "Explore Linux" — four rooms stand in for /etc, /dev, /var, /home; only
# the configuration room holds the flag.
init_mission01() {
    local room="$ROOMS/01"; mkdir -p "$room"
    mkdir -p "$room/config_room" "$room/devices_room" "$room/logs_room" "$room/users_room"
    printf 'Wrong room. This one is like /dev (devices: disks, keyboard, ...).\n' > "$room/devices_room/note.txt"
    printf 'Wrong room. This one is like /var (logs and data that changes).\n' > "$room/logs_room/note.txt"
    printf 'Wrong room. This one is like /home (the users'"'"' own folders).\n' > "$room/users_room/note.txt"
    write_flag_file "$room/config_room/flag.txt" 01 explorer
}

# ---------------------------------------------------------------- mission 02
# "Hidden Files" — dotfile.
init_mission02() {
    local room="$ROOMS/02"; mkdir -p "$room"
    printf 'Not here! There is another file in this folder, but it is hidden.\n' > "$room/normal.txt"
    write_flag_file "$room/.secret" 02 hidden_found
}

# ---------------------------------------------------------------- mission 03
# "File Types" — a regular file, a directory, and a symlink to a hidden file.
init_mission03() {
    local room="$ROOMS/03"; mkdir -p "$room/folder"
    printf 'Just a normal file. Not the flag.\n' > "$room/report.txt"
    printf 'Just some notes. Not the flag.\n' > "$room/folder/notes.txt"
    write_flag_file "$room/.real_flag" 03 link_followed
    ( cd "$room" && ln -sf .real_flag shortcut )
}

# ---------------------------------------------------------------- mission 04
# "Create Files" — student joins piece1 + piece2 into evidence.txt with
# > then >>. State-gated (verify_04).
init_mission04() {
    local room="$ROOMS/04"; mkdir -p "$room"
    printf 'PART-ONE\n' > "$room/piece1.txt"
    printf 'PART-TWO\n' > "$room/piece2.txt"
}

# ---------------------------------------------------------------- mission 05
# "Organize Files" — mkdir, cp, mv, rm. State-gated (verify_05).
init_mission05() {
    local room="$ROOMS/05"
    # only build once, so re-running start.sh never brings back junk.txt
    # or draft.txt after the student removed/renamed them
    [ -d "$room" ] && return 0
    mkdir -p "$room"
    printf 'This is an important report. Keep it safe.\n' > "$room/report.txt"
    printf 'This is a draft. Give it a better name: final.txt\n' > "$room/draft.txt"
    printf 'This is junk. Delete me!\n' > "$room/junk.txt"
}

# ---------------------------------------------------------------- mission 06
# "Environment Variables" — the flag lives in the file named after the
# student's real $SHELL, among files named after other shells.
init_mission06() {
    local room="$ROOMS/06"; mkdir -p "$room"
    local real_shell; real_shell="$(basename "${SHELL:-bash}")"
    for name in bash sh dash zsh fish; do
        printf 'This is not your shell. Try another file.\n' > "$room/${name}.txt"
    done
    write_flag_file "$room/${real_shell}.txt" 06 variables_read
}

# ---------------------------------------------------------------- bonus b1
# "Linked Secret" — a chain of two symlinks, the second one hidden.
init_missionb1() {
    local room="$ROOMS/b1"; mkdir -p "$room"
    write_flag_file "$room/.step2_target" b1 linked_secret
    ( cd "$room" && ln -sf .step2_target .step2 && ln -sf .step2 clue )
}

# ---------------------------------------------------------------- bonus b2
# "Disk Space" — one folder per disk-usage percentage; the real one
# matches this machine's `df -h .` Use% captured right now.
init_missionb2() {
    local room="$ROOMS/b2"; mkdir -p "$room"
    local usep=""
    if command -v df >/dev/null 2>&1; then
        usep="$(df -h "$LAB_ROOT" 2>/dev/null | awk 'NR==2 {print $(NF-1)}')"
    fi
    usep="${usep%\%}"
    [ -n "$usep" ] || usep="0"
    local real_dir="used_${usep}"
    mkdir -p "$room/$real_dir"
    printf '%s\n' "$real_dir" > "$LAB_STATE_DIR/b2_real_dir"
    for decoy in 12 45 88; do
        [ "used_$decoy" = "$real_dir" ] && continue
        mkdir -p "$room/used_$decoy"
    done
}

require_not_root
init_mission00
init_mission01
init_mission02
init_mission03
init_mission04
init_mission05
init_mission06
init_missionb1
init_missionb2
ok "Rooms are ready in lab_workspace/rooms/"
