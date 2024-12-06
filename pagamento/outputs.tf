output "pagamento_webhook_integration" {
  value = aws_api_gateway_integration.pagamento_webhook_integration
}

output "pagamento_integration" {
  value = aws_api_gateway_integration.pagamento_integration
}

output "pagamento_status_id_integration" {
  value = aws_api_gateway_integration.pagamento_status_id_integration
}


output "pagamento_efetuar_pagamento_id_integration" {
  value = aws_api_gateway_integration.pagamento_efetuar_pagamento_id_integration
}