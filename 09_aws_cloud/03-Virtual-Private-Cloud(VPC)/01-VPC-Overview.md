# AMAZON VIRTUAL PRIVATE CLOUD (VPC)
This is a VPC guide that introduce you to what VPC and how it relates to `IP Addressing` and `CIDR Range` covered in the previous section, please if you have not checked that note, see it [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md), it's important to understand that, because it's a prerequisite for `VPC`.

## WHAT IS VPC
VPC Stands for `Virtual Private Cloud`, see it as your small Cloud environment with a defined [Private Network](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#:~:text=A%20CIDR%20Range%20is%20like%20a%20private%20Network%2C%20which%20is%20a%20range%20of%20IPs), this private network is defined as a `CIDR Range` which is nothing but a list of `IPs`, which we already covered in our `IP Adressing` and `CIDR Range` section. You can provision resources like `Databases`, `Servers` e.t.c into this Private Network.

- This Private Network we call `VPC` is a secure environment, you can control what can communicate with the resources that resides inside your VPC like `Databases`, `Servers` and also control where the resources that resides in your VPC can go.

- The reality is this, when you are creating a `VPC` on AWS, you will be asked to specify the [CIDR Range](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#classless-inter-domain-routing-cidr) for that VPC, this simply mean the list of `IP Addresses` you want to have to make up your Private Network.

  - Let's assume you are creating a VPC, if you specify a CIDR Range of `10.8.0.0/16`.
  -  This means you are going to have `2 ** (32-16) = 65,536` IP Addresses that will make up your entire Private Network (VPC).
  -  If you want your friend to connect to a `Server` or `Database` inside that VPC from his house Network, you need to `whitelist` your friends `IP Address` and take care of some other things which we will cover in a later section before he can be able to connect to that `Server` or `Database`, because your friend's IP is not part of the `VPC CIDR Range`.
   
- It's worth to know that, every `AWS Region` comes with a `default VPC` (Created by AWS), but know that this VPC allow routing to the internet, this will be clear in subsequent sections, so ignore this for now.
  - The default VPC cannot be deleted.
- A custom VPC can as well be created by you, all configuration have to be set up by you, including the CDR Range and some other resources which will be covered in subsequent sections.
  
The below image represent how a VPC looks like

<img width="1380" height="534" alt="Screenshot 2025-08-21 at 08 19 44" src="https://github.com/user-attachments/assets/a223593f-1f2d-44a8-8427-cb4a80e4f34d" />

Image Summary
- A VPC created with `10.0.0.0/28` CIDR Range.
- The `CIDR Range` has `16 IPs` that form the Private Network. Read how we get that from our [previous note](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/03-Virtual-Private-Cloud(VPC)/00-IP-Addressing.md#check-list-of-ip-addresses-in-cidr-range).
- The first IP is `10.0.0.0` and the last IP is `10.0.0.15`.
- John want's to communicate with the Network, lets say he wants to connect to a `Server` or `Database` that is inside this VPC, unfortunately its not possible because his IP `52.12.19.145` is not part of the VPC CIDR Range.
- We will cover how IPs that are not part of a VPC can be whitelisted, so relax 😁.

## VPC DNS CONFIGURATIONS
Before going into the `DNS` configurations for a VPC, lets understand the `DNS` concept itself. 
- When you access `www.google.com` on your laptop, you are essentially calling the `IP address` of the google.com application server behind the scene. At the end, that application is running inside a `Server`.
- `www.google.com` is a human readable Domain address, but computer doesn't understand that.
- When you look for `www.google.com` on the internet, a `DNS Server` will help you tranlate that `www.google.com` into the corresponding IP address of the actual `google.com` application running in the `Server`.
- That process is called `DNS Resolution`, and the guy doing the resolution is the `DNS Server`.

There are `2` important DNS configuration important for every VPC
- `DNS Hostnames`: If this is enabled in a VPC, every Servers launched in that VPC receive `public DNS hostnames` that correspond to their `public IP Address`. This is exactly what we said regarding the DNS concept above.
- `DNS Resolution`: If this is enabled, DNS resolution for private DNS hostnames is provided for the VPC by the Amazon DNS server.

This is the overview of what VPC is all about, we will dive into Subnets and Routing next, please feel free to use the below Documenation for more deep dive if you want.

Documenation Reference
- https://docs.aws.amazon.com/vpc/latest/userguide/configure-your-vpc.html
- https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html
- https://docs.aws.amazon.com/vpc/latest/userguide/vpc-cidr-blocks.html
- https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html
- https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc-options.html
- https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc.html
  










