# EC2 NETWORKING 
We all know `Amazon VPC` enables us to create a private network where we can launch AWS resources, such as `Amazon EC2 instances`. 
When you launch an `EC2 Instance`, you must select the subnet within that VPC to launch the instance into.
Don't forget that the subnet is just a division of the `VPC CIDR Range` which nothing but some bunch of `IP Addresses`.

When you launch instances in a subnet , that instance will be attached with one of the available IPs in that 
subnet. Lets understand this with the below image

<img width="747" height="476" alt="Screenshot 2025-08-26 at 20 24 04" src="https://github.com/user-attachments/assets/55380f17-5b0f-4877-9e17-af91f206d942" />

**IMAGE SUMMARY**
- We have a VPC with CIDR Range 10.0.0.0./28, which corresponds to 28 IPs
- We have 2 subnets with CIDR range 10.0.0.0/29 and 10.0.0.8/29, both CIDR Range correspond to 8 IPs each.
- `EC2 Instance` launched in `SUBNET A` automatically and randomly get one of the available IPs, this is done by AWS. 

## ELASTIC NETWORK INTERFACE
When you launch an instance, we know it gets an IP address from the available IPs in that Subnet where it was launched into,
but the reality is this, the IP address is not attached to the EC2 Instance directly, infact its attached with to the `Elastic Network Interface`.

`Elastic Network Interface` is a `CRITICAL` networking component in a VPC that represents a virtual network card, see it as a card. You can create and configure network interfaces and attach them to instances that you launch in the same Availability Zone. When yoiu create ENI in a specific Availability Zone, make sure that the Instance you are attaching it to is also in the same Availability Zone.

So this is what happened when you launch an Instance
- AWS create an Elastic Network Interface called the `Primary ENI`.
- Attach the available `IP Address` in that subnet to the `ENI`.
- The `EC2 Instance` will be created and the `ENI` will be attached to that `EC2 Instance`.

## ELASTIC IP
Before we go into `Elastic IP`, it's important to know that if you want anyone outside of your `VPC CIDR Range` to connect to your `EC2 instance`,
you need to ensure `Public IP` is attached to the EC2 Instance during the time of creation. Again, behind the scene, that `Public IP` will be 
attached to the primary `Elastic Network Interface`.

There is one issue that comes with this, when you stop that instance and start it again, you will not have the same `Public IP`, it will be changed 
to another one. This can be a problem sometimes depending on the use case.

To solve this problem, you can create an `Elastic IP` and attach it to the instance, when you stop and restart the Instance, the `Public IP` still 
remain the same. This `IP Address` is yours until you release it, this mean you remove it from your `EC2 Instance`. You can move an `Elastic IP` from one instance to another instance.

This is what the general represention looks like below

<img width="853" height="398" alt="Screenshot 2025-08-26 at 21 43 33" src="https://github.com/user-attachments/assets/38d6b780-d46c-4735-ba47-3fd7410b180e" />

## EC2 DNS HOSTNAME
It's important to know that when you create an EC2 Instance, at the end its a Server that anyone would have to connect to, either human being or an application.
But how do we communicate with Servers, we can't use their IP address, its not easy to remember, plus IP Address can change, in that case we give the Server a DNS Hostname that is easy to remember.

AWS EC2 instances also give DNS Hostname to instances that you launch, if you have an EC2 instance that you want someone from the internet to reach, they will have a Public DNS hostname, 
however for instances within your VPC, they all have their Private DNS Hostname.

Lets see how a DNS Hostname will be for the image we have above
- Private DNS Hostname: `ip-10.0.0.2.us-west-2.compute.internal`.
- Public DNS Hostname: `ip-43.39.19.2.us-west-2.compute.internal`.
So essentially, this above hostnames is what you use to connect to the instance, behind the scenee, the DNS Hostnames will be resolved back to their corresponding IP address, you don't care about this but AWS will do this.




