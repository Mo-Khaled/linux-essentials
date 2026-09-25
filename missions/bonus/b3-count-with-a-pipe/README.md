# Bonus b3 — Count with a Pipe  (~10 min)

**You will learn:** how to join commands together to count things.

The pipe `|` sends what one command prints into the next command. You can
join many commands this way. `wc -l` counts **l**ines.

## Step 1 — Start the programs

```
cd ~/linux-essentials
bash scripts/start_bonus_b3.sh
```

This starts some `linuxctf_worker_` programs and some `linuxctf_helper_`
programs.

## Step 2 — See them all

```
pgrep -af linuxctf
```

## Step 3 — Try counting

```
echo "one
two
three" | wc -l
```

You should see: `3`

## Your turn

Count **only** the `linuxctf_worker_` programs (not the helpers). Then save
that number into the file `lab_workspace/rooms/b3/answer.txt` using `>`
(from mission 04).

Idea: `pgrep -f WORD` prints one line for each program with that word.
Send it into `wc -l`, then send the result into the file.

## Check your work

```
./check_flag.sh b3 --verify
```

---
Stuck? `cat missions/bonus/b3-count-with-a-pipe/hints/hint1.txt`
