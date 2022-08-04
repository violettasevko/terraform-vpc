#locals {
#  AWS_Region = "eu-central-1"
#  vpc_prefix = "10.60"
#}

variable "AWS_Region" {
  description = "type a region (default - us-east-1)"
  type    = string
  default = "us-east-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.60)"
  type    = string
  default = "10.60"
}
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"
#terraform apply -var="AWS_Region=us-east-2" -var="vpc_prefix=10.62"
#terraform apply -var="AWS_Region=eu-west-3" -var="vpc_prefix=10.63"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "shared-vpc"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   public_subnets  = ["${var.vpc_prefix}.11.0/24", "${var.vpc_prefix}.12.0/24", "${var.vpc_prefix}.13.0/24"]
   private_subnets = ["${var.vpc_prefix}.21.0/24", "${var.vpc_prefix}.22.0/24", "${var.vpc_prefix}.23.0/24"]
  
  enable_nat_gateway = false
  #single_nat_gateway = true

  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [11, 12, 13]

  tags = {
    owner = "violetta"
  }
}
