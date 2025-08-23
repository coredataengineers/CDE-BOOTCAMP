# ROUTE TABLE
Let's talk about another `CRUCIAL` component in a VPC called Route Table, please to be able to proceed with this topic, its important to have gone through the below in this order
- [IP Addressing & CIDR](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md)
- [VPC Overview](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/01-VPC-Overview.md)
- [Subnets](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/02-Subnets.md)

## WHAT IS A ROUTE TABLE 
A Route Table is the component who control the flow of communication in your VPC . 
- Every Route Table have a set of rules which is called `Routes`
- That Route determine where communication from your Subnet is directed to.
- Every VPC comes with a default Route Table called `Main Route Table`.
- Every Subnet you create will automatically be associated with this Main Route Table.
- You can create your own Route Table and explicitly associate your subnets to it.
- Destinations in Route Table simply mean where you want to direct communication from your subnet to, this is represented in IPs or CIDR Range
- Targets in Route Table is just the medium which you want to use to get to the Destination.

For example you can create a Route Table and define a Route that says, any communication from Subnet A should go to a specifc IP Address on the internet. Lets represent this example visually 

<img width="1342" height="806" alt="Screenshot 2025-08-23 at 12 08 21" src="https://github.com/user-attachments/assets/1b86459c-367f-4ec9-af5c-fe8aae6838c9" />

Wait, we have something new in the image called `Internet Gateway` 🤔.
- Internet gateway is nothing but a component you attach to your VPC.
- It facilitate the communication from your VPC to the internet and also facilitate communication from the internet into your VPC.
- Every Default VPC already have an Internet Gateway attached to them.
- You cannot atatch 2 Internet Gateways to a VPC, it can only take 1 internet Gateway.

Let's summarise the Image above
- John is outside of the VPC, here we say he is on the internet considering his IP Address is not part of the VPC CIDR Range. 
- We have a VPC with 2 subnets ( SUBNET A and SUBNET B )
- Subnet A is where we have our Database with no custom Route Table associated.
  - It's associated with the Main Route Table with no link to the Internet Gateway.
  - Any Subnet associated with a Route Table that has no route to the Internet Gateway is called a `PRIVATE SUBNET`.
- Subnet A is where we have our Database with no custom Route Table associated.
  - It's associated with a custom Route Table with a link to the Internet Gateway.
  - Any Subnet associated with a Route Table that has a route to the Internet Gateway is called a `PUBLIC SUBNET`.

 ## NAT GATEWAY
 Nat Gateway is used to establish communication from a Private Subnet to the Internet.
 - The Nat Gateway is created in the public subnet
 - An elastic IP must be created and attached to the Nat Gatweay
   - Elastic IP is nothing mut a static public IP Address that you create and attach to Servers, Nat Gatway.
   - Reason is, if you stop a Server with already attached Public IP Address, when you restart that
     the server, it will generate another Public IP which can affect connectivity.
 - Private subnet route table is configured to have a route to the internet using the Nat Gateway
   - This essentially means, the communication will from the private subnet to the public subnet via the Nat Gatway, who will then forward the communication to the Internet Gateway which is already attached to the VPC to head to the internet. 
 
## CONCLUSION
if you need John to communicate with a resource in your subnet, make sure that resource is provisioned inside a PUBLIC SUBNET,
basically the subnet has to be associated with a Route Table that has a route linked to the Internet Gateway. 


