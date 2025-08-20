# AMAZON VIRTUAL PRIVATE CLOUD (VPC)
This is a VPC guide that introduce you to what VPC and how it relates to IP Addressing and CIDR Range covered in the previous section, please if you have not check that note, see it [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md), it's important to understand that, because it's a 
prerequisite for VPC.

## WHAT IS VPC
VPC Stands for Virtual Private Cloud, see it as your small Cloud environment with a defined [Private Network](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#:~:text=A%20CIDR%20Range%20is%20like%20a%20private%20Network%2C%20which%20is%20a%20range%20of%20IPs), this private network is defined as a `CIDR Range` which is nothing but a list of IPs which we already covered in our IP Adressing and CIDR Range section. You can provision resources like Databases, Servers e.t.c into this Private Network.

- This Private Network we call VPC is a secure environment, you can control what can communicate with the resources that resides inside your VPC like Databases, Servers and also control where the resources that resides in your VPC can go.

- The reality is this, when you are creating a VPC on AWS, you will be asked to specify the [CIDR Range](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#classless-inter-domain-routing-cidr) for that VPC, this simply mean the list of IPs Addresses you want to have that will make up your Private Network.

  - Let's assume you are creating a VPC, if you specify a CIDR Range of `10.8.0.0/16`.
  -  This means you are going to have `2 ** (32-16) = 65,536` IP Addresses that will make up your entire Private Network (VPC).
  -  If you want your friend to connect to a `Server` or `Database` inside that VPC from his house Network, you need to whitelist your friends IP Address and take care of some other things which we will cover in a later section before he can be able to connect to that Server or Database, because your friend's IP is not part of the VPC CIDR Range.
   
- It's worth to know that, every AWS Region comes with a default VPC (Created by AWS), but know that this VPC allow communication from anywhere from the internet to come into it, this will be clear shortly.
  - This VPC cannot be deleted.
- A custom VPC can as well be created by you, all configuration have to be set up by you. We will take care of this shortly too.






