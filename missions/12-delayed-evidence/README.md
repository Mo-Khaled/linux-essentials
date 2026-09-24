# Mission 12 — Delayed Evidence

**Level 5 · Medium-Hard (15-20 min, includes waiting) · PDF: Part 5 — sleep, &&, at, atq/at -l**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

Nothing needs to happen *right now* — it needs to happen a couple of
minutes from now, exactly once, without you sitting there waiting for it.
That's a job for the PDF's one-time scheduler, not for `sleep`.

## Your task

1. Schedule the script `scripts/at_emitter.sh` (use its full path from the
   repo root) to run **2 minutes from now**, using the one-time scheduler
   from Part 5 of the PDF. It writes nothing until it actually fires.
2. Confirm your job is queued and pending.
3. Wait for it to fire, then read:
   ```
   cat lab_workspace/rooms/12/evidence.txt
   ```

If `at`/`atd` isn't installed or running on your machine, ask your
instructor — this is a one-line package install they need to do ahead of
time, not something you should need `sudo` for yourself.

## Submit

```
./check_flag.sh 12 FLAG{...}
```

## Hints

```
cat missions/12-delayed-evidence/hints/hint1.txt
```
