#!/usr/bin/env bash
# Flag generation/verification helpers.
#
# Design: every flag is FLAG{<label>_<8 hex chars>}. The hex suffix is a
# hash of a per-clone RANDOM session seed (generated once, at init time,
# from /dev/urandom) plus the mission id and label. The seed lives only in
# lab_workspace/.state/session_seed — it is gitignored, never committed, and
# regenerated fresh on every clone/reset. Nothing in tracked git history
# contains any value needed to compute a real flag, so a student cannot
# reproduce a flag by reading this file; they can only obtain one by causing
# the mission's own setup/worker code to look up the seed and write the
# resulting flag out via the technique the mission actually teaches.
#
# Sourced by other scripts — do not execute directly.

: "${LAB_ROOT:?common.sh must be sourced before flaglib.sh}"

SEED_FILE="$LAB_STATE_DIR/session_seed"

_hash_cmd() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum
    elif command -v md5sum >/dev/null 2>&1; then
        md5sum
    else
        # extremely unlikely on Ubuntu, but fail loudly instead of silently
        err "Neither sha256sum nor md5sum is available — cannot generate flags."
        exit 1
    fi
}

# Create the session seed if it doesn't exist yet. Idempotent.
ensure_seed() {
    ensure_workspace
    if [ ! -s "$SEED_FILE" ]; then
        if command -v head >/dev/null 2>&1 && [ -r /dev/urandom ]; then
            head -c 32 /dev/urandom | _hash_cmd | awk '{print $1}' > "$SEED_FILE"
        else
            # fallback: still per-clone/per-run random, just lower quality
            printf '%s-%s-%s' "$RANDOM" "$(date +%s%N 2>/dev/null || date +%s)" "$$" | _hash_cmd | awk '{print $1}' > "$SEED_FILE"
        fi
        chmod 600 "$SEED_FILE" 2>/dev/null || true
    fi
}

read_seed() {
    ensure_seed
    cat "$SEED_FILE"
}

# gen_flag <mission_id> <label>  ->  FLAG{label_xxxxxxxx}
gen_flag() {
    local mission="$1" label="$2" seed
    seed="$(read_seed)"
    local h
    h="$(printf '%s' "${seed}:${mission}:${label}" | _hash_cmd | awk '{print $1}' | cut -c1-8)"
    printf 'FLAG{%s_%s}\n' "$label" "$h"
}

# check_flag <mission_id> <label> <submitted_flag>  -> 0 if match, 1 otherwise
check_flag() {
    local mission="$1" label="$2" submitted="$3" expected
    expected="$(gen_flag "$mission" "$label")"
    [ "$submitted" = "$expected" ]
}
