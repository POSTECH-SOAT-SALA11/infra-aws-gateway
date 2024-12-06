resource "aws_api_gateway_integration" "cliente_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.cliente_route.id
  http_method             = aws_api_gateway_method.cliente_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = var.lambda_arn
}


resource "aws_api_gateway_integration" "cliente_cpf_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.cliente_cpf_route.id
  http_method             = aws_api_gateway_method.cliente_cpf_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente/{cpf}"

  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf"
  }
}

resource "aws_api_gateway_integration" "cliente_excluir_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.cliente_excluir_route.id
  http_method             = aws_api_gateway_method.cliente_excluir_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente/{cpf}/excluir"

  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf"
  }
}

resource "aws_lambda_permission" "apigw_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "lambda_cadastro_usuarios"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.source_arn}/*/*"
}
