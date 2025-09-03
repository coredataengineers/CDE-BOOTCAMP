# REDSHIFT ARCHITECTURE
From the overview of `Redshift`, we understood that it's a `Distributed System` which uses `Master` and `Slave` concept.
We also saw it leverage a `Columnar Storage` architecture to store its data on Disk.
Now let's dive into the architecture of a `Redshift Cluster`. 

Firstly, `Amazon Redshift` is based on `PostgreSQL`, so most existing SQL client applications will work with 
only minimal changes, however the backend was rewrote to support `OLAP queries`, `Massively parallel processing (MPP)`
and to be `Columnar` in nature. This allow redshift to horizontally scale, this means more `Compute Nodes` can be added 
to handle more complex workloads.

`Clusters------>` The core infrastructure component of an Amazon Redshift data warehouse is a `Cluster`.
- We know that a Cluster is made up of one or more Compute Nodes.
- If a Cluster is provisioned with two or more Compute Nodes, an additional leader node coordinates the compute nodes and handles external communication. This Leader Node will be created additionally by AWS.
- When you run any SQL Queries, you are actually talking to the Leader Node.

`Leader Node------>` The leader node manages external communications with client programs and all communication with compute nodes.
- This basically mean, if you connect to the Redshift Cluster using your favorite SQL client like Dbeaver, DataGrip e.t.c, you are communicating with the Leader Node behind the scene.
- The Leader will parses and develops `execution plans` to carry out database operations, in particular, the series of steps necessary to obtain results for complex queries.
- Based on the execution plan, the Leader Node compiles the code, distributes the compiled code to the Compute Nodes, and assigns a portion of the data to each Compute Node.
- The leader node distributes SQL statements to the compute nodes only when a query references tables that are stored on the compute nodes.
- All other queries run exclusively on the leader node.
- Amazon Redshift is designed to implement certain SQL functions only on the leader node

`Compute Nodes------>` The leader node compiles code for individual elements of the execution plan and assigns the code to individual compute nodes. 
- The compute nodes run the compiled code and send intermediate results back to the leader node for final aggregation.
- Each compute node has its own dedicated CPU and memory, which are determined by the node type.
- As your workload grows, you can increase the compute capacity of a cluster by increasing the number of nodes, upgrading the node type, or both.

`Redshift Managed Storage------>` Data warehouse data is stored in a separate storage tier Redshift Managed Storage (RMS). 
- RMS provides the ability to scale your storage to petabytes using Amazon S3 storage.
- RMS lets you scale and pay for computing and storage independently, so that you can size your cluster based only on your computing needs.

`Node slices------>` A compute node is partitioned into slices. 
- Each slice is allocated a portion of the `Node's Memory` and `Disk Space`, where it processes a portion of the workload assigned to the node.
- The `Leader Node` manages distributing data to the `Slice`s and apportions the workload for any queries or other database operations to the `Slices`.
- The `Slices` then work in parallel to complete the operation.

`Databases------>` A cluster contains one or more databases. 
- User data is stored on the Compute Nodes.
- Your `SQL Client` communicates with the leader node, which in turn coordinates query run with the compute nodes.
- `Amazon Redshift` is a relational database management system (RDBMS), so it is compatible with other RDBMS applications.
- Although it provides the same functionality as a typical RDBMS, including online transaction processing (OLTP) functions such as inserting and deleting data,
- Amazon Redshift is optimized for high-performance analysis and reporting of very large datasets.

For more on the Architecture: 
- https://docs.aws.amazon.com/redshift/latest/dg/c_high_level_system_architecture.html
- https://docs.aws.amazon.com/prescriptive-guidance/latest/query-best-practices-redshift/data-warehouse-arch-components.html



