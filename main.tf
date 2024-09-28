terraform {

  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-6soat"
    key    = "terraform.tfstate"
    region = "sa-east-1"

  }
}

provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      owner      = "hennangadelha"
      managed-by = "terraform"
    }
  }
}
provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}
