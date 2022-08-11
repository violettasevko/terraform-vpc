variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.72)"
  type    = string
  default = "10.72"
}

#sample
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Vpc2"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   public_subnets  = ["${var.vpc_prefix}.11.0/24", "${var.vpc_prefix}.12.0/24", "${var.vpc_prefix}.13.0/24"]
   private_subnets = ["${var.vpc_prefix}.21.0/24", "${var.vpc_prefix}.22.0/24", "${var.vpc_prefix}.23.0/24"]
  
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  
  default_route_table_name = "igw"

  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [17, 18, 19]
  private_subnet_ipv6_prefixes = [33, 34, 35]

public_subnet_tags = {
  Name = "Vpc1 public subnet A"
  Name = "Vpc1 public subnet B"
  Name = "Vpc1 public subnet C"
}

private_subnet_tags = {
  Name = "Vpc1 private subnet A"
  Name = "Vpc1 private subnet B"
  Name = "Vpc1 private subnet C"
}

  tags = {
    owner = "violetta"
  }
}

