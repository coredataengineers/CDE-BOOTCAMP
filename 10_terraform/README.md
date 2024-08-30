# TERRAFORM
This Terraform guide covers the basics of Terraform to important concept that needs to be known
for beginners, this will help beginners know what terraform is and how it works before
writing Terraform configuration file to provision resources. We will cover the below
- What is Terraform
- How Terraform Works
- Terraform state file


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

IMAGE SUMMARY
- The first thing is writing your configuration file, which is where you will represent what your resources will look like
- Next step is for Terraform to plan based on what you define in the configuration file, Terraform is basically saying this is what you say you want to provision, it gives you a summary of that so you can review it before creating it.
- Final part is to Apply the configuartion file, this is what initiate the creation of the defined resource inside the configuration file
- NOTE: After the resources are applied and created, the copy of that operation is registered in the Terraformn state file.

Source Reference: https://developer.hashicorp.com/terraform/intro

## WHAT IS TERRAFORM STATE FILE ?


