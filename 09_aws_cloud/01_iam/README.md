# IDENTITY AND ACCESS MANAGEMNET ( IAM )

 # TOPICS
 - [What is IAM](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#what-is-iam)
 - [Root User](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#root-user)
 - [IAM user](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-user)
 - [IAM group](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-group)
 - [IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-policy)
 - [IAM Role](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/README.md#iam-role)

### WHAT IS IAM
- AWS Identity and Access Management (IAM) is one of the key service AWS provide that helps you to securely control who can access your AWS account and any of the resources in your account like Servers, Databases. e.t.c.
- With IAM, you can manage permissions that control which AWS resources a specific users can access. - You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
- IAM provides the infrastructure necessary to control authentication and authorization for your AWS accounts.
- In fact, nearly all of the service AWS provide require strong IAM knowledge because
  - No one have access to any resources by default and no AWS services is allowed to talk to another AWS services by default.
  - The only person that has access to everything is the user who created the AWS account, which is called the `ROOT USER`.

### ROOT USER
- When you create an AWS account, you begin with one identity that has complete access to all AWS services and resources in the account.
- This identity is called the AWS account `root user` and is accessed by signing in with the email address and password that you used to create the account.
- AWS strongly recommend that you don't use the root user for your everyday tasks, this user have permission to delete anything and create anything.
-  Safeguard your root user credentials and use them to perform the tasks that only the root user can perform.
-  Best practice is to create a user that will have access to the account , this user will be the identity that will carry out administrative tasks like creating other users , groups , giving permissions and many more.
  - Ideally that user who will be created by the root user credential will be given an administrative permission to be able to carry out those tasks to create other users.
- Below is the representation of a `ROOT USER` who visited https://aws.amazon.com to create an AWS account for the first time.

<img width="1144" alt="Screenshot 2024-09-04 at 19 53 58" src="https://github.com/user-attachments/assets/287c5da4-f46e-4553-98fd-07a8e272e144">

### IAM USER
- An AWS Identity and Access Management (IAM) user is an entity that you create in AWS.
- The IAM user represents the human user or application who uses the IAM user to interact with AWS account.
- Below is an image of an ROOT USER who creates bunch of IAM USERS to be able to access the AWS account
- Note that this IAM users do not have permission to do anything in the account, we will cover something called IAM policy later.

<img width="1159" alt="Screenshot 2024-09-04 at 20 03 00" src="https://github.com/user-attachments/assets/1a2537aa-5a4e-4322-bbe3-cb354e75b8b0">

### IAM GROUP
- An IAM user group is a collection of IAM users.
- User groups let you easily group IAM users that belong to the same function in one entity called IAM group.
- This make it easier to manage the permissions for those users. For example, you could have a user group called Admins and give that user group typical administrator permissions. Any user in that user group automatically has Admins group permissions.
- Similar to the image we have below, you can have users who are Data Engineers into the same group and attach the permission to that group, any Data Engineer who join the team and added to the IAM group will automatically inherit the permission attached to the group.

<img width="1153" alt="Screenshot 2024-09-04 at 20 09 30" src="https://github.com/user-attachments/assets/b4129dc8-c7fd-4e24-9b43-be38bd2af444">

### IAM POLICY
You manage access in AWS by creating policies and attaching them to IAM identities (users, groups of users, or roles) or AWS resources. A policy is an object in AWS that, when associated with an identity or resource, defines their permissions. AWS evaluates these policies when an IAM principal (user or role) makes a request. Permissions in the policies determine whether the request is allowed or denied. Most policies are stored in AWS as JSON documents.

### IAM ROLE
