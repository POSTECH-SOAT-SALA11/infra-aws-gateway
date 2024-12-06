resource "aws_api_gateway_resource" "cliente_route" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "cliente"
}

resource "aws_api_gateway_resource" "cliente_cpf_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.cliente_route.id
  path_part   = "{cpf}"
}

resource "aws_api_gateway_resource" "cliente_excluir_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.cliente_cpf_route.id
  path_part   = "excluir"
}