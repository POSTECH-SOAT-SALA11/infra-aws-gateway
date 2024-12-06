resource "aws_api_gateway_method" "produto_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.produto_route.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = var.auth_func_id
}

resource "aws_api_gateway_method" "produto_id_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.produto_id_route.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = var.auth_func_id

  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_method" "produto_categoria_id_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.produto_categoria_id_route.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.categoriaProduto" = true
  }
}
