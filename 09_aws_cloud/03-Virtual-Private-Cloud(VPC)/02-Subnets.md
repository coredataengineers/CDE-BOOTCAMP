# SUBNETS
Next up is Subnet, this is a `CRITICAL` resource of the VPC, please ensure you've covered the below in the specified order
- [IP Addressing & CIDR](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md)
- [VPC Overview](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/01-VPC-Overview.md)

Let's start to explore other resources inside a VPC, in our last note on VPC, we highlighted its a Private Network
that comes with a CIDR Range, this is nothing but some list of IPs that make up the whole network. We
further said if an IP is not part of that VPC CIDR Range, it will not be able to communicate with 
resources inside that VPC.

### WHAT IS A SUBNET
In the context of VPC, it's nothing but a range of IPs. Yes you heard that correctly, but in this case, its
the range of IP in the VPC CIDR Range. 

This simply mean, when you create a subnet, you need to specify the CIDR Range for that subnet, it's a way of dividing the overall network into small chunks. But its important to know that, the subnet CIDR Range must be from within the VPC CIDR Range.

Let's represent this visually and summarise it.

<img width="479" height="338" alt="Screenshot 2025-08-21 at 09 10 18" src="https://github.com/user-attachments/assets/c612ad95-7494-4a13-9012-dcdc230ee303" />

Image Summary
- The VPC has a CIDR Range `10.0.0.0/28`
- The VPC has `2` Subnets
  - Subnet-A has a CIDR Range 10.0.0.0/32 which has `4` IPs.
  - Subnet-B has a CIDR Range 10.0.0.0/32 which has `8` IPs.
  - Use this [tool](https://www.zerobounce.net/ip-range-cidr-converter/) to convert a range of IPs to CIDR Range 
- The VPC has `4` more IPs not allocated to any Subnet.

### BENEFITS OF SUBNETS
- `Logical Isolation`: Subnets allow you to divide your VPC into smaller, manageable units. This isolation is crucial for security, as it prevents resources in one subnet from directly accessing resources in another, unless explicitly allowed through routing rules and security configurations which we will cover soon.
- `Security Control`: Subnets can be either `public` or `private`. `Public Subnets` have access to the internet through `Routing`, while `Private Subnets` do not have access to the internet. This allows for granular control over which resources are exposed to the internet and which are kept internal.

To be more specific, when you create a Database or a Server in a VPC , they are actually being deployed into a specific Subnet. Let's represent that visually

<img width="664" height="319" alt="Screenshot 2025-08-21 at 11 42 04" src="https://github.com/user-attachments/assets/c784047c-a006-44af-978e-9ebaff749991" />
IMAGE SUMMARY
- The Overall VPC Network is 10.0.0.0/28, which has 16 IPs
- The Network is further divided into 2 smaller chunks subnet A and subnet B
  - A Server is created in the Subnet A with 4 IPs, for your information, one of the IP will be attached to the Server.
  - A Database is created in the Subnet A with 8 IPs, for your information, one of the IP will be attached to the Server hosting that Database behind the scene.







