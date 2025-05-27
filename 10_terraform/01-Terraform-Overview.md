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
