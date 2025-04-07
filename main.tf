provider "aws" {
  region = var.aws_region
}

resource "aws_api_gateway_rest_api" "this" {
  name = var.api_name
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.route_integrations]
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}
