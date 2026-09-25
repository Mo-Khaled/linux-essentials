# Mission 01 — Explore Linux  (~10 min)

**You will learn:** what the main folders of Linux are for.

In Linux, everything starts from one top folder called `/` (say "root").
Inside it are special folders. Four important ones:

| Folder  | What lives there                         |
|---------|------------------------------------------|
| `/etc`  | **settings** (configuration files)        |
| `/dev`  | **devices** (disks, keyboard, ...)        |
| `/var`  | **logs** and data that keeps changing     |
| `/home` | **users' folders** (your files live here) |

## Step 1 — Go to the lab folder

```
cd ~/linux-essentials
```

## Step 2 — Look at the top of the whole system

```
ls /
```

You should see names like `bin  etc  home  var  dev ...`

## Step 3 — Peek inside the settings folder

```
ls /etc
```

You should see a lot of names, like `passwd`, `hosts`, `shells`. These are
the computer's settings. (Just look — don't change anything here!)

## Step 4 — Look at the lab's four rooms

The lab has four rooms. Each one pretends to be one of the folders above.

```
ls lab_workspace/rooms/01
```

You should see: `config_room  devices_room  logs_room  users_room`

## Your turn

Which room is like `/etc` (the **settings** folder)? Look inside that room
with `ls`, then read the file in it with `cat`.

## Check your flag

```
./check_flag.sh 01 FLAG{...}
```

---
Stuck? `cat missions/01-explore-linux/hints/hint1.txt`
