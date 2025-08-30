
# BASIC RESOURCE PROVISIONING
This guide will walk us through a basic resource provisioning, basically we will create a simple resource with terraform and go 
through some relevant commands used to achieve this. In addition tio this , we will try to understand what we see when we run some commands.

Fromn our previoius note here about what a resource template looks like, we will us that script for this walkthrough.
Let's assume you want to start from scratch, ideally you will want to create 1 important file first, the naming convention for that file is to be called
`provider.tf`.

## STEP 1
- Create a `provider.tf` and add the below block of code into it, save the file.
```
provider "aws" {
  region = "eu-central-1"
}
```
- If you run `terraform init` command, it will output the below
<img width="706" height="366" alt="Screenshot 2025-08-30 at 20 56 38" src="https://github.com/user-attachments/assets/96830be8-4123-487c-ba1d-833f9fdd733e" />

**SUMMARY**
The terraform init command use what you defined in the provider.tf file to know which platform it needs to communicate with, basically terraform will initialise 
your project, download the provider plugin you specified in your provider.tf. These plugin is what terraform will use to communicate with your cloud
provider.

## STEP 2
Now that we've initialised the project and necessary plugins required by terraform to commivcate with AWS has been downloaded, next is to create a 
smaple file called `demo.tf`.
- Add the below terraform script and save it, the script is simply to create an IAM User in AWS.
```
resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}
```
- If you Run terraform plan, terraform will give you the plan output of what you want to create, the detail summary and the properties,
you should see something like below

<img width="404" height="359" alt="Screenshot 2025-08-30 at 21 16 18" src="https://github.com/user-attachments/assets/8529ab6f-d129-43a0-81da-3776e6c134df" />

- The image tells us you plan to add 1 resource
- The IAM User `id`, `arn`, `unique_id` will all be known after you apply
- We added `3 Properties/Arguments` in our above block of code, but terraform added some other properties and some `Attribute` of the resources.

## STEP 3
Now that your plan is okay to you, for example if it shows a plan output that doesn't match your intent, then you might want to revisit your script.
- Now we need to create the resource since its fine with us
- Running `terraform apply` will ask you if you really want to create the resource, it will ask you to hit yes, if you want to, something like below

<img width="489" height="105" alt="Screenshot 2025-08-30 at 21 35 24" src="https://github.com/user-attachments/assets/9b267dde-582d-4223-b70a-d3f75345cd7c" />

- After typing yes and hit enter, it will create the resource, you should see something like below.

<img width="548" height="177" alt="Screenshot 2025-08-30 at 21 37 40" src="https://github.com/user-attachments/assets/3939f1c4-2364-42f5-96c0-5338f42de431" />

Now that we've successfully provision our iam user resource, next is understanding something that allow terraform to function, and that is the 
`State File`.




