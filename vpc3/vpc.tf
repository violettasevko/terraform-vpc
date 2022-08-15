variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.73)"
  type    = string
  default = "10.73"
}

#sample
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Vpc3"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   public_subnets  = ["${var.vpc_prefix}.11.0/24", "${var.vpc_prefix}.12.0/24", "${var.vpc_prefix}.13.0/24"]
   intra_subnets = ["${var.vpc_prefix}.31.0/24", "${var.vpc_prefix}.32.0/24", "${var.vpc_prefix}.33.0/24"]
  
  enable_nat_gateway = false

  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [17, 18, 19]
  intra_subnet_ipv6_prefixes = [49, 50, 51]

public_subnet_tags = {
  Name = "Vpc3 public subnet A"
  Name = "Vpc3 public subnet B"
  Name = "Vpc3 public subnet C"
}

intra_subnet_tags = {
  Name = "Vpc3 intra subnet A"
  Name = "Vpc3 intra subnet B"
  Name = "Vpc3 intra subnet C"
}

  tags = {
    owner = "violetta"
  }
}

