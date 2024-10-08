
resource "aws_iam_user" "ced_iam" {
  name = "Potter"
}


# resource "aws_vpc" "ced_vpc" {
#   tags = {
#     name = "${local.name}-vpc"
#   }
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "ced_sn" {
#   vpc_id            = aws_vpc.ced_vpc.id
#   cidr_block        = "10.0.20.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     name = "${local.name}-subnet"
#   }
# }

module "ced_sg" {
  source = "../SG"

  name = "${var.name}-CICD-SG"
  
}

# module "vpc_mod" {
#   source = "../SG"

#   name = "${var.name}-vpc"
# }

# module "snmod" {
#   source = "../SG"

#   name = "${var.name}-subnet"
  
# }

resource "aws_instance" "ced-ec2" {
  count = 2
  tags = {
    name = "${local.name}-server"
  }
  instance_type          = var.instance-type["micro"]
  iam_instance_profile   = var.instance-profile["admin"]
  vpc_security_group_ids = [module.ced_sg.out_sg]
  ami                    = data.aws_ami.ced_ami.id
  subnet_id = module.ced_sg.out_sn
}

module "ced_s3" {
  source = "../s3"

  name = "${var.name}-bucket-v20"

  providers = {
    aws = aws.west
  }
}