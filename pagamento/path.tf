resource "aws_api_gateway_resource" "pagamento_route" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "pagamento"
}

resource "aws_api_gateway_resource" "pagamento_webhook_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pagamento_route.id
  path_part   = "webhook"
}

resource "aws_api_gateway_resource" "pagamento_status_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pagamento_route.id
  path_part   = "status"
}

resource "aws_api_gateway_resource" "pagamento_efetuar_pagamento_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pagamento_route.id
  path_part   = "efetuar-pagamento"
}

resource "aws_api_gateway_resource" "pagamento_efetuar_pagamento_id_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pagamento_efetuar_pagamento_route.id
  path_part   = "{idPedido}"
}

resource "aws_api_gateway_resource" "pagamento_status_id_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pagamento_status_route.id
  path_part   = "{idPedido}"
}
