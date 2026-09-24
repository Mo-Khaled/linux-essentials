#!/usr/bin/env bash
# Local flag validator.
#
#   ./check_flag.sh <mission> <FLAG{...}>   validate a flag you already found
#   ./check_flag.sh <mission> --verify      for missions 04,05,06,07,11: check
#                                            whether your workspace/pipeline
#                                            state is correct, and if so,
#                                            reveal the flag
#
# <mission> is the two-digit id (00, 01, ... 14) or a bonus id (b1, b2, b3).
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/scripts/lib/common.sh"
source "$SCRIPT_DIR/scripts/lib/flaglib.sh"
source "$SCRIPT_DIR/scripts/lib/verifiers.sh"

MISSION="${1:-}"
ARG="${2:-}"

if [ -z "$MISSION" ] || [ -z "$ARG" ]; then
    echo "usage: $0 <mission> <FLAG{...}|--verify>" >&2
    exit 2
fi

label_for() {
    case "$1" in
        00) echo system_identified ;;
        01) echo explorer ;;
        02) echo hidden_found ;;
        03) echo symlink_traced ;;
        04) echo assembled_evidence ;;
        05) echo chain_of_custody ;;
        06) echo storage_located ;;
        07) echo home_claimed ;;
        08) echo daemon_caught ;;
        09) echo process_hunted ;;
        10) echo signal_master ;;
        11) echo pipeline_counted ;;
        12) echo delayed_evidence ;;
        13) echo recurring_evidence ;;
        14) echo final_investigation ;;
        b1) echo linked_secret ;;
        b2) echo signal_log ;;
        b3) echo cron_hunter ;;
        *) echo "" ;;
    esac
}

LABEL="$(label_for "$MISSION")"
if [ -z "$LABEL" ]; then
    err "Unknown mission id: $MISSION"
    exit 2
fi

state_gated_missions="04 05 06 07 11"

if [ "$ARG" = "--verify" ]; then
    case " $state_gated_missions " in
        *" $MISSION "*) ;;
        *)
            info "Mission $MISSION's flag isn't state-gated — once you find it, submit it directly:"
            info "  ./check_flag.sh $MISSION FLAG{...}"
            exit 0
            ;;
    esac
    verify_fn="verify_${MISSION}"
    if reason="$("$verify_fn")"; then
        flag="$(gen_flag "$MISSION" "$LABEL")"
        ok "State looks correct! Your flag:"
        say "  $flag"
        exit 0
    else
        warn "Not yet: $reason"
        exit 1
    fi
fi

expected="$(gen_flag "$MISSION" "$LABEL")"
if [ "$ARG" = "$expected" ]; then
    ok "Correct! Mission $MISSION solved."
    exit 0
else
    err "That's not the right flag for mission $MISSION."
    exit 1
fi
