# Mission 13 — Recurring Evidence

**Level 5 · Hard (15-20 min, includes waiting) · PDF: Part 5 — cron, crontab -e/-l/-r**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

This time the evidence needs to refresh itself **every minute**, on its
own, without you scheduling it again each time. That's a recurring job, not
a one-time one — a different scheduler than mission 12's.

## Your task

1. Edit your **own personal** crontab and add a line that runs
   `scripts/cron_emitter.sh` (full path from the repo root) every minute.
   **Tag your line** with the comment `# LINUX_ESSENTIALS_CTF` at the end —
   this lets you (and the lab's cleanup script) find and remove *only* this
   line later, without touching anything else in your crontab.
2. Confirm your job is actually there by listing your crontab.
3. Wait a minute or two, then read (and watch it update if you check again
   a minute later):
   ```
   cat lab_workspace/rooms/13/evidence.txt
   ```
4. **When you're done, remove your line.** Either edit your crontab again
   and delete just that one line, or run:
   ```
   bash scripts/remove_cron_entry.sh
   ```
   which finds and removes only lines tagged `# LINUX_ESSENTIALS_CTF`.

> ⚠️ The PDF also teaches `crontab -r`. Be careful: `crontab -r` deletes
> your **entire personal crontab**, not just one job. If you use it and had
> other entries, they're gone too — only use it if you're certain the lab
> entry is the only thing in there.

## Submit

```
./check_flag.sh 13 FLAG{...}
```

## Hints

```
cat missions/13-recurring-evidence/hints/hint1.txt
```
