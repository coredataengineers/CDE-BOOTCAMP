# RESOURCE TEMPLATE
Lets take a look at a resourse template, what it looks like and how we can be confident to work and understand
anyone we see later. The Resource template is basically the script available in the Terraform documenation 
to provision resources.

But we just don't want to copy it, we want to understsnd what it is, Terraform resource template file ends
with .tf, but lets assume we've created a file called `demo.tf` and we would like to create a simple 
iam user resource, please if you want to understand what an `IAM USER` is, please check our previous 
note [HERE](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/02-Identity-And-Access-Management(IAM)/00-iam-resources.md#iam-user).

The script to create an `IAM User` will look like this below
```
resource "aws_iam_user" "lb" {
  name = "testing"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}
```

**SCRIPT DETAIL**
- `resource`: This simply mean you want to create a new resource, this will always be constant anytime you want to create a new resource with terraform.
- `aws_iam_user`: This is telling Terraform the specific resource you want to create, there are lots of
resources. For example if you want to create an s3 bucket, it will be different and you can see the resource
name of s3 bucket [HERE](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket).

