# Mission 07 — Environment Investigation

**Level 3 · Medium (10-15 min) · PDF: Part 2 — $HOME, $SHELL, $PATH, export, source**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/07/
```

Every user gets their own "case room" here, named after their own home
directory — not the whole path, just the last part of it. Several decoy
case rooms exist for other (fictional) users. There's also a small
environment file in this room that, once loaded into your shell, tells you
the exact filename your case room is expecting.

## Your task

1. Figure out the last part of your own `$HOME` path — that names your case
   room here (nothing is written to your real `$HOME`; this only uses the
   *name*, safely, inside the lab's own workspace).
2. Load the environment file sitting in this room into your current shell
   (not just read it — the PDF's Part 2 has a command that loads a file's
   variables directly into your session) to learn the exact filename you
   need to create.
3. Create that file, empty, inside your case room.
4. Check your work:
   ```
   ./check_flag.sh 07 --verify
   ```

## Submit

```
./check_flag.sh 07 FLAG{...}
```

## Hints

```
cat missions/07-environment-investigation/hints/hint1.txt
```
