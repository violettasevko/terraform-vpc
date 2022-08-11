variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.74)"
  type    = string
  default = "10.74"
}

#sample
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Vpc4"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   public_subnets  = ["${var.vpc_prefix}.11.0/24", "${var.vpc_prefix}.12.0/24", "${var.vpc_prefix}.13.0/24"]
   private_subnets = ["${var.vpc_prefix}.21.0/24", "${var.vpc_prefix}.22.0/24", "${var.vpc_prefix}.23.0/24"]
   intra_subnets = ["${var.vpc_prefix}.31.0/24", "${var.vpc_prefix}.32.0/24", "${var.vpc_prefix}.33.0/24"]
  
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  
  default_route_table_name = "igw4"

  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [17, 18, 19]
  private_subnet_ipv6_prefixes = [33, 34, 35]
  intra_subnet_ipv6_prefixes = [51, 52, 53]

public_subnet_tags = {
  Name = "Vpc4 public subnet A"
  Name = "Vpc4 public subnet B"
  Name = "Vpc4 public subnet C"
}

private_subnet_tags = {
  Name = "Vpc4 private subnet A"
  Name = "Vpc4 private subnet B"
  Name = "Vpc4 private subnet C"
}

intra_subnet_tags = {
  Name = "Vpc4 intra subnet A"
  Name = "Vpc4 intra subnet B"
  Name = "Vpc4 intra subnet C"
}

  tags = {
    owner = "violetta"
  }
}