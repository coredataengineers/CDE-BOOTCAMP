# CLOUD COMPUTING
In this section, we'll begin exploring the fundamentals of Cloud computing from the ground up, making it accessible for complete beginners. Some of the terms and concepts may seem complex at first, but we'll break them down into simple, easy-to-understand language to help you grasp the ideas more quickly and effectively. Our goal is to ensure these concepts resonate with you, even if you're just starting. 

### TOPICS TO BE COVERED
- [Life before Cloud](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#life-before-cloud)
- [What is Cloud Computing](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-cloud-computing)
- [What is AWS](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-aws)
- [What is  a Data Center](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-data-center)
- [AWS Global Infrastructure](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#aws-global-infrastructure)

### LIFE BEFORE CLOUD
Before exploring Cloud Computing, it's important to understand the traditional setup that existed before its emergence. A commonly used term from that era is `On-Premise.` This term, derived from English, generally refers to something that is located within one's environment or vicinity.
- `On-premise` in the context of Technology refers to private `Data Centers` that companies house in their facilities and maintain themselves.
  - `Data Centers` is a physical location that stores computers which are called `Servers` and their related hardware equipment. It contains the computing infrastructure that IT systems require, such as servers, data storage drives, and network equipment. Read more [HERE](https://en.wikipedia.org/wiki/Data_center#:~:text=A%20data%20center%20(American%20English)%5B1%5D%20or%20data%20centre%20(Commonwealth%20English)%5B2%5D%5Bnote%201%5D%20is%20a%20building%2C%20a%20dedicated%20space%20within%20a%20building%2C%20or%20a%20group%20of%20buildings%5B3%5D%20used%20to%20house%20computer%20systems%20and%20associated%20components%2C%20such%20as%20telecommunications%20and%20storage%20systems.%5B4%5D%5B5%5D)
  -  `Servers` in simple words is a computer that runs something and which can be accessed over the internet
     - See `Server` as your phone which allows you to play games online, stream videos, and store all of your important documents. It also acts as a place for other people to send messages to you and vice versa
     - It's the same for `Servers` websites that you access are running inside a `Server` which is a computer that runs 24 hrs. There is more to Servers, but this will give you a basic understanding of what it is.
- In short, how things used to be before was, that many companies ran an `On-Premise` style of IT infrastructure, which means all Servers, Storage e.t.c are run and maintained within their premises/surroundings.

### WHAT IS CLOUD COMPUTING
Cloud computing is the on-demand delivery of IT resources over the Internet with pay-as-you-go pricing. Instead of owning, running, and maintaining physical data centers and servers on-premise, you can access technology services, such as Servers, storage, and databases, on an as-needed basis from any of the cloud providers. Some of the popular Cloud providers are Amazon Web Service (AWS), Microsoft Azure(Azure), Google Cloud Platform(GCP)
- `Cloud Providers`:  These are providers that run their own data centers in a very BIG physical location, so basically they will have Servers, Storage, Database, and other IT infrastructures in this location. Any individuals or companies can contact them via their website to rent these resources as a pay-as-you-go means, so you pay for what you use monthly. These resources( Servers, Databases, etc.) will then be accessed from the internet from your location.


### WHAT IS AWS
- Amazon Web Service popularly known as AWS is a company offering a Cloud Computing service.
- You sign up on their website to get the Infrastructures/resources you need and pay based on usage.
- If you need a Server or Database for example, you can easily do that with a few clicks on their website without having to manage those physically wherever you are.
- It's still worth knowing that AWS runs the Data Centers in some physical locations across the world. 

### AWS GLOBAL INFRASTRUCTURE
This section provides an overview of AWS's Global Infrastructure, with a focus on the locations of its physical data centers. We'll explore two key concepts: `REGION` and `AVAILABILITY ZONES`. Before diving into a detailed explanation of these terms, let's first take a look at an image that illustrates them.

<img width="1056" alt="Screenshot 2024-09-02 at 18 00 02" src="https://github.com/user-attachments/assets/e02053d1-034f-4eb0-ae4f-d40ad58af531">
Image Reference: https://aws.amazon.com/about-aws/global-infrastructure/?p=ngi&loc=1

- `Region`: A region refers to a specific geographic area where AWS houses its data centers. As mentioned earlier, data centers are physical locations containing resources such as servers, databases, and various IT infrastructures. AWS has numerous such locations globally, and each of these areas is classified as a region. From the provided image, it's clear that AWS services are distributed across multiple regions, one of the most notable being Cape Town, which consists of three distinct `Availability Zones`.
- `Availability Zones`: A region typically consists of one or more data centers, known as `Availability Zones` (AZs). Each AZ corresponds to a distinct data center. For example, in the Cape Town region, there are three AZs, meaning there are three separate data centers. One of the key benefits of having multiple AZs is improved disaster recovery. By distributing your servers across these zones, you ensure that if one data center experiences an outage or failure, your servers remain accessible because they are replicated across other `Availability Zones`.
- `Region Codes`: Every Region has its corresponding way of representing them. For example.
  - Region Cape Town code representation is `af-south-1`
  - Frankfurt code representation is `eu-central-1`
  - Find the full list [HERE](https://www.aws-services.info/regions.html)

### MORE RESOURCES
- https://aws.amazon.com/about-aws/global-infrastructure/regions_az/?p=ngi&loc=2
- https://www.aws-services.info/regions.html

![image](https://github.com/user-attachments/assets/f0fe031f-600a-4d50-abc0-487d83c5dcc4)
