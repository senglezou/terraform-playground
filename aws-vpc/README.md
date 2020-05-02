# Deploy an AWS VPC with terraform

Files in this directory are going to deploy a VPC In Cloudformation

## VPC Architecture

The VPC consists of:
-  Custom VPC 10.0.0.0/16
- 3 Availability zones in the `eu-west-1` region
- 3 Subnets in each AZ
    - 1 Public Subnet (10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24)
    - 1 Private Subnet
    - 1 Internal Subnet
