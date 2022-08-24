variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "vpc_prefix" {
  description = "type a cidr (default - 10.61)"
  type    = string
  default = "10.61"
}

#sample
#terraform apply -var="AWS_Region=eu-central-1" -var="vpc_prefix=10.61"

provider "aws" {
    region = var.AWS_Region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Vpc5"
  cidr = "${var.vpc_prefix}.0.0/16"

  azs             = ["${var.AWS_Region}a", "${var.AWS_Region}b", "${var.AWS_Region}c"]
   public_subnets  = ["${var.vpc_prefix}.11.0/24", "${var.vpc_prefix}.12.0/24", "${var.vpc_prefix}.13.0/24"]
   private_subnets = ["${var.vpc_prefix}.21.0/24", "${var.vpc_prefix}.22.0/24", "${var.vpc_prefix}.23.0/24"]
   intra_subnets = ["${var.vpc_prefix}.31.0/24", "${var.vpc_prefix}.32.0/24", "${var.vpc_prefix}.33.0/24"]
  
  enable_nat_gateway = false

  private_route_table_tags = {
    Name = "Vpc5-private"
  }

  public_route_table_tags = {
    Name = "Vpc5-Public"
  }
  
  enable_ipv6 = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [17, 18, 19]
  private_subnet_ipv6_prefixes = [33, 34, 35]
  intra_subnet_ipv6_prefixes = [49, 50, 51]

public_subnet_tags = {
  Name = "Vpc5 Public subnet"
}

private_subnet_tags = {
  Name = "Vpc5 private subnet"
}

intra_subnet_tags = {
  Name = "Vpc5 intra subnet"
}
}
