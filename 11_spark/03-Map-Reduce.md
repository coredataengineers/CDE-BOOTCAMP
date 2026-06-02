# MapReduce

As data continued to grow, scaling a single machine was no longer enough. The industry needed a way to process massive datasets across multiple machines instead of relying on one powerful server.

This led to the creation of Hadoop, an ecosystem designed for distributed storage and distributed processing.

You can think of Hadoop as the parent ecosystem that provides the infrastructure for handling big data. Within the Hadoop ecosystem, MapReduce serves as the processing framework responsible for executing data processing jobs across a cluster of machines.

A simplified view of the Hadoop ecosystem looks like this:

- HDFS (Storage)
- YARN (Resource Management)
- MapReduce (Processing)

MapReduce was one of the first widely adopted distributed processing frameworks and played a major role in the growth of big data technologies.

## How MapReduce Solved the Single-Node Problem

MapReduce breaks a job into two main phases:

### Map Phase

The input data is divided into smaller chunks and distributed across multiple nodes. Each node processes its assigned portion of the data independently.

### Reduce Phase

The intermediate results produced during the Map phase are collected, grouped, and combined to produce the final result.


This approach allowed organizations to process terabytes and petabytes of data that would have been impossible to handle on a single machine.

Instead of processing a 10 TB dataset on one machine, MapReduce distributes the workload across multiple nodes, allowing each machine to process only a fraction of the data. This significantly reduces the memory pressure on any single node and enables large-scale distributed processing.

### Limitations of MapReduce

While MapReduce introduced distributed processing to the world of big data, it had several limitations:

- **Slow execution speed – Processing could become slow, especially for complex workloads involving multiple stages.

- **Heavy reliance on disk storage – Intermediate results were frequently written to disk rather than kept in memory.

- **High Disk I/O overhead – Constant reading from and writing to disk increased processing time and reduced overall performance.

- **Disk-bound architecture – Performance was largely constrained by disk access speeds, which are significantly slower than memory access speeds.

- **Complex development experience – Building and maintaining MapReduce jobs often required a significant amount of code, making development more challenging.

- **Primarily Java-based programming model – Developers familiar with Python, SQL, or R often faced a steep learning curve when working with MapReduce.

As organizations processed increasingly larger datasets, they needed a system that could reduce disk operations, make better use of memory, provide better performance, and support more developer-friendly programming languages.

These needs eventually led to the creation of Apache Spark.
