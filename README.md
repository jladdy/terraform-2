# Terraform
Terraform EC2 with Route53 Example

Tested with Terraform 0.11.9

## Main Files

### prov.tf

This file is what will actually connect to AWS and provision the instance. Once all instances have been provisioned the
Route53 records will be added. This will not create the Route53 zone itself. 

### values.tf

This file includes all the variables used by prov.tf. 

### prod.tfvars

This file contains the connection information for AWS and Chef. 
