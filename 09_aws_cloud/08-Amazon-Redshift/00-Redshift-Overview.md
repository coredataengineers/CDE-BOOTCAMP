# OVERVIEW
Amazon Redshift is a fully managed, petabyte-scale data warehouse service in the cloud.
But let's break this down a bit, fully managed means it's a manage service by AWS, 
you don't need to build it yourself, basically with few clicks you have a functioning Datawarehousing
system.

In addition to the above, Amazon Redshift is Distributed System, this mean it leverage the concept of Master and Slave architecture, 
where the Master designited what needs to be done to the slaves, it's also worth to know that Redshift
leverage columnar storage concept to store it's data. 

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
