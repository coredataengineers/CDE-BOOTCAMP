# IDENTITY AND ACCESS MANAGEMENT (IAM)

 # TOPICS
 - [What is IAM](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/09_aws_cloud/01_iam/00_IAM_resources.md#what-is-iam)
 - [Root User](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/00_IAM_Resources.md#root-user)
 - [IAM user](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/09_aws_cloud/01_iam/00_IAM_resources.md#iam-user)
 - [IAM group](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/09_aws_cloud/01_iam/00_IAM_resources.md#iam-group)
 - [IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/09_aws_cloud/01_iam/00_IAM_resources.md#iam-policy)
 - [IAM Role](https://github.com/coredataengineers/CDE-BOOTCAMP/edit/main/09_aws_cloud/01_iam/00_IAM_resources.md#iam-role)

### WHAT IS IAM
- AWS Identity and Access Management (IAM) is one of the key services AWS provides that helps you to securely control who can access your account and the resources in it, like Servers and databases. etc.
- With IAM, you can manage permissions that control which AWS resources a specific user can access. - You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use resources.
- IAM provides the infrastructure necessary to control authentication and authorization for your AWS accounts.
- In fact, nearly all the services AWS provides require strong IAM knowledge because
  - No one has access to any resources by default and no AWS services are allowed to talk to other AWS services by default.
  - The only person that has access to everything is the user who created the AWS account, which is called the `ROOT USER`.

### ROOT USER
- When you create an AWS account, you begin with one identity that has complete access to all AWS services and resources in the account.
- This identity is called the AWS account `root user` and is accessed by signing in with the email address and password that you used to create the account.
- AWS strongly recommends that you don't use the root user for your everyday tasks, this user has permission to delete anything and create anything.
-  Safeguard your root user credentials and use them to perform the tasks that only the root user can perform.
- The best practice is to create an `IAM user` who can access the account, this user will be the identity that will carry out administrative tasks like creating other users and groups, giving permissions, and many more.
  - Ideally, the IAM user created by the root user credential will be given administrative permission to carry out tasks, including the creation of other users.
- Below is the representation of a `ROOT USER` who visited https://aws.amazon.com to create an AWS account for the first time.

<img width="1144" alt="Screenshot 2024-09-04 at 19 53 58" src="https://github.com/user-attachments/assets/287c5da4-f46e-4553-98fd-07a8e272e144">

### IAM USER
- An AWS Identity and Access Management (IAM) user is an entity that you create in AWS.
- The IAM user represents the human user or application that uses the IAM user to interact with the AWS account.
- Below is an image of a ROOT USER who creates a bunch of IAM USERS to be able to access the AWS account
- Note that these IAM users cannot do anything with the account, except given permission. We will cover something called the IAM policy later.

<img width="1159" alt="Screenshot 2024-09-04 at 20 03 00" src="https://github.com/user-attachments/assets/1a2537aa-5a4e-4322-bbe3-cb354e75b8b0">

### IAM ACCESS AND SECRET KEY
- These are long-term credentials for an IAM user or the AWS account root user
- These credentials are mainly used to authenticate into your AWS account programatically
- For example you might have a python code that need to put a csv file in an s3 bucket in AWS
  - In this case, python cannot login into AWS, it's not a human being, the only option is use these access key and secret key as a means to authenticate and put the file there.
  - Basically, you will create an IAM user for that your python application
  - You will grant the necessary permission to that IAM user to be able to put file in the s3 bucket.
  - You create the access and secret key for that IAM user
  - Your python application can use the access and secret keys to authenticate and carry out the actions to put the csv in the bucket.

### IAM GROUP
- An IAM user group is a collection of IAM users.
- User groups let you easily group IAM users that belong to the same function in one entity called an IAM group.
- This makes it easier to manage the permissions for those users. For example, you could have a user group called Admins and give that user group typical administrator permissions. Any user in that group automatically has Admins permissions.
- Similar to the image we have below, you can have users who are Data Engineers into the same group and attach the permission to that group, any Data Engineer who joins the team and is added to the IAM group will automatically inherit the permission attached to the group.

<img width="1153" alt="Screenshot 2024-09-04 at 20 09 30" src="https://github.com/user-attachments/assets/b4129dc8-c7fd-4e24-9b43-be38bd2af444">

### IAM POLICY
You manage access in AWS by creating policies and attaching them to IAM identities (users, groups of users, or roles) or AWS resources. A policy is an object in AWS that, when associated with an identity or resource, defines its permissions. AWS evaluates these policies when an IAM principal (user or role) makes a request. Permissions in the policies determine whether the request is allowed or denied. Most policies are stored in AWS as JSON documents. We covered IAM Policy seperately [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/01_IAM_Policy.md) because it's very import to understand it in detail as a Data Engineer.

### IAM ROLE
Another IAM Resource is IAM Role, this role is very important
- An IAM role is an IAM identity that you can create in your account that has specific permissions.
  - Basically you create an `IAM Role`, you attach an IAM Policy to it and anyone or specific service can assume that Role to perform a specific action.
`IAM Role` is `VERY CRITICAL` to know and understand, we covered it in detail [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/02_IAM_Role.md)
