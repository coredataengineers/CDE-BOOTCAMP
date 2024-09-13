# IAM ROLE DEEP DIVE

### WHAT IS IAM ROLE
- An IAM role is an IAM identity that you can create in your account that has specific permissions.
- An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS.
- However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it.
- Also, a role does not have standard long-term credentials such as a password or access keys associated with it.
- You can use IAM Role to delegate access to users, AWS services or applications that don't normally have access to your AWS resources.

### A REAL WORLD MAPPING
Let's map IAM Role to a real world scenario to better understand it ...
- In many countries around the world, we know their is an office of presdident or prime minister.
- This Office will have a permission and some privileges that is attached to this office.
- Different people assume this office over the years, it can be male or female, it can be light skin or Dark skin.
- Once this person win the election and is elected the president, the person assume the office of the President
- Autiomatically this person get all the permission and privilege attached to that office.
- This is the same with IAM Role on AWS
  - It can be assume by anyone, including human, Application or some AWS Service.
 
### IAM ROLE SCENERIO WITHIN AWS EXAMPLE
- Amazon Redshift is a Datawarehouse which allow us to store and access our Data
  - Amazon Redshift is an AWS service that allow us to create a Redshift Cluster resource within the service, this cluster act as a Datawarehouse, we will cover this service in depth in the subsequent topics.
- Amazon s3 is an AWS service that offers object/file based storage for our Data
  - basically you can have your data in a CSV or any file format you want and store it in s3, we will cover this later as well.
- Amazon Redshift cluster have 2 operations he can do as part of his other operations
  - `COPY` - Redshift can copy objects from s3 and save that as a table in Redshift Cluster, this will allow Data analyts for example to run SQL queries against that table for analytics.
  - `UNLOAD` - Redshift can unload a Redshift table into s3
- Before any of this operations mentioned above can be possible,
  - Amazon Redshift Cluster needs permission to be able to `COPY` the object, this action is a `getObject` action.
  - Also, Amazon Redshift Cluster needs permission that will allow it be able to `UNLOAD` the data from the redshift table into s3, this action is a `putObject` action. At the end, the Redshift table will be converted into a file before it can be put into s3.
- Below is the illustration
  
<img width="1094" alt="Screenshot 2024-09-13 at 10 47 31" src="https://github.com/user-attachments/assets/4ee939b7-f150-45f4-a201-0eee15123de6">

**IMAGE SUMMARY**
- First and foremost, Amazon Redshift service and Amazon s3 needs to talk to each other in other to do operations together. 
- By default, Redshift doesn't have access to get object neither is it allowed to put any object in Amazon s3.
- To be able to allow Redshift to achieve both operations, we need to do the following
  - Create an IAM Role
    - We will specify Amazon Redshift in the role that we trust that service to assume the role
    - Below you can see we said the `Principal` we want to `Allow` to be able to `AssumeRole` is the `redshift.amazonaws.com`.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "redshift.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```

  - We create an IAM Policy, this policy will contain a statement saying
    - Allow `getObject` and `putObject` action on the specific s3 bucket
      - `getObject` means retrieve a file from an s3 bucket
      - `putObject` means put a file into an s3 bucket
  - Next is to attach the IAM Policy created to the IAM Role
  - This IAM Role can now be used or assumed by Amazon Redshift whenever it needs to do a COPY operation or UNLOAD operation.
    - Example of a COPY operation on a CSV file [HERE](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY_command_examples.html#load-from-csv)
    - Example of an UNLOAD operation on a Redshift table [HERE](https://docs.aws.amazon.com/redshift/latest/dg/r_UNLOAD_command_examples.html)
