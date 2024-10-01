variable "region" {
  description = "A região AWS onde a infraestrutura será provisionada."
  default     = "sa-east-1" # Defina a região padrão, mas pode ser alterada no arquivo terraform.tfvars
}

variable "s3_backend_bucket_name" {
  description = "Nome do bucket S3 para armazenar o estado do Terraform"
  type        = string
}
