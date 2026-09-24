# PDF Coverage Matrix (instructor-only)

Every command, concept, and practical exercise from
`1-Linux_Essentials_Session.pdf`, mapped to where it's exercised in the
lab. "Hands-on activity" means a student actually has to use it to solve a
mission — appearing only in the cheat sheet, a hint's prose, or a comment
does not count as coverage.

## Part 0 — Introduction

| PDF item | Coverage |
|---|---|
| What is an OS? (layers diagram) | Instructor-demo-only — conceptual, no terminal action maps to it directly. Present in mission 00's briefing narrative. |
| What is Linux? (open source, multi-user/multitasking, distributions) | Instructor-demo-only — narrative/lecture content. |
| Kernel + Shell + Apps | Reinforced by mission 00 (`$SHELL`) and mission 07 (kernel vs shell distinction in briefing); the OS-layer diagram itself is demo-only. |
| `uname -a` | **Hands-on: Mission 00** (used to confirm system identity, part of the briefing task). |
| Multi-user / multitasking concept | Instructor-demo-only — no safe hands-on multi-user exercise without additional accounts. |

## Part 1 — File System

| PDF item | Coverage |
|---|---|
| Everything is a file / directories are files / devices are files | Instructor-demo-only concept; reinforced narratively in Mission 01 and Mission 03 (file types). |
| `ls /`, `/etc`, `/dev`, `/var`, `/home` | **Hands-on: Mission 01** (real, read-only inspection to identify `/etc`). |
| File types (`-drwxrwxrwx` etc: regular, dir, link, char, block, socket, pipe) | **Hands-on: Mission 03** (`ls -l`, regular/dir/symlink discrimination). Char/block/socket/pipe types are covered in the PDF's table and explained in Mission 03's briefing/hints, but this lab does not (and should not, without root) create real device/socket/pipe files — see note below. |
| Partitions / mount points | **Hands-on: Mission 06** (`df -h`, `df -h .`). |
| `ls -l` | **Hands-on: Missions 03, 05.** |
| `ls -a` | **Hands-on: Missions 02, 14, Bonus b1, b3.** |
| `ls -s`, `ls -las`, `ls -laS` | Instructor-demo-only in this build — the PDF's own cheat sheet features `-laS`; no mission gates a flag specifically on the `-s` size-column output (would require students to compare block sizes, which is fragile across filesystems). Instructors should demo `ls -laS ~` live per the PDF's own "Try It Yourself" exercise. |
| `touch`, `echo`, `>`, `>>`, `cat` | **Hands-on: Mission 04** (state-gated on exact `>`/`>>` sequence). |
| `less`, `nano` | Instructor-demo-only — no mission requires an interactive pager/editor (keeps the lab scriptable/non-interactive for `check_flag.sh`); demo live per PDF slide 9. |
| `mkdir`, `cd`, `cp`, `mv`, `ln -s`, `rm`, `rm -r` | **Hands-on: Mission 05** (mkdir, cp, ln -s, rm) and Mission 04/throughout (cd). `mv` is taught/reinforced in Mission 05's hints (cp vs mv distinction) though the verifier only requires cp; `rm -r` is exercised via `cleanup.sh`'s own explanation and mission 05's vault directory removal is optional cleanup, not gated. |
| `rmdir` vs `rm -r` | Instructor-demo-only — explicitly called out as a common-mistake teaching point in the Instructor Guide's mission 05 entry. |

## Part 2 — Environment

| PDF item | Coverage |
|---|---|
| Kernel vs Shell | Instructor-demo-only narrative; reinforced by Mission 00/07. |
| `/etc/shells` | Instructor-demo-only — mentioned in Mission 00's framing (contrasted with `$SHELL`) but not gated. |
| `echo $SHELL` | **Hands-on: Mission 00.** |
| `echo $HOME` | **Hands-on: Mission 07.** |
| `echo $PATH` | Instructor-demo-only in this build — `$PATH` is explained in Mission 07's briefing and cheat sheet, but not separately gated (its value varies too much across student machines/shells to build a robust matching mechanic without fragility; `$HOME` and `source` carry Part 2's hands-on weight instead). |
| `export` | **Hands-on: Mission 07** (via `unlock.env`, though the student `source`s rather than writes their own `export` — see `source` below). |
| `source ~/.bashrc` / `source` | **Hands-on: Mission 07** (`source unlock.env`). |
| `ls -lt`, `ls -lS`, `ls -ltr`, `ls -lSr` | Instructor-demo-only — same reasoning as `ls -s` above; demo live per PDF slide 14. |

## Part 3 — Processes

| PDF item | Coverage |
|---|---|
| Program vs process vs thread | Instructor-demo-only — conceptual (slide 15's browser example has no safe hands-on equivalent). |
| PID, process memory | **Hands-on: Missions 08, 09, 10** (PIDs used directly; memory concept is narrative only). |
| Foreground vs background, `&` | **Hands-on: Mission 08** (worker started with `&` semantics via the launcher; briefing explains foreground/background). |
| `jobs`, Ctrl+Z, Ctrl+C, `bg`, `fg` | **Hands-on: Mission 08** (`jobs` is one of the discovery tools suggested). Ctrl+Z/Ctrl+C/`bg`/`fg` specifically: instructor-demo-only in this build, since the lab's background workers are started by a script (not by the student pressing Ctrl+Z), matching the PDF's own "Try It Yourself — Processes & Jobs" exercise, which instructors should run live as a companion drill. |
| Daemons, `init`/`sshd`/`httpd`/`ftpd` | Instructor-demo-only — the lab's own worker processes are explicitly framed as "lab daemons" in mission 08's narrative; inspecting real system daemons like `sshd` is safe read-only (`ps -ef \| grep sshd`) but not gated to any flag. |
| Process life cycle diagram | Instructor-demo-only — conceptual. |

## Part 4 — Process Control

| PDF item | Coverage |
|---|---|
| `\|` (pipe) | **Hands-on: Mission 11**, also mission 08/09/10 hints suggest `ps -ef \| grep`. |
| `ps`, `ps -e`, `ps -ef` | **Hands-on: Missions 08, 09, 10, 11.** |
| `grep` | **Hands-on: Mission 11** (also used throughout as a suggested filter). |
| `head` | Instructor-demo-only in this build — PDF's `ps -e | head` example; no mission strictly requires `head` (mission 11 uses `grep`+`wc -l`). Mentioned in Mission 09's PDF-alignment but not gated — worth a live demo. |
| `wc -l` | **Hands-on: Mission 11.** |
| `pstree` | **Hands-on tool offered: Mission 09** (one of the valid discovery tools; not the only path, so not strictly required — still a genuine hands-on option every student is pointed at). |
| `top`, `top -u` | Instructor-demo-only — real-time monitor doesn't fit a scripted, non-interactive `check_flag.sh` flow; demo live per PDF slide 20. |
| PID/PPID/UID/%CPU/%MEM/PR/NI/TIME/CMD columns | Instructor-demo-only table; PID is the only column directly load-bearing for missions (08, 09, 10). |
| Signals (SIGHUP/SIGINT/SIGKILL/SIGTERM) | **Hands-on: Mission 10, 14** (SIGTERM vs SIGKILL specifically gated on the flag mechanism). SIGHUP/SIGINT are explained in the briefing/hints but not separately gated — SIGINT is what Ctrl+C sends, already covered conceptually via Part 3. |
| `kill`, `kill -SIGTERM`, `kill -9` | **Hands-on: Missions 10, 14.** |
| `killall`, `pkill` | **Hands-on: Mission 10** (offered as equally valid alternatives to `kill` by PID in the hints). |
| `pidof`, `pgrep` | **Hands-on: Missions 09, 10, 14, Bonus b2.** |

## Part 5 — Scheduling

| PDF item | Coverage |
|---|---|
| `sleep` | **Hands-on: implicit throughout** — every lab worker process's idle loop is `sleep`-based, matching the PDF's own demo pattern; also directly usable by students experimenting per the PDF's own "Try It Yourself" sleep+`&&` exercise. |
| `&&` | Instructor-demo-only in this build's gated missions — the PDF's `sleep 1 && echo "one"` pattern is a "Try It Yourself" drill better run live; no mission flag depends on `&&` specifically, since dependent success-chaining isn't easily made robust for a scripted grader. |
| `at`, `at -m`, `at now + N`, `at -l`/`atq` | **Hands-on: Mission 12.** |
| `cron`, `crontab -e`/`-l`/`-r`, 5-field syntax | **Hands-on: Mission 13, Bonus b3** (`-e`, `-l` hands-on; `-r` is explicitly taught as a *danger*, not used as the cleanup mechanism — see Instructor Guide). |
| Cron syntax examples (`0 15 * * 1-5`, `*/2 * * * *`, etc.) | Instructor-demo-only table; students write their own simple "every minute" (`* * * * *`) line for mission 13/b3, which exercises the syntax without requiring every example pattern. |

## Practical exercises (PDF's own "Try It Yourself" slides)

Every "Try It Yourself" slide's *intent* is covered by at least one
mission (files → missions 04/05; file system → missions 01/02/03/06;
processes & jobs → mission 08; find/watch/kill → missions 09/10/11;
scheduling → missions 12/13). Where a PDF drill doesn't map to a scripted,
gradable mission (interactive editor use, Ctrl+Z/Ctrl+C by hand, `top`,
`ls -lt`/`-lS` sorting, `&&` chaining, `head`), it's flagged
instructor-demo-only above and is a good live companion demo alongside the
mission it's adjacent to — the Instructor Guide's timing section assumes
you may want to spend 5-10 extra minutes on these live between missions.
