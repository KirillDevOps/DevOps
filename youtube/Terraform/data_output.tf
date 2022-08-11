//provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}

output "aws_pvc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "aws_pvc_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.id
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names[1]
}
output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
output "data_aws_region" {
  value = data.aws_region.current.description
}
output "data_aws_region_name" {
  value = data.aws_region.current.name
}