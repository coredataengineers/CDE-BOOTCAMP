
# Spark Job, Stage, and Task

## Table of Contents

- [Introduction](#introduction)
- [The Execution Hierarchy](#the-execution-hierarchy)
- [What is a Job?](#what-is-a-job)
  - [How Jobs Are Triggered](#how-jobs-are-triggered)
  - [Multiple Jobs in One Application](#multiple-jobs-in-one-application)
- [What is a Stage?](#what-is-a-stage)
  - [How Stages Are Created](#how-stages-are-created)
  - [Stage Dependencies](#stage-dependencies)
  - [Shuffle: The Stage Boundary](#shuffle-the-stage-boundary)
  - [Stage Types: ShuffleMapStage vs ResultStage](#stage-types-shufflemapstage-vs-resultstage)
- [What is a Task?](#what-is-a-task)
  - [How Tasks Map to Partitions](#how-tasks-map-to-partitions)
  - [Task Execution on Executors](#task-execution-on-executors)
  - [Task Serialization and Shipping](#task-serialization-and-shipping)
  - [Speculative Execution](#speculative-execution)
- [The DAGScheduler and TaskScheduler](#the-dagscheduler-and-taskscheduler)
  - [DAGScheduler](#dagscheduler)
  - [TaskScheduler](#taskscheduler)
  - [How They Work Together](#how-they-work-together)
- [Data Locality](#data-locality)
- [Fault Tolerance](#fault-tolerance)
  - [Task-Level Retries](#task-level-retries)
  - [Stage-Level Retries](#stage-level-retries)
  - [Shuffle Data and Fault Recovery](#shuffle-data-and-fault-recovery)
- [A Complete Walkthrough Example](#a-complete-walkthrough-example)
- [Monitoring Jobs, Stages, and Tasks](#monitoring-jobs-stages-and-tasks)
  - [Spark Web UI: Jobs Tab](#spark-web-ui-jobs-tab)
  - [Spark Web UI: Stages Tab](#spark-web-ui-stages-tab)
  - [What to Look For](#what-to-look-for)
- [Common Issues and Solutions](#common-issues-and-solutions)
  - [One Slow Task (Straggler)](#1-one-slow-task-straggler)
  - [Too Many Tasks](#2-too-many-tasks)
  - [Too Few Tasks](#3-too-few-tasks)
  - [Stages Waiting Too Long](#4-stages-waiting-too-long)
- [Key Configuration Properties](#key-configuration-properties)
- [Summary](#summary)
- [Further Reading](#further-reading)

---

## Introduction

When you submit a Spark application, your code doesn't just run as a single block. Spark breaks it down into a hierarchy of smaller units of work: **Jobs**, **Stages**, and **Tasks**. Understanding this hierarchy is critical for reading the Spark Web UI, diagnosing performance problems, and writing efficient code.

This guide walks you through each level of the hierarchy, how they relate to each other, and how they are scheduled and executed on your YARN cluster.

---

## The Execution Hierarchy

Every Spark application follows this top-down structure:

```
APPLICATION
  └── JOB 1                    (triggered by one action)
  │     ├── STAGE 0             (set of pipelineable operations)
  │     │     ├── Task 0        (one task per partition)
  │     │     ├── Task 1
  │     │     └── Task 2
  │     │           │
  │     │        [shuffle]
  │     │           │
  │     └── STAGE 1
  │           ├── Task 0
  │           ├── Task 1
  │           └── Task 2
  │
  └── JOB 2                    (triggered by another action)
        └── STAGE 2
              ├── Task 0
              └── Task 1
```

| Level | What Creates It | How Many |
|---|---|---|
| **Application** | `SparkSession.builder.getOrCreate()` | One per Spark program |
| **Job** | Each **action** (e.g., `count()`, `show()`, `write()`) | One per action |
| **Stage** | Shuffle boundaries (e.g., `groupBy()`, `join()`) | One or more per job |
| **Task** | Partitions of data | One per partition per stage |

---

## What is a Job?

A **Job** is the highest-level unit of execution. Every time you call an **action** on a DataFrame, RDD, or Dataset, Spark creates a new job.

### How Jobs Are Triggered

Remember that Spark uses **lazy evaluation**. Transformations like `filter()`, `select()`, and `groupBy()` don't do anything immediately — they build up a plan. Only an **action** triggers computation and creates a job.

```python
# These lines create NO jobs (lazy transformations)
df = spark.read.parquet("orders.parquet")
filtered = df.filter(df.amount > 100)
grouped = filtered.groupBy("region").sum("amount")

# THIS triggers Job 0
grouped.show()

# THIS triggers Job 1
grouped.write.parquet("output/")
```

Common actions that trigger jobs:

| Action | What It Does |
|---|---|
| `count()` | Counts rows, returns a number to the Driver |
| `show()` | Displays the first N rows to the console |
| `collect()` | Returns all data to the Driver as a local array |
| `take(n)` | Returns the first N rows to the Driver |
| `write()` / `save()` | Writes data to an external storage system |
| `foreach()` | Applies a function to each row |
| `reduce()` | Aggregates all elements using a function |

### Multiple Jobs in One Application

A single Spark application can contain many jobs. Each action call creates a separate, independent job.

```python
df = spark.read.parquet("data.parquet")

# Job 0
print(df.count())

# Job 1
df.filter(df.status == "active").show()

# Job 2
df.groupBy("category").count().write.csv("output/")
```

Jobs run sequentially by default (one at a time) unless you use Spark's **Fair Scheduler** or submit jobs from multiple threads.

---

## What is a Stage?

A **Stage** is a subset of a job that contains a group of transformations that can be executed together **without shuffling data**. Within a stage, all operations are **pipelined** — applied row by row in a single pass, without writing intermediate results.

### How Stages Are Created

Spark draws a stage boundary every time data needs to be **shuffled** (redistributed across the network). Operations that require a shuffle are called **wide transformations**.

```python
df = spark.read.parquet("sales.parquet")       # ─┐
filtered = df.filter(df.amount > 100)           #  ├── STAGE 0 (no shuffle needed)
selected = filtered.select("region", "amount")  # ─┘
                                                 #     ↓ shuffle (groupBy redistributes data by region)
grouped = selected.groupBy("region").sum("amount") # ── STAGE 1
```

Stage 0 includes the scan, filter, and select — all narrow operations that process each partition independently. Stage 1 begins after the shuffle that `groupBy` requires.

---

### Stage Dependencies

Stages form a **DAG (Directed Acyclic Graph)** of dependencies. A child stage cannot begin until all of its parent stages have completed, because the child needs the parent's shuffle output as its input.

```
STAGE 0 ────┐
             ├───▶ STAGE 2 (depends on both)
STAGE 1 ────┘         │
                       ▼
                   STAGE 3
```

Independent stages (like Stage 0 and Stage 1 above) can run **in parallel** if the cluster has enough resources.

---

### Shuffle: The Stage Boundary

A **shuffle** is the physical redistribution of data across the network. It happens when the output partitions of one operation depend on data from **multiple** input partitions.

Operations that cause shuffles (and therefore new stages):

| Operation | Why It Shuffles |
|---|---|
| `groupBy()` / `reduceByKey()` | All records with the same key must end up on the same partition |
| `join()` (sort-merge) | Both sides must be co-partitioned by the join key |
| `repartition()` | Explicitly redistributes data into a new number of partitions |
| `distinct()` | Must check for duplicates across all partitions |
| `orderBy()` / `sort()` | Global ordering requires data to be redistributed and sorted |

Operations that do **not** cause shuffles:

| Operation | Why No Shuffle |
|---|---|
| `filter()` | Each partition is filtered independently |
| `map()` / `select()` / `withColumn()` | Each row is processed independently |
| `coalesce()` (reducing partitions) | Merges partitions without a full shuffle |
| `union()` | Simply concatenates partitions |

---

### Stage Types: ShuffleMapStage vs ResultStage

Spark has two internal stage types:

**ShuffleMapStage:**

- Produces output that will be consumed by a subsequent stage via shuffle.
- Each task writes shuffle output (partitioned data) to local disk.
- Not the final stage of a job.

**ResultStage:**

- The **last stage** of a job.
- Produces the final result (e.g., data sent to the Driver for `show()`, or data written to disk for `write()`).
- Each task sends its result directly to the Driver or the output sink.

```
JOB
├── ShuffleMapStage 0  →  writes shuffle data
│         │
│      [shuffle]
│         │
└── ResultStage 1      →  produces final output
```

---

## What is a Task?

A **Task** is the smallest unit of work in Spark. It is a single computation applied to a **single partition** of data, running on a **single executor core**.

### How Tasks Map to Partitions

The number of tasks in a stage equals the number of **partitions** in that stage's input data.

```
DataFrame with 100 partitions
    │
    ▼
STAGE 0: filter → select
    → 100 tasks (one per partition)
    │
    ▼ [shuffle with 200 output partitions]
    │
STAGE 1: groupBy → aggregate
    → 200 tasks (one per new partition)
```

The number of partitions depends on:

- For the first stage: the number of files, file sizes, and `spark.sql.files.maxPartitionBytes` (default 128 MB).
- After a shuffle: `spark.sql.shuffle.partitions` (default 200), or whatever was set by AQE.

---

### Task Execution on Executors

Each task runs as a **thread** inside an Executor JVM. An executor with 4 cores can run 4 tasks simultaneously.

```
EXECUTOR (4 cores, 8 GB memory)
┌───────────────────────────────────────┐
│  Core 1: Task 0   Core 2: Task 1     │
│  Core 3: Task 2   Core 4: Task 3     │
│                                       │
│  Shared memory pool for caching,      │
│  broadcast variables, and shuffle     │
└───────────────────────────────────────┘
```

If a stage has 100 tasks and you have 10 executors with 4 cores each, 40 tasks run in parallel. The remaining 60 tasks wait in a queue and are picked up as cores become available.

---

### Task Serialization and Shipping

Before a task can run on an executor, the Driver must:

1. **Serialize** the task — convert the function code and any referenced data into bytes.
2. **Ship** the serialized task to the executor over the network.
3. The executor **deserializes** the task and runs it.

This is why you should avoid **referencing large objects** from your Driver code inside transformations. If your function captures a 1 GB dictionary from the Driver, that dictionary is serialized and sent with **every single task**.

```python
# BAD — large_dict is serialized with every task
large_dict = load_huge_lookup_table()
df.filter(lambda row: row["key"] in large_dict)

# GOOD — use a broadcast variable (sent once, shared across tasks)
broadcast_dict = spark.sparkContext.broadcast(large_dict)
df.filter(lambda row: row["key"] in broadcast_dict.value)
```

---

### Speculative Execution

Sometimes one task is much slower than others (a "straggler"), possibly because of a slow disk, network issue, or CPU contention on a particular node. Spark can **speculatively launch a duplicate** of the slow task on a different executor. Whichever copy finishes first wins, and the other is killed.

```python
spark.conf.set("spark.speculation", "true")  # Disabled by default
```

| Property | Default | Description |
|---|---|---|
| `spark.speculation` | `false` | Enable speculative execution |
| `spark.speculation.multiplier` | `3` | A task is speculated if it takes N× the median task time |
| `spark.speculation.quantile` | `0.9` | Speculation starts after 90% of tasks have finished |

---

## The DAGScheduler and TaskScheduler

Two internal Driver components manage the execution of Jobs, Stages, and Tasks.

### DAGScheduler

The DAGScheduler operates at the **Job and Stage level**.

Responsibilities:

- Receives a job when an action is called.
- Builds the **DAG of stages** by analyzing shuffle boundaries.
- Determines which stages are independent and can run in parallel.
- Submits stages to the TaskScheduler in dependency order (parent stages first).
- Handles **stage-level failures** — if a stage fails because shuffle data was lost, the DAGScheduler resubmits the parent stage.

### TaskScheduler

The TaskScheduler operates at the **Task level**.

Responsibilities:

- Receives a set of tasks from the DAGScheduler (one stage at a time).
- Assigns individual tasks to available executor cores.
- Respects **data locality** preferences (tries to run tasks on nodes where data resides).
- Tracks task completion and handles **task-level retries**.
- Reports results back to the DAGScheduler.

### How They Work Together

```
Action called (e.g., df.count())
      │
      ▼
┌─────────────────┐
│  DAGScheduler   │
│                 │
│  1. Build DAG   │
│  2. Split into  │
│     stages      │
│  3. Submit      │
│     Stage 0     │──────────▶  ┌─────────────────┐
│                 │              │  TaskScheduler   │
│  (waits for     │              │                 │
│   Stage 0 to    │              │  1. Assign tasks │
│   complete)     │              │     to executors │
│                 │              │  2. Track status │
│  4. Submit      │◀──────────── │  3. Report done  │
│     Stage 1     │──────────▶  │                 │
│                 │              │  (repeat)       │
│  5. Job done    │◀──────────── │                 │
└─────────────────┘              └─────────────────┘
```

---

## Data Locality

When the TaskScheduler assigns a task to an executor, it tries to honor **data locality** — placing the task as close to its data as possible.

Spark defines five locality levels, from best to worst:

| Level | Name | Description |
|---|---|---|
| 1 | `PROCESS_LOCAL` | Data is in the same executor's memory (e.g., cached data). Fastest. |
| 2 | `NODE_LOCAL` | Data is on the same node's disk (e.g., HDFS block on the same machine). |
| 3 | `NO_PREF` | Data has no locality preference (e.g., reading from S3). |
| 4 | `RACK_LOCAL` | Data is on a different node in the same network rack. |
| 5 | `ANY` | Data is anywhere in the cluster. Slowest — requires network transfer. |

Spark will wait a short time for a preferred locality level before falling back to a worse one. This wait is controlled by:

```
spark.locality.wait = 3s       # Overall wait time
spark.locality.wait.node = 3s  # Wait for NODE_LOCAL
spark.locality.wait.rack = 3s  # Wait for RACK_LOCAL
```

---

## Fault Tolerance

Spark is designed to handle failures gracefully at every level.

### Task-Level Retries

If a single task fails (e.g., due to an executor crash, OOM on a specific task, or transient error), the TaskScheduler retries it on a different executor.

- Default retry count: **4 attempts** (`spark.task.maxFailures = 4`).
- If a task fails on the same executor repeatedly, Spark may **blacklist** that executor and avoid scheduling tasks there.

### Stage-Level Retries

If a task fails because it cannot read **shuffle data** from a previous stage (e.g., the executor that wrote the shuffle output has died), the DAGScheduler must **resubmit the parent stage** to regenerate the lost shuffle data.

- Default stage retry count: **4** (`spark.stage.maxConsecutiveAttempts = 4`).

### Shuffle Data and Fault Recovery

Shuffle data is written to **local disk** on each executor. If an executor dies, its shuffle files are lost. Any downstream tasks that need that data will fail, and the parent stage must be re-run to reproduce it.

```
STAGE 0 completes → shuffle data written to Executor A's disk
       │
Executor A crashes → shuffle data lost
       │
STAGE 1 tasks fail (can't read shuffle from Executor A)
       │
DAGScheduler resubmits STAGE 0 → re-runs on surviving executors
       │
STAGE 1 retries successfully
```

This is why **External Shuffle Service** (`spark.shuffle.service.enabled`) is recommended in production. It runs a separate process on each node that serves shuffle files, so shuffle data survives even if the executor JVM dies.

---

## A Complete Walkthrough Example

Let's trace a complete example through the entire Job → Stage → Task hierarchy.

**Code:**

```python
orders = spark.read.parquet("orders.parquet")         # 10 files, ~1 GB total
customers = spark.read.parquet("customers.parquet")   # 2 files, ~50 MB total

result = (
    orders
    .filter(orders.amount > 50)                       # narrow
    .join(broadcast(customers), "customer_id")         # broadcast join (no shuffle)
    .groupBy("country")                                # wide → shuffle
    .agg(sum("amount").alias("total"),
         count("order_id").alias("num_orders"))
)

result.show()  # Action → triggers Job 0
```

**What Spark creates:**

```
JOB 0 (triggered by .show())
│
├── STAGE 0: Scan customers.parquet → BroadcastExchange
│    Type: ShuffleMapStage (sort of — broadcast, not shuffle)
│    Tasks: 2 (one per file/partition of customers)
│    Output: broadcast the small customers table to all executors
│
├── STAGE 1: Scan orders.parquet → Filter → BroadcastHashJoin → Partial Aggregate
│    Type: ShuffleMapStage
│    Tasks: 10 (one per partition of orders, ~100 MB each)
│    Operations pipelined: read → filter → join (with broadcast) → partial aggregate
│    Output: shuffle data partitioned by "country"
│         │
│      [shuffle: hashpartitioning(country, 200)]
│         │
└── STAGE 2: Final Aggregate → show()
     Type: ResultStage
     Tasks: 200 (default spark.sql.shuffle.partitions)
     Output: final aggregated rows sent to Driver for display
```

**Total work units:**

| Level | Count |
|---|---|
| Jobs | 1 |
| Stages | 3 |
| Tasks | 2 + 10 + 200 = **212** |

---

## Monitoring Jobs, Stages, and Tasks

The Spark Web UI (port 4040 by default) is your primary tool for monitoring.

### Spark Web UI: Jobs Tab

Shows:

- All jobs with their status (succeeded, failed, running).
- Number of stages per job.
- A progress bar showing completed vs pending stages.
- Duration of each job.

### Spark Web UI: Stages Tab

Shows:

- All stages across all jobs.
- For each stage:
  - Input size and records.
  - Shuffle read / write sizes.
  - Task count and duration distribution (min, median, max, p25, p75).
  - GC time.

### What to Look For

| Symptom | Where to Look | Likely Cause |
|---|---|---|
| One stage takes 10× longer | Stages tab → Duration | Data skew or missing broadcast join |
| Max task time >> median task time | Stage detail → Task metrics | Data skew (one partition much larger) |
| High shuffle write | Stages tab → Shuffle Write | Unnecessary wide transformation |
| High GC time | Stage detail → GC Time | Memory pressure, reduce cache or increase memory |
| Many failed tasks | Jobs tab → Failed column | OOM, bad data, or unstable executor nodes |

---

## Common Issues and Solutions

### 1. One Slow Task (Straggler)

**Symptom:** 99 tasks finish in 5 seconds, but 1 task takes 10 minutes.

**Cause:** Data skew — one partition has far more data than others.

**Solutions:**

- Enable AQE skew handling: `spark.sql.adaptive.skewJoin.enabled = true`.
- Salt the key: add a random number to the skewed key, aggregate, then re-aggregate without the salt.
- Filter out problematic keys (like `null`) before the shuffle if they aren't needed.
- Enable speculative execution to at least detect and duplicate stragglers.

---

### 2. Too Many Tasks

**Symptom:** Thousands of tasks completing in milliseconds. The Web UI shows more time spent scheduling than computing.

**Cause:** Too many small partitions, often after a shuffle with a high partition count.

**Solutions:**

- Reduce `spark.sql.shuffle.partitions` from the default 200 to something appropriate for your data size.
- Use `coalesce()` to reduce partitions after a heavy filter.
- Enable AQE partition coalescing: `spark.sql.adaptive.coalescePartitions.enabled = true`.

---

### 3. Too Few Tasks

**Symptom:** Only a handful of tasks, each running for a very long time. Most executor cores are idle.

**Cause:** Too few partitions in the input data or too low a shuffle partition count.

**Solutions:**

- Use `repartition(n)` to increase the partition count before heavy computation.
- Increase `spark.sql.shuffle.partitions`.
- For file-based sources, reduce `spark.sql.files.maxPartitionBytes` to create more partitions from the same data.

---

### 4. Stages Waiting Too Long

**Symptom:** Stages are in "pending" or "waiting" status for a long time.

**Cause:** Child stages waiting for parent stages to complete, or not enough cluster resources.

**Solutions:**

- Check if a parent stage is slow due to skew or other issues.
- If resource-starved, increase the number of executors or cores.
- On YARN, check if other applications are consuming cluster resources (check the YARN ResourceManager UI).

---

## Key Configuration Properties

| Property | Default | Description |
|---|---|---|
| `spark.sql.shuffle.partitions` | `200` | Number of partitions after a shuffle. Directly controls task count in post-shuffle stages. |
| `spark.default.parallelism` | Total executor cores | Default number of partitions for RDD operations. |
| `spark.task.maxFailures` | `4` | Max retries per task before marking the job as failed. |
| `spark.stage.maxConsecutiveAttempts` | `4` | Max retries per stage. |
| `spark.speculation` | `false` | Enable speculative re-execution of slow tasks. |
| `spark.locality.wait` | `3s` | How long to wait for data-local task scheduling. |
| `spark.shuffle.service.enabled` | `false` | Use an external shuffle service to preserve shuffle data across executor restarts. |
| `spark.sql.adaptive.enabled` | `true` (3.2+) | Enable Adaptive Query Execution for runtime re-optimization. |

---

## Summary

- An **Application** is your entire Spark program, from `SparkSession` creation to `spark.stop()`.
- A **Job** is created every time you call an action (`count()`, `show()`, `write()`). No action means no job.
- A **Stage** is a group of transformations that can run without a shuffle. Stage boundaries are drawn at shuffle points (`groupBy`, `join`, `repartition`).
- A **Task** is the smallest unit of work — one task per partition per stage. It runs as a thread on a single executor core.
- The **DAGScheduler** builds the DAG of stages and submits them in order. The **TaskScheduler** assigns individual tasks to executor cores with data locality awareness.
- **Shuffles** are the most expensive operation and are the sole reason stages exist as a concept. Minimizing shuffles is the most impactful optimization.
- **Fault tolerance** works at both levels: failed tasks are retried (up to 4 times), and stages can be re-run if shuffle data is lost.
- Use the **Spark Web UI** to monitor jobs, stages, and tasks. Look for skew (max >> median), excessive shuffles, and GC pressure.

---

## Further Reading

- [Spark Cluster Mode Overview](https://spark.apache.org/docs/latest/cluster-overview.html)
- [Spark Job Scheduling](https://spark.apache.org/docs/latest/job-scheduling.html)
- [Tuning Spark](https://spark.apache.org/docs/latest/tuning.html)
- [Adaptive Query Execution](https://spark.apache.org/docs/latest/sql-performance-tuning.html#adaptive-query-execution)

---

> **Remember:** Job → Stage → Task is the execution hierarchy. Actions create Jobs, shuffles create Stages, and partitions create Tasks. Keep this mental model, and the Spark Web UI will make complete sense.
