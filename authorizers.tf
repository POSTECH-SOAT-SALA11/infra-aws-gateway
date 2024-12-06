resource "aws_api_gateway_authorizer" "auth_clientes" {
  rest_api_id     = aws_api_gateway_rest_api.api.id
  name            = "Clientes-ava-Authorizer"
  type            = "REQUEST"
  authorizer_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_auth_clientes_arn}/invocations"
  identity_source = "method.request.header.cpf"
}

resource "aws_api_gateway_authorizer" "auth_funcionarios" {
  rest_api_id     = aws_api_gateway_rest_api.api.id
  name            = "Funcionarios-ava-Authorizer"
  type            = "REQUEST"
  authorizer_uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_auth_funcionarios_arn}/invocations"
  identity_source = "method.request.header.matricula"
}

resource "aws_lambda_permission" "auth_clientes_permission" {
  statement_id  = "AllowAPIGatewayInvokeClientesAvalanches"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_auth_clientes_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "auth_funcionarios_permission" {
  statement_id  = "AllowAPIGatewayInvokeFuncionariosAvalanches"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_auth_funcionarios_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
