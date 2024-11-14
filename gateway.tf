provider "aws" {
  region = "sa-east-1"
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "avalanches"
  description = "API Gateway criado para teste"

  tags = {
    Name = "avalanches"
  }
}

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


resource "aws_api_gateway_resource" "cliente_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "cliente"
}

resource "aws_api_gateway_resource" "cliente_cpf_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.cliente_resource.id
  path_part   = "{cpf}"
}

resource "aws_api_gateway_resource" "cliente_cpf_excluir_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.cliente_resource.id
  path_part   = "excluir"
}

##Cliente cadastro
resource "aws_api_gateway_method" "cliente_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cliente_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cliente_resource.id
  http_method             = aws_api_gateway_method.cliente_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"

  # Colocar uri quando aplicaçao estiver disp no eks
  uri = "${var.url_base}/cliente"

  request_templates = {
    "application/json" = <<EOF
    {
      "nome": "$input.json('$.nome')",
      "cpf": "$input.json('$.cpf')",
      "email": "$input.json('$.email')"
    }
    EOF
  }
}

## Cliente consultar por cpf

resource "aws_api_gateway_method" "cliente_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_cpf_resource.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.cpf" = true
  }
}

resource "aws_api_gateway_integration" "cliente_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cliente_cpf_resource.id
  http_method             = aws_api_gateway_method.cliente_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"

  # Colocar uri quando aplicaçao estiver disp no eks
  uri = "${var.url_base}/cliente/{cpf}"
  tls_config {
    insecure_skip_verification = true
  }

  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf" # Passa o CPF para a integração
  }

}


## Cliente 
resource "aws_api_gateway_method" "cliente_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_cpf_excluir_resource.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_clientes.id

  request_parameters = {
    "method.request.path.cpf" = true
  }
}

resource "aws_api_gateway_integration" "cliente_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.cliente_cpf_excluir_resource.id
  http_method             = aws_api_gateway_method.cliente_delete_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/cliente/{cpf}/excluir"
  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf"
  }
}


# Produto resources
resource "aws_api_gateway_resource" "produto_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "produto"
}

resource "aws_api_gateway_resource" "produto_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.produto_resource.id
  path_part   = "{id}"
}

# Produto cadastro
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

  request_templates = {
    "application/json" = <<EOF
    {
      "valor": "$input.json('$.valor')",
      "quantidade": "$input.json('$.quantidade')",
      "categoria": "$input.json('$.categoria')",
      "nome": "$input.json('$.nome')",
      "descricao": "$input.json('$.descricao')"
    }
    EOF
  }
}

#Produto deleçao
resource "aws_api_gateway_method" "produto_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_id_resource.id
  http_method   = "DELETE"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id

  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_integration" "produto_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_id_resource.id
  http_method             = aws_api_gateway_method.produto_delete_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP_PROXY" # Trocar para "HTTP_PROXY" quando a aplicação estiver disponível

  # Colocar uri quando a aplicação estiver disponível no EKS
  uri = "${var.url_base}/produto/{id}"

  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}


#Produto busca por categoria
resource "aws_api_gateway_method" "produto_get_by_categoria_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_id_resource.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.categoriaProduto" = true
  }
}

resource "aws_api_gateway_integration" "produto_get_by_categoria_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_id_resource.id
  http_method             = aws_api_gateway_method.produto_get_by_categoria_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/produto/{categoriaProduto}"
  request_parameters = {
    "integration.request.path.categoriaProduto" = "method.request.path.categoriaProduto"
  }
}

# Atualizar produto

resource "aws_api_gateway_method" "produto_put_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.produto_id_resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id
  request_parameters = {
    "method.request.path.id" = true
  }

}

resource "aws_api_gateway_integration" "produto_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.produto_id_resource.id
  http_method             = aws_api_gateway_method.produto_put_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY" # Trocar para "HTTP_PROXY" quando a aplicação estiver disponível

  # Colocar uri quando a aplicação estiver disponível no EKS
  uri = "${var.url_base}/produto/{id}"

  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }

  request_templates = {
    "application/json" = <<EOF
    {
      "valor": "$input.json('$.valor')",
      "quantidade": "$input.json('$.quantidade')",
      "categoria": "$input.json('$.categoria')",
      "nome": "$input.json('$.nome')",
      "descricao": "$input.json('$.descricao')"
    }
    EOF
  }
}

resource "aws_api_gateway_resource" "pedido_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "pedido"
}

resource "aws_api_gateway_resource" "pedido_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.pedido_resource.id
  path_part   = "{idPedido}"
}

# cadastro pedido
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

  request_templates = {
    "application/json" = <<EOF
    {
      "valor": "$input.json('$.valor')",
      "dataCriacao": "$input.json('$.dataCriacao')",
      "dataFinalizacao": "$input.json('$.dataFinalizacao')",
      "listaProduto": [
        #foreach($produto in $input.json('$.listaProduto'))
          {
            "idProduto": "$produto.idProduto",
            "quantidade": "$produto.quantidade",
            "valorUnitario": "$produto.valorUnitario"
          }#if($foreach.hasNext),#end
        #end
      ]
    }
    EOF
  }
}

## atualiza status pedido
resource "aws_api_gateway_method" "pedido_put_status_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.pedido_id_resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.lambda_authorizer_funcionarios.id

  request_parameters = {
    "method.request.path.idPedido" = true
  }
}

resource "aws_api_gateway_integration" "pedido_put_status_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.pedido_id_resource.id
  http_method             = aws_api_gateway_method.pedido_put_status_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP_PROXY"
  uri                     = "${var.url_base}/pedido/{idPedido}"

  request_parameters = {
    "integration.request.path.idPedido" = "method.request.path.idPedido"
  }

  request_templates = {
    "application/json" = <<EOF
    {
      "statusPedido": "$input.json('$')"
    }
    EOF
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

#Cadastro pagamento
resource "aws_api_gateway_resource" "pagamento_webhook_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
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
  uri                     = "${var.url_base}/pagamento/webhook"

  request_templates = {
    "application/json" = <<EOF
    {
      "idPedido": "$input.json('$.idPedido')",
      "status": "$input.json('$.status')"
    }
    EOF
  }
}


resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.mock_integration,
    aws_api_gateway_integration.cliente_post_integration,
    aws_api_gateway_integration.cliente_get_integration,
    aws_api_gateway_integration.produto_post_integration,
    aws_api_gateway_integration.produto_delete_integration,
    aws_api_gateway_integration.produto_get_by_categoria_integration,
    aws_api_gateway_integration.pedido_post_integration,
    aws_api_gateway_integration.pedido_put_status_integration,
    aws_api_gateway_integration.pedido_get_list_integration,
    aws_api_gateway_integration.cliente_delete_integration,
    aws_api_gateway_integration.pagamento_webhook_post_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod"
}
