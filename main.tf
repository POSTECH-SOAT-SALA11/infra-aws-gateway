provider "aws" {
  region = "sa-east-1"
}

module "pagamento" {
  source       = "./pagamento"
  rest_api_id  = aws_api_gateway_rest_api.api.id # Passa o rest_api_id
  parent_id    = aws_api_gateway_resource.v1.id  # Passa o parent_id (ou outro, conforme necessário)
  exec_arn     = aws_api_gateway_rest_api.api.execution_arn
  auth_cli_id  = aws_api_gateway_authorizer.auth_clientes.id
  auth_func_id = aws_api_gateway_authorizer.auth_funcionarios.id
}

module "pedido" {
  source       = "./pedido"
  rest_api_id  = aws_api_gateway_rest_api.api.id # Passa o rest_api_id
  parent_id    = aws_api_gateway_resource.v1.id  # Passa o parent_id (ou outro, conforme necessário)
  exec_arn     = aws_api_gateway_rest_api.api.execution_arn
  auth_cli_id  = aws_api_gateway_authorizer.auth_clientes.id
  auth_func_id = aws_api_gateway_authorizer.auth_funcionarios.id
}

module "producao" {
  source       = "./producao"
  rest_api_id  = aws_api_gateway_rest_api.api.id # Passa o rest_api_id
  parent_id    = aws_api_gateway_resource.v1.id  # Passa o parent_id (ou outro, conforme necessário)
  exec_arn     = aws_api_gateway_rest_api.api.execution_arn
  auth_cli_id  = aws_api_gateway_authorizer.auth_clientes.id
  auth_func_id = aws_api_gateway_authorizer.auth_funcionarios.id
}

module "cliente" {
  source       = "./cliente"
  rest_api_id  = aws_api_gateway_rest_api.api.id # Passa o rest_api_id
  parent_id    = aws_api_gateway_resource.v1.id  # Passa o parent_id (ou outro, conforme necessário)
  source_arn   = aws_api_gateway_rest_api.api.execution_arn
  exec_arn     = aws_api_gateway_rest_api.api.execution_arn
  auth_cli_id  = aws_api_gateway_authorizer.auth_clientes.id
  auth_func_id = aws_api_gateway_authorizer.auth_funcionarios.id
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "AvalanchesAPI"
  description = "API Gateway para gerenciar a lanchonete avalanches"
}

resource "aws_api_gateway_resource" "avalanches_v1" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "avalanches"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.avalanches_v1.id
  path_part   = "v1"
}

# Deployment
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    module.pagamento.pagamento_webhook_integration,
    module.pagamento.pagamento_integration,
    module.pagamento.pagamento_status_id_integration,
    module.pagamento.pagamento_efetuar_pagamento_id_integration,
    module.pedido.pedido_create_integration,
    module.pedido.pedido_id_integration,
    module.pedido.pedido_get_integration,
    module.producao.produto_integration,
    module.producao.produto_id_integration,
    module.producao.produto_categoria_id_integration,
    module.cliente.cliente_integration,
    module.cliente.cliente_cpf_integration,
    module.cliente.cliente_excluir_integration,
    module.cliente.apigw_permission,
    aws_api_gateway_authorizer.auth_clientes,
    aws_api_gateway_authorizer.auth_funcionarios,
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
