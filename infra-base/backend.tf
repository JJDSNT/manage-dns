terraform {
  backend "gcs" {
    bucket  = "tfstate-observatudo"
    prefix  = "infra-base"
  }
}
# Backend do Terraform para o módulo 'infra-base'.
# Este state é armazenado no bucket GCS com prefixo 'infra-base',
# e os recursos criados por este módulo terão a label provisioned_by = infra-base.
# Este arquivo não é aplicado, mas serve como modelo para os diretórios que usam o bucket (como zones/observatudo.com.br)
