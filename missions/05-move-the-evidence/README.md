# Mission 05 — Move the Evidence

**Level 2 · Medium (10-15 min) · PDF: Part 1 — cp, mv, ln -s, rm**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/05/
```

A case only counts as properly filed once it's been through the correct
chain of custody: the original evidence has to be duplicated into an
official vault, a shortcut has to point at that copy so it can be found
quickly later, and the loose scratch copy lying around has to be cleaned
up — no evidence should exist in two casual places at once.

Look inside the room. You'll find a source copy, an old scratch note that
shouldn't stick around once things are filed properly, and no vault yet —
you have to create one.

## Your task

File the case properly:

1. The vault doesn't exist yet — you'll need to make it.
2. The evidence needs to end up **duplicated** into the vault as
   `case_file.txt` (the original source stays where it is — you're
   duplicating, not relocating it).
3. Once it's filed, the case needs a **shortcut** — a link, not a second
   copy — sitting in the room and named `case_link`, pointing at the file
   you just placed in the vault.
4. The loose scratch note that was lying around before filing has served
   its purpose. Get rid of it.
5. Check your work — it will tell you exactly what's still missing:
   ```
   ./check_flag.sh 05 --verify
   ```

## Submit

```
./check_flag.sh 05 FLAG{...}
```

## Hints

```
cat missions/05-move-the-evidence/hints/hint1.txt
```
