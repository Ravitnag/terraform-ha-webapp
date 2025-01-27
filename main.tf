
provider "aws" {
  region = "us-east-2"
}

module "aws_vpc" {
    source = "./modules/aws_vpc"
    cidr_block_value = "10.0.0.0/16"

}

output "vpc_id" {
  value = module.aws_vpc.vpc_id
}

resource "aws_subnet" "public" {
  count                   = 1
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = cidrsubnet(module.vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
}

# output "vpc_public_subnets" {
#     value = module.aws_vpc.vpc_public_subnets
# }

