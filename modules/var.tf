locals {
  name = "cedric"
}

variable "name" {
  default = "cedric"
}

variable "instance-profile" {
  default = {
    admin   = "adminFULLaccess-EC2"
    ansible = "adminFULLaccess-EC2"
  }
}
variable "instance-type" {
  default = {
    micro  = "t2.micro"
    medium = "t2.medium"
    large  = "t2.large"
  }
}

data "aws_ami" "ced_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}