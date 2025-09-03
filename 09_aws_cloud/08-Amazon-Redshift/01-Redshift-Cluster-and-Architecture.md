# REDSHIFT ARCHITECTURE
From the overview of `Redshift`, we understood that its a `Distributed System` which uses `Master` and `Slave` concept.
We also see it leverage a `Columnar Storage` architecture to store its data on Disk.
Now let's dive into the architecture of a `Redshift Cluster`. 

Firstly, `Amazon Redshift` is based on `PostgreSQL`, so most existing SQL client applications will work with 
only minimal changes, however the backend was rewrote to support `OLAP queries`, `Massively parallel processing (MPP)`
and to be `Columnar` in nature. This allow redshift to horizontally scale, this means more `Compute Nodes` can be added 
to handle more complex workloads.
