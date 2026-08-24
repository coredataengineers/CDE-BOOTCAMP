
# Spark Execution Plan

## Table of Contents

- [Introduction](#introduction)
- [What is an Execution Plan?](#what-is-an-execution-plan)
- [Lazy Evaluation: Why Plans Exist](#lazy-evaluation-why-plans-exist)
- [The Execution Plan Pipeline](#the-execution-plan-pipeline)
- [Stage 1: Unresolved Logical Plan](#stage-1-unresolved-logical-plan)
- [Stage 2: Resolved (Analyzed) Logical Plan](#stage-2-resolved-analyzed-logical-plan)
- [Stage 3: Optimized Logical Plan](#stage-3-optimized-logical-plan)
  - [Predicate Pushdown](#1-predicate-pushdown)
  - [Column Pruning](#2-column-pruning)
  - [Constant Folding](#3-constant-folding)
  - [Boolean Simplification](#4-boolean-simplification)
  - [Join Reordering](#5-join-reordering)
  - [Combine Filters](#6-combine-filters)
- [Stage 4: Physical Plan](#stage-4-physical-plan)
  - [Physical Plan Strategies](#physical-plan-strategies)
  - [Cost-Based Optimization (CBO)](#cost-based-optimization-cbo)
- [Stage 5: DAG of Stages and Tasks](#stage-5-dag-of-stages-and-tasks)
  - [What is a Job?](#what-is-a-job)
  - [What is a Stage?](#what-is-a-stage)
  - [What is a Task?](#what-is-a-task)
  - [Narrow vs Wide Dependencies](#narrow-vs-wide-dependencies)
  - [Shuffle: The Stage Boundary](#shuffle-the-stage-boundary)
- [Inspecting the Execution Plan](#inspecting-the-execution-plan)
  - [Using explain()](#using-explain)
  - [explain() Modes](#explain-modes)
  - [Reading a Physical Plan](#reading-a-physical-plan)
- [A Complete Walkthrough Example](#a-complete-walkthrough-example)
- [Adaptive Query Execution (AQE)](#adaptive-query-execution-aqe)
  - [What AQE Does](#what-aqe-does)
  - [Key AQE Features](#key-aqe-features)
  - [Enabling AQE](#enabling-aqe)
- [Whole-Stage Code Generation](#whole-stage-code-generation)
- [The Spark Web UI: Visualizing the Plan](#the-spark-web-ui-visualizing-the-plan)
  - [SQL / DataFrame Tab](#sql--dataframe-tab)
  - [Jobs Tab](#jobs-tab)
  - [Stages Tab](#stages-tab)
- [Configuration Properties](#configuration-properties)
- [Common Pitfalls and How to Spot Them](#common-pitfalls-and-how-to-spot-them)
  - [Unnecessary Shuffles](#1-unnecessary-shuffles)
  - [Data Skew](#2-data-skew)
  - [Missing Predicate Pushdown](#3-missing-predicate-pushdown)
  - [BroadcastHashJoin Not Triggered](#4-broadcasthashjoin-not-triggered)
  - [Too Many or Too Few Partitions](#5-too-many-or-too-few-partitions)
- [Best Practices](#best-practices)
- [Summary](#summary)
- [Further Reading](#further-reading)

---

## Introduction

When you write a Spark application, you express *what* you want — filter this, join that, aggregate these columns. You never tell Spark *how* to physically execute those steps. That is the job of the **Execution Plan**.

Understanding execution plans is one of the most valuable skills you can build as a Spark developer. It lets you peek under the hood, understand why a job is slow, and make informed decisions to speed it up. In this guide we will walk through every stage of the plan, from your high-level code all the way down to the individual tasks that run on executors.

We will continue to use **YARN** as our cluster manager, consistent with the previous guides in this series.

---

## What is an Execution Plan?

An execution plan is the **complete strategy** Spark builds to turn your high-level transformations into physical operations that run across a distributed cluster.

Think of it like planning a road trip:

- **What you say:** "I want to go from New York to Los Angeles."
- **What the planner figures out:** Which highways to take, where to refuel, the optimal route considering traffic, tolls, and road closures.

In Spark terms:

- **What you write:** `df.filter(...).groupBy(...).agg(...)`
- **What Spark figures out:** Which algorithms to use, how to minimize data movement across the network, how to split the work across executors, and in what order to execute each step.

---

## Lazy Evaluation: Why Plans Exist

Spark uses **lazy evaluation**. When you write a transformation, Spark does not execute it immediately. Instead, it records it as part of a growing plan.

```python
# Nothing happens yet — Spark just records the intent
df = spark.read.csv("sales.csv")
filtered = df.filter(df.amount > 100)
grouped = filtered.groupBy("region").sum("amount")
```

Execution is only triggered when you call an **action**:

```python
# NOW Spark builds the full plan and executes it
grouped.show()
```

Why does this matter? Because by waiting, Spark can see the **entire chain** of transformations before it starts working. This allows it to optimize the plan as a whole, rather than executing each step blindly.

| Term | Definition | Examples |
|---|---|---|
| **Transformation** | A lazy operation that defines a new dataset from an existing one. Nothing is computed. | `filter()`, `select()`, `groupBy()`, `join()`, `withColumn()` |
| **Action** | An operation that triggers computation and returns a result or writes output. | `show()`, `count()`, `collect()`, `write()`, `save()` |

> **Key Point:** The execution plan is built when an action is called. No action, no plan, no execution.

---

## The Execution Plan Pipeline

When an action is triggered, Spark's **Catalyst Optimizer** and **Tungsten Execution Engine** process your code through a series of stages. Each stage refines the plan further.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    EXECUTION PLAN PIPELINE                          │
│                                                                     │
│   Your Code (Transformations + Action)                              │
│        │                                                            │
│        ▼                                                            │
│   ┌─────────────────────────────────┐                               │
│   │  1. Unresolved Logical Plan     │  "What the user wrote"        │
│   │     (parsed, unvalidated)       │                               │
│   └──────────────┬──────────────────┘                               │
│                  ▼                                                   │
│   ┌─────────────────────────────────┐                               │
│   │  2. Resolved Logical Plan       │  "Validated against catalog"  │
│   │     (columns & types checked)   │                               │
│   └──────────────┬──────────────────┘                               │
│                  ▼                                                   │
│   ┌─────────────────────────────────┐                               │
│   │  3. Optimized Logical Plan      │  "Catalyst optimizations"     │
│   │     (rules + cost-based)        │                               │
│   └──────────────┬──────────────────┘                               │
│                  ▼                                                   │
│   ┌─────────────────────────────────┐                               │
│   │  4. Physical Plan               │  "Concrete algorithms chosen" │
│   │     (strategies selected)       │                               │
│   └──────────────┬──────────────────┘                               │
│                  ▼                                                   │
│   ┌─────────────────────────────────┐                               │
│   │  5. DAG of Stages & Tasks       │  "Ready for execution"        │
│   │     (distributed across cluster)│                               │
│   └─────────────────────────────────┘                               │
└─────────────────────────────────────────────────────────────────────┘
```

Let's walk through each stage in detail.

---

## Stage 1: Unresolved Logical Plan

The first thing Spark does is parse your transformations into an **unresolved logical plan**. This is a tree of operations that represents exactly what you wrote — but Spark has not yet verified whether the column names exist, the data types are compatible, or the tables are real.

```python
df = spark.read.csv("sales.csv")
result = df.filter(df.amount > 100).select("region", "amount")
```

The unresolved logical plan would look something like:

```
Project [region, amount]
  └── Filter [amount > 100]
        └── Relation [sales.csv]
```

At this point, Spark does not know whether `region` and `amount` are real columns. It has only recorded the user's intent.

> **Analogy:** You hand a recipe to a chef. The chef reads it but hasn't yet checked the pantry to see if the ingredients exist.

---

## Stage 2: Resolved (Analyzed) Logical Plan

Next, Spark's **Analyzer** resolves the plan by consulting the **Catalog** — Spark's internal metadata store that knows about tables, columns, data types, and schemas.

The Analyzer:

- Verifies that all referenced columns exist.
- Resolves ambiguous column references (e.g., if two tables have a column called `id`).
- Assigns concrete data types to every expression.
- Throws an `AnalysisException` if something is wrong (e.g., referencing a column that doesn't exist).

After analysis, the plan becomes:

```
Project [region: STRING, amount: DOUBLE]
  └── Filter [amount: DOUBLE > 100]
        └── Relation [sales.csv] [region: STRING, amount: DOUBLE, date: DATE, ...]
```

Now every column has a name and a type. The plan is fully validated.

> **Analogy:** The chef checks the pantry — yes, we have all the ingredients, and they're the right type (flour is flour, not sand).

---

## Stage 3: Optimized Logical Plan

This is where the **Catalyst Optimizer** shines. It takes the resolved logical plan and applies a series of **optimization rules** to produce a more efficient plan. These rules are applied repeatedly until no more improvements can be made (a process called **fixed-point iteration**).

Here are the most important optimizations.

### 1. Predicate Pushdown

**What it does:** Moves filter conditions as close to the data source as possible.

**Why it matters:** If you filter after loading all the data, you waste time reading rows you don't need. By pushing the filter down to the scan, Spark can skip irrelevant data entirely.

```
BEFORE                              AFTER
──────                              ─────
Filter (region = "US")              Scan Parquet
  └── Scan Parquet                    (filter pushed: region = "US")
        (reads everything)              (reads only matching rows)
```

This is especially powerful with columnar file formats like **Parquet** and **ORC**, which support predicate pushdown at the file level using metadata and min/max statistics.

---

### 2. Column Pruning

**What it does:** Removes columns from the scan that are never used downstream.

**Why it matters:** If your table has 200 columns but your query only uses 3, reading all 200 is wasteful. Column pruning tells the data source to only read the columns that are actually needed.

```
BEFORE                              AFTER
──────                              ─────
Project [name, age]                 Project [name, age]
  └── Scan (reads ALL columns)        └── Scan (reads ONLY name, age)
```

---

### 3. Constant Folding

**What it does:** Pre-computes constant expressions at planning time instead of evaluating them for every row at runtime.

```
BEFORE                              AFTER
──────                              ─────
Filter (age > 10 + 8)               Filter (age > 18)
```

This seems minor, but over billions of rows, avoiding repeated arithmetic adds up.

---

### 4. Boolean Simplification

**What it does:** Simplifies complex boolean expressions.

```
BEFORE                              AFTER
──────                              ─────
Filter (true AND age > 18)          Filter (age > 18)
Filter (x > 5 OR true)             (filter removed entirely — always true)
```

---

### 5. Join Reordering

**What it does:** Reorders multi-table joins to minimize intermediate result sizes.

If you join tables A, B, and C, the order matters. Joining the two smallest tables first produces a smaller intermediate result, making the final join faster.

Spark uses **cost-based optimization (CBO)** when table statistics are available to make this decision.

---

### 6. Combine Filters

**What it does:** Merges multiple consecutive filters into a single filter with an `AND` condition.

```
BEFORE                              AFTER
──────                              ─────
Filter (age > 18)                   Filter (age > 18 AND city = "NYC")
  └── Filter (city = "NYC")           └── Scan
        └── Scan
```

This reduces the number of operators in the plan and allows further optimizations on the combined expression.

---

## Stage 4: Physical Plan

The optimized logical plan tells Spark *what* to compute. The **Physical Plan** tells Spark *how* to compute it by selecting concrete algorithms and strategies.

### Physical Plan Strategies

Here are the key decisions Spark makes at this stage.

**Join Strategies:**

| Strategy | When Used | How It Works |
|---|---|---|
| **BroadcastHashJoin** | One side is small (< 10 MB by default) | The small table is broadcast to all executors. Each executor does a hash join locally. No shuffle needed. Very fast. |
| **SortMergeJoin** | Both sides are large | Both sides are shuffled and sorted by the join key. Sorted streams are merged. Default for large-large joins. |
| **ShuffledHashJoin** | One side is moderately smaller | Both sides are shuffled by the join key. The smaller side is built into a hash table. |
| **BroadcastNestedLoopJoin** | Non-equi joins, or very small datasets | Broadcasts one side and does a nested loop comparison. Slowest strategy. |

**Aggregation Strategies:**

| Strategy | Description |
|---|---|
| **HashAggregate** | Uses an in-memory hash map to group and aggregate. Fast when the number of groups fits in memory. |
| **SortAggregate** | Sorts data by group keys first, then aggregates. Used as a fallback when hash aggregation is not possible (e.g., non-reducible aggregation functions). |

**Scan Strategies:**

| Strategy | Description |
|---|---|
| **FileScan** | Reads data from files (Parquet, CSV, JSON, ORC). Applies pushdown filters and column pruning. |
| **InMemoryTableScan** | Reads from a cached DataFrame/table in memory. |

Spark may generate **multiple** physical plan candidates and use a cost model to pick the best one.

---

### Cost-Based Optimization (CBO)

For certain decisions (especially join strategy and join order), Spark can use **table statistics** to make smarter choices. CBO requires statistics to be computed on your tables:

```sql
ANALYZE TABLE sales COMPUTE STATISTICS;
ANALYZE TABLE sales COMPUTE STATISTICS FOR COLUMNS amount, region;
```

With statistics available, Spark knows approximate table sizes and column distributions, allowing it to:

- Choose the right join type (broadcast vs. sort-merge).
- Reorder joins to minimize intermediate data.
- Estimate the selectivity of filters.

Without statistics, Spark falls back to heuristics and default thresholds.

---

## Stage 5: DAG of Stages and Tasks

The physical plan is now broken down into a **DAG (Directed Acyclic Graph)** that can be distributed and executed across the cluster. This is the final step before code runs on executors.

### What is a Job?

A **Job** is created for every **action** in your Spark application. One call to `show()`, `count()`, `write()`, or `collect()` equals one job.

```python
df.count()     # Job 1
df.show()      # Job 2
df.write(...)  # Job 3
```

### What is a Stage?

Each job is divided into one or more **Stages**. Stage boundaries are created at points where a **shuffle** (data redistribution across the network) is required.

A stage is a set of transformations that can be executed **without moving data between executors** — meaning all operations within a stage can be pipelined together.

### What is a Task?

A **Task** is the smallest unit of execution. Each stage is broken into tasks — one task per **partition** of data.

If a stage processes a DataFrame with 200 partitions, that stage has 200 tasks. Each task runs on a single executor and operates on a single partition.

```
ACTION (e.g., df.show())
    │
    └── JOB 1
         │
         ├── STAGE 0  (read + filter)
         │    ├── Task 0  (partition 0)
         │    ├── Task 1  (partition 1)
         │    ├── Task 2  (partition 2)
         │    └── ...
         │         │
         │      shuffle
         │         │
         └── STAGE 1  (groupBy + aggregate)
              ├── Task 0  (partition 0)
              ├── Task 1  (partition 1)
              ├── Task 2  (partition 2)
              └── ...
```

---

### Narrow vs Wide Dependencies

Spark categorizes the relationships between parent and child RDDs/DataFrames into two types. This distinction is what determines stage boundaries.

**Narrow Dependencies:**

- Each partition of the child depends on **one (or a fixed few)** partitions of the parent.
- No data needs to move between nodes.
- Operations can be **pipelined** (executed one after another without writing intermediate results).
- Examples: `map()`, `filter()`, `select()`, `withColumn()`, `union()`.

**Wide Dependencies:**

- Each partition of the child depends on **many or all** partitions of the parent.
- Data **must be shuffled** across the network.
- This forces a **stage boundary**.
- Examples: `groupBy()`, `reduceByKey()`, `join()` (sort-merge), `repartition()`, `distinct()`.

```
NARROW DEPENDENCY                  WIDE DEPENDENCY
(no shuffle, same stage)           (shuffle, new stage)

Parent Partitions:                 Parent Partitions:
  [P0] [P1] [P2] [P3]               [P0] [P1] [P2] [P3]
    │    │    │    │                    \  \ / /\ \  / /
    ▼    ▼    ▼    ▼                    ─────────────────
  [C0] [C1] [C2] [C3]                    SHUFFLE
                                     ─────────────────
Child Partitions:                      / /  \ \  / \
  1-to-1 mapping                     [C0] [C1] [C2]

                                   Child Partitions:
                                     many-to-many mapping
```

---

### Shuffle: The Stage Boundary

A **shuffle** is the most expensive operation in Spark. It involves:

1. **Map side:** Each executor writes its output to local disk, partitioned by a key (e.g., the `groupBy` column).
2. **Network transfer:** Executors pull (fetch) the partitions they need from other executors over the network.
3. **Reduce side:** Each executor reads the fetched partitions and performs the final computation.

Shuffles are expensive because they involve **disk I/O**, **serialization**, **network transfer**, and **deserialization**. Minimizing shuffles is one of the most impactful performance optimizations you can make.

```
EXECUTOR 1                       EXECUTOR 2
┌─────────────────┐              ┌─────────────────┐
│ Partition A     │              │ Partition C     │
│ Partition B     │              │ Partition D     │
│                 │              │                 │
│ Map Output:     │              │ Map Output:     │
│  key=1 → data   │──────────────▶  key=1 → data   │
│  key=2 → data   │◀──────────────  key=2 → data   │
│                 │              │                 │
│ After Shuffle:  │              │ After Shuffle:  │
│  ALL key=1 data │              │  ALL key=2 data │
└─────────────────┘              └─────────────────┘
```

---

## Inspecting the Execution Plan

Spark gives you tools to see exactly what plan it has built. This is invaluable for debugging and optimization.

### Using explain()

The `explain()` method prints the execution plan for any DataFrame or Dataset.

```python
df = spark.read.parquet("sales.parquet")
result = df.filter(df.amount > 100).groupBy("region").sum("amount")

result.explain()
```

This prints the **physical plan** by default.

---

### explain() Modes

Starting from Spark 3.0, `explain()` accepts a `mode` parameter that controls how much detail is shown.

| Mode | What It Shows |
|---|---|
| `explain("simple")` | Physical plan only (default). |
| `explain("extended")` | Parsed logical → Analyzed logical → Optimized logical → Physical plan. |
| `explain("codegen")` | Physical plan + generated Java code (Whole-Stage CodeGen). |
| `explain("cost")` | Optimized logical plan with cost statistics (if available). |
| `explain("formatted")` | Physical plan in a cleaner, more readable format with details about each operator. |

**Example using extended mode:**

```python
result.explain("extended")
```

Output (simplified):

```
== Parsed Logical Plan ==
Aggregate [region], [region, sum(amount)]
  └── Filter (amount > 100)
        └── Relation [sales.parquet]

== Analyzed Logical Plan ==
region: string, sum(amount): double
Aggregate [region#5], [region#5, sum(amount#6) AS sum(amount)#12]
  └── Filter (amount#6 > 100.0)
        └── Relation [sales.parquet] [region#5, amount#6, ...]

== Optimized Logical Plan ==
Aggregate [region#5], [region#5, sum(amount#6) AS sum(amount)#12]
  └── Project [region#5, amount#6]
        └── Filter (isnotnull(amount#6) AND (amount#6 > 100.0))
              └── Relation [sales.parquet] [region#5, amount#6]

== Physical Plan ==
*(2) HashAggregate(keys=[region#5], functions=[sum(amount#6)])
  └── Exchange hashpartitioning(region#5, 200)
        └── *(1) HashAggregate(keys=[region#5], functions=[partial_sum(amount#6)])
              └── *(1) Filter (isnotnull(amount#6) AND (amount#6 > 100.0))
                    └── *(1) FileScan parquet [region#5, amount#6]
                          PushedFilters: [IsNotNull(amount), GreaterThan(amount, 100.0)]
```

---

### Reading a Physical Plan

Physical plans are read **bottom-up** — the execution starts at the bottom (data source) and flows upward to the final result.

Here's a guide to the common operators you'll see:

| Operator | Meaning |
|---|---|
| `FileScan parquet` | Reads data from Parquet files. Check `PushedFilters` to see what was pushed down. |
| `Filter` | Applies a filter condition to rows. |
| `Project` | Selects or computes columns (like SQL `SELECT`). |
| `Exchange` | A **shuffle**. This is a stage boundary. `hashpartitioning` means data is redistributed by hash of a key. |
| `HashAggregate` | Aggregation using a hash table. You'll often see two: `partial` (before shuffle) and `final` (after shuffle). |
| `BroadcastHashJoin` | A join where the smaller table is broadcast to all executors. |
| `SortMergeJoin` | A join where both sides are shuffled, sorted, and merged. Requires an `Exchange` on each side. |
| `BroadcastExchange` | Broadcasts a dataset to all executors (precedes a BroadcastHashJoin). |
| `Sort` | Sorts data by specified columns. |
| `WholeStageCodegen` | Indicates that multiple operators have been fused into a single optimized code block (shown as `*(N)` where N is the codegen stage ID). |

---

## A Complete Walkthrough Example

Let's trace a realistic query through the entire pipeline.

**The code:**

```python
orders = spark.read.parquet("orders.parquet")       # Columns: order_id, customer_id, amount, order_date
customers = spark.read.parquet("customers.parquet")   # Columns: customer_id, name, country

result = (
    orders
    .filter(orders.amount > 50)
    .join(customers, "customer_id")
    .groupBy("country")
    .agg({"amount": "sum", "order_id": "count"})
)

result.show()
```

**Stage 1 — Unresolved Logical Plan:**

```
Aggregate [country], [country, sum(amount), count(order_id)]
  └── Join (on customer_id)
        ├── Filter (amount > 50)
        │     └── Relation [orders.parquet]
        └── Relation [customers.parquet]
```

**Stage 2 — Resolved Logical Plan:**

All columns resolved with data types. `customer_id: INT`, `amount: DOUBLE`, `country: STRING`, etc. Spark confirms both tables have `customer_id`.

**Stage 3 — Optimized Logical Plan:**

```
Aggregate [country], [country, sum(amount), count(order_id)]
  └── Join (on customer_id)
        ├── Project [customer_id, amount, order_id]       ← column pruning (dropped order_date)
        │     └── Filter (isnotnull(amount) AND amount > 50 AND isnotnull(customer_id))
        │           └── Relation [orders.parquet]
        └── Project [customer_id, country]                ← column pruning (dropped name)
              └── Filter (isnotnull(customer_id))
                    └── Relation [customers.parquet]
```

Notice what the optimizer did:

- **Column Pruning:** `order_date` was dropped from orders; `name` was dropped from customers since neither is needed downstream.
- **Null filters added:** `isnotnull(customer_id)` was added on both sides because a join cannot match null keys anyway — filtering them early reduces data.
- **Predicate pushdown:** The `amount > 50` filter will be pushed into the Parquet scan.

**Stage 4 — Physical Plan:**

Assuming `customers` is small enough (< 10 MB) to broadcast:

```
*(4) HashAggregate (keys=[country], functions=[sum(amount), count(order_id)])     FINAL AGG
  └── Exchange hashpartitioning(country, 200)                                    SHUFFLE (stage boundary)
        └── *(3) HashAggregate (keys=[country], functions=[partial_sum, partial_count])   PARTIAL AGG
              └── *(3) BroadcastHashJoin [customer_id]                           JOIN (no shuffle!)
                    ├── *(1) Filter (amount > 50 AND isnotnull(customer_id))
                    │     └── *(1) FileScan parquet [orders]
                    │           PushedFilters: [GreaterThan(amount, 50), IsNotNull(customer_id)]
                    └── BroadcastExchange
                          └── *(2) Filter (isnotnull(customer_id))
                                └── *(2) FileScan parquet [customers]
```

**Stage 5 — DAG of Stages and Tasks:**

```
JOB 0 (triggered by .show())
│
├── STAGE 0: Scan customers.parquet → Broadcast
│    (small table, broadcast exchange)
│
├── STAGE 1: Scan orders.parquet → Filter → BroadcastHashJoin → Partial Aggregate
│    Tasks: one per partition of orders.parquet
│    │
│    └── shuffle (hashpartitioning by country)
│
└── STAGE 2: Final Aggregate → show()
     Tasks: 200 (default shuffle partitions)
```

---

## Adaptive Query Execution (AQE)

Traditional query planning happens **before** execution, based on estimates. But estimates can be wrong — especially when table statistics are missing or data is skewed. **Adaptive Query Execution (AQE)** was introduced in Spark 3.0 to address this.

### What AQE Does

AQE **re-optimizes the execution plan at runtime**, between stages. After a shuffle completes, Spark knows the **actual** size and distribution of the intermediate data. AQE uses this real information to adjust the remaining plan.

```
TRADITIONAL PLANNING              ADAPTIVE (AQE)
──────────────────                 ────────────────
Plan everything upfront            Plan initially
    │                                  │
    ▼                                  ▼
Execute all stages                 Execute Stage 0
    │                                  │
    ▼                                  ▼
Done                               Observe real data sizes
                                       │
                                       ▼
                                   RE-OPTIMIZE remaining plan
                                       │
                                       ▼
                                   Execute Stage 1
                                       │
                                       ▼
                                   Observe again → RE-OPTIMIZE
                                       │
                                       ▼
                                   Execute Stage 2 ...
```

---

### Key AQE Features

**1. Coalescing Post-Shuffle Partitions**

After a shuffle, some partitions may be tiny (a few KB) while others are large. AQE automatically merges small partitions together to reduce the overhead of too many small tasks.

```
Before AQE coalescing:        After AQE coalescing:
[1KB] [2KB] [1KB] [500MB]     [4KB] [500MB]
  T1    T2    T3     T4         T1      T2

3 wasted tasks eliminated!
```

**2. Switching Join Strategies at Runtime**

The planner might initially choose a SortMergeJoin because it estimated a table was too large to broadcast. But after filtering, the actual size turns out to be small. AQE can switch to a BroadcastHashJoin at runtime.

**3. Handling Skewed Joins**

If one partition has far more data than others (data skew), that partition becomes a bottleneck. AQE detects this and splits the skewed partition into smaller sub-partitions, distributing the load more evenly.

```
Without AQE:                   With AQE:
Partition 0: 100 MB            Partition 0a: 50 MB
Partition 1: 100 MB            Partition 0b: 50 MB
Partition 2: 10 GB  ← SKEW!   Partition 1:  100 MB
                               Partition 2:  100 MB
One task runs 100x longer      Work distributed evenly
```

---

### Enabling AQE

```python
spark.conf.set("spark.sql.adaptive.enabled", "true")
```

In Spark 3.2 and later, AQE is **enabled by default**. Relevant sub-configurations:

| Property | Default | Description |
|---|---|---|
| `spark.sql.adaptive.enabled` | `true` (Spark 3.2+) | Master switch for AQE. |
| `spark.sql.adaptive.coalescePartitions.enabled` | `true` | Merge small post-shuffle partitions. |
| `spark.sql.adaptive.skewJoin.enabled` | `true` | Detect and handle skewed partitions in joins. |
| `spark.sql.adaptive.skewJoin.skewedPartitionFactor` | `5` | A partition is skewed if its size > median size × this factor. |
| `spark.sql.adaptive.advisoryPartitionSizeInBytes` | `64 MB` | Target size for coalesced partitions. |

---

## Whole-Stage Code Generation

When you see `*(N)` (e.g., `*(1)`, `*(2)`) in a physical plan, that asterisk indicates **Whole-Stage Code Generation (WholeStageCodegen)**.

Instead of interpreting the plan one operator at a time (volcano model), Spark fuses multiple operators within a stage into a **single optimized Java function** that is compiled and executed. This dramatically improves CPU efficiency by:

- Eliminating virtual function calls between operators.
- Keeping data in CPU registers and L1/L2 cache.
- Reducing memory allocations for intermediate results.

```
WITHOUT CODEGEN (Volcano Model)           WITH CODEGEN
─────────────────────────────             ────────────
FileScan → call → Filter → call →         Single compiled function:
  Project → call → HashAggregate            scan + filter + project + aggregate
                                            (fused into tight loop)
Each arrow = virtual function call,
  memory allocation, boxing/unboxing
```

You can see the generated code using:

```python
result.explain("codegen")
```

Whole-Stage CodeGen is enabled by default (`spark.sql.codegen.wholeStage = true`).

---

## The Spark Web UI: Visualizing the Plan

The Driver hosts a web UI (default port **4040**) that lets you visually inspect execution plans and monitor running jobs.

### SQL / DataFrame Tab

This is the most useful tab for understanding execution plans. For every DataFrame or SQL query that runs, it shows:

- A **visual DAG** of the physical plan (click on a query to see it).
- Metrics for every operator (rows processed, bytes read, time spent).
- Whether predicate pushdown was applied.
- Which join strategy was used.

### Jobs Tab

Shows all jobs with:

- Duration and status (succeeded, failed, running).
- Number of stages and tasks.
- A clickable DAG visualization for each job.

### Stages Tab

Shows all stages with:

- **Shuffle read/write** sizes — critical for identifying expensive shuffles.
- **Task distribution** — min, median, max task duration. A big gap between median and max suggests data skew.
- **GC time** — if tasks spend a lot of time on garbage collection, memory may need tuning.

---

## Configuration Properties

Here are the most important properties that affect execution plans.

| Property | Default | Description |
|---|---|---|
| `spark.sql.shuffle.partitions` | `200` | Number of partitions after a shuffle. Tune based on data size. |
| `spark.sql.autoBroadcastJoinThreshold` | `10485760` (10 MB) | Maximum size of a table that can be broadcast for a BroadcastHashJoin. Set to `-1` to disable. |
| `spark.sql.adaptive.enabled` | `true` (3.2+) | Enables Adaptive Query Execution. |
| `spark.sql.cbo.enabled` | `false` | Enables Cost-Based Optimization for joins and aggregates. |
| `spark.sql.codegen.wholeStage` | `true` | Enables Whole-Stage Code Generation. |
| `spark.sql.files.maxPartitionBytes` | `128 MB` | Maximum bytes per partition when reading files. |
| `spark.sql.inMemoryColumnarStorage.compressed` | `true` | Compress cached DataFrames in memory. |

---

## Common Pitfalls and How to Spot Them

### 1. Unnecessary Shuffles

**How to spot:** Look for `Exchange` operators in the physical plan. Each `Exchange` is a shuffle.

**Common causes:**

- Using `repartition()` when `coalesce()` would suffice (coalesce avoids a full shuffle for reducing partitions).
- Joining on columns that aren't already partitioned the same way.
- Unnecessary `groupBy` operations.

**Fix:** Restructure your code to minimize shuffles. Use broadcast joins where possible. Pre-partition data if it will be joined repeatedly on the same key.

---

### 2. Data Skew

**How to spot:** In the Spark Web UI Stages tab, check the task duration distribution. If the max task time is 10x or more the median, you likely have skew.

**Common causes:** A few keys have disproportionately more data (e.g., a `null` key, or a city like "New York" having 1000x more records than other cities).

**Fix:**

- Enable AQE skew join handling.
- Salt the join key: add a random prefix to the skewed key to split it across multiple partitions.
- Filter out null keys before joining if they aren't needed.

---

### 3. Missing Predicate Pushdown

**How to spot:** In the physical plan, check the `FileScan` operator. Look for the `PushedFilters` field. If your filter is not listed there, it was not pushed down.

**Common causes:**

- Using UDFs (User Defined Functions) in filters — Spark cannot push down UDFs.
- Using unsupported filter expressions for the data source.
- Reading from formats that don't support pushdown (e.g., plain text or CSV without schema).

**Fix:** Use built-in Spark functions instead of UDFs for filter conditions. Use columnar formats like Parquet or ORC. Check `explain("formatted")` to verify pushdown.

---

### 4. BroadcastHashJoin Not Triggered

**How to spot:** You see a `SortMergeJoin` with two `Exchange` operators when you expected a `BroadcastHashJoin`.

**Common causes:**

- The small table exceeds the broadcast threshold (default 10 MB).
- Table statistics are not collected, so Spark doesn't know the table is small.

**Fix:**

- Increase `spark.sql.autoBroadcastJoinThreshold` if you know the table is small enough to broadcast.
- Use an explicit broadcast hint: `df.join(broadcast(small_df), "key")`.
- Collect table statistics: `ANALYZE TABLE ... COMPUTE STATISTICS`.
- Enable AQE, which can switch to broadcast at runtime.

---

### 5. Too Many or Too Few Partitions

**How to spot:**

- **Too many:** Thousands of tasks completing in milliseconds. High scheduler overhead.
- **Too few:** A handful of tasks taking very long. Executor cores sitting idle.

**Fix:**

- Set `spark.sql.shuffle.partitions` based on your data. A good rule of thumb is to aim for partitions of 100–200 MB each.
- Use `coalesce()` after a filter that dramatically reduces data size.
- Use `repartition()` before a computationally heavy operation to increase parallelism.

---

## Best Practices

1. **Always check the plan before running at scale.** Use `explain("formatted")` or `explain("extended")` on your DataFrame before running expensive jobs. It takes seconds and can save hours.

2. **Read the plan bottom-up.** Data flows from the bottom (source scan) to the top (final output). Each `Exchange` is a shuffle and a stage boundary.

3. **Minimize shuffles.** Restructure transformations to reduce the number of `Exchange` operators. Use broadcast joins, pre-partition data, and avoid unnecessary repartitions.

4. **Enable AQE.** It's free performance. AQE handles partition coalescing, join switching, and skew mitigation automatically at runtime.

5. **Use Parquet or ORC.** These columnar formats support predicate pushdown and column pruning, which the optimizer relies on for efficient scans.

6. **Avoid UDFs in filters.** UDFs are opaque to the Catalyst Optimizer. It cannot push them down or optimize through them. Use built-in Spark SQL functions wherever possible.

7. **Collect table statistics for CBO.** Run `ANALYZE TABLE` on your key tables so the optimizer can make better decisions about join strategies and join ordering.

8. **Tune shuffle partitions.** The default of 200 is rarely ideal. For large datasets, increase it. For small datasets, decrease it. AQE's partition coalescing helps, but a reasonable starting value avoids waste.

9. **Monitor the Spark Web UI.** The SQL tab shows the visual plan with real metrics. The Stages tab reveals skew and shuffle sizes. Make the Web UI your first stop when debugging performance.

10. **Compare plans when optimizing.** After making a change, re-run `explain()` and compare the before/after plans. Confirm your change had the intended effect (e.g., a shuffle was eliminated, a BroadcastHashJoin appeared).

---

## Summary

Here is a recap of the key concepts covered in this guide:

- The **Execution Plan** is the full strategy Spark builds to turn your code into distributed work. Understanding it is essential for writing performant Spark applications.
- Spark uses **lazy evaluation** — transformations are recorded, and the plan is only built and executed when an action is called.
- The plan goes through five stages:
  - **Unresolved Logical Plan** — a raw parse of your code, unvalidated.
  - **Resolved Logical Plan** — validated against the catalog (columns, types, tables).
  - **Optimized Logical Plan** — refined by the Catalyst Optimizer using rules like predicate pushdown, column pruning, constant folding, and join reordering.
  - **Physical Plan** — concrete algorithms selected (join strategies, aggregation methods, scan types).
  - **DAG of Stages and Tasks** — broken into stages at shuffle boundaries, then into tasks (one per partition).
- **Shuffles** are the most expensive operations and define stage boundaries. They occur during operations like `groupBy`, `join`, and `repartition`.
- **Narrow dependencies** (no shuffle) stay within the same stage; **wide dependencies** (shuffle) create new stages.
- Use `explain()` to inspect the plan. Read it **bottom-up**. Look for `Exchange` (shuffles), check `PushedFilters`, and verify join strategies.
- **Adaptive Query Execution (AQE)** re-optimizes the plan at runtime based on actual data sizes, handling skew, coalescing partitions, and switching join strategies automatically.
- **Whole-Stage Code Generation** fuses multiple operators into a single compiled function for CPU efficiency.
- The **Spark Web UI** (port 4040) gives you a visual DAG, per-operator metrics, and task distribution to diagnose performance issues.

---

## Further Reading

- [Spark SQL, DataFrames and Datasets Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)
- [Adaptive Query Execution](https://spark.apache.org/docs/latest/sql-performance-tuning.html#adaptive-query-execution)
- [Catalyst Optimizer Deep Dive (Databricks Blog)](https://www.databricks.com/blog/2015/04/13/deep-dive-into-spark-sqls-catalyst-optimizer.html)
- [Understanding Physical Plans in Spark](https://spark.apache.org/docs/latest/sql-ref-explain.html)
- [Tuning Spark Performance](https://spark.apache.org/docs/latest/tuning.html)

---

> **Tip:** Developing the habit of running `explain()` on your queries is like checking a map before driving. It takes a moment, but it prevents you from taking the slowest route.
