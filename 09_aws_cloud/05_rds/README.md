### WHAT IS RDS 
- Amazon Relational Database Service (Amazon RDS) is a web service that makes it easier to set up,
operate, and scale a relational database in the AWS Cloud. 
- In a simple word, it's a service in AWS that offers Database Service
  - For example if you have a company and you want to store your customer's data , products data in a Database, you can easily create a Database with the RDS service.

### WHAT IS A DATABASE
- A database is an organized collection of data stored, so it can be access and managed.
  - Basically, you store and manage your data within that database and you also provide access so that anyone can retrieve data from it.

### DATABASE ENGINE
- A Database engine is the specific relational database software that runs on your `Database Instance`.
- Available Database Engines supported by RDS can be found [HERE](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html#Welcome.Concepts.DBInstance.architecture:~:text=access%20them%20directly.-,DB%20engines,-A%20DB%20engine)

### LOCAL DATABASE INSTANCE
To properly understand RDS concept properly, we need to take some step back on how you will have a Database on your local laptop, lets use Postgres Database as an example. Lets go through the steps of how it will look like
- Ideally you will visit the PostgreSQL [Website](https://www.postgresql.org/download/)
- You will select your Operating system like MacOS, Windows Linux
- Afterwards you download the installer on your Computer which is like the PostgreSQL Software
- You later run the installer up to the point it ask what you want the password of your Postgres Database is
- This mean you have a Postgres Database running on your computer and you can connect to it using any of your SQL clients like PGAdmin, Dbeaver, DataGrip.
- The visual representation can look like this below

![Screenshot 2024-09-06 at 13 05 32](https://github.com/user-attachments/assets/e95bc000-cdb9-413e-a419-b36ff50046f3)

### WHAT IS A DATABASE INSTANCE IN THE CLOUD
Before we know what a `Database Instance` means, lets break some terms down first
  - An `Instance` is like a computer, they are Virtual Machines(VM).
  - In the context of AWS we call them `EC2` instance which are called Virtual Servers
  - A `Database Instance` is an isolated database running inside an EC2 instance which we all know its a Server or Virtual Machine in the cloud.
  - For example the below image shows a Postgres Database Instance in AWS. We can see the Database Engine is of Postgres, while the Virtual Server in this case is an EC2 Instance.
  - NOTE, we only say `Computer` so it will be easy to remember for beginners.

![Screenshot 2024-09-06 at 12 47 24](https://github.com/user-attachments/assets/ca79474e-d836-42d5-9783-0de72424bc6d)

### DATABASE INSTANCE CLASS
- We all know that the Database Enhgine is the same, once you are interested a Database Instance, you will specify the Database Engine, for example Postgres.
- But the Instance where the Database Engine will run differs.
- Thats where Instance Class come in, This is basically the type of Computer you want your Database Engine to run inside.
- This Instance Class are different in computation, at the end they are Virtual computer, so they have different CPU, RAM e.t.c just as your personal laptop too.
  - The Instance Class you want will depend on your use case and how big your workload is
  - For example the Instance Class will determine the RAM, CPU e.t.c of your Database. Basically whatever your Instance has in terms of CPU, Memory, that will be what your Database will inherit.
    - For example, if you are running queries that are CPU intensive, that will automatically affect your Database performance.
  - See more on different Instance Types [HERE](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.Types.html)

### SECURITY GROUP
Before we talk about what Security Group is, its important to know that when you create a Database Instance in the cloud, you can't connect to that Database by default. This is another reason why Cloud Databases are secure. Your local Database you have on your laptop can easily be connected to, but in this case, you have a Database running inside an Instance in the cloud, how do you connect to that Database from your house?
- AWS uses `Security Group` as a security/firewall mechanism to protect communication/traffic that enters or leaves the EC2 Instance where our Database is running. Once any traffic can reach your Instance, then if anyone have the credentials to your Database , they will be able to connect to your Database. So basically the first thing is to be allowed to reach the Instance and thats what Security Group helps with.
  - Any communication or traffic that goes into your Instance is called `Inbound Traffic`
  - Any communication or traffic that goes out of your Instance is called `Outbound Traffic`
- Security Group Rule (sgr) is the rule attached to Security Group that specify the traffic that can enter or leaves an Instance.
  - Basically you create a Security Group and create Security Group Rule. Security Group without a Rule is useless, this Rule is divided into two.
    - `Inbound Rule` specify the rule that is allowed to enter the Instance.
    - `Outbound Rule` specify the rule that is allowed to leave the Instance.
  - More about Security Group [HERE](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html).
  - More on Security Group Rule [HERE](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html)
  - Note that knowledge of Networking is `STRONGLY REQUIRED` to know how to specify a specific rule for a specific traffic.
  - The visual representation of Database Instance and Security Group below

![Screenshot 2024-09-06 at 18 29 45](https://github.com/user-attachments/assets/d16f6ce9-927c-4d2d-bb09-ce7f7b172b6e)



