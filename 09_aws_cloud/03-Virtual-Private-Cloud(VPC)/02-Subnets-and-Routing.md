# SUBNETS AND ROUTING
Now that we now understood what a VPC is, if you haven't check that section, please feel free to read
that [here](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/01-VPC-Overview.md) 
before taking this section.

It's start to explore other resources inside a VPC, in our last note on VPC, we highlighted its a Private Network
that comes with a CIDR Range, this is nothing but some list of IPs that make up the whole network. We
further said if an IP is not part of that VPC CIDR Range, it will not be able to communicate with 
resources inside that VPC.

## WHAT IS A SUBNET
In the context of VPC, it's nothing but a range of IPs. Yes you heard that correctly, but in this case, its
the range of IP in the VPC CIDR Range. Let's represent this visually and summarise it.

<img width="479" height="338" alt="Screenshot 2025-08-21 at 09 10 18" src="https://github.com/user-attachments/assets/c612ad95-7494-4a13-9012-dcdc230ee303" />

