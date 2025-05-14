# /health
resource "aws_api_gateway_resource" "health" {
  count       = var.enable_healthcheck ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "health_get" {
  count         = var.enable_healthcheck ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.health[0].id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "health_get" {
  count                     = var.enable_healthcheck ? 1 : 0
  rest_api_id               = aws_api_gateway_rest_api.this.id
  resource_id               = aws_api_gateway_resource.health[0].id
  http_method               = aws_api_gateway_method.health_get[0].http_method
  type                      = "MOCK"
  integration_http_method   = "GET"
  request_templates         = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "health_get" {
  count       = var.enable_healthcheck ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.health[0].id
  http_method = aws_api_gateway_method.health_get[0].http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "health_get" {
  count       = var.enable_healthcheck ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.health[0].id
  http_method = aws_api_gateway_method.health_get[0].http_method
  status_code = aws_api_gateway_method_response.health_get[0].status_code

  response_templates = {
    "application/json" = ""
  }
}
