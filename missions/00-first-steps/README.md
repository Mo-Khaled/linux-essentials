# Mission 00 — First Steps  (~10 min)

**You will learn:** how to ask the computer "who am I?" and "where am I?",
and how to walk into folders and read files.

A **terminal** is a window where you type commands instead of clicking.
You type a command, press **Enter**, and the computer answers.

## Step 1 — Who am I?

```
whoami
```

You should see your username.

## Step 2 — What computer is this?

```
uname -a
```

You should see a long line with the word `Linux` in it. That is the
system you are using.

## Step 3 — Where am I?

```
pwd
```

`pwd` means **p**rint **w**orking **d**irectory. It shows the folder you
are standing in right now. It should end with `linux-essentials`.

## Step 4 — Walk into the mission folder

`cd` means **c**hange **d**irectory: it moves you into a folder.

```
cd lab_workspace/rooms/00
```

Tip: type `cd lab_` and press **Tab**. The terminal finishes the word for you!

## Step 5 — Look around

`ls` means **l**i**s**t: it shows what's inside the folder you're in.

```
ls
```

You should see: `empty_box  start_here  welcome.txt`

## Step 6 — Read a file

`cat` shows what is written inside a file.

```
cat welcome.txt
```

## Your turn

`welcome.txt` tells you where the flag is. Use `cd` to go into that
folder, use `ls` to look around, then use `cat` to read the flag file.

The flag looks like this: `FLAG{first_steps_1a2b3c4d}`

## Check your flag

First, go back to the lab's main folder:

```
cd ~/linux-essentials
```

Then check your flag (copy it with **Ctrl+Shift+C**, paste it with **Ctrl+Shift+V**):

```
./check_flag.sh 00 FLAG{...}
```

---
Stuck? `cat missions/00-first-steps/hints/hint1.txt`
