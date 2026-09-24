# Bonus B3 — Cron Hunter

**Optional · Fast Finisher · Combines: cron + hidden files**

Like mission 13, but the evidence this time doesn't sit in an obvious
place once it's generated — you'll need mission 02's trick too.

## Your task

1. Add a crontab entry (tagged `# LINUX_ESSENTIALS_CTF`, same as mission
   13) that runs `scripts/bonus_cron_emitter.sh` every minute.
2. Wait for it to fire.
3. The evidence file this job writes doesn't show up in a plain listing.
4. Clean up your crontab line when you're done (same command as mission 13
   works — it removes every line tagged with the lab's marker).

## Submit

```
./check_flag.sh b3 FLAG{...}
```

## Hints

```
cat missions/bonus/b3-cron-hunter/hints/hint1.txt
```
