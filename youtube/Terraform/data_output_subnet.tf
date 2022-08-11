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

resource "aws_subnet" "prod_subnet_1"{
  vpc_id = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block = "10.10.10.0/24"
  tags = {
    Name = "Subnet 1 in ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region = data.aws_region.current.description
  }
}

resource "aws_subnet" "prod_subnet_2"{
  vpc_id = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.working.names[1]
  cidr_block = "10.10.20.0/24"
  tags = {
    Name = "Subnet 1 in ${data.aws_availability_zones.working.names[1]}"
    Account = "Subnet in Account ${data.aws_caller_identity.current.account_id}"
    Region = data.aws_region.current.description
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