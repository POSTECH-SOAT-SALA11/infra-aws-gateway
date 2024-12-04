provider "aws" {
  region = "sa-east-1"
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "avalanches"
  description = "API Gateway"

  tags = {
    Name = "avalanches"
  }
}

# Definição dos recursos e métodos
resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "teste"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "mock_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_method.http_method
  type        = "MOCK"
}

# Recursos para cadastro de cliente
resource "aws_api_gateway_resource" "cadastro_usuario_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "cliente"
}

resource "aws_api_gateway_method" "cadastro_usuario_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cadastro_usuario_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cliente_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cadastro_usuario_resource.id
  http_method             = aws_api_gateway_method.cadastro_usuario_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente"
}

# Cliente: Consultar por CPF
resource "aws_api_gateway_resource" "cliente_cpf_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "{cpf}"
}

resource "aws_api_gateway_method" "cliente_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_cpf_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cliente_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cliente_cpf_resource.id
  http_method             = aws_api_gateway_method.cliente_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente/{cpf}"
}

# Cliente: Deletar
resource "aws_api_gateway_resource" "cliente_cpf_excluir_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.cliente_cpf_resource.id
  path_part   = "excluir"
}

resource "aws_api_gateway_method" "cliente_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_cpf_excluir_resource.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_clientes.id
}

resource "aws_api_gateway_integration" "cliente_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cliente_cpf_excluir_resource.id
  http_method             = aws_api_gateway_method.cliente_delete_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente/{cpf}/excluir"
}

# Produto: Cadastro e Consultas
resource "aws_api_gateway_resource" "produto_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "produto"
}

resource "aws_api_gateway_method" "produto_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id
}

resource "aws_api_gateway_integration" "produto_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_resource.id
  http_method             = aws_api_gateway_method.produto_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto"
}

# Produto: Deletar
resource "aws_api_gateway_resource" "produto_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.produto_resource.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "produto_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_id_resource.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id
}

resource "aws_api_gateway_integration" "produto_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_id_resource.id
  http_method             = aws_api_gateway_method.produto_delete_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto/{id}"
}

# Pedido: Cadastro e Atualização
resource "aws_api_gateway_resource" "pedido_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "pedido"
}

resource "aws_api_gateway_method" "pedido_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pedido_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pedido_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pedido_resource.id
  http_method             = aws_api_gateway_method.pedido_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido"
}

resource "aws_api_gateway_method" "pedido_put_status_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pedido_resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id
}

resource "aws_api_gateway_integration" "pedido_put_status_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pedido_resource.id
  http_method             = aws_api_gateway_method.pedido_put_status_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido/{idPedido}"
}

resource "aws_api_gateway_resource" "pagamento_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "pagamento"
}

# Pagamento: Webhook
resource "aws_api_gateway_resource" "pagamento_webhook_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pagamento_resource.id
  path_part   = "webhook"
}

resource "aws_api_gateway_method" "pagamento_webhook_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pagamento_webhook_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pagamento_webhook_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pagamento_webhook_resource.id
  http_method             = aws_api_gateway_method.pagamento_webhook_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/webhook"

  request_templates = {
    "application/json" = <<EOF
    {
      "idPedido": "$input.json('$.idPedido')",
      "status": "$input.json('$.status')"
    }
    EOF
  }
}

# Pagamento: Status
resource "aws_api_gateway_resource" "pagamento_status_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pagamento_resource.id
  path_part   = "status"
}

resource "aws_api_gateway_resource" "pagamento_status_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pagamento_status_resource.id
  path_part   = "{idPedido}"
}

resource "aws_api_gateway_method" "pagamento_status_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pagamento_status_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pagamento_status_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pagamento_status_id_resource.id
  http_method             = aws_api_gateway_method.pagamento_status_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/status/{idPedido}"
}

# Pagamento: Efetuar pagamento
resource "aws_api_gateway_resource" "pagamento_efetuar_pagamento_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pagamento_resource.id
  path_part   = "efetuar-pagamento"
}

resource "aws_api_gateway_resource" "pagamento_efetuar_pagamento_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pagamento_efetuar_pagamento_resource.id
  path_part   = "{idPedido}"
}

resource "aws_api_gateway_method" "pagamento_efetuar_pagamento_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pagamento_efetuar_pagamento_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pagamento_efetuar_pagamento_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pagamento_efetuar_pagamento_id_resource.id
  http_method             = aws_api_gateway_method.pagamento_efetuar_pagamento_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/efetuar-pagamento/{idPedido}"
}

resource "aws_api_gateway_resource" "produto_categoria_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.produto_resource.id
  path_part   = "categoria"
}

resource "aws_api_gateway_method" "produto_get_by_categoria_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_categoria_resource.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.categoriaProduto" = true
  }
}

resource "aws_api_gateway_integration" "produto_get_by_categoria_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_categoria_resource.id
  http_method             = aws_api_gateway_method.produto_get_by_categoria_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto/categoria/{categoriaProduto}"

  request_parameters = {
    "integration.request.path.categoriaProduto" = "method.request.path.categoriaProduto"
  }
}


resource "aws_api_gateway_method" "pedido_get_list_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pedido_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pedido_get_list_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pedido_resource.id
  http_method             = aws_api_gateway_method.pedido_get_list_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido"
}



resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.cliente_get_integration,
    aws_api_gateway_integration.cliente_post_integration,
    aws_api_gateway_integration.cliente_delete_integration,
    aws_api_gateway_integration.produto_post_integration,
    aws_api_gateway_integration.produto_delete_integration,
    aws_api_gateway_integration.pedido_post_integration,
    aws_api_gateway_integration.pedido_put_status_integration,
    aws_api_gateway_integration.pagamento_webhook_post_integration,
    aws_api_gateway_integration.pagamento_status_get_integration,
    aws_api_gateway_integration.pagamento_efetuar_pagamento_get_integration,
    aws_api_gateway_integration.produto_get_by_categoria_integration,
    aws_api_gateway_integration.pedido_get_list_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod"
}
