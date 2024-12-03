variable "region" {
  description = "A região AWS onde a infraestrutura será provisionada."
  default     = "sa-east-1"
}

variable "s3_backend_bucket_name" {
  description = "Nome do bucket S3 para armazenar o estado do Terraform"
  type        = string
  default     = "6soat-tfstate"
}

variable "url_base" {
  description = "url base aplicaçao eks"
  type        = string
  default     = "http://k8s-default-ingressa-0faf251d7e-890170821.sa-east-1.elb.amazonaws.com"
}
