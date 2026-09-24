# Mission 00 — Identify Your System

**Level 1 · Easy (5-10 min) · PDF: Part 0 — Introduction**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

Before any investigation starts, confirm who you are and what you're
sitting in front of. Every Linux session answers three questions the moment
you open a terminal: *who am I, where am I, and what system is this?*

There's a room prepared for you at:

```
lab_workspace/rooms/00/
```

Inside it are several files, each named after a different command shell
(`bash`, `sh`, `dash`, `csh`, `tcsh`, `ksh`, `zsh`...). Only **one** of them
is telling the truth about the shell you're actually using right now.

## Your task

1. Confirm your identity and system: who you are, where you are, and what
   kernel/architecture you're running.
2. Figure out **which shell is your current shell** — Linux tracks this in
   an environment variable, and the PDF's "Kernel vs. Shell" section shows
   you where to look.
3. Open the one file in `lab_workspace/rooms/00/` whose name matches your
   real shell. That file holds your flag.

## Submit

```
./check_flag.sh 00 FLAG{...}
```

## Hints

Stuck? Hints are in `hints/`, ordered from gentle to specific. Try to solve
it without them first — open one at a time:

```
cat missions/00-identify-your-system/hints/hint1.txt
```
