terraform {
  backend "s3" {
    bucket = var.s3_backend_bucket_name
    key    = "api-gateway/terraform.tfstate"
    region = var.region
  }
}
