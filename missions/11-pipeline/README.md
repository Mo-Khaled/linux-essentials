# Mission 11 — Pipeline

**Level 4 · Medium-Hard (15 min) · PDF: Part 4 — |, grep, head, wc -l**

> DO → INSPECT → OBSERVE → REASON → FIND THE FLAG

## Briefing

A batch of lab workers is about to start — some genuine, some bystanders
with a *similar but different* name that would fool a sloppy search
pattern. You need to combine a process listing with a filter and a counter
into a single pipeline, and save the exact count into a file yourself.

## Your task

1. Launch the batch:
   ```
   bash scripts/start_mission11.sh
   ```
2. Build a pipeline that lists processes, filters to exactly the genuine
   `linuxctf_worker_11_` family (not the bystanders, not `grep` matching
   itself), and counts the results.
3. Redirect that pipeline's output into:
   ```
   lab_workspace/rooms/11/answer.txt
   ```
4. Check your work:
   ```
   ./check_flag.sh 11 --verify
   ```

## Submit

```
./check_flag.sh 11 FLAG{...}
```

## Hints

```
cat missions/11-pipeline/hints/hint1.txt
```
