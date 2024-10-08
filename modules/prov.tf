provider "aws" {
  region = "us-east-1"

}

provider "aws" {
  region = "us-west-2"
  alias  = "west"
}

terraform {
  backend "s3" {
    bucket = "demo-cedric-tf"
    region = "us-east-1"
    key    = "ced"
  }
}

