data "aws_region" "current" {}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "invoke_url" {
  value = "https://${aws_api_gateway_rest_api.this.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${var.environment}"
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.this.execution_arn
}
