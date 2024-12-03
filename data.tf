data "aws_lambda_function" "lambda_authorizer_clientes" {
  function_name = "lambda_authorizer_clientes"
}

data "aws_lambda_function" "lambda_authorizer_funcionarios" {
  function_name = "lambda_authorizer_funcionarios"
}

data "aws_lambda_function" "lambda_cadastro_usuarios" {
  function_name = "lambda_cadastro_usuarios"
}