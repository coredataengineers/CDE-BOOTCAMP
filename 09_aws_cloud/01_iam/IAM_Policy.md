# IAM POLICY
This page will give detail understanding of IAM Policy, this is an important resource in AWS to understand. 
To be honest, you can do very little without IAM policy, we will cover this in detail.

### Topics that will be covered
- [What is IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#what-is-iam-policy)
- [Type of IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#type-of-policy)
  - [AWS Managed Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=TYPE%20OF%20POLICY-,AWS%20Managed%20Policies,-An%20AWS%20managed)
  - [Inline Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=Managed%20Polices%20HERE-,Inline%20policies,-An%20inline%20policy)
  - [Identity Based Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=is%20also%20deleted.-,Identity%2Dbased%20policies,-These%20are%20attached)
  - [Resource Based Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=or%20Inline%20Policies.-,Resource%2Dbased%20policies,-These%20are%20policies)
- [What is ARN](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#what-is-arn-amazon-resource-name)
- [Format of ARN](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#arn-format)
- [Understanding AWS Service and Resource](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#understanding-aws-service-and-resource)
- [IAM policy example](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#iam-policy-example)
- [IAM Policy Deep Dive](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#iam-policy-deep-dive)


### WHAT IS IAM POLICY
- In a simple word, IAM Policy is a Document containing the instruction of what an AWS entity like IAM User, IAM Role, IAM Group can do.
  - Basically, this policy contain what an entity should have and what they should not have access to.
  - For example you can define a policy saying access to be able to create a Database is allowed.
  - When this policy is attached to an IAM user called `John` for example, it means `John` will be able to carry out the action to create a Database.
  - Also you can create a policy to grant a permission to a specific `Principal` in AWS.
    - A `Principal` is the user, account, service, or other entity that is allowed or denied access to a resource in AWS.
    - You can create a policy that say only `John` can access an s3 Bucket, we will cover Amazon s3 later.

### TYPE OF POLICY
- `AWS Managed Policies`
  - An AWS managed policy is a policy that is created and managed by AWS, they are already created and it comes with every AWS account
  - AWS managed policies make it convenient for you to assign appropriate permissions to users, user groups, and roles.
  - You cannot change the permissions defined in AWS managed policies.
  - AWS occasionally updates the permissions defined in an AWS managed policy.
    - When AWS does this, the update affects all principal entities (users, user groups, and roles) that the policy is attached to
  - It is faster than writing the policies yourself, and includes permissions for many common use cases.
    - But AWS Management policies sometimes doesn't fit our use case sometimes.
    - For example, you might want to restrict someone from having access to a resource which will require you to really customize the policy
    - In that case, you have to write your own.
  - More on `AWS Managed Polices` [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html#aws-managed-policies)
   
- `Inline policies`
  - An inline policy is a policy created for a single IAM identity (a user, group, or role)
  - They are deleted when you delete the identity
    - For example, if you create an inline policy for `John`, when you delete `John`, the inline policy is also deleted.
   
- `Identity-based policies`
  - These are attached to an IAM user, group, or role, they are identity based in nature.
  - These policies let you specify what that identity can do (its permissions)
  -  Identity-based policies can be be [Managed Policies or Inline Policies.](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html)

- `Resource-based policies`
  - These are policies that are attached to a resource for example s3, Databases, EC2 e.t.c
  - With resource-based policies, you can specify who has access to the resource and what actions they can perform on it.
 
### WHAT IS ARN (AMAZON RESOURCE NAME)?
- Amazon Resource Names (ARNs) uniquely identify AWS resources. Resources are like infrastructures you create in the cloud like Storage, Database, Server e.t.c.
- Basically when you create resources in the cloud, to be able to identify them uniquely, they are assigned their corresponding ARN
- Two resources can not share the same ARN

### ARN FORMAT
- The format of ARN is not the same accross every resources
- The specific AWS service will determine the format of the ARN
  - For example the ARN format for an Amazon s3 bucket is like this below
    - `arn:PARTITION:s3:::NAME-OF-YOUR-BUCKET`
    - PARTITION in this case is `aws`. See [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html#arns-syntax) for more on ARN.
  - The ARN format for an IAM user called `john` is like this below
    - `arn:PARTITION:iam::AWS-ACCOUNT-NUMBER:user/john`
  - It's evident that the format of ARN varies based on specific AWS Service.
- To know the format for a specific AWS Service, follow the below steps
  - Go to [Service Authorization Reference](https://docs.aws.amazon.com/service-authorization/latest/reference/reference.html)
  - On the left, click on the [Actions, Resource and Condition Keys](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
  - You will see a long list of all the service offered by AWS
    - Search and click on [Amazon s3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html) from the long list on the left.
  - Under the `Topics` section, click on [Resource Types Defined by Amazon s3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html#amazons3-resources-for-iam-policies)
    - You can see a table with `Resource types` and `ARN`
      - The ARN side, shows the format of the ARN for a specific resources in Amazon s3.
     
### UNDERSTANDING AWS SERVICE AND RESOURCE
Understanding the difference between these two is important to know in AWS, this will come very handy when we jump to understanding IAM Policy and also in other AWS services that will be covered.
Below is a visual representation of both AWS Service and Resource, in this case we picked IAM Service.

![Screenshot 2024-09-05 at 19 54 19](https://github.com/user-attachments/assets/0fb12a96-f186-41d3-8443-e759be7796e2)

To summarise the image above
- Within the AWS Account, there is a Service AWS offer called IAM
  - This Service allow us to create identity and manage access that secure our AWS Account and its related Services
- Within the IAM Service, you can create users , groups, roles, policies which are called `Resources`
- So in short, You create one or more Resources within a specific AWS Service

### IAM POLICY EXAMPLE
- Let's take a look at the IAM policy below, this policy simply allow a `ListBucket` Action to take place on a bucket called `core-data-engineers-cohort1`.
- If this policy is attached to a specific IAM entity like IAM user, IAM role e.t.c
  - They will be able to perform a `ListBucket` action only on the `core-data-engineers-cohort1` that is specified in the IAM Policy.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": ["s3:ListBucket"],
            "Resource": ["arn:aws:s3:::core-data-engineers-cohort1"]
        }
    ]
}
```

### IAM POLICY DEEP DIVE
We are going to use our IAM policy example above to do a deep dive that will give us a detail understanding of the structure and its elements.
- `Version`: The Version policy element specifies the language syntax rules that are to be used to process a policy. More on `Version` [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_version.html)
- `Statement`: The Statement element is the most important element for an IAM policy. Within a Statement element, you can have One or More Statements inside a `List` for people coming from Python Background and `Array` for individuals coming from JavaScript background. Each statement are wrapped inside a curly braces. Example: `"Statement": [ {Statement1}, {Statement2} ]`. More on Statement element [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_statement.html).
  - `Sid`: This is just the id of the individual statement within the Statement element, this can be any unique id of your choice. More on Sid [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_sid.html)
  - `Effect`: Effect takes 2 values `Allow` or `Deny`, this is just specifying whether to Allow a specific Action or Deny it. By default it's `Deny`. More on Effect [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_effect.html)
  - `Action`: The Action element describes the specific action or actions that will be allowed or denied, you can have one or more actions, depending on your use case. More on Actions [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_action.html).
    - To see the complete list of Actions that is associated with a specific AWS Service, please visit [Service Authorisation Reference](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
    - For example to see Actions related to IAM Service, Visit [HERE](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsidentityandaccessmanagementiam.html#awsidentityandaccessmanagementiam-actions-as-permissions)
  - `Resource`: The Resource element in an IAM policy statement defines the object/Resource or objects/Resources within an AWS Service that the statement applies to. You specify a Resource using an Amazon Resource Name (ARN). More on Resource [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_resource.html)
 
NOTE: The above IAM Policy elements are not the only elements, there are more which can be found [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html). But you do not require all of them, the one mentioned here are enough to start writing IAM Policy, you can always extend as you grow in the field. 
 
### DOCUMENTATION REFERENCE
- https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
- https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html


    


    
