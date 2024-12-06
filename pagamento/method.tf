resource "aws_api_gateway_method" "pagamento_webhook_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pagamento_webhook_route.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "pagamento_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pagamento_route.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "pagamento_status_id_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pagamento_status_id_route.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.idPedido" = true
  }
}

resource "aws_api_gateway_method" "pagamento_efetuar_pagamento_id_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.pagamento_efetuar_pagamento_id_route.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.idPedido" = true
  }
}
