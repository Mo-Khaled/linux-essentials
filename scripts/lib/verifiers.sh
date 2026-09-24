#!/usr/bin/env bash
# State-gated missions (04, 05, 06, 07, 11) don't hand out a flag by simply
# reading a pre-placed file — the flag is only computed and revealed once
# the student's own filesystem/pipeline actions produce the expected end
# state. This keeps the flag tied to real action, not lucky reading.
#
# Each verify_XX function returns 0 (state correct -> caller may reveal the
# flag) or 1 (not yet -> caller prints the *reason*, never the missing
# command). Sourced by check_flag.sh — do not execute directly.

: "${LAB_WORKSPACE:?common.sh must be sourced before verifiers.sh}"

verify_04() {
    local f="$LAB_WORKSPACE/rooms/04/evidence.txt"
    [ -f "$f" ] || { echo "evidence.txt does not exist yet in rooms/04."; return 1; }
    local want
    want="$(printf 'LAB-EVIDENCE-PART-ONE\nLAB-EVIDENCE-PART-TWO')"
    local got
    got="$(cat "$f" 2>/dev/null)"
    if [ "$got" = "$want" ]; then
        return 0
    fi
    echo "evidence.txt exists but its content isn't the two parts in the right order/mode."
    return 1
}

verify_05() {
    local room="$LAB_WORKSPACE/rooms/05"
    [ -f "$room/vault/case_file.txt" ] || { echo "vault/case_file.txt not found — the report hasn't been filed into the vault yet."; return 1; }
    [ -L "$room/case_link" ] || { echo "case_link doesn't exist yet (or isn't a symbolic link)."; return 1; }
    local target
    target="$(readlink -f "$room/case_link" 2>/dev/null)"
    local want
    want="$(readlink -f "$room/vault/case_file.txt" 2>/dev/null)"
    [ -n "$target" ] && [ "$target" = "$want" ] || { echo "case_link exists but doesn't point at vault/case_file.txt."; return 1; }
    [ -f "$room/old_notes.txt" ] && { echo "old_notes.txt is still here — the scratch copy needs to be removed once filed."; return 1; }
    return 0
}

verify_06() {
    local room="$LAB_WORKSPACE/rooms/06/storage"
    local real_dir
    real_dir="$(cat "$LAB_STATE_DIR/mission06_real_dir" 2>/dev/null)"
    [ -n "$real_dir" ] || { echo "Lab state missing — re-run start.sh."; return 1; }
    [ -f "$room/$real_dir/i_was_here" ] || { echo "No marker found in the folder matching this machine's real 'df -h .' output."; return 1; }
    return 0
}

verify_07() {
    local room="$LAB_WORKSPACE/rooms/07"
    local user_dir
    user_dir="$(basename "$HOME")"
    [ -f "$room/$user_dir/claim.txt" ] || { echo "No claim.txt found under the case room matching \$HOME's last path segment."; return 1; }
    return 0
}

verify_11() {
    local f="$LAB_WORKSPACE/rooms/11/answer.txt"
    [ -f "$f" ] || { echo "answer.txt not found in rooms/11 yet."; return 1; }
    local expected got
    expected="$(cat "$LAB_STATE_DIR/mission11_expected_count" 2>/dev/null)"
    got="$(tr -d '[:space:]' < "$f" 2>/dev/null)"
    [ -n "$expected" ] || { echo "Lab state missing — re-run start.sh, or the workers already stopped: restart mission 11."; return 1; }
    if [ "$got" = "$expected" ]; then
        return 0
    fi
    echo "answer.txt exists but doesn't hold the right count yet."
    return 1
}
