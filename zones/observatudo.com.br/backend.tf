# Backend do Terraform para o módulo de DNS do domínio observatudo.com.br.
# State armazenado no bucket GCS com prefixo 'zones/observatudo.com.br'.
# O bucket deve ser criado previamente e o Terraform deve ter permissão para
# acessar o bucket.
terraform {
  backend "gcs" {
    bucket = "tfstate-observatudo"
    prefix  = "zones/observatudo.com.br"
  }
}
