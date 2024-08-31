# TERRAFORM GUIDE
This Terraform guide covers the basics of Terraform to important concept that needs to be known
for beginners, this will help beginners know what terraform is and how it works before
writing Terraform configuration file to provision resources. We will cover the below
- [Prerequisite](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#prerequisite)
- [Real life Scenario](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#a-real-life-scenrario)
- [What is Terraform](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#what-is-terraform-)
- [How Terraform Works](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#how-does-terraform-work-)
- [Terraform state file](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#what-is-terraform-state-file-)
- [Terraform Commands](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#useful-terraform-commands)

# PREREQUISITE
To be able to work with terraform, it's important to have the below prerequisite in place.
- Install Teraform on your Computer
  - MAC/LINUX users: Open your terminal and run the below command ( Make sure you have brew install, if not, install it [HERE](https://brew.sh/)
    - `brew tap hashicorp/tap`
    - `brew install hashicorp/tap/terraform`
  - WINDOWS users: Follow the manual installation [HERE](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  - After the installation, to verify everything is good, run `terraform --version` on your terminal


## A REAL LIFE SCENRARIO
Befor we start Terraform, let's consider a real life example and we map that to Terraform afterwards, so we understand what Terraform is doing.
- Let's assume you want to build a 3 bedroom apartment, you will need a lot of resources like bricks, water, sand, wood, roofing materials e.t.c. This resources are interchangeably called infrastructures.
- So ideally you will call a contractor to start the construction from scratch, so they start to combine all the above resources together to make the floor, later create the rooms and up to the roofing stage and finally the whole apartment will be ready for use.
- If you need to maintain the apartment, maybe change something, you simple call the contractor and they change what they need to change.
- This is exactly what happen in the Terraform world
  - Let's assume Terraform is the Contractor in this case, Terraform will ask the owner of the apartment to represent what he or she wants in a configuration file.
  - The owner in this case will specify, 3 rooms , the size, 2 toilets, 1 kitchen e.tc .
  - This file will be submitted to Terraform.
  - Terraform will create everything as described in the configuration file.
  - If the owner have to change anything in the apartment, the owner go back to that configuration file and make the changes, lets assume change from 2 toilets to 1.
  - Once the changes are completed, again Terraform will check the file and make the modification to match what is represented by the owner.

## WHAT IS TERRAFORM ?

Terraform is an infrastructure as code (IaC) tool that enable anyone to define what you want your cloud resource/infrastructure
to look like in a human readable terraform configuration file with .tf extension.
Basically , you create a terraform file and define what and what you want your cloud infrastructure or resource to 
be, and Terraform takes care of the rest for you.
So its exactly what we describe in the real world scenario, you basically create a terraform file, for example my_cloud_resources.tf, you specify what and how you want that your resources to look like, tehn Terraform takes care of the rest.

## HOW DOES TERRAFORM WORK ?
Before we know how terraform works, its important to talk about few things. Some of the major Cloud providers are Amazon Web Service(AWS), Microsoft Azure, Google Cloud Platform (GCP), lets assume we would like to create a resources on AWS, how does Terraform carry out this operation? 
This are the things that will happen...
- First, you need to create a Terraform configuration file that ends with .tf
- In this file, you need to specify that the provider you want to create the resource on is `aws`, this will look like this.
  
  <img width="204" alt="Screenshot 2024-08-30 at 22 19 35" src="https://github.com/user-attachments/assets/a0703d1c-b9d1-4f2e-8f7e-35c49e98c7a8">
  
- In the above, you are saying the provider where you want to create your resources on is aws and you said the region is us-east-1. Please read on AWS region and Availability Zones [HERE](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/)
- Below shows the flow of how terraform provision your resources
<img width="574" alt="Screenshot 2024-08-30 at 22 44 45" src="https://github.com/user-attachments/assets/7453f25c-b372-4860-9fee-28836441461b">

**IMAGE SUMMARY**
- The first thing is writing your configuration file, which is where you will represent what your resources will look like
- Next step is for **Terraform** to plan based on what you define in the configuration file, Terraform is basically saying this is what you say you want to provision, it gives you a summary of that so you can review it before creating it.
- Final part is to Apply the configuartion file, this is what initiate the creation of the defined resource inside the configuration file
- NOTE: After the resources are applied and created, the copy of that operation is registered in the Terraformn state file.

Source Reference: https://developer.hashicorp.com/terraform/intro

## WHAT IS TERRAFORM STATE FILE ?
First of all, we need to understand that Terraform state file is **VERY IMPORTANT**, in fact Terraform cann ot function without the state file. So lets describe what the state file is all about
- Terraform state file is a file that contain the summary of the resource that has been created
  - If you define a resource A in your Terraform configuration file, when you apply, the resource **A** will be created on aws for example, Terraform will also make sure it writes in the terraform state file that **A** has been created in AWS.
  - Let us assume you go back to your Terraform configuration file where you define A to change it to B
  - Terraform will compare what you have in the configuration file which B with what Terraform have in the Terraform state file which is A.
    - When you run a plan on the Terraform configuration file, Terraform will notice a difference, immediately Terraform will assume you want to create B.
  - So this means Terraform use the state file as a reference to what you already created and use it to compare what you have inside your configuration file, if there is difference, it shows you that.
  - What if you are creating a another new configuration file, lets assume you want to create a resource called JJJ, again Terraform will check the terraform state file if JJJ is there, if it's not, then Terraform will show you that you are about create JJJ in the plan summary.
  - State file Reference:
    - https://developer.hashicorp.com/terraform/language/state
    - https://developer.hashicorp.com/terraform/language/state/purpose
  - **NOTE**: When working with Terraform state file, PLEASE DO NOT push the state file to github. Terraform state file contains your infrastructure in plain text, it means if you create a Database, the username and password of the database will be available in plain text inside the state file. See here on how to manage state file in Production [HERE](https://developer.hashicorp.com/terraform/language/state/remote).
 
## USEFUL TERRAFORM COMMANDS
To be able to work with terraform, some commands are useed to conduct the terraform operations, in short, you can't create these resources in the cloud without using terraform commands. Below are the most commonly used

**NOTE**: Terraform command will only work if you are running the command in the Directory that contain any terraform configuration file that ends with .tf.

- `terraform init`: This command initialise your terraform project, if you have a specific provider in your project for example `aws`, this will install the plugins for the `aws` provider, so that terraform can be able to use this plugins to communicate with the provider. If you have a new provided added for example `azure`, you need to run the `terraform init` command again.
- `terraform plan`: This command shows the summary of what you are about to create for review. Basically you create a terraform configuration file of what you want that infrastructure or resource to look like, when you run terraform plan, it display the summary of what that infrastructure looks like, this allow you to review if its exactly what you want.
- `terraform apply`: This command create the resource in the target provider, for example it will create the rersource in `aws`. Before the final creation, it will ask you to type in `yes`, as soon as this is typed in, the resource will be created.
- `terraform validate`: This command help you to check if your terraform configuration file is correct, one thing is creating a configuration file of what you want your cloud resources should look like, but you need to confirm if how you represent those resource inside the file is correct or valid.
- Terraform Command Reference: https://developer.hashicorp.com/terraform/cli/commands

 

