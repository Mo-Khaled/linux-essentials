# Mission 10 — Kill the Process

**Level 4 · Medium-Hard (15 min) · PDF: Part 4 — signals, kill, kill -9, killall, pkill**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

A target process is about to start. It will only hand over its evidence if
it's given the chance to clean up after itself before it dies — a polite
termination request. If you force-kill it instead, it dies instantly with
no cleanup and no evidence. Choose your signal carefully.

## Your task

1. Launch the target:
   ```
   bash scripts/start_mission10.sh
   ```
2. Find its PID (Part 4's tools again).
3. Send it the signal that asks a process to terminate but allows it to
   clean up first — **not** the one that kills unconditionally.
4. Once it's gone, read:
   ```
   cat lab_workspace/rooms/10/flag_after_term.txt
   ```

If you jump straight to the forceful signal, the process dies with no
evidence — you'll need to re-run `start_mission10.sh` to get a fresh target
and try again with the correct one.

## Submit

```
./check_flag.sh 10 FLAG{...}
```

## Hints

```
cat missions/10-kill-the-process/hints/hint1.txt
```
