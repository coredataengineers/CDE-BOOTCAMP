## Scenario 1

At `CloudScale Inc.`, Data Engineering teams frequently spin up temporary 
IAM users for testing automated scripts used by tools like `Airflow`, `Airbyte` e.t.c in a shared AWS account. 

These temporary user accounts follow a strict naming convention: they all contain the word staging (e.g., airflow-staging-user, 
airbyte-staging-sync).

To prevent the AWS account from cluttering up with stale, orphaned credentials, 
the `Data Platform Team` wants to empower a specific group of `Junior Data Engineers` to safely delete these staging users without needing full administrative access (AdministratorAccess) or full IAM access.

The below IAM policy Document will solve the problem once its attached to the Data Engineering IAM group

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DeleteAccess",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteUser",
                "iam:DeleteLoginProfile",
                "iam:RemoveUserFromGroup"
            ],
            "Resource": [
                "arn:aws:iam::340752803932:user/*staging*"
            ]
        }
    ]
}
```
- `Effect`: This basically allowing the list of Actions on that Resourse
- `Action`: The Action that needs to be taken by anyone who get attached to the Policy
  - Note that DeleteUser has some dependency actions which can be found [here](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteUser.html)
- `Resource`: The actual IAM resource ARN that the actions applied upon.


## Scenario 2

As `CloudScale Inc.` scales its infrastructure, deleting production IAM users (e.g., airflow-production, airbyte-production) carries high risk. 

To prevent accidental production outages, the `Data Platform Team` implemented a strict delegation rule:
1. `Junior Data Engineers` retain permission to delete staging users (*staging*).
2. Deleting production users is strictly restricted to the `Lead Engineer` called `Mark`.

Using IAM Condition Keys (aws:PrincipalArn), the policy grants global deletion privileges 
exclusively when Mark triggers the request, while keeping standard engineers scoped strictly to staging resources.

The below IAM policy Document will solve the problem once its attached to the Data Engineering IAM group, its just an extension of the one above.


```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DeleteAccess",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteUser",
                "iam:DeleteLoginProfile",
                "iam:RemoveUserFromGroup"
            ],
            "Resource": [
                "arn:aws:iam::340752803932:user/*staging*"
            ]
        },
        {
            "Sid": "FullDeletionForMarkOnly",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteUser",
                "iam:DeleteLoginProfile",
                "iam:RemoveUserFromGroup"
            ],
            "Resource": [
                "arn:aws:iam::340752803932:user/*"
            ],
            "Condition": {
                "ArnEquals": {
                    "aws:PrincipalArn": "arn:aws:iam::340752803932:user/mark"
                }
            }
        }
    ]
}
```

- `Condition`: Conditionally target a specific IAM user to delete any bucket
- `ArnEquals`: This is the IAM condition operator, find all operators [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html)
- `aws:PrincipalArn`: This is the global condition context key to use in the condition , all condition context can be found [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html).
