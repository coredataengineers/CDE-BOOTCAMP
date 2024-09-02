# TERRAFORM GUIDE
This Terraform guide covers the basics of Terraform as an important concept that needs to be known
for beginners, this will help beginners know what terraform is and how it works before
writing Terraform configuration file to provision resources. We will cover the topics below:

- [Prerequisite](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#prerequisite)
- [Brief Introduction to IAC](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#Brief-Introduction-to-IAC)
- [Real life Scenario](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#a-real-life-scenrario)
- [What is Terraform](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#what-is-terraform-)
- [How Terraform Works](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#how-does-terraform-work-)
- [Terraform state file](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#what-is-terraform-state-file-)
- [State and Configuration File Handling In Terraform](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#State-and-Configuration-File-Handling-In-Terraform)
- [Terraform Commands](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/10_terraform/README.md#useful-terraform-commands)

## PREREQUISITE
Before you start working with Terraform, you'll need to have certain prerequisites in place.
- Install Terraform on your Computer
  - MAC/LINUX users: Open your terminal and run the below command ( Make sure you have brew installed, if not, install it [HERE](https://brew.sh/)
    - `brew tap hashicorp/tap`
    - `brew install hashicorp/tap/terraform`
  - WINDOWS users: Follow the manual installation [HERE](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  - After the installation, to verify everything is good, run `terraform --version` on your terminal

# Brief Introduction to IAC

Infrastructure as Code (IaC) is a method of managing and provisioning infrastructure by using code instead of relying on manual processes. This approach involves defining your infrastructure in configuration files, which makes it easier to adjust and share settings, while also ensuring that each environment you set up is identical to the previous one. By documenting these configurations in code, IaC also helps prevent the unintentional changes that can occur with manual setups.

An important aspect of IaC is version control, where these configuration files are managed just like any other software code. This practice allows you to break down your infrastructure into reusable, modular parts that can be combined and automated in various ways.

By automating infrastructure tasks through IaC, developers no longer need to manually set up servers, operating systems, or other infrastructure components whenever they work on new applications or updates.

In the past, setting up infrastructure was a labor-intensive and expensive manual task. With the advent of virtualization, containers, and cloud technologies, the management of infrastructure has shifted away from physical hardware in data centers. While this transition offers many benefits, it also introduces new challenges, such as the need to handle an increasing number of infrastructure components and the frequent scaling of resources. Without IaC, managing today’s complex infrastructure can be quite challenging.

IaC helps organizations effectively manage their infrastructure by enhancing consistency, reducing errors, and eliminating the need for repetitive manual configurations.

The key advantages of IaC include:
- Lower costs
- Faster deployment processes
- Reduced chances of errors
- Greater consistency in infrastructure setup
- Prevention of configuration drift



## A REAL LIFE SCENARIO
Before we start Terraform, let's consider a real-life example and we map that to Terraform afterward, so we understand what Terraform is doing.
- Let's assume you want to build a 3-bedroom apartment, you will need a lot of resources like bricks, water, sand, wood, roofing materials, etc. These resources can be interchangeably called infrastructures.
- Ideally, you will call a contractor to start the construction from scratch. They start to combine all the above resources to make the floor, create the rooms, get to the roofing stage, and finally, the whole apartment will be ready for use.
- If you need to maintain the apartment, maybe change something, you simply call the contractor and they change what they need to change.
- This is exactly what happens in the Terraform world
  - Let's assume Terraform is the Contractor in this case, Terraform will ask the owner of the apartment to represent what he or she wants in a configuration file. You can see the configuration as the building’s schematic/plan.
  - The owner in this case will specify, 3 rooms, the size, 2 toilets, 1 kitchen, etc.
  - This file will be submitted to Terraform.
  - Terraform will create everything as described in the configuration file.
  - If the owner has to change anything in the apartment, he/she returns to that building plan/schematics (configuration file) and makes the changes, let us assume a change from 2 toilets to 1.
  - Once the changes are completed, again Terraform will check the file and modify it to match what is specified by the owner.

## WHAT IS TERRAFORM ?

Terraform is an infrastructure as code (IaC) tool that   anyone to define what you want your cloud resource/infrastructure 
to look like in a human-readable terraform configuration file with a `.tf` extension.
Basically, you create a terraform file and define what you want your cloud infrastructure or resource to 
be, and Terraform takes care of the rest for you.
So it is exactly what we described in the real-world scenario; you create a building blueprint/Terraform file, for example, `my_cloud_resources.tf`, specify what resources you want and how they should look, and then Terraform takes care of the rest.

## HOW DOES TERRAFORM WORK?
Before we know how Terraform works, it is important to talk about a few things. Some of the major Cloud providers are Amazon Web Service(AWS), Microsoft Azure, and Google Cloud Platform (GCP). Assuming we would like to create a resource on AWS, how does Terraform carry out this operation? 
These are the things that will happen...
- Firstly, you need to create a Terraform configuration file that ends with `.tf`
- Secondly, in the `my_cloud_resources.tf` file, you will need to specify that the provider you want to create the resource on is `aws` in `us-east-1`.  Please read on AWS region and Availability Zones [HERE](https://aws.amazon.com/about-aws/global-infrastructure/regions_az/). This will look like this.
  
  <img width="204" alt="Screenshot 2024-08-30 at 22 19 35" src="https://github.com/user-attachments/assets/a0703d1c-b9d1-4f2e-8f7e-35c49e98c7a8">
    
**Visual Representation of Terraform’s Resource Provisioning**




<img width="574" alt="Screenshot 2024-08-30 at 22 44 45" src="https://github.com/user-attachments/assets/7453f25c-b372-4860-9fee-28836441461b">



**Source Reference**: https://developer.hashicorp.com/terraform/intro

**IMAGE SUMMARY**
- STEP 1: Write your configuration file, this is where you will represent what your resources will look like.
- STEP 2: **Terraform** plans your earlier defined resources based on the configuration file. Here Terraform reiterates the resource you want to provision, and summarises it, so you can review it before creating it.
- STEP 3: The configuration file is applied. This is what initiates the creation of the defined resource inside the configuration file
- **NOTE**: After the resources are applied and created, the copy of that operation is registered in the Terraform state file.


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
 
## USEFUL TERRAFORM COMMANDS
To efficiently work with Terraform, specific commands are essential for executing various operations. Simply put, creating cloud resources is not possible without utilizing these Terraform commands. Here are some of the most frequently used ones.
**NOTE**: Terraform Commands will only work if you are running them in a Directory that contains a configuration file i.e. a file with name ending with `.tf`.

- `terraform init`: This command sets up your Terraform project. If your project uses a specific provider, such as AWS, running this command will download the necessary plugins for that provider, enabling Terraform to interact with it. If you add a new provider, like Azure, you’ll need to rerun `terraform init` to install the corresponding plugins.
- `terraform plan`: This command generates a detailed preview of the infrastructure Terraform is about to create. After you define your desired infrastructure in a configuration file, running `terraform plan` provides a summary of what will be built, allowing you to review and verify the setup before proceeding.
- `terraform apply`: This command executes the creation of the specified resources in your chosen provider, such as AWS. Before Terraform proceeds with creating the infrastructure, it prompts you to confirm by typing `yes`. Once confirmed, the resources are deployed.
- `terraform validate`: This command checks the accuracy of your Terraform configuration files. It verifies whether the configuration is valid and properly structured, ensuring that the resources you’ve defined can be correctly interpreted and deployed by Terraform.
- Terraform Command Reference: [Terraform CLI Commands](https://developer.hashicorp.com/terraform/cli/commands)
