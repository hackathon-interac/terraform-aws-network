# AWS Terraform Network Module

## Description
### This terraform module creates following AWS resources
- VPC
- Subnets - Public & Private
- Internet Gateway

**Name of the vpc & subnet will be deduced based on project name and environment e.g.**

**VPC = <project-name>-<environment>-<vpc>**

### Variables
The terraform code requires following variables to be passed:
- AWS Region
- Project Name
- CIDR Block
- Enviornment

**Important Note : Environment variable decides how many private subnets will get provisioned. For the simplicity, choosing dev env will provision 1 private subnet and prod will provision 2 private subnet** 
