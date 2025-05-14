# provisioned_by = infra-base
resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI/CD"
  description = "Criada pelo módulo infra-base para CI/CD do Terraform"
}

resource "google_service_account" "github_actions_deploy" {
  account_id   = "github-actions-deploy"
  display_name = "GitHub Actions Deploy"
  description  = "Criada pelo módulo infra-base para CI/CD via GitHub Actions"
}