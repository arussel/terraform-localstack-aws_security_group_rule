# Running the code
1. start `localstack` using `docker-compose up`
2. In a different console, run terraform:
   1. `terraform init`
   2. `terraform apply`

# Issue with local stack:
If all the lines of provider "aws" are commented out, and with proper aws credentials set, then the code run and create
the expected subnet in AWS. But against localstack, it output an error:

```
aws_vpc.redshift_vpc: Creating...
aws_vpc.redshift_vpc: Creation complete after 1s [id=vpc-4468e533]
aws_subnet.redshif_subnet: Creating...
aws_subnet.redshif_subnet: Creation complete after 1s [id=subnet-e7cb48ee]
aws_redshift_subnet_group.redshift_subnet_group: Creating...

Error: Unable to find Redshift Subnet Group: []*redshift.ClusterSubnetGroup(nil)
```

Removing the `aws_redshift_subnet_group` fixes the problem. Adding a `aws_redshift_cluster` that references the subnet 
group does not fix the issue.
