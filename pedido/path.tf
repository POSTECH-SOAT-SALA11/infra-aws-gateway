resource "aws_api_gateway_resource" "pedido_create_route" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "pedido"
}

resource "aws_api_gateway_resource" "pedido_id_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.pedido_create_route.id
  path_part   = "{idPedido}"
}