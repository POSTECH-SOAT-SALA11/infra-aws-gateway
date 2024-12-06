resource "aws_api_gateway_integration" "produto_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.produto_route.id
  http_method             = aws_api_gateway_method.produto_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto"
}

resource "aws_api_gateway_integration" "produto_id_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.produto_id_route.id
  http_method             = aws_api_gateway_method.produto_id_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto/{id}"

  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}

resource "aws_api_gateway_integration" "produto_categoria_id_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.produto_categoria_id_route.id
  http_method             = aws_api_gateway_method.produto_categoria_id_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto/{categoriaProduto}"

  request_parameters = {
    "integration.request.path.categoriaProduto" = "method.request.path.categoriaProduto"
  }
}
