#!/usr/bin/env bash
# Builds a student-safe copy of this repo under dist/ with the instructor
# answer key removed, so an instructor can publish dist/ (as a public repo,
# a zip, whatever) without manually stripping anything by hand.
#
# Usage: ./scripts/make_student_release.sh
set -u
SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

DIST="$LAB_ROOT/dist"
rm -rf "$DIST"
mkdir -p "$DIST"

# Copy everything except VCS metadata, generated lab state, and instructor
# materials.
( cd "$LAB_ROOT" && tar cf - \
    --exclude='.git' \
    --exclude='dist' \
    --exclude='lab_workspace' \
    --exclude='instructor' \
    . ) | ( cd "$DIST" && tar xf - )

if [ -d "$DIST/instructor" ]; then
    err "instructor/ leaked into dist/ — aborting, please investigate."
    exit 1
fi

ok "Student-safe release written to: $DIST"
info "This copy has no instructor/ folder and no answer key. Publish this one."
