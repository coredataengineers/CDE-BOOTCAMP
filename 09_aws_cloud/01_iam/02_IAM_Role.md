# IAM ROLE DEEP DIVE

### WHAT IS IAM ROLE
- An IAM role is an IAM identity that you can create in your account that has specific permissions.
- An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS.
- However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it.
- Also, a role does not have standard long-term credentials such as a password or access keys associated with it.
- Instead, when you assume a role, it provides you with temporary security credentials for your role session
- You can use IAM Role to delegate access to users, applications, or AWS services that don't normally have access to your AWS resources.

### A REAL WORLD MAPPING
Let's map IAM Role to a real world scenario to better understand it ...
- In many countries around the world, we know their is an office of presdident or prime minister.
- This Office will have a permission and some privileges that is attached to this office.
- Different people assume this office over the years, it can be male or female, it can be light skin or Dark skin.
- Once this person win the election and is elected the president, the person assume the office of the President
- Autiomatically this person get all the permission and privilege attached to that office.
- This is the same with IAM Role on AWS
  - It can be assume by anyone, including human, Application or some AWS Service.
 
### 
