# Bonus b2 — Disk Space  (~10 min)

**You will learn:** how to see how full your disk is.

`df -h` shows every disk and how full it is. The `-h` makes the numbers
easy for **h**umans to read (like `20G` instead of `20971520`).

## Step 1 — Look at all disks

```
cd ~/linux-essentials
df -h
```

## Step 2 — Look at only the disk you are on

`.` means "the folder I'm in right now".

```
df -h .
```

You should see one line. Find the `Use%` column: it says how full this
disk is, like `61%`.

## Step 3 — Look at the room

```
ls lab_workspace/rooms/b2
```

You should see folders like `used_12`, `used_45`, `used_88`, ...

## Your turn

Find the folder whose number matches **your** `Use%`. Put an empty file
called `i_was_here` inside it with `touch`.

## Check your work

```
./check_flag.sh b2 --verify
```

---
Stuck? `cat missions/bonus/b2-disk-space/hints/hint1.txt`
