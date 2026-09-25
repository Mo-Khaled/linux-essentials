# Bonus b5 — Final Boss  (~15 min)

**Uses everything:** hidden files, processes, `kill`, and one new command.

This time there are no step-by-step commands. You already know them all!

## Start

```
cd ~/linux-essentials
bash scripts/start_bonus_b5.sh
```

## Your mission

1. There is a **hidden** file in `lab_workspace/rooms/b5/`. Find it and
   read it. (Mission 02)
2. It tells you the name of a program. Find its PID. (Mission 07)
3. Stop it the **gentle** way. (Mission 08)
4. It leaves a file called `secret.b64`. It looks like nonsense because it
   is written in **base64** (a way of writing text in a scrambled form).
   Decode it with:

   ```
   base64 -d lab_workspace/rooms/b5/secret.b64
   ```

5. The decoded text is the path to the flag file. Read it with `cat`.

## Check your flag

```
./check_flag.sh b5 FLAG{...}
```

---
Stuck? `cat missions/bonus/b5-final-boss/hints/hint1.txt`
