#!/usr/bin/env bash
# Shared helpers for the Linux Essentials CTF lab scripts.
# Sourced by other scripts — do not execute directly.

# Resolve the repo root regardless of where a script is invoked from.
# common.sh always lives at <repo_root>/scripts/lib/common.sh
lab_root() {
    local src="${BASH_SOURCE[0]}"
    while [ -h "$src" ]; do
        local dir
        dir="$(cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd)"
        src="$(readlink "$src")"
        [[ $src != /* ]] && src="$dir/$src"
    done
    cd -P "$(dirname "$src")/../.." >/dev/null 2>&1 && pwd
}

LAB_ROOT="$(lab_root)"
LAB_WORKSPACE="$LAB_ROOT/lab_workspace"
LAB_STATE_DIR="$LAB_WORKSPACE/.state"
LAB_CRON_MARKER="# LINUX_ESSENTIALS_CTF"

c_reset='\033[0m'; c_green='\033[0;32m'; c_yellow='\033[0;33m'
c_red='\033[0;31m'; c_cyan='\033[0;36m'; c_bold='\033[1m'

say()  { printf "%b\n" "$*"; }
info() { printf "%b[*]%b %s\n" "$c_cyan" "$c_reset" "$*"; }
ok()   { printf "%b[+]%b %s\n" "$c_green" "$c_reset" "$*"; }
warn() { printf "%b[!]%b %s\n" "$c_yellow" "$c_reset" "$*"; }
err()  { printf "%b[x]%b %s\n" "$c_red" "$c_reset" "$*" >&2; }

# Refuse to run as root — this lab never needs it, and nothing here should
# ever touch real system files, so running as root would only be a mistake.
require_not_root() {
    if [ "$(id -u 2>/dev/null)" = "0" ]; then
        err "This lab must NOT be run as root/sudo. Re-run as your normal user."
        exit 1
    fi
}

ensure_workspace() {
    mkdir -p "$LAB_WORKSPACE" "$LAB_STATE_DIR"
}
