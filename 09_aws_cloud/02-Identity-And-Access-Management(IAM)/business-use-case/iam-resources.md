# The Business Use Case: Core-Data-Engineers Ingestion & Access Control

"Welcome team. 
Today at Core-Data-Engineers, we are building out our initial data pipeline architecture.

<img width="1761" height="770" alt="Screenshot 2026-10-25 at 17 15 18" src="https://github.com/user-attachments/assets/d8ff4330-67c5-48a1-bb21-0484225b9de4" />

### Here is what we need to accomplish:
- The Ingestion Pipeline:
  - We have a Python script that reads from our data sources (like Faker) and writes two streams of data to S3: orders data and customer data.
  
- The End-Users & Workflows:
  - Our Data Analyst needs access to query the orders data.
  - Our Debt Collection Agent needs access to go after the customers who haven't paid yet, meaning they need access to the customer data.


### The IAM Challenge
- To make our Python script orchestrated with Airflow talk to AWS, it needs credentials to authenticate into AWS. So we will create an IAM user, and an access key and secret key for our code.

- However, keep this golden rule in mind: Creating access keys and secret keys only handles authentication (proving who the script is). It does not automatically grant permission to touch any bucket. That is why we must create an explicit IAM policy to authorise our Python script.

- Finally, because of data privacy, we need to create two separate, restricted policies, one for our Data Analyst and one for our Debt Collection Agent, so each group can only access the exact data they are cleared to see, and nothing else."
