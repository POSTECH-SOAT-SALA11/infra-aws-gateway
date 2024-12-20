variable "region" {
  description = "A região AWS onde a infraestrutura será provisionada."
  default     = "sa-east-1"
}

variable "s3_backend_bucket_name" {
  description = "Nome do bucket S3 para armazenar o estado do Terraform"
  type        = string
  default     = "6soat-tfstate"
}

variable "s3_backend_key" {
  description = "Nome do key do bucket S3 para armazenar o estado do Terraform"
  type        = string
  default     = "api-gateway/terraform.tfstate"
}

variable "url_base" {
  description = "url base aplicaçao eks"
  type        = string
  default     = "http://k8s-default-ingressa-0faf251d7e-1124737897.sa-east-1.elb.amazonaws.com/avalanches/v1"
}

variable "lambda_auth_clientes_arn" {
  description = "ARN da Lambda de autorização para clientes"
  type        = string
  default     = "arn:aws:lambda:sa-east-1:307946636040:function:lambda_authorizer_clientes"
}

variable "lambda_auth_funcionarios_arn" {
  description = "ARN da Lambda de autorização para funcionários"
  type        = string
  default     = "arn:aws:lambda:sa-east-1:307946636040:function:lambda_authorizer_funcionarios"
}