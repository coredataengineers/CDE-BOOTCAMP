

A `Security Group` is a firewall that controls the traffic that is allowed to reach and leave the resources that it is associated with. 
For example, you can create a server in a specific subnet, create a security group that can be attached to the server.
This essentially is a firewall that control communication into and out of the server.

When you create a VPC, it comes with a default security group. You can create a custom security groups for a VPC, 
each with their own inbound and outbound rules.
- `Inbound`: Communication that come into the resource, for example a Server or a Database
- `Outbound`: Communication that leave the resourse 

<img width="1161" height="666" alt="Screenshot 2025-08-25 at 00 15 26" src="https://github.com/user-attachments/assets/6ad024b2-4d87-4915-86fb-af15ced09c84" />
