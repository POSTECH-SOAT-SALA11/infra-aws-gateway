resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "teste-avalanche"
  description = "API Gateway criado para teste"

  tags = {
    Name = "teste-avalanche"
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

##Cliente cadastro
resource "aws_api_gateway_resource" "cliente_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "cliente"
}

resource "aws_api_gateway_method" "cliente_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cliente_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.cliente_resource.id
  http_method = aws_api_gateway_method.cliente_post_method.http_method
  integration_http_method = "POST"
  type        = "MOCK" 
  
  # Colocar uri quando aplicaçao estiver disp no eks
  ##uri         = "http://<eks>//avalanches/v1/cliente"

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

## Cliente consultar
resource "aws_api_gateway_method" "cliente_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_resource.id
  http_method   = "GET"
  authorization = "NONE"
  
  request_parameters = {
    "method.request.path.cpf" = true
  }
}

resource "aws_api_gateway_integration" "cliente_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.cliente_resource.id
  http_method = aws_api_gateway_method.cliente_get_method.http_method
  integration_http_method = "GET"
  type        = "MOCK" ## TROCAR PARA HTTP_Proxy

  #Colocar uri quando aplicaçao estiver disp no eks
  #uri         = "779846815660.dkr.ecr.sa-east-1.amazonaws.com/sistema-lanchonete-avalanches/avalanches/v1/cliente"

  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf"  # Passa o CPF para a integração
  }

}


## Cliente 
resource "aws_api_gateway_method" "cliente_delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.cliente_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
  
  request_parameters = {
    "method.request.path.cpf" = true
  }
}

resource "aws_api_gateway_integration" "cliente_delete_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.cliente_resource.id
  http_method = aws_api_gateway_method.cliente_delete_method.http_method
  integration_http_method = "DELETE"
  type        = "MOCK" ## TROCAR PARA HTTP_Proxy

  #Colocar uri quando aplicaçao estiver disp no eks
  #uri         = ""

  request_parameters = {
    "integration.request.path.cpf" = "method.request.path.cpf"  
  }

}


## colar aqui

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.mock_integration]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "prod"
}
