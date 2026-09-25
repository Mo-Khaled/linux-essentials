# Mission 04 — Create Files  (~10 min)

**You will learn:** how to make files and write into them.

- `touch NAME` makes a new, empty file.
- `echo "words"` prints words on the screen.
- `>` sends what a command prints **into a file**. It **replaces** what was
  in the file before.
- `>>` also sends into a file, but it **adds to the end**. It keeps what
  was there.

## Step 1 — Go into the room

```
cd ~/linux-essentials/lab_workspace/rooms/04
```

## Step 2 — Practice

```
touch practice.txt
echo "apple" > practice.txt
cat practice.txt
```

You should see: `apple`

```
echo "banana" >> practice.txt
cat practice.txt
```

You should see `apple` **and** `banana`. `>>` added to the end.

```
echo "cherry" > practice.txt
cat practice.txt
```

You only see `cherry`! `>` wiped everything and started again.

## Step 3 — Look at the two pieces

```
cat piece1.txt
cat piece2.txt
```

## Your turn

Make a file called `evidence.txt` that has piece 1 on the first line and
piece 2 on the second line.

Idea: `cat piece1.txt` prints piece 1. Send that into `evidence.txt` with
`>`. Then send piece 2 with... which arrow keeps what's already there?

## Check your work

```
cd ~/linux-essentials
./check_flag.sh 04 --verify
```

If it's right, it shows your flag and you're done with this mission.

---
Stuck? `cat missions/04-create-files/hints/hint1.txt`
