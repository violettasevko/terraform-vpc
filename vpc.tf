provider "aws" {
    region = var.AWS_Region
}

resource "aws_vpc" "vpc22" {
  cidr_block       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = "true"
  instance_tenancy = "default"

  tags = {
    Name = "vpc22"
    owner = "violetta"
  }
}

resource "aws_subnet" "pub_subnet" {
    vpc_id = "${aws_vpc.vpc22.id}"

    availability_zone = var.az
    cidr_block        = cidrsubnet(aws_vpc.vpc22.cidr_block, 0, 1)
    ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc22.ipv6_cidr_block, 0, 2)
 
    map_public_ip_on_launch = "true" //it makes this a public subnet
    assign_ipv6_address_on_creation = true

    tags = {
        Name = "pub-subnet"
        owner = "violetta"
    }
}

resource "aws_subnet" "priv_subnet" {
    vpc_id = "${aws_vpc.vpc22.id}"

    availability_zone = var.az
    cidr_block        = cidrsubnet(aws_vpc.vpc22.cidr_block, 0, 3)
    ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc22.ipv6_cidr_block, 0, 4)

    map_public_ip_on_launch = "true" //it makes this a private subnet
    assign_ipv6_address_on_creation = false
    
    tags = {
        Name = "priv_subnet"
        owner = "violetta"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc22.id}"
    tags = {
        Name = "igw"
        owner = "violetta"
    }
}

resource "aws_egress_only_internet_gateway" "egress" {
  vpc_id = "${aws_vpc.vpc22.id}"
}

resource "aws_route_table" "public_route" {
    vpc_id = "${aws_vpc.vpc22.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.igw.id}" 
    }
    
    route {
        ipv6_cidr_block = "::/0"
        egress_only_gateway_id = "${aws_egress_only_internet_gateway.egress.id}"
    }

    tags = {
        Name = "public_route"
        owner = "violetta"
    }
}

resource "aws_route_table_association" "rta_pub_subnet"{
    subnet_id = aws_subnet.pub_subnet.id
    route_table_id = "${aws_route_table.public_route.id}"
}

resource "aws_security_group" "secgroup_web" {
    vpc_id = "${aws_vpc.vpc22.id}"
    name = "secgroup_forweb"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "access all ipv4"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        ipv6_cidr_blocks = ["::/0"]
        description = "access all ipv6"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH port for all ipv4"
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        ipv6_cidr_blocks = ["::/0"]
        description = "SSH port for all ipv6"
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP port for all ipv4"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        ipv6_cidr_blocks = ["::/0"]
        description = "HTTP port for all ipv6"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTPS port"
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        ipv6_cidr_blocks = ["::/0"]
        description = "HTTPS port"
    }
    tags = {
        Name = "secgroup_web"
        owner = "violetta"
    }
}
