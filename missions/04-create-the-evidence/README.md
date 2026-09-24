# Mission 04 — Create the Evidence

**Level 2 · Easy-Medium (10 min) · PDF: Part 1 — touch, echo, >, >>, cat**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/04/
```

There's no flag file waiting for you this time — you have to build it.
Two evidence fragments are sitting in this room, in the right order, in two
separate files. Your job is to combine them, in order, into a single file
named `evidence.txt`.

This is exactly the kind of mistake the PDF warns about: one redirection
arrow **replaces** a file's content, two redirection arrows **add** to it.
Use the wrong one for the second fragment and you'll destroy the first.

## Your task

1. Look at what's in the room.
2. Create `evidence.txt` containing the first fragment.
3. Add the second fragment to the **end** of `evidence.txt` — don't
   overwrite what's already there.
4. This mission doesn't hand you a pre-made flag — it's earned by state.
   Once `evidence.txt` looks right, check your work:
   ```
   ./check_flag.sh 04 --verify
   ```
   It will tell you if something's off, and reveal your flag once it's
   correct.

## Submit

```
./check_flag.sh 04 FLAG{...}
```

## Hints

```
cat missions/04-create-the-evidence/hints/hint1.txt
```
