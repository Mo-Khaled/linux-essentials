#!/usr/bin/env bash
# Checks that the tools this lab relies on are present. Never installs
# anything and never uses sudo — if something is missing, it prints the
# instructor-facing install hint and lets the caller decide what to do.
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# shellcheck source=lib/common.sh
source "$SCRIPT_DIR/lib/common.sh"

missing=0

check() {
    local cmd="$1" hint="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "$cmd found"
    else
        warn "$cmd NOT found — $hint"
        missing=1
    fi
}

info "Checking required tools..."
check bash        "should always be present on Ubuntu"
check ls           "coreutils — should always be present"
check ps            "procps — should always be present"
check grep           "should always be present"
check awk             "gawk/mawk — should always be present"
check sha256sum        "coreutils — should always be present"
check base64             "coreutils — should always be present"

info "Checking process-inspection tools (Part 4 of the PDF)..."
check pgrep        "procps — sudo apt install procps"
check pkill          "procps — sudo apt install procps"
check killall          "psmisc — sudo apt install psmisc"
check pstree              "psmisc — sudo apt install psmisc"
check top                   "procps — sudo apt install procps"

info "Checking scheduling tools (Part 5 of the PDF)..."
check at       "sudo apt install at   (then: sudo service atd start)"
check crontab     "cron — sudo apt install cron   (then: sudo service cron start)"

if [ "$missing" -eq 0 ]; then
    ok "All tools present. The lab should run end-to-end."
else
    warn "Some tools are missing. Students can still do most of the lab;"
    warn "an instructor should install the missing packages ahead of the"
    warn "session using the hints above (none of this requires the student"
    warn "to run sudo)."
fi

exit 0
