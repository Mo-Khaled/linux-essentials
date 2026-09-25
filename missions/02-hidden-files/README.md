# Mission 02 — Hidden Files  (~5 min)

**You will learn:** how to see hidden files.

In Linux, a file whose name **starts with a dot** (like `.secret`) is
hidden. A normal `ls` does not show it. It's not locked — just hidden.

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Look in the room

```
ls lab_workspace/rooms/02
```

You should see only one file: `normal.txt`

## Step 3 — Read it

```
cat lab_workspace/rooms/02/normal.txt
```

It says the flag is hidden somewhere in this room.

## Your turn

`ls -a` means "list **a**ll" — it shows hidden files too. Use it on the
room, find the hidden file, and read it with `cat`.

(You will also see `.` and `..` — those just mean "this folder" and "the
folder above". Ignore them.)

## Check your flag

```
./check_flag.sh 02 FLAG{...}
```

---
Stuck? `cat missions/02-hidden-files/hints/hint1.txt`
