## WHAT IS A TERRAFORM STATE FILE?
It is crucial to bear in mind that the Terraform State file is  **VERY IMPORTANT** that Terraform cannot function without it. Moving on,  let us delve into what the state file is all about.
- Terraform State File is a file that contains the summary/Metadata of any resource that has been created. It has the `.tfstate` extension. A typical file name could be `terraform.tfstate`
  - If you define a resource `A` in your Terraform configuration file called `example.tf` when you `apply`,  Terraform will automatically document this resource creation in the State file.

## STATE AND CONFIGURATION FILE HANDLING IN TERRAFORM
  - Let us assume you go back to your Terraform configuration file `example.tf` where you define resource `A` to change it to B. 
  - Terraform will compare what you have in the configuration file (which has now changed from `A` to `B`) with what exists in the Terraform State file, A.
    - When you run a `plan` on this configuration file, Terraform notices a difference and immediately assumes you now want to create B.
  - In essence, Terraform uses the State file as a reference to what you previously created, which is `A` in this case (remember it has the metadata to the most recent state of your configuration file), and compares it to what you now have inside your configuration file, `B`. It then shows you any differences detected from both versions.
  -  Assuming you want to create another new configuration file with a resource, `JJJ`. Again Terraform will check the State file to determine if `JJJ` is there, if it's not, then it will show you that you are about to create `JJJ` in the plan summary.
  - State file Reference:
    - https://developer.hashicorp.com/terraform/language/state
    - https://developer.hashicorp.com/terraform/language/state/purpose
  - **NOTE**: When working with Terraform state file, **PLEASE DO NOT** push the state file to GitHub. Terraform state file contains your infrastructure in plain text, which means if you create a Database, its username and password will be available in plain text inside the State file. See how to manage State files in Production [HERE](https://developer.hashicorp.com/terraform/language/state/remote).
