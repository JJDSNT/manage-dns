# provisioned_by = infra-base
resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI/CD"
  description = "Criada pelo módulo infra-base para CI/CD do Terraform"
}
