terraform {
  backend "s3" {
    bucket = "cjwcsl"
    key    = "tessian-platform-interview-challenge"
    region = "eu-west-1"
    dynamodb_table  = "tessian-platform-interview-challenge"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.64"
    }
  }
}

provider "aws" {
  profile = "default"
  region     = var.aws_region
  default_tags {
    tags = {
      Environment = "test"
      Owner       = "cwalsh"
      Project     = "tessian-platform-interview-challenge"
    }
  }
}
