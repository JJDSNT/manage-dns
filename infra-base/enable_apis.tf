# Ativa as APIs necessárias para o projeto.
# Recurso gerenciado pelo state 'infra-base' (ver terraform.tfstate).
# provisioned_by = infra-base (não aplicável como label diretamente)

resource "google_project_service" "enable_apis" {
  for_each = toset([
    "storage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com"
  ])

  service = each.value
  project = var.project_id

  disable_on_destroy = false
}
