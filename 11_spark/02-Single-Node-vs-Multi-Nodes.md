# Single-Node vs Multi-Node Systems

Before learning Spark, it is important to understand the difference between single-node and multi-node systems. These concepts form the foundation of distributed computing and help explain why technologies such as Spark were created.

## What is a Node?

A node is simply a computing machine. It could be a laptop, desktop computer, virtual machine (VM), or physical server.

A node typically consists of:

- Application Layer for applications like (Pandas, Polars, Python, PostgreSQL, etc.)
- An Operating System (Windows, Linux, macOS)
- Hardware Layer that hosts resources such as CPU, Memory (RAM) and Storage

Regardless of its size, a node provides the resources required to run applications and process data.

## Single-Node Systems

In a single-node system, all processing happens on one machine. Popular tools such as Pandas, Polars and SQLite operate in this manner.

When you run a Pandas script on your laptop, all computation is performed using the CPU and memory available on that single machine.

Consider a machine/node with:

- 4 CPU cores
- 7 GB RAM
- Pandas installed

Now imagine the dataset being processed is 10 GB in size.

At this point, the machine has a problem. The dataset is larger than the available memory, which can result in an OOM (Out Of Memory) error. An OOM error occurs when an application requires more memory than the system can provide.

A simple way to think about it is:

- CPU performs the computations.
- Memory (RAM) stores the data being actively processed.

If there is not enough memory available, the application may slow down significantly, crash, or fail completely.

## Limitations of Single-Node Systems

As datasets grow, single-node systems begin to face several challenges.

### Memory Constraints

A machine can only process data within the limits of its available RAM. When datasets exceed available memory, performance degrades and applications may fail.

### Limited Compute Resources

A single machine has a fixed number of CPU cores. Once those resources are fully utilized, processing cannot be accelerated without upgrading the hardware.

### Vertical Scaling Has Limits

One way to improve performance is vertical scaling, which involves increasing the resources of a machine.

Before

- 4 CPU Cores
- 7 GB RAM

After

- 16 CPU Cores
- 64 GB RAM

While this can improve performance, it is not a permanent solution. Hardware upgrades become increasingly expensive, physical limits are eventually reached and datasets often continue growing faster than a single machine can handle.

This is why data engineers often say:

> Big data is relative.

There is no fixed size that automatically qualifies as big data. A dataset is considered "big" when it becomes difficult for the available hardware to process efficiently. A 10 GB dataset may be small for a cluster of servers but too large for a laptop with limited memory.

## Polars: Improving Single-Node Performance

Another limitation of some single-node tools comes from how they utilize CPU resources.

Pandas is primarily a single-threaded framework. In many operations, it effectively uses only one CPU core at a time, even when multiple cores are available.

Polars was designed to address this limitation. It is a multi-threaded DataFrame library that can utilize multiple CPU cores simultaneously, making it significantly faster than Pandas for many workloads.

However, Polars does not solve the scalability problem entirely. Both Pandas and Polars remain single-node technologies. Regardless of how efficiently they use CPU resources, they are still limited by the CPU, memory and storage available on a single machine.

Eventually, scaling a single machine is no longer enough.

## Multi-Node Systems

As data continues to grow, organizations need a way to move beyond the limits of a single machine. Instead of relying on one node, work can be distributed across multiple nodes. This approach is known as distributed computing.

In a multi-node system:

- Data is distributed across multiple machines.
- Processing is shared among multiple machines.
- Resources from several machines are combined to solve larger problems.

Rather than one machine doing all the work, multiple machines work together as a cluster.

Many modern technologies are designed for this distributed approach, including:

- Apache Spark
- Apache Kafka
- Apache Flink
- Kubernetes

These technologies coordinate work across multiple nodes, making it possible to process larger workloads and scale beyond the limits of a single machine.

This shift from single-node computing to distributed computing paved the way for technologies such as MapReduce and, later, Apache Spark.
