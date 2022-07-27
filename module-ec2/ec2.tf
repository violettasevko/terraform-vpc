provider "aws" {
    region = var.AWS_Region
}

variable "AWS_Region" {
  description = "type a region (default - eu-central-1)"
  type    = string
  default = "eu-central-1"
}

variable "instance_type" {
  description = "instance type for ec2"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "mykey"
}

resource "aws_instance" "testinstance" {
  ami           = "ami-0b9064170e32bde34"
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [ "Webstd"]
  tags= {
    Name = "testinstance"
  }
}
