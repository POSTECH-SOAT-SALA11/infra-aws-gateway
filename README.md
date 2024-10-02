# API Gateway - Terraform Infrastructure

Este repositório contém a configuração da infraestrutura do AWS API Gateway utilizando Terraform. Ele inclui a definição dos recursos para clientes, produtos e pedidos, com integração via proxies HTTP e autorização por Lambda.

## Estrutura de Arquivos

- **authorizers.tf**: Configurações dos `Lambda Authorizers` para controle de acesso de clientes e funcionários.
- **backend.tf**: Configuração do backend do Terraform utilizando S3.
- **data.tf**: Referências às funções Lambda utilizadas nos `Lambda Authorizers`.
- **gateway.tf**: Configuração principal do API Gateway, incluindo recursos, métodos e integrações para clientes, produtos e pedidos.

## Recursos

### API Gateway

- **Clientes**
  - Cadastro (`POST /cliente`)
  - Consulta por CPF (`GET /cliente/{cpf}`)
  - Exclusão por CPF (`DELETE /cliente/{cpf}/excluir`)
  
- **Produtos**
  - Cadastro (`POST /produto`)
  - Exclusão por ID (`DELETE /produto/{id}`)
  - Busca por Categoria (`GET /produto/{categoriaProduto}`)
  - Atualização (`PUT /produto/{id}`)

- **Pedidos**
  - Cadastro (`POST /pedido`)
  - Atualização de Status (`PUT /pedido/{idPedido}`)
  - Listagem (`GET /pedido`)

### Authorizers

- **Lambda Authorizer Clientes**: Controla a autorização para exclusão de clientes.
- **Lambda Authorizer Funcionários**: Controla a autorização para operações relacionadas a produtos e atualização de status de pedidos.

## Variáveis

- **var.region**: Região AWS onde os recursos serão criados.
- **var.s3_backend_bucket_name**: Nome do bucket S3 utilizado para armazenar o estado do Terraform.
- **var.url_base**: URL base das integrações HTTP com os microsserviços.
