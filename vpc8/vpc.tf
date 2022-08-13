variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.78)"
  type    = string
  default = "10.78"
}

#sample
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Vpc8"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   private_subnets = ["${var.vpc_prefix}.21.0/24", "${var.vpc_prefix}.22.0/24", "${var.vpc_prefix}.23.0/24"]
   
  enable_nat_gateway = false

  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  private_subnet_ipv6_prefixes = [33, 34, 35]

private_subnet_tags = {
  Name = "Vpc8 private subnet A"
  Name = "Vpc8 private subnet B"
  Name = "Vpc8 private subnet C"
}

  tags = {
    owner = "violetta"
  }
}