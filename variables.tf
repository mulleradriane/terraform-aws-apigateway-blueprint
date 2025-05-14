variable "name" {
  description = "Nome do API Gateway"
  type        = string
}

variable "description" {
  description = "Descrição da API"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Ambiente para a stage (ex: dev, prod)"
  type        = string
}

variable "proxy_mode" {
  description = "Modo do proxy: catch_all_proxy | method_http_proxy | lambda_proxy"
  type        = string
  default     = null
}

variable "enable_healthcheck" {
  description = "Cria rota de healthcheck GET /health (mock)"
  type        = bool
  default     = false
}

variable "proxy_enabled" {
  description = "Habilita rota proxy ANY /proxy+"
  type        = bool
  default     = false
}


variable "proxy_config" {
  description = "Configuração detalhada para o proxy"
  type = object({
    path_part               = string
    http_method             = string
    authorization           = string
    integration_type        = string
    integration_http_method = string
    uri                     = string
    request_templates       = map(string)
    response_templates      = map(string)
    status_code             = string
  })
  default = null
}

variable "enable_proxy" {
  description = "Define se os recursos de proxy devem ser criados"
  type        = bool
  default     = false
}

variable "proxy_uri" {
  description = "URI do proxy para ser usado no recurso base path mapping"
  type        = string
  default     = ""
}


