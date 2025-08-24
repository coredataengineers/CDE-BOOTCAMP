# SECURITY GROUP AND NACL

A `Security Group` is a firewall that controls the traffic that is allowed to reach and leave the resources that it is associated with. 
For example, you can create a server in a specific subnet, create a security group that can be attached to the server.
This essentially is a firewall that control communication into and out of the server.

When you create a VPC, it comes with a default security group. You can create a custom security groups for a VPC, 
each with their own inbound and outbound rules.
- `Inbound`: Communication that come into the resource, for example a Server or a Database
- `Outbound`: Communication that leave the resourse 

<img width="1161" height="666" alt="Screenshot 2025-08-25 at 00 15 26" src="https://github.com/user-attachments/assets/6ad024b2-4d87-4915-86fb-af15ced09c84" />

## HOW DOES SECURITY GROUP WORKS?
Let's assume you create a Database in a public subnet, don't forget a public subnet has a route to the internet. The fact it has a 
route to the internet does not automatically allow connection from anyone on the internet. 
- You will need to create a Security Group that will be attached to that Database Instance
- You will create a `Security Group Rule`
  - `Ingress Rule`: Rule that control the inbound, basically control who can connect to that Database
    - Here you can say allow any connection into the Database from this specific IP Address or CIDR range.
  - `Egress Rule`: Rule that control outbound, pretty much communication that can leave the Database instance
    - Here you can say allow any connection from the Database to go to this specific IP Address or CIDR range.

## WHAT ABOUT NACL
`NACL stands for Network Access Control List`. This is a `firewall` not on the resource residing inside a subnet , but on the `subnet` level itself. When you create a `NACL` and associate a subnet to it, if you deny inbound traffic from a specific IP into that subnet, no connection can happen on the resource that resides inside that subnet even if security grouo allow the conNection.

<img width="1189" height="569" alt="Screenshot 2025-08-25 at 00 39 16" src="https://github.com/user-attachments/assets/9425bbef-8a79-4aad-940b-a5ccc6b6ee09" />


