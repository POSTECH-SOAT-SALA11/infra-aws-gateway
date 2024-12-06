resource "aws_api_gateway_integration" "pagamento_webhook_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pagamento_webhook_route.id
  http_method             = aws_api_gateway_method.pagamento_webhook_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pagamento/webhook"
}

resource "aws_api_gateway_integration" "pagamento_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pagamento_route.id
  http_method             = aws_api_gateway_method.pagamento_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pagamento"
}

resource "aws_api_gateway_integration" "pagamento_status_id_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pagamento_status_id_route.id
  http_method             = aws_api_gateway_method.pagamento_status_id_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pagamento/status/{idPedido}"

  request_parameters = {
    "integration.request.path.idPedido" = "method.request.path.idPedido" 
  }
}

resource "aws_api_gateway_integration" "pagamento_efetuar_pagamento_id_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.pagamento_efetuar_pagamento_id_route.id
  http_method             = aws_api_gateway_method.pagamento_efetuar_pagamento_id_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pagamento/efetuar-pagamento/{idPedido}"

  request_parameters = {
    "integration.request.path.idPedido" = "method.request.path.idPedido" 
  }
}

