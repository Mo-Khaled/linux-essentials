# Mission 07 — Find the Process  (~10 min)

**You will learn:** what a process is and how to find one.

A **process** is a program that is running right now. Every process gets a
number called a **PID** (**P**rocess **ID**), like a ticket number.

Some processes run in the **background**: they keep working while you
keep typing.

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Try a background process yourself

```
sleep 100 &
```

`sleep 100` waits 100 seconds. The `&` at the end sends it to the
background, so you get your terminal back right away.

```
jobs
```

`jobs` shows the background programs you started in this terminal.

## Step 3 — Start the mission's program

```
bash scripts/start_mission07.sh
```

This starts a program called `linuxctf_evidence_daemon` in the background.
While it is running, it keeps a flag file. When it stops, the file is deleted.

## Step 4 — See all processes

```
ps -ef
```

That's a LOT of lines! Every line is one running process. The second
column (`PID`) is its number.

## Your turn

1. Find **only** the lab's program. `grep` keeps only the lines that
   contain a word you choose:

   ```
   ps -ef | grep linuxctf
   ```

   The `|` is called a **pipe** (on most keyboards: Shift + `\`). It sends
   what one command prints into the next command. Find the PID of
   `linuxctf_evidence_daemon`.

2. While it is running, read its flag file:

   ```
   cat lab_workspace/rooms/07/flag_while_running.txt
   ```

## Check your flag

```
./check_flag.sh 07 FLAG{...}
```

---
Stuck? `cat missions/07-find-the-process/hints/hint1.txt`
