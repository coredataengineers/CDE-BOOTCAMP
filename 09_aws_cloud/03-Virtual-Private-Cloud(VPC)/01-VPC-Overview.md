# AMAZON VIRTUAL PRIVATE CLOUD (VPC)
This is a VPC guide that introduce you to what VPC and how it relates to IP Addressing and CIDR Range covered in the 
previous section, please if you have not check that note, see it [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md), it's important to understand that, because it's a 
prerequisite for VPC.

## WHAT IS VPC
VPC Stands for Virtual Private Cloud, see it as your small Cloud environment with a defined [Private Network](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#:~:text=A%20CIDR%20Range%20is%20like%20a%20private%20Network%2C%20which%20is%20a%20range%20of%20IPs), this private network is defined as a CIDR Range which is nothing but a list of IPs. You can provision resources like Databases, Servers e.t.c into this Private Network.

- This Private Network we call VPC is secure , you can control what can communicate with the resources that resides inside your VPC and also control where the resources that resides in your VPC can go.

- The reality is this, when you are creating a VPC on AWS, you will be asked to specify the [CIDR Range](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#classless-inter-domain-routing-cidr) for that VPC, this simply mean the list of IP Addresses you want to have that will make up your Private Network.

  - Let's assume you are creating a VPC, if you specify a CIDR Range of 10.8.0.0/16, this means you are going
to have 2 ** (32-16) = 65,536 IP Addresses that will make up your entire Private Network (VPC). Any IP that is not part of these list of IPs is not part of that network, hence any device using that IP cannot establish communication with the resources residing inside that VPC.
    - In this case, it's your job to whitelist that IP if you really want it to communicate with the resource in your Private Network (VPC), more on how to do this later.




