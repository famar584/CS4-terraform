# variables.tf

# Região da AWS
variable "region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1" # Alterar conforme necessário
}

# Chave de Acesso AWS
variable "access_key" {
  description = "Chave de acesso da AWS"
  type        = string
  sensitive   = true
}

# Chave Secreta AWS
variable "secret_key" {
  description = "Chave secreta da AWS"
  type        = string
  sensitive   = true
}

# Token de Sessão AWS (para credenciais temporárias)
variable "session_token" {
  description = "Token de sessão da AWS para credenciais temporárias"
  type        = string
  sensitive   = true
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "VPC"
}

variable "AZ" {
  description = "Zonas de Disponibilidade"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "amplify"{
  description = "Nome da branch"
  type        = string
  default     = "amplify"
}

variable "ami" {
  description = "AMI ID para as instâncias EC2"
  type        = string
  default     = "ami-0c94855ba95c71c99"
}