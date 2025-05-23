# IAM POLICY
This page will give detailed understanding of the IAM Policy, this is an important resource in AWS to understand. 
To be honest, you can do very little without the IAM policy, we will cover this in detail.

### Topics that will be covered
- [Common IAM Concepts](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#common-iam-concepts)
- [What is IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#what-is-iam-policy)
- [Type of IAM Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#type-of-policy)
  - [AWS Managed Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=TYPE%20OF%20POLICY-,AWS%20Managed%20Policies,-An%20AWS%20managed)
  - [Inline Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=Managed%20Polices%20HERE-,Inline%20policies,-An%20inline%20policy)
  - [Identity-Based Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=is%20also%20deleted.-,Identity%2Dbased%20policies,-These%20are%20attached)
  - [Resource Based Policy](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#:~:text=or%20Inline%20Policies.-,Resource%2Dbased%20policies,-These%20are%20policies)
- [What is ARN](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#what-is-arn-amazon-resource-name)
- [Format of ARN](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#arn-format)
- [Understanding AWS Service and Resource](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#understanding-aws-service-and-resource)
- [IAM policy example](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#iam-policy-example)
- [IAM Policy Deep Dive](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/01_iam/IAM_Policy.md#iam-policy-deep-dive)

### COMMON IAM CONCEPTS
  We will be explaining the concepts of Identity, Entity, and Principals. Feel free to revert here when you seem confused about their application and how they differ.
- `AWS Entity`: An entity refers is any object that interacts with AWS resources. This could include identities, but it also encompasses broader AWS resources that have permissions. The term “entity” is broader than identity. While all identities are entities (since they can interact with AWS), not all entities are identities. An EC2 instance or Lambda function, for instance, is an entity but not typically considered an identity in the human or application sense.
- `AWS Identity`: An identity in AWS refers to any entity (user, role, group, etc.) that can be authenticated and authorized to interact with AWS resources. The term "identity" emphasizes who or what is authenticated. AWS identities are defined and managed in AWS Identity and Access Management (IAM).
- `AWS Principal`: A principal is an identity that can request to interact with an AWS resource. It is the actor or initiator of an action within AWS. Principals can be human users, AWS services, or external identity providers who are given temporary access to AWS and can act as principals.


### WHAT IS IAM POLICY
- Simply put, the IAM Policy is a Document containing the instructions of what an AWS entity like IAM User, IAM Role, or IAM Group can do. 
  - Basically, this policy contains what an entity should have and what they should not have access to.
  - For example, you can define a policy that grants access to create a Database.
  - When this policy is attached to an IAM user called `John` for example, it means `John` will be able to create a Database.
  - Also, you can create a policy to grant permission to a specific `Principal` in AWS.
    - You can create a policy that says only `John` can access an s3 Bucket, we will cover Amazon s3 later.

### TYPE OF POLICY
- `AWS Managed Policies`
  - AWS-managed policies are pre-built and maintained by AWS, available by default in every AWS account.
  - These policies make it easy to assign relevant permissions to users, groups, and roles without needing to create them manually.
  - The permissions in AWS-managed policies are fixed, and you cannot modify them.
  - AWS occasionally updates the permissions within these policies, and these changes apply automatically to all entities (users, groups, or roles) that the policy is associated with.
  - Using AWS-managed policies is quicker than creating your own and covers many typical use cases.
  - However, they may not always meet specific needs.
  - For instance, if you need to limit access to certain resources, you would need to customize the policy accordingly.
  - In such cases, writing a custom policy is necessary.
  - More on `AWS Managed Policies` [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html#aws-managed-policies)
   
- `Inline policies`
  - An inline policy is a policy created for a single IAM identity (a user, group, or role)
  - They are deleted when you delete the identity
    - For example, if you create an inline policy for `John`, when you delete `John`, the inline policy is also deleted.
   
- `Identity-based policies`
  - These are attached to an IAM user, group, or role, they are identity-based in nature. They are the most used policies.
  - These policies let you specify what that identity can do (its permissions)
  -  Identity-based policies can be [Managed Policies or Inline Policies.](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html)

- `Resource-based policies`
  - These are policies that are attached to a resource for example s3, Databases, EC2 e.t.c
  - With resource-based policies, you can specify who has access to the resource and what actions they can perform on it.
 
### WHAT IS ARN (AMAZON RESOURCE NAME)?
- Amazon Resource Names (ARNs) uniquely identify AWS resources. Resources are like infrastructures you create in the cloud like Storage, Database, Server, etc.
- When you create resources in the cloud, to be able to identify them uniquely, they are assigned their corresponding ARN. You can visualize it as a tag/barcode.
- Two resources cannot share the same ARN

### ARN FORMAT
- The format of ARN is not the same across every resource
- The specific AWS service will determine the format of the ARN
  - For example, the ARN format for an Amazon s3 bucket is like 
    - `arn:PARTITION:s3:::NAME-OF-YOUR-BUCKET`
    - PARTITION, in this case, is `aws`. See [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html#arns-syntax) for more on ARN.
  - Meanwhile, the ARN format for Amazon IAM for a user, `john` is like
    - `arn:PARTITION:iam::AWS-ACCOUNT-NUMBER:user/john`
  - It's evident that the format of ARN varies based on specific AWS Services.
- To know the format for a specific AWS Service, follow the below steps
  - Go to [Service Authorization Reference](https://docs.aws.amazon.com/service-authorization/latest/reference/reference.html)
  - On the left, click on the [Actions, Resource, and Condition Keys](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
  - You will see a long list of all the services offered by AWS
    - Search and click on [Amazon s3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html) from the long list on the left.
  - Under the `Topics` section, click on [Resource Types Defined by Amazon s3](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazons3.html#amazons3-resources-for-iam-policies)
    - You can see a table with `Resource types` and `ARN`
      - The ARN side, shows the format of the ARN for a specific resource in Amazon s3.
     
### UNDERSTANDING AWS SERVICE AND RESOURCE
Understanding the difference between these two is important in AWS, this will come in very handy when we jump to understanding the IAM Policy and other AWS services that will be covered.

`AWS Service`: Refers to the platform or tool provided by AWS to offer functionality (e.g. IAM, EC2, S3, Lambda). Services deliver capabilities and are abstract concepts.

`AWS Resource`: Refers to the instances or objects you create and manage using AWS services (e.g., IAM User, EC2 instance, S3 bucket, Lambda function). Resources are concrete and actionable items.

Below is a visual representation of both AWS Service and Resource, in this case, we picked IAM Service.

![Screenshot 2024-09-05 at 19 54 19](https://github.com/user-attachments/assets/0fb12a96-f186-41d3-8443-e759be7796e2)

To summarize the image above
 - AWS offers a service called IAM (Identity and Access Management) that helps manage identities and control access, ensuring the security of your AWS account and its associated services.

With IAM, you can set up users, groups, roles, and policies—collectively known as 'resources'—to manage permissions and control who can access what within your AWS environment.

In essence, IAM allows you to create and manage multiple resources within a particular AWS service to handle access and identity-related tasks.

### IAM POLICY EXAMPLE
- Let's take a look at the IAM policy below, this policy simply allows a `ListBucket` Action to take place on a bucket called `core-data-engineers-cohort1`.
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
We are going to use our IAM policy example above to do a deep dive that will give us a detailed understanding of the structure and its elements.
- `Version`: The Version policy element specifies the language syntax rules that are to be used to process a policy. More on `Version` [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_version.html)
- `Statement`: The Statement element is the most important element for an IAM policy. Within a Statement element, you can have One or More Statements inside a `List` or `Array` for people coming from Python and JavaScript backgrounds respectively. Each statement is wrapped inside a curly brace. Example: `"Statement": [ {Statement1}, {Statement2} ]`. More on Statement element [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_statement.html).
  - `Sid`: This is just the id of the individual statement within the Statement element, this can be any unique id of your choice. More on Sid [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_sid.html)
  - `Effect`: Effect takes 2 values `Allow` or `Deny`, this is just specifying whether to Allow a specific Action or Deny it. By default, it's `Deny`. More on Effect [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_effect.html)
  - `Action`: The Action element describes the specific action or actions that will be allowed or denied, you can have one or more actions, depending on your use case. More on Actions [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_action.html).
    - To see the complete list of Actions that are associated with a specific AWS Service, please visit [Service Authorization Reference](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
    - For example, to see Actions related to IAM Service, Visit [HERE](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsidentityandaccessmanagementiam.html#awsidentityandaccessmanagementiam-actions-as-permissions)
  - `Resource`: The Resource element in an IAM policy statement defines the object/Resource or objects/Resources within an AWS Service that the statement applies to. You specify a Resource using an Amazon Resource Name (ARN). More on Resource [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_resource.html)
 
NOTE: The above IAM Policy elements are not the only elements, there are more which can be found [HERE](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html). But you do not require all of them, the ones mentioned here are enough to start writing the IAM Policy, and you can always extend as you grow in the field. 
 
### DOCUMENTATION REFERENCE
- https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
- https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html
- https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html
