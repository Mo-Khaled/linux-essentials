# Mission 09 — Process Hunter

**Level 3 · Medium (10-15 min) · PDF: Part 4 — ps -e/-ef, pgrep, pidof, pstree**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

A pool of lab worker processes is about to launch, all sharing a common
name pattern — except one, which was slipped in under a different name to
see if you're paying attention. The evidence folder for this mission is
named after **how many genuine workers** are actually running — not
counting the impostor.

## Your task

1. Launch the pool:
   ```
   bash scripts/start_mission09.sh
   ```
2. Use process-inspection tools from Part 4 of the PDF (`ps -e`, `ps -ef`,
   `pgrep`, `pidof`, `pstree`) to find every process whose name starts with
   `linuxctf_worker_9_`, and count them precisely — don't count the
   impostor, whose name doesn't match that pattern.
3. That count tells you which folder under
   `lab_workspace/rooms/09/investigation/` holds the real evidence. The
   others are decoys with the wrong count.

## Submit

```
./check_flag.sh 09 FLAG{...}
```

## Hints

```
cat missions/09-process-hunter/hints/hint1.txt
```
