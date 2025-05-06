terraform {
  backend "gcs" {
    bucket  = "terraform-state-observatudo"
    prefix  = "zones/observatudo.com.br"
  }
}
