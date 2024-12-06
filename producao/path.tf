resource "aws_api_gateway_resource" "produto_route" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "produto"
}

resource "aws_api_gateway_resource" "produto_id_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.produto_route.id
  path_part   = "{id}"
}

resource "aws_api_gateway_resource" "produto_categoria_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.produto_route.id
  path_part   = "categoria"
}

resource "aws_api_gateway_resource" "produto_categoria_id_route" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.produto_categoria_route.id
  path_part   = "{categoriaProduto}"
}