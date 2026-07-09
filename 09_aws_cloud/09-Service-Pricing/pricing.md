# AWS Services – Pricing Overview

A quick-reference guide to how each service in the architecture is billed, with links to the official AWS pricing pages for full rate tables (rates vary by region and change periodically — always confirm current rates before finalizing a cost estimate).

---

## 1. AWS Identity and Access Management (IAM)

**How it's billed:** IAM itself — users, roles, groups, and policies — is provided at no additional charge. You only start paying if you turn on optional add-on features such as IAM Access Analyzer's internal/unused access analysis (billed per monitored resource or per IAM principal per month) or custom policy check API calls.

**Typical cost for a standard setup:** $0, since core IAM usage (roles, policies, MFA) carries no charge.

**Official pricing docs:**
- IAM Access Analyzer pricing: https://aws.amazon.com/iam/access-analyzer/pricing/
- IAM FAQs (confirms core IAM is free): https://aws.amazon.com/iam/faqs/

---

## 2. Amazon Virtual Private Cloud (VPC)

**How it's billed:** Creating a VPC, subnets, route tables, security groups, and an internet gateway is free. Charges come from the components you attach:
- **NAT Gateway:** hourly charge + per-GB data processing fee (usually the largest VPC-related cost)
- **Public IPv4 addresses:** ~$0.005/hour per address, whether in use or idle
- **VPC Interface Endpoints (PrivateLink):** hourly charge per AZ + per-GB data processing
- **VPC Gateway Endpoints (S3, DynamoDB):** free
- **Data transfer:** free within the same AZ; charged for cross-AZ, cross-region, and internet egress traffic

**Official pricing docs:**
- VPC pricing: https://aws.amazon.com/vpc/pricing/
- VPC FAQs: https://aws.amazon.com/vpc/faqs/

---

## 3. Amazon Elastic Compute Cloud (EC2)

**How it's billed:** Per-second (Linux) or per-hour (other OS) compute charges based on instance type, region, and OS, plus separate charges for EBS storage and data transfer. Four main purchasing models:
- **On-Demand:** pay per second/hour, no commitment — most expensive per unit but maximum flexibility
- **Savings Plans:** commit to $/hour spend for 1 or 3 years for up to ~72% savings
- **Reserved Instances:** 1- or 3-year term commitment for a discount
- **Spot Instances:** up to 90% off, using spare capacity that can be reclaimed with short notice

**Official pricing docs:**
- EC2 pricing overview: https://aws.amazon.com/ec2/pricing/
- EC2 On-Demand pricing (rate tables): https://aws.amazon.com/ec2/pricing/on-demand/

---

## 4. Amazon Simple Storage Service (S3)

**How it's billed:** Across several independent dimensions:
- **Storage:** priced per GB/month and varies by storage class (S3 Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, Glacier tiers, etc.) — S3 Standard is around $0.023/GB for the first 50 TB/month, tapering at higher volumes
- **Requests:** PUT/COPY/POST/LIST vs. GET/SELECT are priced differently, per 1,000 requests
- **Data transfer:** ingress is free; egress to the internet is charged per GB (first tier free, then tiered rates)
- **Optional features:** Intelligent-Tiering monitoring fee, S3 Inventory, Storage Lens, etc.

**Official pricing docs:**
- S3 pricing: https://aws.amazon.com/s3/pricing/
- S3 storage classes: https://aws.amazon.com/s3/storage-classes/

---

## 5. AWS Glue & Amazon Athena

### AWS Glue
**How it's billed:**
- **ETL jobs, crawlers, interactive sessions:** billed per DPU-hour (1 DPU = 4 vCPU + 16 GB memory), $0.44/DPU-hour standard rate, billed per second with a short minimum duration; Flex execution offers a lower rate (~$0.29/DPU-hour) for non-urgent jobs
- **Glue Data Catalog:** first 1 million objects stored and first 1 million metadata requests per month are free; $1 per additional 100,000 objects and $1 per additional 1 million requests beyond that

### Amazon Athena
**How it's billed:** Pay-per-query — $5 per TB of data scanned from S3, rounded up to the nearest MB with a 10 MB minimum per query. DDL statements (CREATE/ALTER/DROP TABLE) and failed queries incur no charge. Converting data to a compressed columnar format (e.g., Parquet) and partitioning tables can cut scan costs by 80–95%. An alternative **Provisioned Capacity** model bills a flat DPU-hour rate for predictable, high-volume workloads.

**Official pricing docs:**
- AWS Glue pricing: https://aws.amazon.com/glue/pricing/
- Amazon Athena pricing: https://aws.amazon.com/athena/pricing/

---

## 6. Amazon Relational Database Service (RDS)

**How it's billed:** Multiple independent meters that combine into the total bill:
- **DB instance hours:** priced per hour by instance class and engine (MySQL/PostgreSQL/MariaDB are typically cheapest; Aurora and commercial engines like SQL Server/Oracle cost more)
- **Storage:** per GiB/month, depends on storage type (gp3, io1/io2, magnetic)
- **Backup storage:** free up to the size of provisioned storage; additional snapshot storage is billed separately
- **Data transfer:** charged for traffic to the internet and across regions
- **Multi-AZ deployments:** roughly double compute and storage cost due to the standby replica
- **Purchase options:** On-Demand (pay by the hour, no commitment) or Reserved Instances (1- or 3-year term for up to ~50-70% savings on compute only)

**Official pricing docs:**
- RDS pricing: https://aws.amazon.com/rds/pricing/
- RDS DB instance billing details: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/User_DBInstanceBilling.html

---

## 7. Amazon Redshift

**How it's billed:** Two deployment models:
- **Provisioned clusters:** hourly rate per compute node (RA3 or DC2 node types), starting around $0.54+/hour depending on node type/size. RA3 nodes decouple compute from storage — you separately pay for **Redshift Managed Storage (RMS)** at roughly $0.024/GB-month
- **Redshift Serverless:** billed per Redshift Processing Unit (RPU)-hour on a per-second basis (60-second minimum), starting around $0.375/RPU-hour (~$1.50/hour at the 4-RPU base capacity); managed storage is billed the same way as provisioned RA3
- **Redshift Spectrum** (querying data directly in S3): $5 per TB scanned, same pattern as Athena — included in RPU billing under Serverless
- **Reserved node pricing** is available for provisioned clusters for predictable, steady-state workloads

**Official pricing docs:**
- Amazon Redshift pricing: https://aws.amazon.com/redshift/pricing/

---

## Notes

- All rates above are illustrative reference points (largely US East / N. Virginia unless noted) — always validate against the official AWS Pricing Calculator (https://calculator.aws) for your target region (e.g., eu-central-1) before finalizing a client-facing cost estimate.
- For a full architecture cost model, remember to add cross-cutting costs that don't belong to a single service line: data transfer between services/regions, CloudWatch monitoring/logging, and KMS encryption if used.
