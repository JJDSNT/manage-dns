terraform {
  backend "gcs" {
    bucket  = "tfstate-observatudo"
    prefix  = "infra-base"
  }
}
#Este arquivo não é aplicado, mas serve como modelo para os diretórios que usam o bucket (como zones/observatudo.com.br)