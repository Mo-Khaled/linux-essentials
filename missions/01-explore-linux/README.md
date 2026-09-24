# Mission 01 — Explore Linux

**Level 1 · Easy (5-10 min) · PDF: Part 1 — "On Linux, Everything Is a File"**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

Real Linux systems organize almost everything under a handful of top-level
directories off of `/`. Four of the most important:

- one holds **configuration files**
- one holds **device files**
- one holds **changing data** (logs, caches, mail...)
- one holds **per-user home directories**

Go inspect the **real** system (read-only — you don't need to and shouldn't
change anything there) to figure out which real top-level directory is
"the one that holds configuration files."

## Your task

1. List the real root of the filesystem and look at what's there.
2. Peek inside the directory you believe holds configuration files (a
   plain listing is enough — you're just confirming, e.g., that
   config-looking files live there).
3. This lab keeps a *simulated* stand-in for that concept — not the real
   system — under:
   ```
   lab_workspace/rooms/01/
   ```
   It contains four "rooms," each standing in for one of those four real
   directories, named descriptively (not `etc`/`dev`/`var`/`home` — so you
   never confuse the simulation with the real machine). Only the
   **configuration room** holds the flag.

## Submit

```
./check_flag.sh 01 FLAG{...}
```

## Hints

```
cat missions/01-explore-linux/hints/hint1.txt
```
