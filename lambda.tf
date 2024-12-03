resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = "lambda_cadastro_usuarios"
}

resource "aws_api_gateway_integration" "cadastro_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.cadastro.id
  http_method             = aws_api_gateway_method.cadastro_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"  
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_cadastro_usuarios.arn}/invocations"
}