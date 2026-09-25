# 🐧 Lab 2 — Getting Ready + Command Cheat Sheet

This guide gets your brand-new Ubuntu ready for the lab. It takes about
**10 minutes**. Do it **before** the lab starts if you can.

You will:

1. Open the terminal
2. Install **Git**, the tool that downloads the lab
3. Install **VS Code**, a nice app to see and edit files
4. Download the lab and start it

---

## Step 0 — Open the terminal

The **terminal** is a window where you type commands instead of clicking.

👉 Press **Ctrl + Alt + T** on your keyboard.

A window opens with a line that ends in `$`. That's where you type.

> 💡 **Two rules for the terminal**
> - Press **Enter** after each command to run it.
> - To **paste** into the terminal, use **Ctrl + Shift + V** (plain Ctrl + V does not work here).

---

## Step 1 — Update Ubuntu's app list

A new Ubuntu doesn't know about the latest apps yet. Type:

```
sudo apt update
```

- `sudo` means "do this as the boss (administrator)".
- It will ask for **your password** (the one you use to log in to Ubuntu).
- ⚠️ When you type the password, **nothing appears on the screen**, not even
  dots. That's normal! Type it and press **Enter**.

Wait until it finishes and you see the `$` again.

---

## Step 2 — Install Git

**Git** is the tool that downloads (clones) the lab from the internet.

```
sudo apt install -y git
```

Check it worked:

```
git --version
```

✅ You should see something like `git version 2.43.0`.

---

## Step 3 — Install VS Code

**VS Code** is a free app for opening folders and reading or editing files.
It also has its own terminal inside it.

### Option A — With clicks (easiest)

1. Click **Show Apps** (the grid of dots at the bottom-left of the screen).
2. Open **App Center** (on older Ubuntu it's called **Ubuntu Software**).
3. Search for **Visual Studio Code**.
4. Click **Install** and type your password if asked.

### Option B — With one command

```
sudo snap install code --classic
```

Check it worked:

```
code --version
```

✅ You should see a version number like `1.9x.x`.

---

## Step 4 — (Only for bonus level b4) Install `at`

Bonus level b4 uses a program called `at`. Install it now so it's ready:

```
sudo apt install -y at
```

---

## Step 5 — Download the lab

Type these **one at a time**:

**1. Go to your home folder**

```
cd ~
```

**2. Download the lab**

```
git clone https://github.com/Mo-Khaled/linux-essentials.git
```

✅ You should see a few lines ending with `done`.

**3. Go into the lab folder**

```
cd linux-essentials
```

**4. Set up the lab**

```
./start.sh
```

✅ You should see: `The lab is ready!`

> 🛑 From here on, the lab **never** needs `sudo`. If a lab step asks for your
> password, stop and ask your TA.

---

## Step 6 — Start playing

```
cat missions/00-first-steps/README.md
```

Follow the level. When you find a flag, check it:

```
./check_flag.sh 00 FLAG{...}
```

It tells you the command for the next level. Have fun! 🎉

---

## 🆘 Help! Something went wrong

| Problem | Fix |
|---|---|
| `Permission denied` when running `./start.sh` | Run `chmod +x *.sh scripts/*.sh`, then try again |

---

## 📖 Command Cheat Sheet

Every command you will use in this lab, in simple words.

### Setup commands (used once, in this guide)

| Command | What it does |
|---|---|
| `sudo` | Runs a command as the boss of the computer. It asks for your password. |
| `sudo apt update` | Refreshes Ubuntu's list of apps you can install. |
| `sudo apt install NAME` | Installs the app called NAME. |
| `sudo snap install code --classic` | Installs VS Code. |
| `git --version` | Shows which version of Git you have (a quick check that it's installed). |
| `git clone LINK` | Downloads a copy of a project from the internet. |

### Lab commands

| Command | What it does |
|---|---|
| `./start.sh` | Sets up the lab. `./start.sh --reset` starts everything over. |
| `./check_flag.sh 00 FLAG{...}` | Checks if your flag for level 00 is right. |
| `./check_flag.sh 04 --verify` | Checks your work for levels that make you build something. |
| `./cleanup.sh` | Stops the lab's programs and deletes the lab's files when you finish. |
| `bash scripts/FILE.sh` | Runs one of the lab's helper scripts (some levels ask you to). |

### Where am I? Who am I?

| Command | What it does |
|---|---|
| `whoami` | Shows your username. |
| `pwd` | Shows the folder you are in right now ("**p**rint **w**orking **d**irectory"). |
| `uname -a` | Shows information about your system (Linux version and more). |

### Moving around and looking

| Command | What it does |
|---|---|
| `ls` | Lists what's inside the folder you're in. |
| `ls FOLDER` | Lists what's inside another folder. |
| `ls /` | Lists the very top folder of the whole computer. |
| `ls -a` | Lists **all** files, including hidden ones (names that start with a dot `.`). |
| `ls -l` | Lists files with details. The first letter shows the kind: `-` file, `d` folder, `l` link. |
| `ls -la` | Both at once: all files, with details. |
| `cd FOLDER` | Goes into a folder. |
| `cd ~` | Goes to your home folder. `~` is short for your home folder. |
| `cd ..` | Goes up one folder. |

### Reading files

| Command | What it does |
|---|---|
| `cat FILE` | Shows what is written inside a file. |
| `cat missions/00-first-steps/README.md` | Example: shows the instructions for level 00. |
| `cat FILE1 > FILE2` | Copies what's inside FILE1 into FILE2 (you'll use this in level 04). |

### Making and changing files

| Command | What it does |
|---|---|
| `touch FILE` | Makes a new, empty file. |
| `echo "text"` | Prints the text on the screen. |
| `COMMAND > FILE` | Puts what the command prints into the file. It **replaces** what was there. |
| `COMMAND >> FILE` | Adds what the command prints to the **end** of the file. It keeps what was there. |
| `mkdir FOLDER` | Makes a new folder. |
| `cp FILE WHERE` | Copies a file. The original stays. |
| `mv OLD NEW` | Moves or renames a file. The old name is gone. |
| `rm FILE` | Deletes a file forever. There is no trash can! |

### Variables

| Command | What it does |
|---|---|
| `echo $USER` | Shows your username, stored in a variable. |
| `echo $HOME` | Shows the path of your home folder. |
| `echo $SHELL` | Shows your shell, the program that reads what you type. |
| `export NAME=value` | Makes your own variable. No spaces around `=`! |

### Processes (running programs)

| Command | What it does |
|---|---|
| `sleep 100` | Waits 100 seconds, then stops. |
| `COMMAND &` | Runs the command in the background, so you can keep typing. |
| `jobs` | Lists the background programs you started in this terminal. |
| `ps -ef` | Lists **every** program running on the computer, with its PID (ID number). |
| `grep WORD` | Keeps only the lines that contain WORD. |
| `pgrep -f NAME` | Shows the PID of the program called NAME. |
| `pgrep -af NAME` | Shows the PID **and** the full name of matching programs. |
| `kill PID` | Asks a program to stop, gently (SIGTERM). It can tidy up first. |
| `kill -9 PID` | Forces a program to stop right now (SIGKILL). No tidying up. |
| `Ctrl + C` | Stops the command that is running in the terminal. |

**The pipe `|`** (on most keyboards: Shift + `\`) joins two commands: it
sends what the first command prints into the second one. For example,
`ps -ef | grep linuxctf` lists all programs, then keeps only the lines with
"linuxctf" in them.

### Bonus-level commands

| Command | What it does |
|---|---|
| `df -h` | Shows how full each disk is, in easy numbers (GB, MB). |
| `df -h .` | Shows how full the disk you are on is. |
| `wc -l` | Counts lines. |
| `at now + 1 minute` | Runs a command once, 1 minute from now. |
| `atq` | Lists commands waiting to run with `at`. |
| `base64 -d FILE` | Turns a base64-scrambled file back into normal text. |

### Keyboard shortcuts

| Keys | What they do |
|---|---|
| **Ctrl + Alt + T** | Opens a new terminal. |
| **Ctrl + Shift + V** | Pastes into the terminal. |
| **Ctrl + Shift + C** | Copies from the terminal. |
| **Tab** | Finishes a file or folder name for you. |
| **↑** (up arrow) | Brings back your last command. |
| **Ctrl + C** | Stops a stuck command. |
