# SUBNETS AND ROUTING
Now that we now understood what a VPC is, if you haven't check that section, please feel free to read
that [here](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/01-VPC-Overview.md) 
before taking this section.

It's start to explore other resources inside a VPC, in our last note on VPC, we highlighted its a Private Network
that comes with a CIDR Range, this is nothing but some list of IPs that make up the whole network. We
further said if an IP is not part of that VPC CIDR Range, it will not be able to communicate with 
resources inside that VPC.

### WHAT IS A SUBNET
In the context of VPC, it's nothing but a range of IPs. Yes you heard that correctly, but in this case, its
the range of IP in the VPC CIDR Range, it's a way of dividing the overall network into small chunks. Let's represent this visually and summarise it.

<img width="479" height="338" alt="Screenshot 2025-08-21 at 09 10 18" src="https://github.com/user-attachments/assets/c612ad95-7494-4a13-9012-dcdc230ee303" />

Image Summary
- The VPC has a CIDR Range `10.0.0.0/28`
- The VPC has 2 Subnets
  - Subnet-A has 4 IPs and Subnet-B has 8 IPs
- The VPC has 4 more IPs not allocated to any Subnet.

### BENEFITS OF SUBNETS
- `Logical Isolation`: Subnets allow you to divide your VPC into smaller, manageable units. This isolation is crucial for security, as it prevents resources in one subnet from directly accessing resources in another, unless explicitly allowed through routing rules and security configurations which we will cover soon.
- `Security Control`: Subnets can be either `public` or `private`. Public subnets have access to the internet through `Routing`, while private subnets do not have access to the internet. This allows for granular control over which resources are exposed to the internet and which are kept internal.





