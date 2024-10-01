resource "aws_api_gateway_authorizer" "lambda_authorizer_clientes" {
  rest_api_id     = aws_api_gateway_rest_api.api_gateway.id
  name            = "lambda_authorizer_clientes"
  type            = "REQUEST" # REQUEST authorizer, se for necessário validar tokens JWT, por exemplo
  authorizer_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${data.aws_lambda_function.lambda_authorizer_clientes.arn}/invocations"
  identity_source = "method.request.header.Authorization" # Ponto de extração do token, por exemplo no header Authorization

  depends_on = [
    aws_lambda_permission.api_gateway_invoke_clientes
  ]
}

resource "aws_lambda_permission" "api_gateway_invoke_clientes" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda_authorizer_clientes.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_authorizer" "lambda_authorizer_funcionarios" {
  rest_api_id     = aws_api_gateway_rest_api.api_gateway.id
  name            = "lambda_authorizer_funcionarios"
  type            = "REQUEST"
  authorizer_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${data.aws_lambda_function.lambda_authorizer_funcionarios.arn}/invocations"
  identity_source = "method.request.header.Authorization"
  depends_on = [
    aws_lambda_permission.api_gateway_invoke_funcionarios
  ]
}

resource "aws_lambda_permission" "api_gateway_invoke_funcionarios" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.lambda_authorizer_funcionarios.function_name
  principal     = "apigateway.amazonaws.com"
}