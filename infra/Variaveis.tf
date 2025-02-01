variable "nome_repositorio" {
  type = string
}

variable "cargoIAM" {
  type = string
}

variable "ambiante" {
  type = string
}

variable "log_retention_days" {
  type        = number
  default     = 30
  description = "Número de dias para reter os logs no CloudWatch"
}

variable "cpu_threshold" {
  type        = number
  default     = 80
  description = "Limite de CPU para alarme (%)"
}

variable "memory_threshold" {
  type        = number
  default     = 80
  description = "Limite de memória para alarme (%)"
}

variable "waf_rate_limit" {
  type        = number
  default     = 2000
  description = "Limite de requisições por IP para o WAF"
}

variable "enable_shield_advanced" {
  type        = bool
  default     = false
  description = "Habilitar AWS Shield Advanced"
}

variable "tgw_destination_cidr" {
  type        = string
  default     = "10.0.0.0/8"
  description = "CIDR para roteamento via Transit Gateway"
}

variable "enable_network_firewall" {
  type        = bool
  default     = true
  description = "Habilitar AWS Network Firewall"
}

variable "blocked_domains" {
  type        = list(string)
  default     = []
  description = "Lista de domínios para bloquear no Network Firewall"
}