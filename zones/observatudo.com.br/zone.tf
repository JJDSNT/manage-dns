resource "google_dns_managed_zone" "observatudo" {
  name        = "observatudo-zone"
  dns_name    = "observatudo.com.br."
  description = "Zona DNS principal para o domínio observatudo.com.br"
  project    = var.project_id

    labels = {
    provisioned_by = var.state_label
  }
}
