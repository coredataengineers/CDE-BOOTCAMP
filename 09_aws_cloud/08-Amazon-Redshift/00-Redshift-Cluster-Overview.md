# OVERVIEW
`Amazon Redshift` is a fully managed, `petabyte-scale` data warehouse service in the cloud.
But let's break this down a bit, 
- `Fully Managed` means it's manage by AWS.
- you don't need to build it yourself, basically with few clicks you have a functioning `Datawarehousing
System`.

In addition to the above, Amazon Redshift is `Distributed System`, this mean it leverage the concept of `Master and Slave Architecture`, where the `Master` designited what needs to be done to the `Slaves`. it's also worth to know that Redshift leverage `Columnar Storage` architecture to store it's data. 

Before anything, Amazon Redshift is an AWS service, Cluster is a resource you create within that service that let you build your Datawarehouse. To better understand Amazon Redshift, we need to understand what a `Redshift Cluster`, `Distributed System` and a `Columnar Storage` mean, the concept needs to be clear.
We need to know that we are not here to write SQL against this cluster, but we need to properly
deep dive into what the system is, so as to enable us work efficiently with it.

## WHAT IS A REDSHIFT CLUSTER
`Redshift Cluster`: is a collection of 2 or more computers called `Node` networked together to act as a single system. These Nodes networked together act as a unified system that helps to process our queries and store the data within that cluster. The Cluster is designed to allow the `Nodes` to communicate with one another. The image representation below shows a Redshift cluster with 3 Nodes connected to each other.

<img width="555" height="393" alt="Screenshot 2025-09-03 at 19 34 26" src="https://github.com/user-attachments/assets/944e22c5-37b8-41bb-9ade-9708ecf86beb" />

## DESTRIBUTED SYSTEM CONCEPT
`Distributed System`: These are systems that leverage a Master and Slave architecture. Redshift is a distrubted system, the above image shows what a typical Redshift Cluster looks like. 
- We can see we have 3 Nodes.
- But typically in a distributed system, there is a `Master Node` which we called a `LEADER NODE` in the context of Redshift cluster.
  - The Leader Node , coordinate the task and assign it to the Slaves.
- The rest of the 2 Nodes will be the `Slaves` which we called a `Compute Node` in the context of Redshift Cluster.
  - These are the guys that do the work designated to them by the `Leader Node`.
The visual representation looks like the below

<img width="653" height="438" alt="Screenshot 2025-09-03 at 19 41 56" src="https://github.com/user-attachments/assets/09cd365e-7e49-43ae-bec7-9de73faaf5bf" />

## WHAT DO WE MEAN BY COLUMNAR STORAGE 
`Columnar storage`: This is a database architecture that organizes and stores data by column rather than by row. 
- This method stores all values of a single column together in a `Block` on Disk.
  - `Block`: This is where data are stored on `Disk` in a Database, `Disk` is just a storage.
  - When you read or write data to a database table, you are actyually reading from that block or writing to that block.
- This method is very efficient for analytical queries and data warehousing applications that only need to access a subset of a table's columns.

Let us illustrate how a table will be store on Disk in a `Row Based` and `Columnar Based` Database, lets assume 
we have `Customer Table` with just 3 rows below.

|  Name  | Age     |  Location |
|---------|---------|-----------|
|  John   |  20     |  Berlin   |
|         |         |           |
|  Terry  |  18     |  Lagos    |
|         |         |           |
| Cynthia |  25     |  London   |

1. Let's represent how these 3 rows will be stored on a Postgres Database Disk. Note, Postgres Database is Row Oriented Database.

<img width="1322" height="157" alt="Screenshot 2025-09-03 at 20 31 32" src="https://github.com/user-attachments/assets/01726a8e-dd4f-4d6a-8973-9a94db22e29a" />

**Image Summary**
- We assume `Postgres` stores the 3 rows inside `3 blocks` on Disk.
  - Please be aware that this is just an example, a block can take more than a row depending on its fixed size, we are not here to discuss the detail of Database block.
- If you are interested in only the `Age Column` and only where `Age is 18`, the query will look like this `select Age where Age = 18;`
- As simple as this query is, this will scan all the entire `Block`, because Postgres is not sure if any age is 18 in the `first block` or not, it will check all the blocks and that will impact the query time.
- In this scenerio, we say the frequency of `I/O (Input/Output)` is high for `Row Oriented` Database when they conduct `analytical queries`, because it needs to keep checking in and out of blocks.

2. Let's represent how these 3 rows will be stored on a Redshift Cluster Disk. Note, Redshift is Columnar Oriented.

<img width="1309" height="154" alt="Screenshot 2025-09-03 at 21 30 24" src="https://github.com/user-attachments/assets/8d9d8c9a-ed43-4699-aed1-838c79e7d224" />

**Image Summary**
- We assume `Redshift` stores the 3 rows inside `3 blocks` on Disk.
  - Again, this is just an example, a fixed block size in Redshift is 1 MB, so this can take in more rows, but we are using this to explain the concept.
- if you are interested in the same Age Column and specifically where Age is 18, because this is stored in a Columns, Redshift will check only the Block 2, this will reduce `I/O (Input/Output)` because Redshift only care about that column.

For more on Redshift Columnar Storage: https://docs.aws.amazon.com/redshift/latest/dg/c_columnar_storage_disk_mem_mgmnt.html









