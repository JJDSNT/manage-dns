variable "project_id" {
  description = "ID do projeto GCP onde a zona DNS será gerenciada"
  type        = string
}

variable "state_label" {
  type    = string
  default = "dns-zones-observatudo"
}