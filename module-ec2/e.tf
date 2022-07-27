module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "testinstance"

  ami                    = "ami-0ceb85bb30095410b"
  instance_type          = "t4g.micro"
  key_name               = "mykey"
  vpc_security_group_ids = ["Webstd"]
  subnet_id              = "subnet-0b71a64ba91b38019"

  tags = {
    owner   = "violetta"
  }
}