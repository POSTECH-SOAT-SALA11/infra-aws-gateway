resource "aws_api_gateway_method" "cliente_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.cliente_route.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "cliente_cpf_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.cliente_cpf_route.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.cpf" = true
  }
}

resource "aws_api_gateway_method" "cliente_excluir_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.cliente_excluir_route.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = var.auth_cli_id

  request_parameters = {
    "method.request.path.cpf" = true
  }
}
