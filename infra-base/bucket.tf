resource "google_storage_bucket" "terraform_state" {
  name     = "tfstate-observatudo"
  location = "us-east1"

  labels = {
    provisioned_by = var.state_label
  }

  force_destroy               = false
  uniform_bucket_level_access = true

  # Versionamento desligado de propósito (decisão: custo de armazenar
  # versões antigas, mesmo pequeno, não compensa para este caso).
  versioning {
    enabled = false
  }

  # Nenhuma lifecycle_rule de exclusão automática aqui — state remoto não
  # pode ter expiração. A regra anterior (Delete após 365 dias) apagou
  # silenciosamente o state de produção do observatudo-bq em 2026-06,
  # sem deixar rastro de auditoria (Data Access logging não estava
  # habilitado neste bucket). Ver AI_context/REFACTOR_CONTEXT.md do
  # observatudo-bq para o histórico do incidente.
}
