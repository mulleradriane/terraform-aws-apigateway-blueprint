variable "api_name" {
  description = "Nome da API"
  type        = string
}

variable "stage_name" {
  description = "Nome do stage"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "routes" {
  description = "Mapa de rotas para o API Gateway"
  type = map(object({
    path_part = string
    method    = string
    integration = object({
      type                    = string
      integration_http_method = string
      request_templates       = map(string)
      response_template       = string
    })
  }))
}
