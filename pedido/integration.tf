resource "aws_api_gateway_integration" "pedido_create_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pedido_create_route.id
  http_method             = aws_api_gateway_method.pedido_create_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido"
}

resource "aws_api_gateway_integration" "pedido_id_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pedido_id_route.id
  http_method             = aws_api_gateway_method.pedido_id_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido/{idPedido}"

  request_parameters = {
    "integration.request.path.idPedido" = "method.request.path.idPedido" 
  }
}

resource "aws_api_gateway_integration" "pedido_get_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pedido_create_route.id
  http_method             = aws_api_gateway_method.pedido_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido"
}