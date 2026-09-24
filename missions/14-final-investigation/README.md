# Mission 14 — Final Investigation

**Level 6 · Hard (20 min) · Combines: hidden files, process ID, signals, encoding, file ops**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

This is the last case, and it pulls together everything the investigation
has taught you so far. Nothing new to learn here — just the full chain,
done yourself, start to finish. No single clue below tells you the whole
path; you have to follow it.

## Your task

1. Start the final investigation:
   ```
   bash scripts/start_mission14.sh
   ```
2. There's a dossier hidden somewhere in `lab_workspace/rooms/14/` — it
   won't show up in a plain listing. Find it and read it.
3. The dossier names a process. Find it, confirm it's running, and get its
   PID.
4. It will only cooperate with a clean, polite termination signal — the
   same one you used in mission 10. Force-killing it tells you nothing.
5. Once it's terminated cleanly, it leaves behind an encoded file at
   `lab_workspace/rooms/14/encoded.b64`. It's not human-readable as-is —
   it's wrapped in a standard, reversible text encoding (not a cipher —
   just an encoding, and there's a standard Linux tool to reverse it).
6. Decoding it reveals a *path* — not the flag itself. Follow that path
   (it's relative to `lab_workspace/`) and read what's there.

## Submit

```
./check_flag.sh 14 FLAG{...}
```

## Hints

```
cat missions/14-final-investigation/hints/hint1.txt
```
