# Mission 03 — File Detective

**Level 1 · Easy (5-10 min) · PDF: Part 1 — File types / ls -l**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/03/
```

This room has three different kinds of filesystem object sitting side by
side: a regular file, a directory, and something that only *looks* like a
regular file in a plain listing — but points somewhere else entirely.

## Your task

1. List the room normally, then list it with details/long format so you can
   see each entry's **type**, not just its name.
2. Find the entry whose type character means "this is a link, not a real
   file" (the PDF's file-types slide has the full list: `-`, `d`, `l`, `c`,
   `b`, `s`, `p`).
3. Follow it.

## Submit

```
./check_flag.sh 03 FLAG{...}
```

## Hints

```
cat missions/03-file-detective/hints/hint1.txt
```
