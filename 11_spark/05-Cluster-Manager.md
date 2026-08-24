# Apache Spark Cluster Manager: A Beginner's Guide

## Table of Contents

- [Introduction](#introduction)
- [What is a Cluster Manager?](#what-is-a-cluster-manager)
- [Types of Cluster Managers in Spark](#types-of-cluster-managers-in-spark)
- [Why YARN?](#why-yarn)
- [YARN Architecture & Components](#yarn-architecture--components)
  - [ResourceManager](#1-resourcemanager-rm)
  - [NodeManager](#2-nodemanager-nm)
  - [ApplicationMaster](#3-applicationmaster-am)
  - [Container](#4-container)
- [How Spark Runs on YARN](#how-spark-runs-on-yarn)
  - [Cluster Mode](#cluster-mode)
  - [Client Mode](#client-mode)
- [Spark on YARN: Key Terminology](#spark-on-yarn-key-terminology)
- [Submitting a Spark Application on YARN](#submitting-a-spark-application-on-yarn)
- [Key Configuration Properties](#key-configuration-properties)
- [Summary](#summary)
- [Further Reading](#further-reading)

---

## Introduction

When you write a Spark application, it might seem like everything runs on a single machine. In reality, Spark distributes your work across many machines in a **cluster**. But something needs to manage those machines, decide who gets what resources, and keep everything running smoothly. That "something" is the **Cluster Manager**.

In this guide, we will focus on **YARN (Yet Another Resource Negotiator)** as our cluster manager of choice.

---

## What is a Cluster Manager?

A Cluster Manager is an external service responsible for:

- **Allocating resources** (CPU, memory) across applications running on the cluster.
- **Monitoring** the health and status of worker nodes.
- **Scheduling** tasks so that multiple applications can share the cluster fairly.
- **Restarting** failed components to maintain fault tolerance.

Think of it as the "operating system" of your cluster. Just like your OS manages programs on your laptop, the cluster manager manages applications across many machines.

---

## Types of Cluster Managers in Spark

Spark supports three main cluster managers:

| Cluster Manager | Description |
|---|---|
| **Standalone** | Spark's own built-in cluster manager. Simple to set up but limited in features. Best for development or small workloads. |
| **Apache YARN** | The resource manager that ships with Hadoop. Production-grade, widely adopted, and supports multi-tenancy. **This is what we will use.** |
| **Apache Mesos** (deprecated) | A general-purpose cluster manager. Spark support for Mesos has been deprecated as of Spark 3.2+. |
| **Kubernetes** | A container orchestration platform. Growing in popularity for running Spark in containerized environments. |

> **Note:** In this guide, we will be using **YARN** as our cluster manager. It is the most common choice in enterprise Hadoop environments and provides robust resource management out of the box.

---

## Why YARN?

There are several reasons YARN is a popular choice for managing Spark clusters:

1. **Tight Hadoop Integration** — If your data lives in HDFS (Hadoop Distributed File System), YARN is the natural fit. It is already part of the Hadoop ecosystem.
2. **Multi-Tenancy** — YARN allows multiple applications (Spark, MapReduce, Hive, etc.) to share the same cluster and its resources fairly.
3. **Mature & Battle-Tested** — YARN has been used in production at massive scale by companies worldwide for over a decade.
4. **Resource Isolation** — Each application gets its own set of containers with dedicated CPU and memory, preventing one app from starving another.
5. **Security** — YARN integrates with Kerberos and other Hadoop security features.

---

## YARN Architecture & Components

YARN follows a **master-worker** architecture. Below are its core components.

### 1. ResourceManager (RM)

The **ResourceManager** is the **master daemon** of YARN. There is one per cluster (with an optional standby for high availability).

**Responsibilities:**

- Accepts resource requests from applications.
- Allocates cluster resources (containers) to applications.
- Tracks the available resources on every node in the cluster.

The ResourceManager has two main internal components:

- **Scheduler** — Decides *how* resources are distributed among applications. It does not monitor or restart failed tasks; it only allocates resources. Common schedulers include the Fair Scheduler and the Capacity Scheduler.
- **ApplicationsManager** — Accepts job submissions, negotiates the first container for the ApplicationMaster, and restarts the ApplicationMaster on failure.

> **Analogy:** Think of the ResourceManager as the principal of a school. They decide how classrooms (resources) are assigned to different classes (applications) but don't teach the classes themselves.

---

### 2. NodeManager (NM)

The **NodeManager** is the **worker daemon** of YARN. There is one running on **every worker node** in the cluster.

**Responsibilities:**

- Manages resources (CPU, memory) on its specific node.
- Launches and monitors containers on that node.
- Reports the health and resource usage of the node back to the ResourceManager via periodic heartbeats.
- Kills containers if instructed by the ResourceManager or if they exceed their allocated resources.

> **Analogy:** If the ResourceManager is the principal, the NodeManager is the classroom teacher — managing what happens in their own room and reporting back to the principal.

---

### 3. ApplicationMaster (AM)

The **ApplicationMaster** is a **per-application** process. Every time you submit a Spark job (or any YARN application), a new ApplicationMaster is created.

**Responsibilities:**

- Negotiates resources (containers) with the ResourceManager on behalf of the application.
- Works with NodeManagers to launch, monitor, and manage the application's tasks within those containers.
- Reports progress and status back to the ResourceManager.
- Handles task-level fault tolerance (e.g., retrying failed tasks).

> **Analogy:** The ApplicationMaster is like a project manager. The principal (ResourceManager) gives them rooms and resources, and they coordinate the actual work happening inside those rooms.

In the context of Spark, the ApplicationMaster is responsible for requesting the containers that will run Spark **Executors**.

---

### 4. Container

A **Container** is the fundamental unit of resource allocation in YARN.

**What it represents:**

- A logical bundle of resources on a single node, such as:
  - A fixed amount of **memory** (e.g., 4 GB)
  - A fixed number of **CPU virtual cores** (e.g., 2 vCores)
- An isolated environment in which a task or process runs.

**Key points:**

- Containers are launched by NodeManagers.
- The ApplicationMaster runs inside a container.
- Spark Executors each run inside their own container.
- A single node can host multiple containers simultaneously.

> **Analogy:** A container is like a desk in a classroom. Each desk has a set amount of space and supplies, and one student (task) works at each desk.

---

### Component Interaction Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                          YARN CLUSTER                           │
│                                                                 │
│   ┌───────────────────────────────────┐                         │
│   │        RESOURCEMANAGER (Master)   │                         │
│   │  ┌─────────────┬────────────────┐ │                         │
│   │  │  Scheduler   │ Applications  │ │                         │
│   │  │              │   Manager     │ │                         │
│   │  └─────────────┴────────────────┘ │                         │
│   └──────────┬──────────────┬─────────┘                         │
│              │              │                                   │
│       ┌──────▼──────┐ ┌────▼────────┐                           │
│       │ NodeManager │ │ NodeManager │    ... (one per node)     │
│       │  (Node 1)   │ │  (Node 2)   │                           │
│       │ ┌─────────┐ │ │ ┌─────────┐ │                           │
│       │ │Container│ │ │ │Container│ │                           │
│       │ │  (AM)   │ │ │ │(Executor│ │                           │
│       │ └─────────┘ │ │ └─────────┘ │                           │
│       │ ┌─────────┐ │ │ ┌─────────┐ │                           │
│       │ │Container│ │ │ │Container│ │                           │
│       │ │(Executor│ │ │ │(Executor│ │                           │
│       │ └─────────┘ │ │ └─────────┘ │                           │
│       └─────────────┘ └─────────────┘                           │
└─────────────────────────────────────────────────────────────────┘
```

---

## How Spark Runs on YARN

When you submit a Spark application to YARN, Spark can run in one of two **deploy modes**.

### Cluster Mode

```
spark-submit --master yarn --deploy-mode cluster ...
```

- The **Spark Driver** runs **inside** the ApplicationMaster container on the cluster.
- The client (your terminal) can disconnect after submission — the job continues running.
- This is the **recommended mode for production** because the driver is close to the executors, reducing network latency.

**Flow:**

1. You submit the application from a client machine.
2. The ResourceManager allocates a container for the ApplicationMaster.
3. The ApplicationMaster launches the **Spark Driver** within itself.
4. The Driver (inside AM) requests additional containers from the ResourceManager.
5. Executors are launched in those containers across the cluster.
6. The Driver coordinates task execution on the Executors.

---

### Client Mode

```
spark-submit --master yarn --deploy-mode client ...
```

- The **Spark Driver** runs on the **client machine** (where you ran `spark-submit`).
- The ApplicationMaster only handles resource requests; it does not run the Driver.
- The client must stay connected for the entire duration of the job.
- This is useful for **interactive workloads** (e.g., `spark-shell`, Jupyter notebooks).

**Flow:**

1. The Driver starts on your local/client machine.
2. The ResourceManager allocates a container for the ApplicationMaster.
3. The ApplicationMaster requests additional containers for Executors.
4. Executors are launched across the cluster.
5. The Driver (on the client machine) communicates directly with the Executors.

---

### Cluster Mode vs. Client Mode at a Glance

| Feature | Cluster Mode | Client Mode |
|---|---|---|
| Driver location | Inside the AM on the cluster | On the client machine |
| Client connection | Can disconnect after submission | Must stay connected |
| Best for | Production batch jobs | Interactive / debugging |
| Network overhead | Low (driver is co-located) | Higher (driver is remote) |

---

## Spark on YARN: Key Terminology

Understanding how Spark terms map to YARN terms is essential.

| Spark Concept | YARN Equivalent | Description |
|---|---|---|
| Driver | Runs in ApplicationMaster (cluster mode) or on client (client mode) | The process that runs your `main()` function and creates the SparkContext. |
| Executor | Runs inside a Container | A JVM process on a worker node that runs tasks and stores data. |
| Task | Work unit inside an Executor | A single unit of computation sent to an executor. |
| SparkContext | Communicates with ResourceManager | The entry point to Spark functionality; requests resources from the cluster. |

---

## Submitting a Spark Application on YARN

Here is a basic example of submitting a Spark application using YARN as the cluster manager.

```bash
spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 4 \
  --executor-memory 4G \
  --executor-cores 2 \
  --driver-memory 2G \
  --class com.example.MySparkApp \
  /path/to/my-spark-app.jar \
  arg1 arg2
```

**Breakdown of the flags:**

| Flag | Description |
|---|---|
| `--master yarn` | Tells Spark to use YARN as the cluster manager. |
| `--deploy-mode cluster` | Runs the driver inside the cluster (in the AM). |
| `--num-executors 4` | Requests 4 executor containers. |
| `--executor-memory 4G` | Each executor gets 4 GB of memory. |
| `--executor-cores 2` | Each executor uses 2 CPU cores. |
| `--driver-memory 2G` | The driver process gets 2 GB of memory. |
| `--class` | The main class of your application. |

---

## Key Configuration Properties

Below are some important Spark-on-YARN configuration properties you should be aware of.

| Property | Default | Description |
|---|---|---|
| `spark.yarn.am.memory` | `512m` | Memory allocated to the ApplicationMaster in client mode. |
| `spark.yarn.am.cores` | `1` | Number of CPU cores for the ApplicationMaster in client mode. |
| `spark.executor.instances` | `2` | The number of executor containers to launch. |
| `spark.executor.memory` | `1g` | Memory per executor. |
| `spark.executor.cores` | `1` | CPU cores per executor. |
| `spark.driver.memory` | `1g` | Memory allocated to the driver. |
| `spark.yarn.queue` | `default` | The YARN queue to submit the application to. Useful for multi-tenant clusters. |
| `spark.dynamicAllocation.enabled` | `false` | If `true`, Spark can add/remove executors dynamically based on workload. |

---

## Summary

Here is a quick recap of everything we covered:

- A **Cluster Manager** is responsible for allocating and managing resources across a cluster of machines.
- **YARN** is our cluster manager of choice. It is mature, production-grade, and integrates seamlessly with the Hadoop ecosystem.
- YARN has four core components:
  - **ResourceManager** — the master that allocates resources cluster-wide.
  - **NodeManager** — the worker daemon on each node that manages local resources and containers.
  - **ApplicationMaster** — a per-application coordinator that negotiates resources and manages tasks.
  - **Container** — the fundamental unit of resources (memory + CPU) where processes actually run.
- Spark can run on YARN in **cluster mode** (driver on the cluster, best for production) or **client mode** (driver on your machine, best for interactive use).
- The `spark-submit` command with `--master yarn` is how you launch Spark applications on a YARN-managed cluster.

---

## Further Reading

- [Apache Spark Official Documentation — Running on YARN](https://spark.apache.org/docs/latest/running-on-yarn.html)
- [Apache Hadoop YARN Documentation](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html)
- [Spark Configuration Reference](https://spark.apache.org/docs/latest/configuration.html)

---

> **Happy Learning!** Once you are comfortable with these concepts, try submitting a simple Spark job on a YARN cluster to see everything in action.
