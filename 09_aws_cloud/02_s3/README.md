# AMAZON SIMPLE STORAGE SERVICE ( S3 )
This guide gives what beginners need to know about Amazon s3, there is a lot about Amazon s3 but this guide is enought to understand what Amazon s3 is all about and its important features.

### TOPICS TO COVER
- [What is Amazon s3](https://github.com/coredataengineers/CDE-BOOTCAMP/blob/main/09_aws_cloud/02_s3/README.md#what-is-amazon-s3)
- Amazon s3 features
  - Storage Classes
  - Storage management
  - Access management and security
  - Analytics and insights
  - s3 Versioning
  - Regions Support
  - s3 access medium
- AWS Documenation Reference

### WHAT IS AMAZON S3
- Amazon Simple Storage Service (Amazon S3) is an object storage service that offers scalability, data availability, security, and performance.
- Lets explain what `Object` mean from above, Object are files in the context of s3.
  - For example, you have a data in a csv file, that is called Object in Amazon s3 world.
  - Your JPEG, PNG are all called Object in Amazon s3
- In Amazon s3, we create something called `s3 Bucket`, this bucket is like a container for your objects or files.
  - Basically you create `Bucket`, you store your Objects or files inside the bucket.
- Customers of all sizes and industries can use Amazon S3 to store and protect any amount of data for a range of use cases.
  - Basically any organisation can collect data about their business and store that iN Amaozn s3
  - This data can be of any size, thats exactly part of what s3 is built for.
- Amazon S3 provides management features so that you can optimize, organize, and configure access to your data to meet your specific business, organizational, and compliance requirements.
  - Your company data that is stored in Amazon s3 need to be secure, they need to be organise also, these are sopme of the many feature s3 offer you.


### S3 FEATURES
Let's discuss some of the top feature of Amazon s3
- Storage classes
  - Amazon s3 offer something called storage class which is designed for different use case that meet your needs. There are different types of storage class available in s3 and they all vary in cost.
  - For example, there are some objects in s3 you will often need time to time, in that case, those will be stored in a storage class that allow you to quickly retrieve this objects.
  - For data that are very less frequently used, maybe they are only needed once in 1 year, it make sense to go into a storage class that allow you to pay less.
  - Please find all the storage class [HERE](https://aws.amazon.com/s3/storage-classes/) and their corresponding detals
- Storage management
  - Storage management help us to manage the lifecycle of our object which can be very useful in cost savings.
    - For example, you can configure something called `lifecycle rule` that automatically transition a data from a specific storage class to a cost effective storage class after a specific period of time.
    - You can as well automatically delete the object when it meet a specift period you set, for example, you can have a less critical data deleted after 30 days or after 1 year.
    - More on lifecycle rule [HERE](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html#:~:text=for%20compliance%20requirements.-,S3%20Lifecycle,-%E2%80%93%20Configure%20a%20lifecycle)
- Access management and security
  - Security is CRITICAL on AWS, in fact we said previously that no one has permission to anything until you give them the access to.
  - You can configure a restriction on your s3 bucket and also the object inside it to only be access by a specific IAM user or a specific service.
- Analytics and insights
  - Amazon S3 offers analytics and insights to help you gain visibility into your storage usage, which empowers you to better understand, analyze, and optimize your storage.
- s3 Versioning
  - Amazon s3 provides a powerful feature called `Versioning`
  - Versioning helps during acidental deletion of an object in an s3 bucket
  - But you have to enable Versioning on the s3 Bucket
  - Once Versioning is enabled, every Object that lands in the bucket automatically get versioned, its basically keeping a copy of every object in the bucket. If the object is accidentally deletd, it can be recovered since its versioned somewhere.
    - Read more on s3 Versioning [HERE](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Versioning.html)
- Regions Support
  - You can choose the geographical AWS Region where Amazon S3 stores the buckets that you create.
  - You might choose a Region to optimize latency, minimize costs, or address regulatory requirements.
    - For example, if your customers are in `Nigeria` in Africa, for regulatory purpose and to easily reach your data in terms of latency, it make sense to create your s3 bucket in the `Cape Town` Region in South Africa.
  - Objects stored in an AWS Region never leave the Region unless you explicitly transfer or replicate them to another Region. For example, objects stored in the Europe (Ireland) Region never leave it.
- To access s3 bucket on AWS, You can use any of the below medium
  - AWS Console (AWS Website)
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/s3/)
  - AWS SDK (Python)
    - [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html)
   
### AWS DOCUMENTATION REFERENCE
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html
- Note, there is a lot in the Documenation, this notes above summarise what you need to be aware and thats enought to work with Amazon s3.
