resource "aws_api_gateway_method" "pedido_create_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pedido_create_route.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "pedido_id_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pedido_id_route.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = var.auth_func_id

  request_parameters = {
    "method.request.path.idPedido" = true
  }
}

resource "aws_api_gateway_method" "pedido_get_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pedido_create_route.id
  http_method   = "GET"
  authorization = "NONE"
}
