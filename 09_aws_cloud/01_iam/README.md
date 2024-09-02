# IDENTITY AND ACCESS MANAGEMNET ( IAM )

 # TOPICS
 - [What is IAM](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#what-is-iam)
 - [Root User](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#root-user)
 - [IAM user](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-user)
 - [IAM group](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-group)
 - [IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-policy)
 - IAM Role

### WHAT IS IAM
AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources. With IAM, you can manage permissions that control which AWS resources users can access. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources. IAM provides the infrastructure necessary to control authentication and authorization for your AWS accounts.

### ROOT USER
When you create an AWS account, you begin with one sign-in identity that has complete access to all AWS services and resources in the account. This identity is called the AWS account root user and is accessed by signing in with the email address and password that you used to create the account. We strongly recommend that you don't use the root user for your everyday tasks. Safeguard your root user credentials and use them to perform the tasks that only the root user can perform. 

### IAM USER
An AWS Identity and Access Management (IAM) user is an entity that you create in AWS. The IAM user represents the human user or workload who uses the IAM user to interact with AWS. A user in AWS consists of a name and credentials.

### IAM GROUP
An IAM user group is a collection of IAM users. User groups let you specify permissions for multiple users, which can make it easier to manage the permissions for those users. For example, you could have a user group called Admins and give that user group typical administrator permissions. Any user in that user group automatically has Admins group permissions.

### IAM POLICY
You manage access in AWS by creating policies and attaching them to IAM identities (users, groups of users, or roles) or AWS resources. A policy is an object in AWS that, when associated with an identity or resource, defines their permissions. AWS evaluates these policies when an IAM principal (user or role) makes a request. Permissions in the policies determine whether the request is allowed or denied. Most policies are stored in AWS as JSON documents.
