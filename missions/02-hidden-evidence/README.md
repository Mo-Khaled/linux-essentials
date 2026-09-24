# Mission 02 — Hidden Evidence

**Level 1 · Easy (5 min) · PDF: Part 1 — ls flags**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/02/
```

A plain listing of this room shows exactly one file, and it's a dead end.
But a normal listing doesn't show everything Linux is willing to store in a
directory — some files are deliberately left out unless you ask.

## Your task

1. List the room normally. Note what you see.
2. Linux hides files whose name starts with a certain character. List the
   room again, but this time ask to see *all* files, including those.
3. Read whatever you find.

## Submit

```
./check_flag.sh 02 FLAG{...}
```

## Hints

```
cat missions/02-hidden-evidence/hints/hint1.txt
```
