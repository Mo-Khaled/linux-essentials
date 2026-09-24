# Linux Essentials CTF

> **Instructors:** before you publish this repository somewhere students
> can see it, remove or privatize the `instructor/` folder — it holds the
> full answer key. Either `git rm -r instructor && git commit`, keep it on
> a private branch/fork, or run `./scripts/make_student_release.sh`, which
> builds a clean, answer-free copy under `dist/` for you automatically.

Welcome to the Linux Essentials Investigation.

This is a hands-on, "Find the Flag" companion to a Linux Essentials /
Operating Systems session covering the Linux filesystem, environment
variables, processes, process control & signals, and scheduling. Instead of
a list of commands to run, you get a series of investigation missions.
Each one gives you a clue, not an answer — you decide which Linux command
or concept solves it.

```
DO → INSPECT → OBSERVE → REASON → FIND THE FLAG → UNLOCK THE NEXT MISSION
```

## Prerequisites

- A real Ubuntu/Linux machine, VM, or WSL install (not required to be
  Ubuntu specifically, but the PDF/session this lab supports assumes it).
- `bash` and standard coreutils (already on any Ubuntu install).
- `git`, to clone this repo.
- **No `sudo` required anywhere in this lab.** A few missions (12, 13, and
  the process-hunting missions) use `at`, `cron`, `pgrep`/`pkill`/`killall`/
  `pstree` — if your machine is missing one of these, ask your instructor
  to install it ahead of time (`scripts/preflight.sh` tells you exactly
  what's missing and the one-line `apt install` for it).

## Getting started

```
git clone <this-repository-url>
cd linux-essentials-ctf
./start.sh
```

`start.sh` checks your tools, sets up the first several missions, and tells
you where to start. It's safe to run more than once — it won't overwrite
anything you've already done. If you ever want a completely fresh start:

```
./start.sh --reset
```

Then:

```
cat missions/00-identify-your-system/README.md
```

Each mission's `README.md` is your clue. Work out which Linux command or
concept applies, try it, and see what you find. If you're stuck, each
mission has a `hints/` folder with 2-3 hints, ordered from gentle nudge to
fairly direct — open them one at a time, only as needed:

```
cat missions/00-identify-your-system/hints/hint1.txt
```

## Submitting flags

Every mission's flag looks like `FLAG{...}`. Check yours locally:

```
./check_flag.sh 00 FLAG{...}
```

A handful of missions (04, 05, 06, 07, 11) don't hand you a pre-made flag —
you prove you did the right thing first, and the flag is generated once
your workspace state is actually correct:

```
./check_flag.sh 06 --verify
```

Your flags are unique to your own clone/session (a random value is
generated the first time you run `start.sh`) — don't share your flags with
classmates, and don't expect someone else's flags to validate against your
`check_flag.sh`.

## Missions

| # | Mission | Level | Time | PDF section |
|---|---------|-------|------|-------------|
| 00 | Identify Your System | 1 — Easy | 5-10m | Part 0: OS/Linux intro |
| 01 | Explore Linux | 1 — Easy | 5-10m | Part 1: filesystem hierarchy |
| 02 | Hidden Evidence | 1 — Easy | 5m | Part 1: `ls -a` |
| 03 | File Detective | 1 — Easy | 5-10m | Part 1: `ls -l`, file types |
| 04 | Create the Evidence | 2 — Easy/Med | 10m | Part 1: touch/echo/`>`/`>>`/cat |
| 05 | Move the Evidence | 2 — Medium | 10-15m | Part 1: cp/mv/ln -s/rm |
| 06 | Storage Investigation | 2 — Medium | 10-15m | Part 1: `df -h`, `df -h .` |
| 07 | Environment Investigation | 3 — Medium | 10-15m | Part 2: `$HOME`/`$PATH`/`export`/`source` |
| 08 | Find the Process | 3 — Medium | 10-15m | Part 3: `&`, `jobs`, `ps` |
| 09 | Process Hunter | 3 — Medium | 10-15m | Part 4: `ps -ef`, `pgrep`, `pstree` |
| 10 | Kill the Process | 4 — Med/Hard | 15m | Part 4: signals, `kill`, `kill -9` |
| 11 | Pipeline | 4 — Med/Hard | 15m | Part 4: `\|`, `grep`, `wc -l` |
| 12 | Delayed Evidence | 5 — Med/Hard | 15-20m | Part 5: `at`, `atq` |
| 13 | Recurring Evidence | 5 — Hard | 15-20m | Part 5: `cron`, `crontab` |
| 14 | Final Investigation | 6 — Hard | 20m | Combines the whole lab |
| B1-B3 | Bonus | Optional | 5-10m each | Fast-finisher combos |

### Full Lab

All 15 missions plus bonus, done in order. Budget ~3 hours for a full pass
including waiting on missions 12/13.

### Short Lab (time-limited sessions)

If you're short on time, this subset still touches every PDF part:
**00, 02, 03, 04, 06, 08, 10, 13.**

### Fast Finishers

Done early? The `missions/bonus/` folder has three optional combo
challenges (`b1`, `b2`, `b3`) that mix concepts from earlier missions.

## Rules

- Work through missions in order — later ones assume you've done (or at
  least understand) the earlier ones.
- Don't share flags, hints you've written down, or spoilers with
  classmates who haven't solved a mission yet.
- Nothing in this lab requires `sudo`. If a mission seems to be asking for
  it, that's not the intended solution — ask your instructor.
- Everything this lab creates lives inside the cloned repository, mainly
  under `lab_workspace/` (plus one tagged line in your own personal
  crontab for missions 13/b3, which you remove yourself when done).

## Safety

- No script here ever runs `sudo`, deletes anything outside this
  repository, or touches real system files (`/etc`, `/dev`, `/var` are only
  ever read, never written to).
- Every background process this lab starts has an unmistakable name
  (`linuxctf_...`) so you can always tell lab processes apart from real
  ones, and so cleanup never risks touching anything else.
- Mission 13/bonus b3 add exactly one line to **your own personal**
  crontab, tagged `# LINUX_ESSENTIALS_CTF`. The PDF also teaches
  `crontab -r` — be aware that command deletes your *entire* crontab, not
  just this lab's line; this lab's own cleanup never uses it.

## Cleanup

When you're done (or if anything gets stuck):

```
./cleanup.sh
```

This stops every lab process it started, removes the tagged crontab entry
(and tells you about any pending lab `at` job so you can remove it with
`atrm`), and deletes `lab_workspace/`. It never touches anything else.

## For instructors

See `instructor/INSTRUCTOR_GUIDE.md` (full answer key, teaching notes, and
timing) and `instructor/PDF_COVERAGE_MATRIX.md` (every PDF command/concept
mapped to the mission that covers it). Remember to strip or privatize
`instructor/` before publishing this repo to students — see the note at the
top of this file.
