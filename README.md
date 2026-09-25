# Linux Treasure Hunt 🏴

## What is this?

This is a **treasure hunt inside your computer**.

Every level hides a secret word called a **flag**. A flag looks like this:

```
FLAG{first_steps_1a2b3c4d}
```

You find flags by **typing commands**. Each level shows you exactly what
to type. At the end of each level there is one small thing you do alone.

You don't need to know anything about Linux to start. Let's go!

---

## Your keyboard superpowers

Learn these first. They make everything easier.

| Do this | To... |
|---|---|
| **Ctrl + Alt + T** | open the terminal (the black window where you type) |
| **Ctrl + Shift + V** | **paste** into the terminal (plain Ctrl+V does NOT work here!) |
| **Ctrl + Shift + C** | **copy** from the terminal |
| **Tab** | finish a long name for you. Type `mis` and press Tab! |
| **↑** (up arrow) | bring back the last command you typed |
| **Ctrl + C** | stop a command that is stuck |
| **Enter** | run the command you typed |

> Typing tip: capital letters, spaces and dots matter. `ls -a` is not the
> same as `ls-a`.

---

## Start the game

Open the terminal (**Ctrl + Alt + T**). Type each command below, **one at
a time**, and press **Enter** after each one.

**1. Go to your home folder**

```
cd ~
```

Nothing is printed. That's normal!

**2. Download the game**

```
git clone https://github.com/Mo-Khaled/linux-essentials.git
```

You should see a few lines ending with `done`.

**3. Go into the game folder**

```
cd linux-essentials
```

**4. Set up the game**

```
./start.sh
```

You should see: `The lab is ready!`

**5. Read the first level**

```
cat missions/00-first-steps/README.md
```

That's it, you're playing! 🎉

---

## How to play a level

1. **Read** the level: `cat missions/NN-.../README.md`
2. **Type** the commands it shows you, one by one.
3. **Do** the "Your turn" part by yourself.
4. **Check** your flag:

   ```
   ./check_flag.sh 00 FLAG{...}
   ```

   Put the level number where `00` is, and your flag where `FLAG{...}` is.

5. If it says **Correct!**, it also tells you the command for the next level.

---

## Help! I'm lost

- **"Where am I?"** Type `pwd`.
- **"I want to go back to the game folder."** Type:

  ```
  cd ~/linux-essentials
  ```

- **"I'm stuck on a level."** Every level has 3 hints. Open them one at a
  time, for example:

  ```
  cat missions/00-first-steps/hints/hint1.txt
  ```

- **"I broke something."** Start everything over:

  ```
  ./start.sh --reset
  ```

- **"The terminal is frozen."** Press **Ctrl + C**.

---

## The levels

| Level | Name | You will learn |
|---|---|---|
| 00 | First Steps | `whoami`, `pwd`, `ls`, `cd`, `cat` |
| 01 | Explore Linux | the main Linux folders (`/etc`, `/home`, ...) |
| 02 | Hidden Files | `ls -a` |
| 03 | File Types | `ls -l`, links |
| 04 | Create Files | `touch`, `echo`, `>`, `>>` |
| 05 | Organize Files | `mkdir`, `cp`, `mv`, `rm` |
| 06 | Environment Variables | `echo $HOME`, `$SHELL`, `export` |
| 07 | Find the Process | `&`, `jobs`, `ps`, `grep`, PID |
| 08 | Stop the Process | `kill`, `kill -9` |

**Finished early?** Try the bonus levels in `missions/bonus/`:

| Level | Name | You will learn |
|---|---|---|
| b1 | Linked Secret | a link to a link |
| b2 | Disk Space | `df -h` |
| b3 | Count with a Pipe | `\|`, `wc -l` |
| b4 | Run It Later | `at`, `atq` |
| b5 | Final Boss | everything + `base64` |

---

## When you're done

```
./cleanup.sh
```

This stops the game's programs and deletes the game's files. It does not
touch anything else on your computer.

The game never needs `sudo`. If something asks for your password, stop and
ask your instructor.
