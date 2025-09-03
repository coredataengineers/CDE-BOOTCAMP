# OVERVIEW
Amazon Redshift is a fully managed, petabyte-scale data warehouse service in the cloud.
But let's break this down a bit, fully managed means it's a manage service by AWS, 
you don't need to build it yourself, basically with few clicks you have a functioning Datawarehousing
system.

In addition to the above, Amazon Redshift is Distributed System, this mean it leverage the concept of Master and Slave architecture, 
where the Master designited what needs to be done to the slaves, it's also worth to know that Redshift
leverage columnar storage concept to store it's data. 

To better understand Amazon Redshift, we need to understand what a `Cluster`, `Distributed System` and a `Columnar Storage` mean.
We need to know that we are not here to write SQL against this Data warehouse service, but we need to properly
deep dive into what the system is.

WHAT IS A 
