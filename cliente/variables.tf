variable "region" {
  description = "A região AWS onde a infraestrutura será provisionada."
  default     = "sa-east-1"
}

variable "url_base" {
  description = "url base aplicaçao eks"
  type        = string
  default     = "http://k8s-default-ingressa-0faf251d7e-1124737897.sa-east-1.elb.amazonaws.com/avalanches/v1"
}

variable "rest_api_id" {
  description = "ID da API Gateway"
  type        = string
}

variable "parent_id" {
  description = "ID do recurso pai para a API"
  type        = string
}

variable "exec_arn" {
  description = "ID do recurso pai para a API"
  type        = string
}

variable "source_arn" {
  description = "ID do recurso pai para a API"
  type        = string
}

variable "lambda_arn" {
  description = "ARN da Lambda existente para integração com o API Gateway"
  type        = string
  default     = "arn:aws:apigateway:sa-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:307946636040:function:lambda_cadastro_usuarios/invocations"
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

variable "auth_cli_id" {
  description = "ID do recurso pai para a API"
  type        = string
}

variable "auth_func_id" {
  description = "ID do recurso pai para a API"
  type        = string
}