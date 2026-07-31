# Apache Spark Overview and Architecture

Every computer has three resources that limit data processing: CPU (how fast it computes), memory or RAM (how much data it can hold for fast access), and disk (how much it can store, but slowly). The most important for data processing is RAM, because computation happens on data loaded into memory. RAM, Disk/Storage are terms we are already familiar with. To be fair, most times when the average person wants to purchase a laptop, they just ask for RAM (e.g 8GB, 16GB, 32GB), and then disk (500GB SSD, 1T SSD, 2T SSD), they hardly ask about cores (CPU). But, all three are important and will solidify our understanding of Spark (and even any distributed system).

Apache Spark is a **distributed, in-memory data processing engine**. In plain English: it takes a job that is too big for one computer, chops it into small pieces, spreads those pieces across many computers, processes them **in RAM** (which is much faster than disk), and then brings the answer back to you.

**The Restaurant Analogy (keep this in your head the whole time)**

> Imagine a busy restaurant handling a 500-person banquet:
>
> | Spark Component | Restaurant Role | What they do |
> |---|---|---|
> | **Driver** | Head Chef | Reads the recipe (your code), plans the cooking steps, assigns work |
> | **Cluster Manager** | Restaurant Manager | Decides how many cooks and stoves the Head Chef gets |
> | **Worker Nodes** | Kitchen Stations | The physical stations where cooking happens |
> | **Executors** | Line Cooks | Actually cook the food (process the data) |
> | **Tasks** | Individual dishes | The smallest unit of work, one dish per cook at a time |
>
> One Head Chef never cooks 500 meals alone. They **plan** and **delegate**. That's exactly what Spark does with data.

---

## The Three Core Components

### 1. The Driver Program (The "Brain" / Head Chef)

The Driver is the process that runs your `main()` function — the actual Python/Scala/SQL script you wrote. It creates the **`SparkSession`**, which is your entry point into everything Spark does.

```python
from pyspark.sql import SparkSession

# This single line "hires the Head Chef" — your Driver comes alive here
spark = SparkSession.builder.appName("my_first_app").getOrCreate()
```

The Driver's four jobs:

1. **Translate** — converts your high-level code into a *logical plan* (what needs to happen).
2. **Optimize & Schedule** — turns that plan into a **DAG** (Directed Acyclic Graph): a step-by-step flowchart of operations with no loops. "Acyclic" just means the arrows never circle back — data always flows forward.
3. **Distribute** — sends individual **tasks** to executors and tracks their progress.
4. **Collect** — receives the final results (or tells executors to write them directly to storage — more on this in the *Return Trip* section 👇).

 **Summary:** *"The Driver is the coordinator process that converts user code into a DAG of stages and tasks, schedules them onto executors, and tracks the application's overall state."*

**Note:** the Driver does **not** process the big data itself. If you force all data back to the Driver (e.g., `df.collect()` on a huge dataset), you'll crash it with an Out-Of-Memory error. The Head Chef plans; they don't cook 500 meals on their own stove. Remember, the idea of distributed processing is to share one big task originally meant for one computer across many others.

---

### 2. The Cluster Manager (The Restaurant Manager)

The Cluster Manager is an **external service** that owns the hardware. The Driver goes to it and says: *"I need 10 executors, each with 4 CPU cores and 8 GB of RAM."* The Cluster Manager finds the space and spins them up.

The three main options ([official docs](https://spark.apache.org/docs/latest/cluster-overview.html)):

| Cluster Manager | What it is | When you'd see it |
|---|---|---|
| **Standalone** | Spark's built-in manager | Simple setups, learning environments |
| **Hadoop YARN** | Resource manager from the Hadoop world | Older/legacy big-data platforms |
| **Kubernetes** | Modern container orchestration | Modern cloud-native platforms (this is what runs on EKS 👀) |

> **Summary:** *"The Cluster Manager allocates CPU and memory across the cluster; the Driver negotiates with it to launch executors. Spark supports Standalone, YARN, and Kubernetes."*

---

### 3. Worker Nodes & Executors (The Kitchen & Line Cooks)

- A **Worker Node** = a physical or virtual machine in the cluster (a kitchen station).
- An **Executor** = a **JVM process** running *inside* a worker node, dedicated to *your* application only (a line cook assigned to your banquet and nobody else's).

What executors do:

1. **Run tasks** — each executor has CPU cores; each core runs one task at a time.
2. **Cache data in RAM** — when you call `df.cache()` or `df.persist()`, executors keep that data in memory so the *next* query on it is lightning fast.
3. **Stay isolated** — because each executor is its own JVM, if another application's executor crashes, yours keeps running.

>  **Summary:** *"Executors are per-application JVM processes on worker nodes that execute tasks in parallel across their cores and cache intermediate data in memory."*

---

## (Your Code → The Cluster)

What happens when you run `spark-submit my_script.py`:

```
                        THE JOURNEY OUT (planning & distribution)
                        ═════════════════════════════════════════

 ┌─────────────┐   ①    ┌──────────────────────────┐
 │  Your Code   │ ─────▶ │        DRIVER            │
 │ (my_script)  │  run   │  • builds SparkSession   │
 └─────────────┘        │  • builds logical plan    │
                        │  • creates the DAG        │
                        └───────────┬──────────────┘
                                    │ ② "I need resources!"
                                    ▼
                        ┌──────────────────────────┐
                        │     CLUSTER MANAGER      │
                        │ (Standalone / YARN / K8s)│
                        └───────────┬──────────────┘
                                    │ ③ launches executors
                     ┌──────────────┼──────────────┐
                     ▼              ▼              ▼
              ┌────────────┐ ┌────────────┐ ┌────────────┐
              │ WORKER NODE│ │ WORKER NODE│ │ WORKER NODE│
              │ ┌────────┐ │ │ ┌────────┐ │ │ ┌────────┐ │
              │ │Executor│ │ │ │Executor│ │ │ │Executor│ │
              │ │ (JVM)  │ │ │ │ (JVM)  │ │ │ │ (JVM)  │ │
              │ └────────┘ │ │ └────────┘ │ │ └────────┘ │
              └────────────┘ └────────────┘ └────────────┘
                     ▲              ▲              ▲
                     └──────────────┼──────────────┘
                                    │ ④ Driver sends TASKS
                                    │    directly to executors
                            (one task per data partition)
```

Step by step:

1. **Initialization** — your script creates a `SparkSession`. The Driver process starts and contacts the Cluster Manager, which launches executor JVMs across the worker nodes.
2. **Lazy Evaluation** — as your code calls *transformations* like `filter()`, `select()`, or `map()`, **nothing runs yet**. Spark just writes them into its "recipe notebook" (the logical plan). Think of a chef reading the whole recipe before touching a single pan.
3. **DAG Generation** — the moment you call an **action** — `count()`, `show()`, `collect()`, `write()` — Spark says "okay, NOW we cook." The **Catalyst Optimizer** rewrites your plan into the most efficient version and produces the final DAG.
4. **Stages & Tasks** — the DAG Scheduler slices the DAG into **stages**. A new stage begins wherever data must be **shuffled** (moved between machines over the network — e.g., for a `groupBy` or `join`). Each stage is split into parallel **tasks**, one per data **partition** (a partition = one slice of your dataset).
5. **Execution** — executors run the tasks on their CPU cores, constantly sending heartbeat/status updates back to the Driver.


## Execution / Deployment Modes

Where does the Driver itself live? Three options:

| Mode | Where the Driver runs | Where Executors run | Best for |
|---|---|---|---|
| **Cluster Mode** | Inside the cluster, on a worker node | Across the cluster | Production pipelines (scheduled jobs). If your laptop disconnects, the job keeps running. |
| **Client Mode** | On *your* machine (the one running the script) | Across the cluster | Interactive work & debugging (notebooks, spark-shell). Close your laptop → Driver dies → job dies. |
| **Local Mode** | Your machine | Your machine (as threads, e.g. `local[4]`) | Learning, unit tests, quick prototyping. No cluster needed at all. |

> **Summary** *"Cluster mode puts the Driver inside the cluster for resilient production jobs; client mode keeps it on your machine for interactive debugging; local mode simulates everything with threads on one machine."*

---

## Cheat Sheet — 10-Second Recap

1. **Driver** = brain. Plans (DAG), delegates (tasks), never does the heavy lifting.
2. **Cluster Manager** = landlord. Hands out CPU/RAM (Standalone, YARN, or Kubernetes).
3. **Executors** = muscle. JVMs on worker nodes that run tasks in parallel and cache data in RAM.
4. **Transformations are lazy; actions trigger execution.**

## Learn more (official docs)

- [Cluster Mode Overview](https://spark.apache.org/docs/latest/cluster-overview.html)
- [RDD Programming Guide (lazy evaluation, actions vs transformations)](https://spark.apache.org/docs/latest/rdd-programming-guide.html)
- [Spark SQL & Catalyst Optimizer](https://spark.apache.org/docs/latest/sql-programming-guide.html)
- [Submitting Applications (spark-submit, deploy modes)](https://spark.apache.org/docs/latest/submitting-applications.html)
