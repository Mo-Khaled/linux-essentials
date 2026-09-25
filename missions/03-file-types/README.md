# Mission 03 — File Types  (~10 min)

**You will learn:** how to see what *kind* of thing each file is.

`ls -l` means "list, **l**ong version". It shows more details. The very
**first letter** of each line tells you the kind:

| First letter | Kind |
|---|---|
| `-` | a normal file |
| `d` | a **d**irectory (folder) |
| `l` | a **l**ink — a shortcut that points to another file |

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Normal list

```
ls lab_workspace/rooms/03
```

You should see: `folder  report.txt  shortcut`. You can't tell what kind
they are yet.

## Step 3 — Long list

```
ls -l lab_workspace/rooms/03
```

Now look at the first letter of each line.

## Your turn

One line starts with `l` and has an arrow `->`. That's the shortcut (a
link). The arrow shows which file it points to.

Read the shortcut with `cat` — `cat` follows the arrow for you and shows
the real file.

## Check your flag

```
./check_flag.sh 03 FLAG{...}
```

---
Stuck? `cat missions/03-file-types/hints/hint1.txt`
