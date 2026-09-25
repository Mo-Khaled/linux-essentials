# Mission 08 — Stop the Process  (~10 min)

**You will learn:** how to stop a process, the gentle way and the hard way.

To stop a process, you send it a **signal** (a message) with `kill`:

| Command | Signal | What happens |
|---|---|---|
| `kill PID` | SIGTERM (gentle) | "Please stop." The program can tidy up first. |
| `kill -9 PID` | SIGKILL (hard) | The program is stopped instantly. No tidying up. |

Always try the gentle way first!

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Start the mission's program

```
bash scripts/start_mission08.sh
```

This starts a program called `linuxctf_target`. It gives you its flag
**only when it is stopped the gentle way**.

## Step 3 — Find its PID

```
pgrep -f linuxctf_target
```

It prints one number: the PID. (`ps -ef | grep linuxctf` from mission 07
works too.)

## Your turn

Stop it the **gentle** way using its PID. Then read the flag it left behind:

```
cat lab_workspace/rooms/08/flag_after_term.txt
```

If you used `kill -9`, the program was stopped before it could write the
flag. Run `bash scripts/start_mission08.sh` again and use the gentle way.

## Check your flag

```
./check_flag.sh 08 FLAG{...}
```

---
Stuck? `cat missions/08-stop-the-process/hints/hint1.txt`
