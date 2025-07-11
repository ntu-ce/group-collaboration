terraform {
  required_version = ">= 1.9"

  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "jsrn/terraform.tfstate"  # add your key
    region = "ap-southeast-1" # add your region
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1" # add your region
}
