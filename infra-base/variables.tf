variable "project_id" {
  description = "ID do projeto GCP onde os recursos serão criados"
  type        = string
}

variable "bucket_name" {
  description = "Nome do bucket para o terraform.tfstate"
  type        = string
}

variable "region" {
  description = "Região onde o bucket será criado"
  type        = string
  default     = "us-east1"
}
