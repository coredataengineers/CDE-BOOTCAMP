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
