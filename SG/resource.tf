resource "aws_vpc" "ced_vpc" {
  tags = {
    name = var.name
  }
  cidr_block = "10.0.0.0/16"
}

output "out_vpc" {
  value = aws_vpc.ced_vpc.id
}

resource "aws_subnet" "ced_sn" {
  vpc_id            = aws_vpc.ced_vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1a"
  tags = {
    name = var.name
  }
}

output "out_sn" {
  value = aws_subnet.ced_sn.id
}

resource "aws_security_group" "ced_sg" {
  name        = var.name
  description = "for both maven and sonarcube servers"
  vpc_id = aws_vpc.ced_vpc.id


  dynamic "ingress" {
    for_each = [22, 8081, 9000]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

output "out_sg" {
  value = aws_security_group.ced_sg.id
}



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "name" {
  type = string
}
