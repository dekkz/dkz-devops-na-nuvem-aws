terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::887602716352:role/DKZDevOpsNaNuvemRole-8388eb07-529e-411b-92a0-40fb8c5ac8f4"
  }
}
