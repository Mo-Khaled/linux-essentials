# Mission 06 — Storage Investigation

**Level 2 · Medium (10-15 min) · PDF: Part 1 — df -h, df -h ., partitions & mount points**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

```
lab_workspace/rooms/06/storage/
```

Several storage folders sit here, each named after a partition/usage
reading. Only **one** of them matches what your own machine is actually
reporting right now for the partition this lab lives on — the rest are
decoys with plausible but wrong numbers. This isn't a guessing game: the
correct folder's name was generated from a real command's real output, on
*your* machine, when the lab was set up.

## Your task

1. Find out which partition your lab directory lives on, and how full it
   is — there's a command specifically for checking the partition of the
   *current* directory rather than every mounted partition on the system.
2. Match what you see to one of the folder names under `storage/`.
3. Once you're confident you found the right one, leave your mark: create
   an empty file named `i_was_here` inside that folder.
4. Check your work:
   ```
   ./check_flag.sh 06 --verify
   ```

## Submit

```
./check_flag.sh 06 FLAG{...}
```

## Hints

```
cat missions/06-storage-investigation/hints/hint1.txt
```
