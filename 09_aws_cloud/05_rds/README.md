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
- 
![Screenshot 2024-09-06 at 12 57 22](https://github.com/user-attachments/assets/b49552e6-1bac-4faf-bd19-ca1bf061443c)

### WHAT IS A DATABASE INSTANCE IN THE CLOUD
Before we know what a `Database Instance` means, lets break some terms down first
  - An `Instance` is like a computer, they are Virtual Machines(VM).
  - In the context of AWS we call them `EC2` instance which are called Virtual Servers
  - A `Database Instance` is an isolated database running inside an EC2 instance which we all know its a Server or Virtual Machine in the cloud.
  - For example the below image shows a Postgres Database Instance in AWS. We can see the Database Engine is of Postgres, while the Virtual Server in this case is an EC2 Instance.
  - NOTE, we only say Computer so it will be easy to remember for beginners.

![Screenshot 2024-09-06 at 12 47 24](https://github.com/user-attachments/assets/ca79474e-d836-42d5-9783-0de72424bc6d)



### TYPICAL CLOUD DATABASE INSTANCE

### SECURING RDS INSTANCE
