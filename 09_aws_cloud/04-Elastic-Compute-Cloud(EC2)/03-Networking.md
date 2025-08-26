# EC2 NETWORKING 
We all know `Amazon VPC` enables us to create a private network where we can launch AWS resources, such as Amazon EC2 instances. 
When you launch an EC2 instance, you must select the subnet within that VPC to launch the instance into.
Don't forget that the subnet is just a division of the VPC CIDR range which nothing but some bunch of IP Addresses.

When you launch instances in a subnet , that instance will be attached with one of the available IPs in that 
subnet. Lets understand this with the below image

<img width="747" height="476" alt="Screenshot 2025-08-26 at 20 24 04" src="https://github.com/user-attachments/assets/55380f17-5b0f-4877-9e17-af91f206d942" />
**IMAGE SUMMARY**
- We have a VPC with CIDR Range 10.0.0.0./28, which corresponds to 28 IPs
- We have 2 subnets with CIDR range 10.0.0.0/29 and 10.0.0.8/29, both CIDR Range correspond to 8 IPs each.
- `EC2 Instance` launched in `SUBNET A` automatically and randomly get one of the available IPs, this is done by AWS. 

## ELASTIC NETWORK INTERFACE
When you launch an instance, it automatically comes with an Elastic Network Interface, this will be created 
behind the scene by AWS.
The instance is configured with a primary network interface, which is a logical virtual network card. 
The instance receives a primary private IP address from the IPv4 address of the subnet, 
and it is assigned to the primary network interface.

You can control whether the instance receives a public IP address from Amazon's pool of public IP addresses. 
The public IP address of an instance is associated with your instance only until it is stopped or terminated. 
If you require a persistent public IP address, you can allocate an Elastic IP address for your AWS account 
and associate it with an instance or a network interface. 
An Elastic IP address remains associated with your AWS account until you release it, 
and you can move it from one instance to another as needed. 
You can bring your own IP address range to your AWS account, where it appears as an address pool,
and then allocate Elastic IP addresses from your address pool.
