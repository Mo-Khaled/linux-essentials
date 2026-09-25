# Mission 05 — Organize Files  (~10 min)

**You will learn:** how to make folders, and copy, rename and delete files.

| Command | What it does | Pattern |
|---|---|---|
| `mkdir` | **m**a**k**e a **dir**ectory (folder) | `mkdir FOLDER` |
| `cp` | **c**o**p**y a file (the original stays) | `cp FILE WHERE` |
| `mv` | **m**o**v**e or rename a file (the old name is gone) | `mv OLD_NAME NEW_NAME` |
| `rm` | **r**e**m**ove (delete) a file. There is no trash can, it's gone! | `rm FILE` |

## Step 1 — Go into the room

```
cd ~/linux-essentials/lab_workspace/rooms/05
ls
```

You should see: `draft.txt  junk.txt  report.txt`

## Step 2 — Make a folder (we do this one together)

```
mkdir vault
ls
```

Now you also see `vault`.

## Your turn

Do these three jobs. Run `ls` after each one to see what changed.

1. **Copy** `report.txt` into the `vault` folder. (Use `cp`.)
2. **Rename** `draft.txt` to `final.txt`. (Use `mv`.)
3. **Delete** `junk.txt`. (Use `rm`.)

Look at the Pattern column in the table and put in the right names.

## Check your work

```
cd ~/linux-essentials
./check_flag.sh 05 --verify
```

If something is missing, it tells you what. Fix it and try again.

---
Stuck? `cat missions/05-organize-files/hints/hint1.txt`
