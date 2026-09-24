# Instructor Guide — Linux Essentials CTF

**This file is instructor-only.** It contains the full answer key. Do not
publish it where students can read it — see the note at the top of the
main `README.md` for how to strip it before publishing
(`scripts/make_student_release.sh` automates this).

## How the lab works (mechanics, for your own understanding)

- Students run `./start.sh` once. It runs `scripts/preflight.sh` (checks
  for `at`/`crontab`/`pgrep`/`pkill`/`killall`/`pstree`/`top` and warns —
  never installs anything, no `sudo`), then `scripts/init_missions.sh`,
  which builds the static scenario for missions 00-07 and bonus b1 under
  `lab_workspace/rooms/`.
- A random secret ("session seed") is generated the first time, from
  `/dev/urandom`, and stored at `lab_workspace/.state/session_seed`
  (gitignored, never committed, regenerated on `--reset`). Every flag is
  `FLAG{label_<8 hex>}`, where the hex is a hash of that seed + mission id
  + label (`scripts/lib/flaglib.sh`). **No flag can be computed by reading
  the repo** — the seed only exists at runtime, per clone. This is why
  `grep -R "FLAG{" .` on a fresh clone finds nothing: nothing has been
  generated yet, and everything lives under the gitignored
  `lab_workspace/`.
- Missions 04, 05, 06, 07, 11 don't hand out a pre-placed flag. They're
  **state-gated**: `check_flag.sh <mission> --verify` (logic in
  `scripts/lib/verifiers.sh`) inspects the actual filesystem/pipeline state
  the student produced and only computes+reveals the flag once it's
  correct. This directly ties the flag to having done the real action, not
  to having read a file.
- Missions 08, 09, 10, 11, 14 launch real background processes
  (`scripts/start_missionNN.sh` → `scripts/lib/state.sh`'s `spawn_worker`,
  which copies `scripts/worker.sh` to a distinctively-named file under
  `lab_workspace/.state/bin/` and runs it — this way `ps`/`pgrep` see the
  lab's own process name directly in the command line). Every spawned PID
  is recorded to `lab_workspace/.state/procs/*.pid` with its expected name,
  so `cleanup.sh` only ever signals a PID after re-checking it still
  matches that name (never a blind kill-by-name sweep as the *first*
  resort).
- Missions 12/13/b3 use the student's own **user-level** `at`/`crontab`.
  The cron line students add is tagged `# LINUX_ESSENTIALS_CTF`;
  `scripts/remove_cron_entry.sh` (called by `cleanup.sh`) removes only
  lines carrying that marker — it never runs `crontab -r`.

## PDF technical notes / corrections (things the PDF simplifies or that don't translate directly to a hands-on lab)

1. **`at` without piped input is interactive.** PDF slide 24 shows
   `at now +5 hours` / `at 3pm + 4 days` as if directly runnable; without
   piped/redirected stdin, real `at` opens an interactive `at>` prompt
   (Ctrl+D to send). This lab always uses `echo "cmd" | at ...`, matching
   the PDF's own first example, and mission 12's hints call this out
   explicitly so students don't get stuck at a prompt they don't
   recognize.
2. **Slide 8's `ls -las` sample output is illustrative, not literal.** It
   shows 4 columns before the filename (blocks, permissions, links, owner)
   and omits the byte-size field real `ls -l` includes between owner/group
   and date. Nothing in this lab depends on students reproducing that
   exact abbreviated layout — they see genuine `ls -l` output throughout.
3. **Real vs. simulated filesystem.** The PDF's `ls /etc`, `ls /dev`,
   `ls /var` examples inspect the real system. This lab can't safely place
   graded, mutable evidence inside real `/etc`/`/dev`/`/var` (that would
   need root and would be genuinely risky). Missions 00/01 have students
   inspect the **real**, read-only system directories for the concept, then
   find graded evidence in a clearly-named, never-colliding
   `lab_workspace/rooms/...` stand-in — the mission text says which is
   which every time, so students never confuse the simulation with the
   real machine.
4. **Process life-cycle diagram (slide 17)** and **thread diagram (slide
   15)** are conceptual and not turned into hands-on exercises — see the
   coverage matrix for what's marked instructor-demo-only and why.

## Timing

- **Full lab**: ~3 hours (00-14 + bonus), including the ~2-5 minutes of
  real waiting built into missions 12/13/b3.
- **Short lab** (fits a single 1-1.5h lab session): 00, 02, 03, 04, 06, 08,
  10, 13 — touches every PDF part with fewer total missions.
- **Fast finishers**: bonus b1/b2/b3, ~5-10 min each.

## Per-mission answer key

Legend per mission: **Concept** · **Do** · **Inspect** · **Observation
that should click** · **Misconception/mistake it catches** · **What the
flag proves** · **Expected commands** · **Flag mechanism** · **Common
mistakes** · **Time**.

### Mission 00 — Identify Your System (Level 1, Easy, 5-10m)

- **Concept**: `whoami`/`pwd`/`uname -a`, `$SHELL`.
- **Do**: read `$SHELL`, find the matching file among 7 shell-named decoys.
- **Inspect**: `lab_workspace/rooms/00/`.
- **Observation**: `echo $SHELL` gives a full path; only the basename
  matters.
- **Misconception caught**: confusing "the shell you're using" with "every
  shell installed" (`/etc/shells` lists all installed shells, not the
  current one).
- **Flag proves**: they can read an environment variable and reason about
  a path's basename.
- **Expected commands**: `whoami`, `pwd`, `uname -a`, `echo $SHELL`, `ls`,
  `cat`.
- **Flag mechanism**: pre-placed at init time in the one file matching
  `basename "$SHELL"`.
- **Common mistakes**: cat-ing the full path instead of the basename;
  trying `/etc/shells` instead of `$SHELL`.

### Mission 01 — Explore Linux (Level 1, Easy, 5-10m)

- **Concept**: `ls /`, `/etc` = config.
- **Do**: inspect real `/`, real `/etc`; find the matching simulated room.
- **Inspect**: real `/`, `/etc`; `lab_workspace/rooms/01/config_room/`.
- **Observation**: `/etc` genuinely holds config-looking files
  (`passwd`, `hosts`, `shells`...).
- **Misconception caught**: `/var` vs `/etc` vs `/dev` (all "system-ish"
  to a beginner, very different purposes).
- **Flag mechanism**: pre-placed in `config_room/flag.txt`; the other 3
  rooms (`devices_room`, `variable_data_room`, `user_homes_room`) hold
  explanatory decoy notes.
- **Common mistakes**: picking `devices_room` (confusing "hardware" with
  "configuration").

### Mission 02 — Hidden Evidence (Level 1, Easy, 5m)

- **Concept**: `ls -a`, dotfiles.
- **Flag mechanism**: `lab_workspace/rooms/02/.evidence`, plain text.
- **Common mistakes**: forgetting dotfiles aren't a permissions thing —
  some students try `chmod`/`sudo`.

### Mission 03 — File Detective (Level 1, Easy, 5-10m)

- **Concept**: `ls -l`, file type column, symlinks.
- **Flag mechanism**: `lab_workspace/rooms/03/shortcut` → `.locker`
  (hidden target). `cat shortcut` follows it transparently.
- **Common mistakes**: trying to `cd` into the symlink; not noticing the
  `l` type character vs `-`/`d`.

### Mission 04 — Create the Evidence (Level 2, Easy/Med, 10m)

- **Concept**: `touch`, `echo`, `>` vs `>>`, `cat`.
- **Flag mechanism**: **state-gated** (`verify_04` in `verifiers.sh`).
  Checks `lab_workspace/rooms/04/evidence.txt` content equals
  `piece1.txt`'s content followed by `piece2.txt`'s content, each on its
  own line. Correct sequence: `cat piece1.txt > evidence.txt && cat
  piece2.txt >> evidence.txt`.
- **Common mistakes**: using `>` for both (overwrites, loses piece 1) —
  this is the exact classic mistake the PDF calls out, reproduced as a
  gate rather than a warning.

### Mission 05 — Move the Evidence (Level 2, Medium, 10-15m)

- **Concept**: `mkdir`, `cp`, `ln -s`, `rm`.
- **Flag mechanism**: **state-gated** (`verify_05`). Checks
  `vault/case_file.txt` exists, `case_link` is a symlink resolving to it,
  and `old_notes.txt` no longer exists.
- **Solution**:
  ```
  cd lab_workspace/rooms/05
  mkdir vault
  cp source/original.txt vault/case_file.txt
  ln -s vault/case_file.txt case_link
  rm old_notes.txt
  cd -; ./check_flag.sh 05 --verify
  ```
- **Common mistakes**: using `mv` instead of `cp` for the vault copy
  (destroys the source, verifier doesn't actually require the source to
  still exist, but it's worth a teaching moment about cp vs mv);
  symlinking the wrong direction (`ln -s case_link vault/case_file.txt`).
- **Windows/Git-Bash testing note**: `ln -s` cannot be exercised
  end-to-end in this dev environment (see Testing section below) — real
  Ubuntu required to confirm `verify_05`'s `[ -L ... ]` check.

### Mission 06 — Storage Investigation (Level 2, Medium, 10-15m)

- **Concept**: `df -h`, `df -h .`, mount points, use%.
- **Flag mechanism**: **state-gated** (`verify_06`). At `init_missions.sh`
  time, the script runs `df -h` on the repo's own directory, extracts the
  real "Mounted on" and "Use%" fields, and creates one folder named from
  them (e.g. `mount_root_use_61pct`) alongside 3 fixed decoys with
  plausible-but-wrong numbers. Because it's captured from the *student's
  own machine at setup time*, this is robust across very different
  environments (bare metal, VM, WSL, cloud) without needing to hardcode
  anything.
- **Common mistakes**: running `df -h` (all partitions) and not narrowing
  to `df -h .`; not noticing the folder name encodes both mount point and
  use% (both have to match).

### Mission 07 — Environment Investigation (Level 3, Medium, 10-15m)

- **Concept**: `$HOME`, `source`, `export`.
- **Flag mechanism**: **state-gated** (`verify_07`). Checks a file named
  by `unlock.env`'s `CASE_FILE` variable (`claim.txt`) exists inside
  `lab_workspace/rooms/07/$(basename "$HOME")/`.
- **Common mistakes**: reading `unlock.env` with `cat` instead of
  `source`-ing it (reading doesn't set the variable in their shell); using
  the full `$HOME` path instead of its basename as the folder name.

### Mission 08 — Find the Process (Level 3, Medium, 10-15m)

- **Concept**: `&`, `jobs`, `ps`, PID.
- **Flag mechanism**: `scripts/start_mission08.sh` spawns
  `linuxctf_evidence_daemon` (`worker.sh` mode `alive-flag`), which
  rewrites `lab_workspace/rooms/08/flag_while_running.txt` every 2s while
  alive and deletes it on exit/SIGTERM/SIGINT. No signal is required to
  solve this mission — it's about *finding* the running process before it
  (potentially) stops, and confirms `jobs` alone isn't enough if the
  process wasn't started from that same shell.
- **Common mistakes**: relying only on `jobs` (empty if started differently
  or in another terminal) instead of `ps -ef | grep`.

### Mission 09 — Process Hunter (Level 3, Medium, 10-15m)

- **Concept**: `ps -e`/`-ef`, `pgrep`, `pidof`, `pstree`.
- **Flag mechanism**: `scripts/start_mission09.sh` spawns 4
  `linuxctf_worker_9_N` processes plus 1 `linuxctf_decoy_service`
  impostor. The real evidence folder is named `found_4`; decoys `found_3`,
  `found_5`, `found_6` exist too. Student must count precisely (`pgrep -c
  linuxctf_worker_9_`) and not include the impostor.
- **Common mistakes**: counting all `linuxctf_*` processes (includes the
  impostor) instead of the specific `_worker_9_` family.

### Mission 10 — Kill the Process (Level 4, Med/Hard, 15m)

- **Concept**: SIGTERM vs SIGKILL, `kill`, `kill -9`, `killall`, `pkill`.
- **Flag mechanism**: `linuxctf_target` (`worker.sh` mode `sigterm-flag`)
  only writes `lab_workspace/rooms/10/flag_after_term.txt` inside its
  SIGTERM trap. `kill -9` bypasses the trap entirely (kernel-level, no
  userspace cleanup possible) — process dies, no flag, and the mission
  README tells them to just restart it and try again with the right
  signal. This is a hands-on demonstration of the PDF's SIGTERM/SIGKILL
  distinction rather than a slide.
- **Common mistakes**: reaching straight for `kill -9` out of habit; not
  realizing they need to re-launch the target after killing it wrong.
- **Windows/Git-Bash testing note**: see Testing section — SIGTERM
  delivery to a backgrounded worker script could not be fully exercised in
  this dev environment; the trap logic is standard, well-documented bash
  and should be smoke-tested once on real Ubuntu before the session.

### Mission 11 — Pipeline (Level 4, Med/Hard, 15m)

- **Concept**: `|`, `grep`, `wc -l`.
- **Flag mechanism**: **state-gated** (`verify_11`). 5 genuine
  `linuxctf_worker_11_N` + 2 `linuxctf_bystander_N` processes start;
  expected count (5) is recorded at launch time in
  `lab_workspace/.state/mission11_expected_count`. Student must write the
  precise count into `lab_workspace/rooms/11/answer.txt` via a pipeline
  they build themselves.
- **Solution**:
  `ps -ef | grep linuxctf_worker_11_ | grep -v grep | wc -l > lab_workspace/rooms/11/answer.txt`
- **Common mistakes**: forgetting `grep -v grep` (grep's own process line
  matches its own search pattern, off-by-one); counting bystanders too
  (imprecise pattern).

### Mission 12 — Delayed Evidence (Level 5, Med/Hard, 15-20m incl. wait)

- **Concept**: `at`, `atq`/`at -l`.
- **Flag mechanism**: student schedules `scripts/at_emitter.sh`; it writes
  `lab_workspace/rooms/12/evidence.txt` (containing the flag) only once it
  actually fires — nothing exists before that.
- **Common mistakes**: running `at now + 2 minutes` with no piped stdin
  (opens an interactive prompt, see PDF correction #1); forgetting `at`
  needs `atd` running (instructor should confirm ahead of time).

### Mission 13 — Recurring Evidence (Level 5, Hard, 15-20m incl. wait)

- **Concept**: `cron`, `crontab -e`/`-l`/`-r`, 5-field syntax.
- **Flag mechanism**: student adds a `crontab -e` line (tagged
  `# LINUX_ESSENTIALS_CTF`) running `scripts/cron_emitter.sh` every
  minute; it overwrites `lab_workspace/rooms/13/evidence.txt` each tick.
- **Cleanup**: `bash scripts/remove_cron_entry.sh` removes only the tagged
  line — **never tell students to run `crontab -r`** as cleanup; that
  wipes their entire personal crontab. The mission README calls this out
  explicitly.
- **Common mistakes**: using a relative script path in the crontab line
  (cron's working directory isn't the repo — use the absolute path, as
  the hints show); forgetting the marker comment (makes later cleanup
  harder, though `crontab -e` by hand always works too).

### Mission 14 — Final Investigation (Level 6, Hard, 20m)

- **Concept**: full chain, no new commands.
- **Flag mechanism**: `.dossier` (hidden, names the process) →
  `linuxctf_final_target` (`worker.sh` mode `sigterm-b64`) → SIGTERM it →
  writes `base64(payload)` to `encoded.b64`, where `payload` is the
  relative path `rooms/14/vault/final_evidence.txt` → `base64 -d` reveals
  that path → `cat lab_workspace/<path>` → real final flag (placed at
  launch time in `vault/final_evidence.txt`).
- **Common mistakes**: decoding the base64 and expecting a flag directly
  (it's a *path*, one more hop remains); `kill -9`-ing the process out of
  habit (no trap fires, no encoded file, same lesson as mission 10 reused
  here deliberately).

### Bonus B1 — Linked Secret

Two-hop symlink chain (`clue` → `.step2` → `.step2_target`), the middle
hop hidden. `cat lab_workspace/rooms/b1/clue` resolves the whole chain.

### Bonus B2 — Signal Log

Single `linuxctf_bonus_watcher` process; evidence folder named by PID
digit-length (`len_N`), computed and matched at launch time so it's always
correct regardless of the actual PID value on that machine.

### Bonus B3 — Cron Hunter

Same mechanism as mission 13, pointed at `scripts/bonus_cron_emitter.sh`,
writing a **hidden** file (`lab_workspace/rooms/b3/.evidence`) instead of a
visible one — combines cron with the `ls -a` skill from mission 02.

## Difficulty validation pass (performed while writing the missions)

Re-read as a student who only knows the PDF, mission by mission:

- Every mission's required concepts trace to PDF material at or before its
  own level; nothing forward-references a later mission (checked against
  `PDF_COVERAGE_MATRIX.md`).
- 00-03 (Level 1) are single-technique, no combinations, matching "teach
  the loop, don't stump anyone."
- 04-06 (Level 2) chain 2-4 same-family filesystem commands; still no
  independent tool *selection* required — the family (file ops vs. df) is
  named by the mission.
- 07-09 (Level 3) is where tool selection starts mattering — env var
  family, then "which process-inspection tool" is genuinely up to the
  student.
- 10-11 (Level 4) require combining identification (Level 3 skills) with a
  new action (signals / pipelines) — appropriately harder because more is
  combined, not because clues got vaguer.
- 12-13 (Level 5) add real waiting/statefulness, appropriately time-boxed
  as the longest missions.
- 14 (Level 6) intentionally introduces zero new concepts — pure
  combination, matching the "final boss reuses everything" rule.
- No mission relies on a hidden/undocumented fact a diligent PDF reader
  couldn't reach; every "which folder is correct" decision point resolves
  from real command output the student generates themselves, never from
  arbitrary trivia.
- **Adjustment made during this pass**: mission 05's `README.md` originally
  spelled out `mkdir`/`cp`/`ln -s`/`rm` as an explicit ordered checklist,
  which read more like "type this" than "figure this out" for a Level 2
  mission. Rewritten to describe the *outcome* needed (a vault, a copy, a
  shortcut, a cleaned-up scratch file) and pushed the literal command names
  into the hint ladder instead, consistent with every other mission.

## Testing performed (and what still needs a real-Ubuntu pass)

Built and tested from a Windows machine using Git Bash — see the top-level
testing summary for full detail. In short:

- **Verified here**: all scripts pass `bash -n`; the full filesystem-only
  chain (missions 00, 01, 02, 03, 04, 06, 07 plus the `check_flag.sh`
  discovery and `--verify` paths) was run end-to-end for real and works
  correctly, including `start.sh`'s idempotency and `--reset`.
- **Not fully verifiable in Git Bash, needs one real-Ubuntu pass before the
  session**: `ln -s` (Git Bash on Windows without symlink privileges falls
  back to writing a plain file instead of a real symlink, so mission 05's
  and bonus b1's symlink checks couldn't be exercised end-to-end here);
  SIGTERM delivery to a backgrounded worker script (a Windows/MSYS
  signal-emulation quirk unrelated to the script logic — confirmed the
  *general* trap+background+`kill -TERM` mechanism works in Git Bash in
  isolation, but the exact combination used by `worker.sh` did not reliably
  receive the signal in this environment); `at`, `crontab`, `pgrep`,
  `pkill`, `killall`, `pstree`, `top` are simply not present in this Git
  Bash install. None of this indicates a bug in the scripts — `ln -s`,
  bash traps in backgrounded scripts, and all of the above tools are
  completely standard, well-documented Ubuntu behavior — but please run
  through missions 05, 08, 09, 10, 11, 12, 13, 14, and bonus b1-b3 once on
  a real Ubuntu machine before running this with students.

## Cleanup for instructors

`./cleanup.sh` is safe to run repeatedly and only touches lab-created
state (recorded PIDs verified by name, `lab_workspace/`, the tagged cron
line). It never touches real system files and never runs `crontab -r`.
