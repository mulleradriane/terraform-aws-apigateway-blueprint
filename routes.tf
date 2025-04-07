resource "aws_api_gateway_resource" "routes" {
  for_each    = var.routes
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = each.value.path_part
}

resource "aws_api_gateway_method" "route_methods" {
  for_each      = var.routes
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.routes[each.key].id
  http_method   = each.value.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "route_integrations" {
  for_each                = var.routes
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.routes[each.key].id
  http_method             = aws_api_gateway_method.route_methods[each.key].http_method
  type                    = each.value.integration.type
  integration_http_method = each.value.integration.integration_http_method
  request_templates       = each.value.integration.request_templates
}

resource "aws_api_gateway_method_response" "route_responses" {
  for_each    = var.routes
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.routes[each.key].id
  http_method = aws_api_gateway_method.route_methods[each.key].http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "route_integration_responses" {
  for_each    = var.routes
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.routes[each.key].id
  http_method = aws_api_gateway_method.route_methods[each.key].http_method
  status_code = aws_api_gateway_method_response.route_responses[each.key].status_code

  response_templates = {
    "application/json" = each.value.integration.response_template
  }
}
