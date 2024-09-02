# CLOUD COMPUTING
In this section, we are going to start the concept of Cloud from scratch, this will be very beginner friendly, 
there are many buzzy words and concepts that might sound veryu challenging to beginners, this is why we are 
going to explain with simple terms as much as possible, so as to allow this
concepts to stick faster. 

### TOPICS TO BE COVERED
- [Life before Cloud](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#life-before-cloud)
- [What is Cloud Computing](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-cloud-computing)
- [What is AWS](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-aws)
- [What is Data Center](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#what-is-data-center)
- [AWS Global Infrastructure](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/00_cloud_concept/README.md#aws-global-infrastructure)

### LIFE BEFORE CLOUD
Before diving into Cloud Computing, it's critical for us to have an idea of how things used to be. When we talk about how things were in the past before the rise of Cloud, there is a popular word that fly around which is called `On-Premise`, from our English word, it simply means something that is within your surrounding or environment.
- `On-Premise` in the context of Technology refers to private `Data Centers` that companies house in their own facilities and maintain themselves.
  - `Data Centers` is a physical location that stores computers which are called `Servers` and their related hardware equipment. It contains the computing infrastructure that IT systems require, such as servers, data storage drives, and network equipment. Read more [HERE](https://en.wikipedia.org/wiki/Data_center#:~:text=A%20data%20center%20(American%20English)%5B1%5D%20or%20data%20centre%20(Commonwealth%20English)%5B2%5D%5Bnote%201%5D%20is%20a%20building%2C%20a%20dedicated%20space%20within%20a%20building%2C%20or%20a%20group%20of%20buildings%5B3%5D%20used%20to%20house%20computer%20systems%20and%20associated%20components%2C%20such%20as%20telecommunications%20and%20storage%20systems.%5B4%5D%5B5%5D)
  -  `Servers` in a simple word is a computer that runs something and which can be access over the internet
     - See `Server` as your phone which allows you to play games online, stream videos, and store all of your important documents. It also acts as a place for other people to send messages to you and vice versa
     - It's exactly the same for `Servers`, in fact websites that you access are running inside a `Server` which is a computer that runs 24 hrs. There is more to Servers , but this will give you a base understanding of what it is.
- In short, how things use to be before was, many company run an `On-Premise` style of IT infrastructure, which means all Servers, Storages e.t.c are run and maintain within their premises/surrounding.

### WHAT IS CLOUD COMPUTING
Cloud computing is the on-demand delivery of IT resources over the Internet with pay-as-you-go pricing. Instead of owning, running, and maintaining physical data centers and servers in an on-premise, you can access technology services, such as Servers, storage, and databases, on an as-needed basis from any of the cloud provider. Some of the popular Cloud providers are Amazon Web Service (AWS), Microsoft Azure(Azure), Google Cloud Platform(GCP)
- `Cloud Providers`:  These are providers that run their own data centers in a very BIG physical location, so basically they will have Servers, Storage, Database and other IT infrastructures in this locaation. Any individuals or companies can contact them via their website to rent these resources as a pay-as-you-go means, so you pay for what you use on a monthly basis. These resources( Servers, Databases e.t.c) will then be access from an internet from your own location.


### WHAT IS AWS
- Amazon Web Service popularlily known as AWS is a company offering a Cloud Computing service.
- You sign up on their website to get Infrastructures/resources you need and pay based on usage.
- If you need a Server or Database for example, you can easily do that with few clicks on their website without having to manage those physically wherever you are.
- It's still worth to know that AWS run the Data Center in some physical locations accross the world. 

### AWS GLOBAL INFRASTRUCTURE
These section aim to provide some informations about the Global Infrastructure of AWS, we are focusing on where do AWS have those physical Data Centers. We will be introduce to 2 important concepts called `REGION` and `AVAILABILITY ZONES`. Before we dive into explaining what both really means, lets see an image representing both.

<img width="1056" alt="Screenshot 2024-09-02 at 18 00 02" src="https://github.com/user-attachments/assets/e02053d1-034f-4eb0-ae4f-d40ad58af531">
Image Reference: https://aws.amazon.com/about-aws/global-infrastructure/?p=ngi&loc=1

- `Region`: This is a physical geographical location around the world where they have their data centers. Previously above, we said Data Centers are physical location where all this resources like Servers, Databases and many other IT infrsatructures are. AWS has many of this locations around the world, they classify each geographical location as a Region. From the above image we can see they spread accross different region , the obvious region shown is Cape Town which has 3 `Availability Zones`.
- `Availability Zones`: This is one or more Data Center, Usually within a Region, you have 1 or more `Availability Zones(AZ)`. Each AZ represent a data center, As we can see above image, Cape Town Region have 3 Availability Zones, which means they have 3 Data Centers. One of the advantages of muliple `Availability Zone (AZ)` is disaster recovery, if you create your Servers accross the 3 `Availabilty Zone (AZ)` , it means if one of the Data Centers experience Outage or Failure, you still have access to your Server since its replicated accross multiple `Availability Zone (AZ)`.
- `Region Codes`: Every Region have their corresponding way of representing them. For example ..
  - Region Cape Town code representation is `af-south-1`
  - Frankfurt code representation is `eu-central-1`
  - Find the full list [HERE](https://www.aws-services.info/regions.html)

### MORE RESOURCES
- https://aws.amazon.com/about-aws/global-infrastructure/regions_az/?p=ngi&loc=2
- https://www.aws-services.info/regions.html

