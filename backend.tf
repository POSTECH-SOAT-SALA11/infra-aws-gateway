terraform {
  backend "s3" {
    bucket = "6soat-tfstate"
    key    = "api-gateway/terraform.tfstate"
    region = "sa-east-1"
  }
}