As we've covered in the past that a `Redshift Cluster` is made up of one or more `Compute Node`, 
AWS will create the Leader Node and manage that behind the scene, However applications and `SQL Clients` can communicate with
the Leader Node.

This simply mean we care about our `Compute Node`, when we launch a `Redshift Cluster`, we are asked the type of Node we want to have as 
our `Compute Node`, it's importamt to know what kind of Node type we will need to form our cluster. It's also importanmt to know the kind of 
workload and what we care about, do we care about storage or we care more about compute ?

If you have a `Compute Intensive` workload, you need to opt for the Node type that is more compute efficient, if storage is what you care about, 
it's important to provision storage optimised Node type. This is why we will cover the various Node type available and know 
what hardware spec they have.

Below are the important `hardware/resource` that comes with a Redshift Cluster Nompute Node
- `CPU` is the number of virtual CPUs for each node
- `RAM` is the amount of memory in gibibytes (GiB) for each node.
- `Default slices` per node is the number of slices into which a Compute Node is partitioned when a cluster is created.
- `Storage` is the capacity and type of storage for each node.
