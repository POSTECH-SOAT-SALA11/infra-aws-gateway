output "cliente_integration" {
  value = aws_api_gateway_integration.cliente_integration
}

output "cliente_cpf_integration" {
  value = aws_api_gateway_integration.cliente_cpf_integration
}

output "cliente_excluir_integration" {
  value = aws_api_gateway_integration.cliente_excluir_integration
}

output "apigw_permission" {
  value = aws_lambda_permission.apigw_permission
}