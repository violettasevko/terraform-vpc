locals {
  AWS_Region = "eu-central-1"
  vpc_prefix = "10.60"
}

provider "aws" {
    region = local.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "shared-vpc"
  cidr = "${local.vpc_prefix}.0.0/16"

  azs             = ["${local.AWS_Region}a", "${local.AWS_Region}b", "${local.AWS_Region}c"]
   public_subnets  = ["${local.vpc_prefix}.11.0/16", "${local.vpc_prefix}.12.0/16", "${local.vpc_prefix}.13.0/16"]
   #private_subnets = ["${local.vpc_prefix}.21.0/16", "${local.vpc_prefix}.22.0/16", "${local.vpc_prefix}.23.0/16"]
  
  enable_nat_gateway = false

  enable_ipv6 = true
  assign_ipv6_addressn_on_creation = true

  public_subnet_ipv6_prefixes = [11, 12, 13]

  tags = {
    owner = "violetta"
  }
}