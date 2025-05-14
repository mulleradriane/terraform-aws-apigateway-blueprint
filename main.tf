# Criação da API Gateway REST com config básica
resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "API REST gerenciada via módulo - ${var.environment}"

  endpoint_configuration {
    types = ["EDGE"]
  }
}

# Deploy da API
resource "aws_api_gateway_deployment" "this" {
  depends_on = [
    aws_api_gateway_method.proxy_any,
    aws_api_gateway_integration.proxy_any,
    aws_api_gateway_method_response.proxy_any,
    aws_api_gateway_integration_response.proxy_any,
    aws_api_gateway_method.proxy_options,
    aws_api_gateway_integration.proxy_options,
    aws_api_gateway_method_response.proxy_options,
    aws_api_gateway_integration_response.proxy_options,
  ]

  rest_api_id = aws_api_gateway_rest_api.this.id
  triggers = {
    redeployment = timestamp()
  }
}

# Criação do stage (dev, prod etc)
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.environment
}

