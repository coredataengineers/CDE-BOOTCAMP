# EC2 SECURITY

Launching instances is one thing, securing it to ensure the right people have access to it and also secure it to prevent unauthorised individuals
from accessing it iis very CRITICAL.
We will cover 3 security ways 
- IAM
- Key Pair
- Security Group

## IAM
Applications must sign their API requests with AWS credentials. Therefore, 
if you are an application developer, you need a strategy for managing credentials for your applications that run on EC2 instances. 
For example, you can securely distribute your AWS credentials to the instances, enabling the applications on those instances to use 
your credentials to sign requests, while protecting your credentials from other users. However, it's challenging to securely 
distribute credentials to each instance, especially those that AWS creates on your behalf, such as Spot Instances or instances in 
Auto Scaling groups. You must also be able to update the credentials on each instance when you rotate your AWS credentials.

We designed IAM roles so that your applications can securely make API requests from your instances, 
without requiring you to manage the security credentials that the applications use. Instead of creating and distributing your AWS credentials, 
you can delegate permission to make API requests using IAM roles as follows:

## KEY PAIRS
A key pair, consisting of a public key and a private key, is a set of security credentials that you use to prove your identity when connecting
to an Amazon EC2 instance. For Linux instances, the private key allows you to securely SSH into your instance. For Windows instances, 
the private key is required to decrypt the administrator password, which you then use to connect to your instance.

Amazon EC2 stores the public key on your instance, and you store the private key, as shown in the following diagram. 
It's important that you store your private key in a secure place because anyone who possesses your private key can connect to your instances 
that use the key pair.

## SECURITY GROUP
A security group acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic. 
Inbound rules control the incoming traffic to your instance, and outbound rules control the outgoing traffic from your instance. 
When you launch an instance, you can specify one or more security groups. 
If you don't specify a security group, Amazon EC2 uses the default security group for the VPC. After you launch an instance, 
you can change its security groups.

Security is a shared responsibility between AWS and you. For more information, see Security in Amazon EC2. AWS provides security groups as one of the tools for securing your instances, and you need to configure them to meet your security needs. If you have requirements that aren't fully met by security groups, you can maintain your own firewall on any of your instances in addition to using security groups.


