# ELASTIC COMPUTE CLOUD - EC2

An `EC2 instance` is a virtual server in the `AWS Cloud`, see it as a computer hosted by AWS somewhere
and you have access to from where you are.

When you launch an `EC2 instance`, the instance type that you specify determines the hardware
available to your instance. 
Each instance type offers a different spec of compute, memory, network, and storage resources.

It's important to know that EC2 instance is a very `CRITICAL` resource in AWS, in fact, it powers a lot of
services behind the scene. As a `Data Engineer`, all of our workloads needs to run somewhere, they typically 
on servers like `EC2 Instance`.

## AMAZON MACHINE IMAGE - AMI
An Amazon Machine Image (AMI) is an image that provides the software that is required to
set up and boot an Amazon EC2 instance. 
- You must specify an AMI when you launch an instance. 
- The AMI must be compatible with the instance type that you chose for your instance. 
- You can use an AMI provided by AWS, a public AMI, an AMI that someone else shared with you, 
or an AMI that you purchased from the AWS Marketplace.

You can launch multiple instances from a single AMI when you require multiple instances with 
the same configuration. You can use different AMIs to launch instances when you require 
instances with different configurations, as shown in the following diagram.

## INSTANCE TYPES AND FAMILY
Instance type is just the type of Server, this is usually differentiated majorly based on the hardware available to that instance type. For example, Instance A might have 1 CPU and Instance B might have 5 CPU, this is similar to 
our computers where they all varies based on their hardware spec.

Instance types are combination of the Instance Family + Instance size, 
See this image below from AWS official Documenation

<img width="831" height="219" alt="image" src="https://github.com/user-attachments/assets/675efa42-0c04-4cc4-ae58-b2776d9fd755" />

IMAGE SUMMARY
- Every EC2 Instance comes with hardwares like `CPU`, `Memory`, `Storage` and `Network`.
- c7gn is the Family this instance belongs to
- 2xlarge is the instance size . 


EC2 instances are categorised into different categories based on the workload that suits you.
We will cover 4 of these categories that we consider the most common 
- `General Purpose` ----> Provide a balance of compute, memory, and networking resources. These instances are ideal for applications that use these resources in equal proportions, such as web servers. 
  - See [HERE](https://docs.aws.amazon.com/ec2/latest/instancetypes/gp.html) to see all Instance Types and specifications for the General purpose category
- `Compute optimized` – Designed for compute intensive applications that benefit from high performance processors. These instances are ideal for batch processing workloads, high performance web servers, high performance computing (HPC), scientific modeling, dedicated gaming servers, ad server engines, and machine learning inference.
  - See [HERE](https://docs.aws.amazon.com/ec2/latest/instancetypes/co.html) to see all Instance Types and specifications for the Compute optimized category.
- `Memory optimized` – Designed to deliver fast performance for workloads that process large data sets in memory.
  - See [HERE](https://docs.aws.amazon.com/ec2/latest/instancetypes/mo.html) to see all Instance Types and specifications for the Compute optimized category.
- `Storage optimized` – Designed for workloads that require high, sequential read and write access to very large data sets on local storage. They are optimized to deliver tens of thousands of low-latency, random I/O operations per second (IOPS) to applications.
  - See [HERE](https://docs.aws.amazon.com/ec2/latest/instancetypes/so.html) to see all Instance Types and specifications for the Storage Optimized category.
- `High-performance computing` – Purpose built to offer the best price performance for running HPC workloads at scale on AWS. These instances are ideal for applications that benefit from high-performance processors, such as large, complex simulations and deep learning workloads.
  - See [HERE](https://docs.aws.amazon.com/ec2/latest/instancetypes/hpc.html) to see all Instance Types and specifications for the High-performance computing category.



