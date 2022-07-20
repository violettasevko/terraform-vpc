variable "AWS_Region" {
    default = "eu-central-1"
}

variable "vpc_cidr_block" {
    default = "10.60.0.0/16"
}

variable "instance_type" {
    default = "t4g.micro"
}

variable "az" {
    default = "eu-central-1a"
}

variable "web_key_name" {
    default = "lunakey"
}
