# Mission 08 — Find the Process

**Level 3 · Medium (10-15 min) · PDF: Part 3 — sleep, &, jobs, ps, PID, fg/bg**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

A background process is about to start running on this machine. While it's
alive, it's writing evidence to a file — but the moment it stops running,
that evidence disappears. You need to find it (by name, not by luck) while
it's still up.

## Your task

1. Launch it:
   ```
   bash scripts/start_mission08.sh
   ```
2. Confirm it's actually running and find out its PID. You have several
   tools from Part 3/4 of the PDF for this — a background-jobs list if you
   started it from this same shell, or a general process listing if you
   didn't (or want the real PID rather than a job number).
3. While it's alive, its evidence file exists at:
   ```
   lab_workspace/rooms/08/flag_while_running.txt
   ```
   Read it. If you stop the process first, the file disappears — that's
   intentional, and it's the point of this mission.

## Submit

```
./check_flag.sh 08 FLAG{...}
```

## Hints

```
cat missions/08-find-the-process/hints/hint1.txt
```
