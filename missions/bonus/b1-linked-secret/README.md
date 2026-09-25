# Bonus b1 — Linked Secret  (~5 min)

**Uses:** hidden files (mission 02) + links (mission 03).

```
cd ~/linux-essentials
ls lab_workspace/rooms/b1
```

You should see one link called `clue`. It points to a **hidden** link, and
that link points to the real file. A shortcut to a shortcut!

## Your turn

1. Use `ls -la lab_workspace/rooms/b1` (that's `-l` and `-a` together) to
   see the hidden files **and** where each arrow `->` points.
2. Read the flag with `cat`. `cat` follows all the arrows for you.

## Check your flag

```
./check_flag.sh b1 FLAG{...}
```

---
Stuck? `cat missions/bonus/b1-linked-secret/hints/hint1.txt`
