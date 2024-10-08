resource "aws_s3_bucket" "ced_bucket" {
  bucket        = var.name
  force_destroy = true
}
output "out_s3" {
  value = aws_s3_bucket.ced_bucket.id
}



terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "name" {
  type = string
}