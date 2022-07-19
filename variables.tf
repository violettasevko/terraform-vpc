variable "AWS_Region" {
    default = "eu-central-1"
}

variable "instance_type" {
    default = "t4g.micro"
}

variable "vpc_cidr_block" {
    default = "10.60.0.0/16"
}

variable "availability_zones" {
    default = {
        eu-central-1a = 1
        eu-central-1b = 2
        eu-central-1c = 3
    }
}

variable "web_key_name" {
    default = "lunakey"
}
