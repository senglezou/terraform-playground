# Deploy an AWS VPC with terraform

Files in this directory are going to deploy a VPC In Cloudformation

## VPC Architecture

The VPC consists of:
-  Custom VPC 10.0.0.0/16
- 3 Availability zones in the `eu-west-1` region
- 3 Subnets (public, private, internal (for databases)) in each AZ:
    - publicA, mainVPC, eu-west-1a, 10.0.0.0/24
    - publicB, mainVPC, eu-west-1b, 10.0.1.0/24
    - publicC, mainVPC, eu-west-1c, 10.0.2.0/24
    - privateA, mainVPC, eu-west-1a, 10.0.4.0/24
    - privateB, mainVPC, eu-west-1b, 10.0.5.0/24
    - privateC, mainVPC, eu-west-1c, 10.0.6.0/24
    - internalA, mainVPC, eu-west-1a, 10.0.8.0/24
    - internalB, mainVPC,  eu-west-1b, 10.0.9.0/24
    - internalC, mainVPC, eu-west-1c, 10.0.10.0/24

## TODO
- Add a diagram at some point.
