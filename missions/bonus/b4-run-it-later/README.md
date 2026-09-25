# Bonus b4 — Run It Later  (~10 min, includes 1 minute of waiting)

**You will learn:** how to tell the computer to run a command later.

`at` runs a command **one time**, at a time you choose. You give it the
command through a pipe `|`.

> Needs the `at` program. If you get "command not found", ask your instructor.

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Schedule the job

This runs the lab's script **1 minute from now**. Copy it exactly:

```
echo "bash $(pwd)/scripts/at_emitter.sh" | at now + 1 minute
```

## Step 3 — See your waiting job

```
atq
```

`atq` shows jobs that are waiting to run (the **at** **q**ueue).

## Your turn

The flag file does not exist yet! Wait one minute, run `atq` again (your
job is gone from the list = it ran), then look in `lab_workspace/rooms/b4/`
and read the flag.

## Check your flag

```
./check_flag.sh b4 FLAG{...}
```

---
Stuck? `cat missions/bonus/b4-run-it-later/hints/hint1.txt`
