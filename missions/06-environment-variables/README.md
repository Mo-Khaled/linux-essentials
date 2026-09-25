# Mission 06 — Environment Variables  (~10 min)

**You will learn:** what variables are and how to read them.

A **variable** is a name that holds a value, like a box with a label on
it. Linux keeps some boxes ready for you. To look inside a box, put `$` in
front of its name and use `echo`.

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Read some variables

```
echo $USER
```

Your username (the same as `whoami`).

```
echo $HOME
```

Your home folder. `~` is a short way to write this folder.

```
echo $SHELL
```

Your **shell**. The shell is the program that reads what you type and
runs it. It prints something like `/bin/bash`.

## Step 3 — Make your own variable

```
export COLOR=blue
echo $COLOR
```

You should see: `blue`. (No spaces around the `=`!)

## Step 4 — Look in the room

```
ls lab_workspace/rooms/06
```

You should see files named after different shells: `bash.txt`,
`zsh.txt`, `fish.txt`, ...

## Your turn

Only the file named after **your** shell has the flag. Look at what
`echo $SHELL` printed: the last word after the final `/` is your shell's
name. Read that file with `cat`.

## Check your flag

```
./check_flag.sh 06 FLAG{...}
```

---
Stuck? `cat missions/06-environment-variables/hints/hint1.txt`
