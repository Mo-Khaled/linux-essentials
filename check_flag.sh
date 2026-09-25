#!/usr/bin/env bash
# Local flag checker.
#
#   ./check_flag.sh <mission> <FLAG{...}>   check a flag you found
#   ./check_flag.sh <mission> --verify      missions 04, 05, b2, b3: check your
#                                            work and, if it's right, show the flag
#
# <mission> is 00 ... 08, or a bonus id b1 ... b5.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/flaglib.sh"
source "$SCRIPT_DIR/scripts/lib/verifiers.sh"

MISSION="${1:-}"
ARG="${2:-}"

if [ -z "$MISSION" ] || [ -z "$ARG" ]; then
    echo "How to use:  ./check_flag.sh 00 FLAG{...}" >&2
    exit 2
fi

label_for() {
    case "$1" in
        00) echo first_steps ;;
        01) echo explorer ;;
        02) echo hidden_found ;;
        03) echo link_followed ;;
        04) echo files_created ;;
        05) echo files_organized ;;
        06) echo variables_read ;;
        07) echo process_found ;;
        08) echo process_stopped ;;
        b1) echo linked_secret ;;
        b2) echo disk_space ;;
        b3) echo pipe_counted ;;
        b4) echo run_it_later ;;
        b5) echo final_boss ;;
        *) echo "" ;;
    esac
}

# folder name of the mission that comes after $1 (empty after the last one)
next_mission_dir() {
    case "$1" in
        00) echo 01-explore-linux ;;
        01) echo 02-hidden-files ;;
        02) echo 03-file-types ;;
        03) echo 04-create-files ;;
        04) echo 05-organize-files ;;
        05) echo 06-environment-variables ;;
        06) echo 07-find-the-process ;;
        07) echo 08-stop-the-process ;;
        08) echo bonus/b1-linked-secret ;;
        b1) echo bonus/b2-disk-space ;;
        b2) echo bonus/b3-count-with-a-pipe ;;
        b3) echo bonus/b4-run-it-later ;;
        b4) echo bonus/b5-final-boss ;;
        *) echo "" ;;
    esac
}

print_next() {
    local next; next="$(next_mission_dir "$MISSION")"
    say ""
    if [ "$MISSION" = "08" ]; then
        ok "You finished all the main missions. Great job!"
        say "Want more? Try the bonus missions:"
    elif [ -z "$next" ]; then
        ok "You finished EVERYTHING. You are a Linux champion!"
        say "When you're done, run:  ./cleanup.sh"
        return
    else
        say "Next mission:"
    fi
    say "  cat missions/$next/README.md"
}

LABEL="$(label_for "$MISSION")"
if [ -z "$LABEL" ]; then
    err "There is no mission called '$MISSION'. Use 00 to 08, or b1 to b5."
    exit 2
fi

state_gated_missions="04 05 b2 b3"

if [ "$ARG" = "--verify" ]; then
    case " $state_gated_missions " in
        *" $MISSION "*) ;;
        *)
            info "Mission $MISSION doesn't use --verify. Find the flag, then run:"
            info "  ./check_flag.sh $MISSION FLAG{...}"
            exit 0
            ;;
    esac
    if reason="$("verify_${MISSION}")"; then
        ok "Well done! Mission $MISSION solved. Your flag is:"
        say "  $(gen_flag "$MISSION" "$LABEL")"
        print_next
        exit 0
    else
        warn "Not yet: $reason"
        exit 1
    fi
fi

expected="$(gen_flag "$MISSION" "$LABEL")"
if [ "$ARG" = "$expected" ]; then
    ok "Correct! Mission $MISSION solved."
    print_next
    exit 0
else
    err "That's not the right flag for mission $MISSION. Tip: copy it with Ctrl+Shift+C and paste with Ctrl+Shift+V."
    exit 1
fi
