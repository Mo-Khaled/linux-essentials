#!/usr/bin/env bash
# State-gated missions (04, 05, b2, b3) don't hand out a flag by simply
# reading a pre-placed file — the flag is only computed and revealed once
# the student's own actions produce the expected end state.
#
# Each verify_XX function returns 0 (state correct -> caller may reveal the
# flag) or 1 (not yet -> caller prints the reason in plain words). Sourced
# by check_flag.sh — do not execute directly.

: "${LAB_WORKSPACE:?common.sh must be sourced before verifiers.sh}"

verify_04() {
    local f="$LAB_WORKSPACE/rooms/04/evidence.txt"
    [ -f "$f" ] || { echo "There is no evidence.txt in lab_workspace/rooms/04/ yet."; return 1; }
    local want got
    want="$(printf 'PART-ONE\nPART-TWO')"
    got="$(cat "$f" 2>/dev/null)"
    [ "$got" = "$want" ] && return 0
    echo "evidence.txt should have PART-ONE on line 1 and PART-TWO on line 2. Look at it with: cat lab_workspace/rooms/04/evidence.txt"
    return 1
}

verify_05() {
    local room="$LAB_WORKSPACE/rooms/05"
    [ -d "$room/vault" ] || { echo "There is no folder called vault yet (use mkdir)."; return 1; }
    [ -f "$room/vault/report.txt" ] || { echo "vault/report.txt is missing (use cp)."; return 1; }
    [ -f "$room/report.txt" ] || { echo "report.txt must stay in the room: use cp (copy), not mv. Put it back with: cp vault/report.txt ."; return 1; }
    [ -f "$room/final.txt" ] || { echo "final.txt is missing (rename draft.txt with mv)."; return 1; }
    [ -e "$room/draft.txt" ] && { echo "draft.txt is still there (mv renames it, so the old name disappears)."; return 1; }
    [ -e "$room/junk.txt" ] && { echo "junk.txt is still there (use rm)."; return 1; }
    return 0
}

verify_b2() {
    local real_dir
    real_dir="$(cat "$LAB_STATE_DIR/b2_real_dir" 2>/dev/null)"
    [ -n "$real_dir" ] || { echo "Lab files are missing — run ./start.sh again."; return 1; }
    [ -f "$LAB_WORKSPACE/rooms/b2/$real_dir/i_was_here" ] || { echo "No i_was_here file in the folder that matches your Use% from df -h ."; return 1; }
    return 0
}

verify_b3() {
    local f="$LAB_WORKSPACE/rooms/b3/answer.txt"
    [ -f "$f" ] || { echo "There is no answer.txt in lab_workspace/rooms/b3/ yet."; return 1; }
    local expected got
    expected="$(cat "$LAB_STATE_DIR/b3_expected_count" 2>/dev/null)"
    got="$(tr -d '[:space:]' < "$f" 2>/dev/null)"
    [ -n "$expected" ] || { echo "The workers are not running — run: bash scripts/start_bonus_b3.sh"; return 1; }
    [ "$got" = "$expected" ] && return 0
    echo "answer.txt has '$got', which is not the right number. Count only linuxctf_worker_ programs."
    return 1
}
